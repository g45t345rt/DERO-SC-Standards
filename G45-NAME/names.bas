Function Initialize() Uint64
10 RETURN 0
End Function

Function RegisterName(name String, setAddr Uint64) Uint64
10 DIM scid, signer as String
20 LET scid = SCID()
30 LET signer = SIGNER()
40 IF ASSETVALUE(scid) == 0 THEN GOTO 140
50 IF EXISTS("scid_" + scid) == 1 THEN GOTO 140
60 IF EXISTS("name_" + name) == 1 THEN GOTO 140
70 STORE("scid_" + name, scid)
80 STORE("name_" + scid, name)
90 IF setAddr == 0 THEN GOTO 140
100 IF ADDRESS_STRING(signer) == "" THEN GOTO 140
110 STORE("addr_" + name, signer)
120 SEND_ASSET_TO_ADDRESS(scid, 1, signer)
130 RETURN 0
140 RETURN 1
End Function

Function SetAddress() Uint64
10 DIM scid, name, signer as String
20 LET scid = SCID()
30 IF ADDRESS_STRING(signer) == "" THEN GOTO 100
40 IF ASSETVALUE(scid) == 0 THEN GOTO 100
50 IF EXISTS("name_" + scid) == 0 THEN GOTO 100
60 LET name = LOAD("name_" + scid)
70 STORE("addr_" + name, signer)
80 SEND_ASSET_TO_ADDRESS(scid, 1, signer)
90 RETURN 0
100 RETURN 1
End Function

Function DelAddress() Uint64
10 DIM scid, name, signer as String
20 LET scid = SCID()
30 IF ASSETVALUE(scid) == 0 THEN GOTO 80
40 IF EXISTS("name_" + scid) == 0 THEN GOTO 80
50 LET name = LOAD("name_" + scid)
60 DELETE("addr_" + name)
70 RETURN 0
80 RETURN 1
End Function