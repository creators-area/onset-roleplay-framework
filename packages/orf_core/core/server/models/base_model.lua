local utils = ImportPackage( 'orf_utils' )

local BaseModel = {}
BaseModel.__index = BaseModel

local function init_accessors( model )
	for k, v in pairs( model._fields ) do
		if ( v.is_primary_key ) then model._PrimaryKeyField = v.field end
		model[ 'Get' .. k ] = function() return model[ '_' .. v.field ] or nil end
		model[ 'Set' .. k ] = function( s, value )
			model[ '_' .. v.field ] = value
		end
	end
end

local function get_updatable_field( model )
	local fields, values = {}, {}
	for k, v in pairs( model._fields ) do
		if ( not v.is_primary_key and ( v.updatable == nil or v.updatable ) and ( v.is_sync == nil or ( v.is_sync ~= nil and v.is_sync ) ) ) then
			table.insert( fields, v.field )
			table.insert( values, model[ 'Get' .. k ]() )
		end
	end
	return fields, values
end

local function get_insertable_field( model )
	local fields, values = {}, {}
	for k, v in pairs( model._fields ) do
		if ( ( v.insertable == nil or ( v.insertable ~= nil and v.insertable ) ) and ( v.is_sync == nil or ( v.is_sync ~= nil and v.is_sync ) ) ) then
			table.insert( fields, v.field )
			table.insert( values, model[ 'Get' .. k ]() )
		end
	end
	return fields, values
end

function BaseModel.new( primary_key )
	local base = setmetatable( {
		_primaryKey = primary_key
	}, BaseModel )
	init_accessors( base )
	return base
end

function BaseModel:Load( callback, ... )
	local vargs = { ... }
	local query = ( 'SELECT * FROM `%s` WHERE %s = ? LIMIT 1' ):format( self._table, self._PrimaryKeyField )
	database.asyncQuery( query, { self:GetPrimaryKey() }, function( results )
		results = results[ 1 ]
		for k, v in pairs( self._fields ) do
			if ( results[ v.field ] ~= nil ) then
				self[ 'Set' .. k ]( self, results[ v.field ] )
			end
		end
		callback( results, table.unpack( vargs ) )
	end)
end

function BaseModel:DbUpdate( callback, ... )
	local vargs = { ... }
	local fields, values = get_updatable_field( self )
	for i = 1, #fields do fields[ i ] = fields[ i ] .. ( type( values[ i ] ) == 'string' and " = '?'" or ' = ?' ) end
	local query = ( 'UPDATE `%s` SET %s WHERE %s = ?' ):format( self._table, table.concat( fields, ', ' ), self._PrimaryKeyField )
	table.insert( values, self:GetPrimaryKey() )
	database.asyncQuery( query, values, function( results )
		if ( type( callback ) == 'function' ) then callback( results, table.unpack( vargs ) ) end
	end)
end

function BaseModel:DbSave( callback, ... )
	local vargs = { ... }
	local fields, values = get_insertable_field( self )
	local prepared_values = {}
	for i = 1, #values do
		prepared_values[ i ] = type( values[ i ] ) == 'string' and "'?'" or '?'
	end
	local query = ( 'INSERT INTO `%s` ( %s ) VALUES ( %s )' ):format( self._table, table.concat( fields, ', ' ), table.concat( prepared_values, ', ' ) )
	database.asyncQuery( query, values, function( results )
		if ( type( callback ) == 'function' ) then callback( results, extras, table.unpack( vargs ) ) end
	end)
end

function BaseModel:GetPrimaryKey()
	return self._primaryKey
end

return BaseModel
