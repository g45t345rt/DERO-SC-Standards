Function Initialize() Uint64
10 IF EXISTS("minter") == 1 THEN GOTO 1
20 STORE("minter", SIGNER())
30 RETURN 0
40 RETURN 1
End Function

Function internalDelete(name String, scId String)
10 DELETE("scid_" + name)
20 DELETE("name_" + scId)
30 DELETE("expire_" + name)
40 IF EXISTS("addr_" + name) = 0 THEN GOTO 50
50 DELETE("addr_" + name)
60 RETURN
End Function

// Bind name with native token
Function Attach(scId String, name String, setAddr Uint64) Uint64
10 DIM signer as String
20 LET signer = SIGNER()
30 IF ASSETVALUE(scId) == 0 THEN GOTO 160 // need to burn native token
40 IF EXISTS("expire_" + name) == 0 THEN GOTO 70 // if expire is present means that name is also taken so check expiration
50 IF BLOCK_TIMESTAMP() < LOAD("expire_" + name) THEN GOTO 160 // name expired (never renewed) anybody can overwrite :D
60 internalDelete(name, LOAD("scid_" + name))
70 IF EXISTS("name_" + scId) == 1 THEN GOTO 160 // native token already used (one NFT per name)
80 STORE("scid_" + name, scId)
90 STORE("name_" + scId, name)
100 STORE("expire_" + name, BLOCK_TIMESTAMP() + 31536000)
110 IF setAddr == 0 THEN GOTO 130
120 IF ADDRESS_STRING(signer) == "" THEN GOTO 160
130 STORE("addr_" + name, signer)
140 SEND_ASSET_TO_ADDRESS(signer, 1, scId) // give native token back
150 RETURN 0
160 RETURN 1
End Function

// Reset expiration date (anyone can snatch if not renew after one year)
Function Renew(scId String)
10 IF ASSETVALUE(scId) == 0 THEN GOTO 60 // need the native token
20 IF EXISTS("name_" + scId) == 0 THEN GOTO 60 // name is not used
30 STORE("expire_" + LOAD("name_" + scId), BLOCK_TIMESTAMP() + 31536000)
40 SEND_ASSET_TO_ADDRESS(SIGNER(), 1, scId) // give native token back
50 RETURN 0
60 RETURN 1
End Function

// Detach native token from name
Function Detach(scId String) Uint64
10 DIM name as String
20 IF ASSETVALUE(scId) == 0 THEN GOTO 80 // need the native token
30 IF EXISTS("name_" + scId) == 0 THEN GOTO 80 // name is not used
40 LET name = LOAD("name_" + scId)
50 internalDelete(name, scId)
60 SEND_ASSET_TO_ADDRESS(SIGNER(), 1, scId) // give native token back
70 RETURN 0
80 RETURN 1
End Function

// Bind signer address with native token as authorization key
Function BindAddress(scId String) Uint64
10 DIM scid, name, signer as String
20 LET signer = SIGNER()
30 IF ADDRESS_STRING(signer) == "" THEN GOTO 100 // make sure you don't use ringsize 2
40 IF ASSETVALUE(scid) == 0 THEN GOTO 100 // need the native token
50 IF EXISTS("name_" + scid) == 0 THEN GOTO 100 // check if scid is bind to a name
60 LET name = LOAD("name_" + scid)
70 STORE("addr_" + name, signer)
80 SEND_ASSET_TO_ADDRESS(signer, 1, scid)
90 RETURN 0
100 RETURN 1
End Function