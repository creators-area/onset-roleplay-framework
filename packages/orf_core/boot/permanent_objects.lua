local utils = ImportPackage( 'orf_utils' )
local BUILDER = {}

ORF = ORF or {}
ORF.PermanentObjects = {}

function BUILDER.car_dealer( data )
    local id = CreateNPC( data.model_id, data.x, data.y, data.z, data.h )
    SetNPCPropertyValue( id, 'type', data.type, true )
end

function BUILDER.estate_agent( data )
    local id = CreateNPC( data.model_id, data.x, data.y, data.z, data.h )
    SetNPCPropertyValue( id, 'type', data.type, true )
end

function BUILDER.weapon_seller( data )
    local id = CreateNPC( data.model_id, data.x, data.y, data.z, data.h )
    SetNPCPropertyValue( id, 'type', data.type, true )
end

AddEvent( 'ORF.OnDatabaseInit', function()
    database.asyncQuery( database.GET_ALL_PERMANENT_OBJECTS, {}, function( results )
        for i = 1, #results do
            local result = results[ i ]
            local type = result.type
            if ( type ~= nil and BUILDER[ type ] ~= nil and type( BUILDER[ type ] ) == 'function' ) then
                BUILDER[ type ]( result )
            end
        end
    end)
end)
