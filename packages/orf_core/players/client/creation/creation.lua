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

local function changeClothes( face, hair, hair_color, top, top_color, pants, shoes )
	local SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Body")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/BodyMerged/" .. face))

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing0")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/" .. hair))
	local hair_color = ORF.HairsColor[hair_color];
	SkeletalMeshComponent:SetColorParameterOnMaterials("Hair Color", FLinearColor( hair_color[1], hair_color[2], hair_color[3], hair_color[4] ) )

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing1")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. top))
	local top_color = utils.json_decode( top_color )
	SkeletalMeshComponent:SetColorParameterOnMaterials("Clothing Color", FLinearColor( ( top_color[1] / 255 ) ^ 2.2, ( top_color[2] / 255 ) ^ 2.2, ( top_color[3] / 255 ) ^ 2.2, top_color[4] / 255 ) )

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing2")
	SkeletalMeshComponent:SetSkeletalMesh( nil )

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing4")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. pants))

	SkeletalMeshComponent = GetPlayerSkeletalMeshComponent(GetPlayerId(), "Clothing5")
	SkeletalMeshComponent:SetSkeletalMesh(USkeletalMesh.LoadFromAsset("/Game/CharacterModels/SkeletalMesh/Outfits/" .. shoes))
end

local function toggle_ui_visiblity()
	local x, y, z = GetPlayerLocation(GetPlayerId())
	SetCameraRotation( -18, 90, 0 )
	SetCameraLocation( x + 80, y - 200, z + 60 )

	utils.toggleVisiblity( creation_ui )

	changeClothes( ORF.Faces['faceNormal1'], ORF.Hairs['normalHair03'], 'brown', ORF.Shirts['formalShirt1'], '["12","46","61","1"]', ORF.Pants['cargoPants'], ORF.Shoes['businessShoes'] )
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

local function backToSelection()
	toggle_ui_visiblity()
	CallEvent('ORF.PlayerSelectionToggleVisiblity')
end

-- Html call/send events
AddEvent( 'ORF.BackToCharacterSelectionMenu', backToSelection )
AddRemoteEvent( 'ORF.BackToCharacterSelection', backToSelection )

AddEvent( 'ORF.ChangeClothes', changeClothes)

AddEvent( 'ORF.InvalidCharacterName', function()
	utils.ORF_Notify( __('invalid_names'), __('should_fill_names'), {
		type = 'danger'
	})
end)

AddEvent( 'ORF.CreateCharacter', function( firstname, lastname, faces, hairs, hair_color, shirts, shirt_color, pants, shoes )
	print( 'ORF.CreateCharacter' )
	CallRemoteEvent( 'ORF.CreateCharacter', firstname, lastname, faces, hairs, hair_color, shirts, shirt_color, pants, shoes )
end)
