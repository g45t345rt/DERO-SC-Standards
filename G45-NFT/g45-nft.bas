Function InitializePrivate(collection String, metadataFormat String, metadata String) Uint64
1 IF EXISTS("minter") == 1 THEN GOTO 11
2 STORE("minter", SIGNER())
3 STORE("type", "G45-NFT")
4 STORE("owner", "")
5 STORE("timestamp", BLOCK_TIMESTAMP())
6 SEND_ASSET_TO_ADDRESS(SIGNER(), 1, SCID())
7 STORE("collection", collection)
8 STORE("metadataFormat", metadataFormat)
9 STORE("metadata", metadata)
10 RETURN 0
11 RETURN 1
End Function

Function DisplayToken() Uint64
1 IF ADDRESS_STRING(SIGNER()) == "" THEN GOTO 5
2 IF ASSETVALUE(SCID()) != 1 THEN GOTO 5
3 STORE("owner", ADDRESS_STRING(SIGNER()))
4 RETURN 0
5 RETURN 1
End Function

Function RetrieveToken(amount Uint64) Uint64
1 IF LOAD("owner") != ADDRESS_STRING(SIGNER()) THEN GOTO 5
2 SEND_ASSET_TO_ADDRESS(SIGNER(), 1, SCID())
3 STORE("owner", "")
4 RETURN 0
5 RETURN 1
End Function