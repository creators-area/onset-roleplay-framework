local utils = ImportPackage( 'orf_utils' )
local creation_ui = nil

AddEvent( 'OnPackageStart', function()
	local w, h = GetScreenSize()
	creation_ui = MakeUI( 'players/client/creation/ui/creation.html', { x = w * 0.15, y = h * 0.1, w = w * 0.40, h = h }, {
		default_visibility = WEB_HIDDEN,
		show_mouse_on_show = true,
		input_mode_on_show = INPUT_UI,
		input_mode_on_hide = INPUT_GAME
	})
end)

local function toggle_ui_visiblity()
	local x, y, z = GetPlayerLocation(GetPlayerId())
	SetCameraRotation( -18, 90, 0 )
	SetCameraLocation( x + 80, y - 200, z + 60 )

	utils.toggleVisiblity( creation_ui )

	local customization = {
		faces = ORF.Faces,
		shirts = ORF.Shirts,
		pants = ORF.Pants,
		hairs = ORF.Hairs,
		shoes = ORF.Shoes,
		hair_color = ORF.HairsColor
	}
	utils.SendPayloadToWebJS( creation_ui, 'OnReceiveCustomization', customization )

end
AddEvent( 'ORF.PlayerCreationToggleVisiblity', toggle_ui_visiblity )

-- Html call/send events
AddEvent( 'ORF.BackToCharacterSelectionMenu', function()
	toggle_ui_visiblity()
	CallEvent('ORF.PlayerSelectionToggleVisiblity')
end)

AddEvent( 'ORF.Test', function( face, hair, hair_color, top, top_color, jacket, pants, shoes )
	local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Body")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/BodyMerged/" .. face))
	if ( face == 'HZN_CH3D_SpecialAgent_LPR' ) then
		SkeletalMeshComponent:SetMaterial(0, UMaterialInterface.LoadFromAsset("/Game/CharacterModels/Materials/HZN_Materials/M_HZN_Body_NoShoesLegsTorso"))
	else
		SkeletalMeshComponent:SetMaterial(3, UMaterialInterface.LoadFromAsset("/Game/CharacterModels/Materials/HZN_Materials/M_HZN_Body_NoShoesLegsTorso"))
	end

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing0")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/" .. hair))
	local hair_color = utils.json_decode( hair_color )
	SkeletalMeshComponent:SetColorParameterOnMaterials("Hair Color", FLinearColor( ( hair_color[1] / 255 ) ^ 2.2, ( hair_color[2] / 255 ) ^ 2.2, ( hair_color[3] / 255 ) ^ 2.2, hair_color[4] / 255 ) )

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing1")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. top))
	local top_color = utils.json_decode( top_color )
	SkeletalMeshComponent:SetColorParameterOnMaterials("Clothing Color", FLinearColor( ( top_color[1] / 255 ) ^ 2.2, ( top_color[2] / 255 ) ^ 2.2, ( top_color[3] / 255 ) ^ 2.2, top_color[4] / 255 ) )

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing2")
	if ( jacket ~= 'NONE' ) then
		SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. jacket))
	else
		SkeletalMeshComponent:SetSkeletalMesh( nil )
	end

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing4")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. pants))

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing5")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. shoes))
end)
