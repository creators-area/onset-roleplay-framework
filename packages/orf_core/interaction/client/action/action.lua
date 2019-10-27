local animation_ui = nil

local function createAnimationMenu()
	local width, height = GetScreenSize()
	
	animation_ui = CreateWebUI( 0, 0, 0, 0, 1, 32 )

    LoadWebFile( animation_ui, ( 'http://asset/%s/interaction/client/action/ui/action.html' ):format( GetPackageName() ) )
    SetWebSize( animation_ui, width, height )
    SetWebAlignment( animation_ui, 0.5, 0.5 )
	SetWebAnchors( animation_ui, 0.5, 0.5, 0.5, 0.5 )
	SetWebVisibility( animation_ui, WEB_HIDDEN )
end

local function toggleAnimationMenu()
    if ( not animation_ui ) then
        createAnimationMenu()
    end

    local is_visible = GetWebVisibility( animation_ui ) == 1
    
	ShowMouseCursor( not is_visible )
	SetInputMode( not is_visible and INPUT_UI or INPUT_GAME )
	SetWebVisibility( animation_ui, not is_visible and WEB_VISIBLE or WEB_HIDDEN )
end

AddEvent( 'OnPackageStop', function()
    DestroyWebUI( animation_ui )
end)

AddEvent( 'OnKeyPress', function( key )	
    if ( key == "F2" ) then
        toggleAnimationMenu()
	end
end)

AddEvent( 'ORF.AnimationMenu.Close', function()
    toggleAnimationMenu()
end)

AddEvent( 'ORF.AnimationMenu.StartAction', function( animName, closeMenu )
	closeMenu = closeMenu == 1
	
    if ( closeMenu ) then
        toggleAnimationMenu()
    end
    
    CallRemoteEvent( 'ORF.AnimationMenu.StartAction', animName )
end)
