local utils = ImportPackage( 'orf_utils' )
local creation_ui = nil

local function create_web_ui()
	local w, h = GetScreenSize()
	creation_ui = CreateWebUI( w * 0.15, h * 0.1, w * 0.40, h * 1, 10, 32 )
	SetWebAlignment( creation_ui, 0, 0 )
	SetWebAnchors( creation_ui, 0, 0, 0, 0 )
	LoadWebFile( creation_ui, ( 'http://asset/%s/players/client/creation/ui/creation.html' ):format( GetPackageName() ) )
	SetWebVisibility( creation_ui, WEB_HIDDEN )
end

local function OnPackageStop()
	if ( creation_ui ~= nil ) then DestroyWebUI( creation_ui ) end
end
AddEvent( 'OnPackageStop', OnPackageStop )

local function OnKeyPress( key )

end
AddEvent( 'OnKeyPress', OnKeyPress )

local function toggle_ui_visiblity( characters )
    if ( not creation_ui ) then create_web_ui() end

	local x, y, z = GetPlayerLocation(GetPlayerId())
	SetCameraRotation( -18, 90, 0 )
	SetCameraLocation( x + 80, y - 200, z + 60 )

	local is_visible = GetWebVisibility( creation_ui ) == 1
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_UI or INPUT_GAME )
	SetWebVisibility( creation_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )

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
	if( face == 'HZN_CH3D_SpecialAgent_LPR' ) then
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