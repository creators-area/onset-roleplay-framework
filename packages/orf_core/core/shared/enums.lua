__ = function( k, ... ) return ImportPackage( 'i18n' ).t( GetPackageName(), k, ... ) end

ORF = ORF or {}

ORF.Faces = {
    faceNormal1 = 'HZN_CH3D_Normal01_LPR',
    faceNormal2 = 'HZN_CH3D_Normal02_LPR',
    faceNormal3 = 'HZN_CH3D_Normal03_LPR',
    faceNormal4 = 'HZN_CH3D_Normal04_LPR',
    faceBusiness = 'HZN_CH3D_Business_LPR',
}

ORF.Shirts = {
    formalShirt1 = 'HZN_Outfit_Piece_FormalShirt_LPR',
    formalShirt2 = 'HZN_Outfit_Piece_FormalShirt2_LPR',
    pieceShirt = 'HZN_Outfit_Piece_Shirt_LPR',
    tShirtKnitted2 = 'HZN_Outfit_Piece_TShirt_Knitted2_LPR',
    tShirtKnitted = 'HZN_Outfit_Piece_TShirt_Knitted_LPR',
    pieceTShirt = 'HZN_Outfit_Piece_TShirt_LPR',
}

ORF.Pants = {
    cargoPants = 'HZN_Outfit_Piece_CargoPants_LPR',
    denimPants = 'HZN_Outfit_Piece_DenimPants_LPR',
    formalPants = 'HZN_Outfit_Piece_FormalPants_LPR',
}

ORF.Shoes = {
    businessShoes = 'HZN_Outfit_Piece_BusinessShoes_LPR',
    normalShoes = 'HZN_Outfit_Piece_NormalShoes_LPR',
}

ORF.Hairs = {
    hairBusiness = 'HZN_CH3D_Hair_Business_LP',
    hairScientist = 'HZN_CH3D_Hair_Scientist_LP',
    normalHair01 = 'HZN_CH3D_Normal_Hair_01_LPR',
    normalHair02 = 'HZN_CH3D_Normal_Hair_03_LPR',
    normalHair03 = 'HZN_CH3D_Normal_Hair_02_LPR',
}

ORF.HairsColor = {
    blond = { 250, 240, 190, 1 },
    black = { 0, 0, 0, 1 },
    red = { 255, 0, 0, 1 },
    brown = { 139, 69, 19, 1 }
}
