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
	local fields = {}
	for k, v in pairs( model._fields ) do
		if ( not v.is_primary_key and ( v.updatable == nil or v.updatable ) and ( v.is_sync == nil or ( v.is_sync ~= nil and v.is_sync ) ) ) then
			fields[ v.field ] = model[ 'Get' .. k ]()
		end
	end
	return fields
end

local function get_insertable_field( model )
	local fields = {}
	for k, v in pairs( model._fields ) do
		if ( ( v.insertable == nil or ( v.insertable ~= nil and v.insertable ) ) and ( v.is_sync == nil or ( v.is_sync ~= nil and v.is_sync ) ) ) then
			fields[ v.field ] = model[ 'Get' .. k ]()
		end
	end
	return fields
end

function BaseModel.new( primary_key )
	local self = setmetatable( {
		_primaryKey = primary_key
	}, BaseModel )
	init_accessors( self )
	return self
end

function BaseModel:DbUpdate( callback, ... )
	local vargs = { ... }
	local updatable_fields = get_updatable_field( self )
	QueryBuilder:new():update( self._table, updatable_fields ):where( self._PrimaryKeyField, '=', self:GetPrimaryKey()):exec(function( results, extras )
		if ( type( callback ) == 'function' ) then callback( results, extras, table.unpack( vargs ) ) end
	end) 
end

function BaseModel:DbSave( callback, ... )
	local vargs = { ... }
	local insertable_fields = get_insertable_field( self )
	QueryBuilder:new():insert( self._table, insertable_fields ):exec(function( results, extras )
		if ( type( callback ) == 'function' ) then callback( results, extras, table.unpack( vargs ) ) end
	end)
end

function BaseModel:GetPrimaryKey()
	return self._primaryKey
end

return BaseModel