Function Initialize() Uint64
10 STORE("minter", SIGNER())
20 STORE("type", "T345-NFT")
30 STORE("init", 0)
40 RETURN 0
End Function

Function InitStore(collection String, supply Uint64, metadata String, frozen Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("init") == 0 THEN GOTO 50
40 RETURN 1
50 IF supply > 0 THEN GOTO 70
60 RETURN 1
70 IF frozen <= 1  THEN GOTO 90
80 RETURN 1
90 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
100 STORE("collection", collection)
110 STORE("metadata", metadata)
120 STORE("supply", supply)
130 STORE("frozen", frozen)
140 STORE("init", 1)
150 RETURN 0
End Function

Function Set(supply Uint64, metadata String, frozen Uint64) Uint64
10 IF LOAD("minter") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF frozen <= 1  THEN GOTO 50
40 RETURN 1
50 STORE("metadata", metadata)
60 STORE("frozen", frozen)
70 STORE("supply", LOAD("supply") + supply)
80 SEND_ASSET_TO_ADDRESS(LOAD("minter"), supply, SCID())
90 RETURN 0
End Function