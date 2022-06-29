// G45-NFT Standard
// Simple standard for tradable/exchangable immutable NFTs (no UPDATE_SC_CODE)
// Max smart contract storage is 20KB
// The SCID is the NFT unique hash

Function Initialize() Uint64
10 DIM signer as String
20 LET owner = SIGNER()
30 STORE("minter", owner) // use this to verify authenticity of NFTs - came from original creator
40 STORE("type", "G45-NFT")
50 SEND_ASSET_TO_ADDRESS(onwer, 1, SCID()) // can be 1 or more if you and to print more of the same nft
// STORE("collection", "1/3500")
// STORE("master_sc", "{master_sc_id}")
// STORE("nft_collection", "{name}")
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
60 RETURN 0
End Function
