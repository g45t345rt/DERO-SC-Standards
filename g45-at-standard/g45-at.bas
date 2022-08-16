Function InitializePrivate() Uint64
10 IF EXISTS("minter") == 0 THEN GOTO 30
20 RETURN 1
30 STORE("minter", SIGNER())
40 STORE("originalMinter", SIGNER())
50 STORE("type", "G45-AT")
60 STORE("init", 0)
70 STORE("timestamp", BLOCK_TIMESTAMP())
80 RETURN 0
End Function

Function InitStore(collection String, supply Uint64, metadataFormat String, metadata String, freezeCollection Uint64, freezeSupply Uint64, freezeMetadata Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("init") == 0 THEN GOTO 50
40 RETURN 1
50 IF supply > 0 THEN GOTO 70
60 RETURN 1
70 IF freezeCollection <= 1  THEN GOTO 90
80 RETURN 1
90 IF freezeSupply <= 1  THEN GOTO 110
100 RETURN 1
110 IF freezeMetadata <= 1  THEN GOTO 130
120 RETURN 1
130 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
140 STORE("collection", collection)
150 STORE("supply", supply)
160 STORE("metadataFormat", metadataFormat)
170 STORE("metadata", metadata)
180 STORE("frozenCollection", freezeCollection)
190 STORE("frozenMetadata", freezeMetadata)
200 STORE("frozenSupply", freezeSupply)
210 STORE("init", 1)
220 RETURN 0
End Function

Function SetMetadata(format String, metadata String) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenMetadata") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("metadataFormat", format)
60 STORE("metadata", metadata)
70 RETURN 0
End Function

Function SetCollection(collection String) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenCollection") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("collection", collection)
60 RETURN 0
End Function

Function AddSupply(supply Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenSupply") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("supply", LOAD("supply") + supply)
60 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
70 RETURN 0
End Function

Function Burn() Uint64
10 STORE("supply", LOAD("supply") - ASSETVALUE(SCID()))
20 RETURN 0
End Function

Function Freeze(supply Uint64, metadata Uint64, collection Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF supply == 0 THEN GOTO 50
40 STORE("frozenSupply", 1)
50 IF metadata == 0 THEN GOTO 70
60 STORE("frozenMetadata", 1)
70 IF collection == 0 THEN GOTO 90
80 STORE("frozenCollection", 1)
90 RETURN 0
End Function

Function DisplayToken() Uint64
10 DIM amount as Uint64
20 DIM signerString as String
30 LET signerString = ADDRESS_STRING(SIGNER())
40 IF signerString != "" THEN GOTO 60
50 RETURN 1
60 LET amount = ASSETVALUE(SCID())
70 IF amount > 0 THEN GOTO 90
80 RETURN 1
90 IF EXISTS("owner_" + signerString) == 0 THEN GOTO 110
100 LET amount = amount + LOAD("owner_" + signerString)
110 STORE("owner_" + signerString, amount)
120 RETURN 0
End Function

Function RetrieveToken(amount Uint64) Uint64
10 DIM storedAmount as Uint64
20 DIM signerString as String
30 LET signerString = ADDRESS_STRING(SIGNER())
40 LET storedAmount = LOAD("owner_" + signerString)
50 IF amount <= storedAmount THEN GOTO 70
60 RETURN 1
70 SEND_ASSET_TO_ADDRESS(SIGNER(), amount, SCID())
80 LET storedAmount = storedAmount - amount
90 IF storedAmount == 0 THEN GOTO 120
100 STORE("owner_" + signerString, storedAmount)
110 RETURN 0
120 DELETE("owner_" + signerString)
130 RETURN 0
End Function

Function TransferMinter(newMinter string) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("tempMinter", ADDRESS_RAW(newMinter))
40 RETURN 0
End Function

Function CancelTransferMinter() Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 DELETE("tempMinter")
40 RETURN 0
End Function

Function ClaimMinter() Uint64
10 IF LOAD("tempMinter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("minter", SIGNER())
40 DELETE("tempMinter")
50 RETURN 0
End Function