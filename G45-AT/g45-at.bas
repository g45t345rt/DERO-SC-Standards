Function InitializePrivate(startSupply Uint64, decimals Uint64, collection String, metadataFormat String, metadata String, freezeCollection Uint64, freezeMetadata Uint64) Uint64
1 IF EXISTS("minter") == 1 THEN GOTO 17
2 STORE("minter", SIGNER())
3 STORE("originalMinter", SIGNER())
4 STORE("type", "G45-AT")
5 STORE("timestamp", BLOCK_TIMESTAMP())
6 SEND_ASSET_TO_ADDRESS(SIGNER(), startSupply, SCID())
7 STORE("collection", collection)
8 STORE("maxSupply", 0)
9 STORE("totalSupply", startSupply)
10 STORE("decimals", decimals)
11 STORE("metadataFormat", metadataFormat)
12 STORE("metadata", metadata)
13 STORE("frozenCollection", freezeCollection)
14 STORE("frozenMint", 0)
15 STORE("frozenMetadata", freezeMetadata)
16 RETURN 0
17 RETURN 1
End Function

Function SetMetadata(format String, metadata String) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 6
2 IF LOAD("frozenMetadata") >= 1 THEN GOTO 6
3 STORE("metadataFormat", format)
4 STORE("metadata", metadata)
5 RETURN 0
6 RETURN 1
End Function

Function SetCollection(collection String) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 5
2 IF LOAD("frozenCollection") >= 1 THEN GOTO 5
3 STORE("collection", collection)
4 RETURN 0
5 RETURN 1
End Function

Function Mint(amount Uint64) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 6
2 IF LOAD("frozenMint") >= 1 THEN GOTO 6
3 STORE("totalSupply", LOAD("totalSupply") + amount)
4 SEND_ASSET_TO_ADDRESS(LOAD("minter"), amount, SCID())
5 RETURN 0
6 RETURN 1
End Function

Function Burn() Uint64
1 STORE("totalSupply", LOAD("totalSupply") - ASSETVALUE(SCID()))
2 RETURN 0
End Function

Function Freeze(mint Uint64, metadata Uint64, collection Uint64) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 10
2 IF mint == 0 THEN GOTO 5
3 STORE("frozenMint", 1)
4 STORE("maxSupply", LOAD("totalSupply"))
5 IF metadata == 0 THEN GOTO 7
6 STORE("frozenMetadata", 1)
7 IF collection == 0 THEN GOTO 9
8 STORE("frozenCollection", 1)
9 RETURN 0
10 RETURN 1
End Function

Function DisplayToken() Uint64
1 DIM amount as Uint64
2 DIM signerString as String
3 LET signerString = ADDRESS_STRING(SIGNER())
4 IF signerString == "" THEN GOTO 10
5 LET amount = ASSETVALUE(SCID())
6 IF EXISTS("owner_" + signerString) == 0 THEN GOTO 8
7 LET amount = amount + LOAD("owner_" + signerString)
8 STORE("owner_" + signerString, amount)
9 RETURN 0
10 RETURN 1
End Function

Function RetrieveToken(amount Uint64) Uint64
1 DIM storedAmount as Uint64
2 DIM signerString as String
3 LET signerString = ADDRESS_STRING(SIGNER())
4 LET storedAmount = LOAD("owner_" + signerString)
5 IF amount > storedAmount THEN GOTO 13
6 SEND_ASSET_TO_ADDRESS(SIGNER(), amount, SCID())
7 LET storedAmount = storedAmount - amount
8 IF storedAmount == 0 THEN GOTO 11
9 STORE("owner_" + signerString, storedAmount)
10 RETURN 0
11 DELETE("owner_" + signerString)
12 RETURN 0
13 RETURN 1
End Function

Function TransferMinter(newMinter string) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 4
2 STORE("tempMinter", ADDRESS_RAW(newMinter))
3 RETURN 0
4 RETURN 1
End Function

Function CancelTransferMinter() Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 4
2 DELETE("tempMinter")
3 RETURN 0
4 RETURN 1
End Function

Function ClaimMinter() Uint64
1 IF LOAD("tempMinter") != SIGNER() THEN GOTO 5
2 STORE("minter", SIGNER())
3 DELETE("tempMinter")
4 RETURN 0
5 RETURN 1
End Function