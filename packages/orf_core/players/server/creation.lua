local utils = ImportPackage( 'orf_utils' )
local Character = require( 'packages/' .. GetPackageName() .. '/core/server/models/character' )

AddRemoteEvent( 'ORF.CreateCharacter', function( player, firstname, lastname, faces, hairs, hair_color, shirts, shirt_color, pants, shoes )
    print( 'ORF.CreateCharacter' )
    local character = Character.new()
    character:SetFirstName(firstname)
    character:SetLastName(lastname)
    local clothes = {
        face = faces,
        hairs = hairs,
        hair_color = hair_color,
        shirts = shirts,
        shirt_color = shirt_color,
        pants = pants,
        shoes = shoes,
    }
    character:SetClothes(clothes)
    character:SetHealth(100)
    character:SetArmor(100)
    character:SetCash(0)
    character:SetBankCash(500)
    local identifier = character:Save()
    utils.ORF_Notif( player, __('charater_created_title'), __('character_successfully_created'), {
        type = 'success'
    })
    SetPlayerName( player, firstname .. ' ' .. lastname )
    CallRemoteEvent( 'ORF.BackToCharacterSelection' )
end)
