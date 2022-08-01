Function InitializePrivate() Uint64
10 IF EXISTS("minter") == 0 THEN GOTO 30
20 RETURN 1
30 STORE("minter", SIGNER())
40 STORE("type", "G45-NFT")
50 STORE("init", 0)
60 RETURN 0
End Function

Function InitStore(collection String, supply Uint64, metadata String, freezeMetadata Uint64, freezeSupply Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("init") == 0 THEN GOTO 50
40 RETURN 1
50 IF supply > 0 THEN GOTO 70
60 RETURN 1
70 IF freezeMetadata <= 1  THEN GOTO 90
80 RETURN 1
90 IF freezeSupply <= 1  THEN GOTO 110
100 RETURN 1
110 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
120 STORE("collection", collection)
130 STORE("metadata", metadata)
140 STORE("supply", supply)
150 STORE("frozenMetadata", freezeMetadata)
160 STORE("frozenSupply", freezeSupply)
170 STORE("init", 1)
180 RETURN 0
End Function

Function SetMetadata(metadata String) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenMetadata") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("metadata", metadata)
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

Function FreezeMetadata() Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("frozenMetadata", 1)
40 RETURN 0
End Function

Function FreezeSupply() Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("frozenSupply", 1)
40 RETURN 0
End Function

Function DisplayToken() Uint64
10 DIM amount as Uint64
20 DIM signerString as String
30 LET signerString = ADDRESS_STRING(SIGNER())
40 LET amount = 0
50 IF EXISTS("owner_" + signerString) == 0 THEN GOTO 70
60 LET amount = LOAD("owner_" + signerString)
70 LET amount = amount + ASSETVALUE(SCID())
80 STORE("owner_" + signerString, amount)
90 RETURN 0
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