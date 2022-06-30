Function Initialize() Uint64
10 STORE("minter", SIGNER())
20 STORE("type", "T345-NFT")
30 STORE("init", 0)
40 RETURN 0
End Function

Function InitStore(collection String, supply Uint64, metadata String, frozen Uint64) Uint64
10 DIM minter String
20 LET minter = LOAD("minter")
30 IF minter == SIGNER() THEN GOTO 50
40 RETURN 1
50 IF LOAD("init") == 0 THEN GOTO 70
60 RETURN 1
70 IF supply > 0 THEN GOTO 90
80 RETURN 1
90 IF frozen <= 1  THEN GOTO 110
100 RETURN 1
110 SEND_ASSET_TO_ADDRESS(minter, supply, SCID())
120 STORE("collection", collection)
130 STORE("metadata", metadata)
140 STORE("supply", supply)
150 STORE("frozen", frozen)
160 STORE("init", 1)
170 RETURN 0
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