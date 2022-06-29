// G45-NFT Standard
// Simple standard for tradable/exchangable immutable NFTs (no UPDATE_SC_CODE)
// Max smart contract storage is 20KB
// The SCID is the NFT unique hash

Function Initialize() Uint64
10 DIM signer as String
20 LET owner = SIGNER()
30 STORE("minter", owner) // use this to verify authenticity of NFTs - came from original creator
40 STORE("owner", owner)
50 STORE("type", "G45-NFT")
//60 STORE("collection", "1/3500")
//60 STORE("master_sc", "{master_sc_id}")
//70 STORE("nft_collection", "{name}")
60 STORE("royalty_fees", 5) // in percentage
// Store attributes here
// STORE("attr_{name}", "{value}")
// DERO Seals NFT example
// STORE("attr_collection", "Dero Seals")
// STORE("attr_index", "1/3500")
// STORE("attr_imageLink", "https://ipfs.io/ipfs/QmQqzMTavQgT4f4T5v6PWBp7XNKtoPmC9jvn12WPT3gkSE")
// STORE("attr_imageBase64", "{base64 image source}")
// STORE("attr_imageFormat", "{webp|svg|png|jpg}")
// Custom trait attributes
// STORE("attr_rarity", 200)
// STORE("attr_background", "Untitled_Artwork 33")
// STORE("attr_base", "Untitled_Artwork 31")
// STORE("attr_hairAndHats", "Untitled_Artwork 12")
// STORE("attr_shirts", "Untitled_Artwork 4")
80 RETURN 0
End Function

// empty assetToken is default DERO token
// price can be set to 0
Function Transfer(newOwner String, assetToken String, price Uint64) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("tfr_owner", ADDRESS_RAW(newOwner))
40 STORE("tfr_assetToken", assetToken)
50 STORE("tfr_price", price)
60 RETURN 0
End Function

Function ClaimTransfer() Uint64
10 DIM assetToken, signer as String
20 DIM price as Uint64
30 LET signer = SIGNER()
40 IF LOAD("tfr_owner") != signer THEN GOTO 190
50 LET assetToken = LOAD("tfr_assetToken")
60 LET price = LOAD("tfr_price")
LET royaltyFees = LOADT("royalty_fees")
LET royaltyCut = price * royaltyFees / 100
70 IF price == 0 THEN GOTO 140
80 IF assetToken != "" THEN GOTO 110
90 IF DEROVALUE() != price THEN GOTO 190
100 SEND_DERO_TO_ADDRESS(LOAD("owner"), price - royaltyCut)
SEND_DERO_TO_ADDRESS(LOAD("minter"), royaltyCut)
110 IF assetToken != "" THEN GOTO 140
120 IF ASSETVALUE(assetToken) != price THEN GOTO 190
130 SEND_ASSET_TO_ADDRESS(LOAD("owner"), price - royaltyCut, assetToken)
130 SEND_ASSET_TO_ADDRESS(LOAD("minter"), royaltyCut, assetToken)
140 STORE("owner", signer)
150 DELETE("tfr_owner")
160 DELETE("tfr_assetToken")
170 DELETE("tfr_price")
180 RETURN 0
190 RETURN 1
End Function

Function CancelTransfer() Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 DELETE("tfr_owner")
40 DELETE("tfr_assetToken")
50 DELETE("tfr_price")
60 RETURN 0
End Function

Function Burn() Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("owner", "")
40 RETURN 0
End Function
