Function storeTX()
10 STORE("txid_" + HEX(TXID()), 1)
20 RETURN
End Function

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
180 storeTX()
190 RETURN 0
End Function

Function SetMetadata(metadata String) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenMetadata") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("metadata", metadata)
60 storeTX()
70 RETURN 0
End Function

Function AddSupply(supply Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenSupply") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("supply", LOAD("supply") + supply)
60 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
70 storeTX()
80 RETURN 0
End Function

Function FreezeMetadata() Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("frozenMetadata", 1)
40 storeTX()
50 RETURN 0
End Function

Function FreezeSupply() Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("frozenSupply", 1)
40 storeTX()
50 RETURN 0
End Function