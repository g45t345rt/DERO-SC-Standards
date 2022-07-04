Function PrivateInitialize() Uint64
10 STORE("minter", SIGNER())
20 STORE("type", "G45-NFT")
30 STORE("init", 0)
40 RETURN 0
End Function

Function InitStore(collection String, supply Uint64, metadata String, frozenMetadata Uint64, frozenSupply Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("init") == 0 THEN GOTO 50
40 RETURN 1
50 IF supply > 0 THEN GOTO 70
60 RETURN 1
70 IF frozenMetadata <= 1  THEN GOTO 90
80 RETURN 1
90 IF frozenSupply <= 1  THEN GOTO 110
100 RETURN 1
110 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
100 STORE("collection", collection)
110 STORE("metadata", metadata)
120 STORE("supply", supply)
130 STORE("frozenMetadata", frozenMetadata)
140 STORE("frozenSupply", frozenSupply)
150 STORE("init", 1)
160 RETURN 0
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