Function InitializePrivate(collection String, supply Uint64, metadataFormat String, metadata String, freezeCollection Uint64, freezeSupply Uint64, freezeMetadata Uint64) Uint64
1 DIM minter as String
2 IF EXISTS("minter") == 1 THEN GOTO 21
3 LET minter = SIGNER()
4 STORE("minter", minter)
5 STORE("originalMinter", minter)
6 STORE("type", "G45-AT")
7 STORE("timestamp", BLOCK_TIMESTAMP())
8 IF supply == 0 THEN GOTO 21
9 IF freezeCollection > 1  THEN GOTO 21
10 IF freezeSupply > 1  THEN GOTO 21
11 IF freezeMetadata > 1  THEN GOTO 21
12 SEND_ASSET_TO_ADDRESS(minter, supply, SCID())
13 STORE("collection", collection)
14 STORE("supply", supply)
15 STORE("metadataFormat", metadataFormat)
16 STORE("metadata", metadata)
17 STORE("frozenCollection", freezeCollection)
18 STORE("frozenSupply", freezeSupply)
19 STORE("frozenMetadata", freezeMetadata)
20 RETURN 0
21 RETURN 1
End Function

Function SetMetadata(format String, metadata String) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 6
2 IF LOAD("frozenMetadata") == 1 THEN GOTO 6
3 STORE("metadataFormat", format)
4 STORE("metadata", metadata)
5 RETURN 0
6 RETURN 1
End Function

Function SetCollection(collection String) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 5
2 IF LOAD("frozenCollection") == 1 THEN GOTO 5
3 STORE("collection", collection)
4 RETURN 0
5 RETURN 1
End Function

Function Mint(qty Uint64) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 6
2 IF LOAD("frozenSupply") == 1 THEN GOTO 6
3 STORE("supply", LOAD("supply") + qty)
4 SEND_ASSET_TO_ADDRESS(LOAD("minter"), qty, SCID())
5 RETURN 0
6 RETURN 1
End Function

Function Burn() Uint64
1 STORE("supply", LOAD("supply") - ASSETVALUE(SCID()))
2 RETURN 0
End Function

Function Freeze(supply Uint64, metadata Uint64, collection Uint64) Uint64
1 IF LOAD("minter") != SIGNER() THEN GOTO 9
2 IF supply == 0 THEN GOTO 4
3 STORE("frozenSupply", 1)
4 IF metadata == 0 THEN GOTO 6
5 STORE("frozenMetadata", 1)
6 IF collection == 0 THEN GOTO 8
7 STORE("frozenCollection", 1)
8 RETURN 0
9 RETURN 1
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