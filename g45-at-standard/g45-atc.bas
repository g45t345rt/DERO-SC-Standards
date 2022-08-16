Function Initialize() Uint64
10 IF EXISTS("owner") == 0 THEN GOTO 30
20 RETURN 1
30 STORE("owner", SIGNER())
40 STORE("originalOwner", SIGNER())
50 STORE("type", "G45-ATC")
60 STORE("frozenCollection", 0)
70 STORE("frozenMetadata", 0)
80 STORE("metadataFormat", "")
90 STORE("metadata", "")
100 STORE("assetCount", 0)
110 STORE("timestamp", BLOCK_TIMESTAMP())
120 RETURN 0
End Function

Function Freeze(collection Uint64, metadata Uint64) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF collection == 0 THEN GOTO 50
40 STORE("frozenCollection", 1)
50 IF metadata == 0 THEN GOTO 70
60 STORE("frozenMetadata", 1)
70 RETURN 0
End Function

Function SetAsset(asset String, index Uint64) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenCollection") == 0 THEN GOTO 50
40 RETURN 1
50 IF EXISTS("asset_" + asset) == 1 THEN GOTO 70
60 STORE("assetCount", LOAD("assetCount") + 1)
70 STORE("asset_" + asset, index)
80 RETURN 0
End Function

Function DelAsset(asset String) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenCollection") == 0 THEN GOTO 50
40 RETURN 1
50 IF EXISTS("asset_" + asset) == 1 THEN GOTO 70
60 RETURN 1
70 DELETE("asset_" + asset)
80 STORE("assetCount", LOAD("assetCount") - 1)
90 RETURN 0
End Function

Function SetMetadata(format String, metadata String) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("frozenMetadata") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("metadataFormat", format)
60 STORE("metadata", metadata)
70 RETURN 0
End Function

Function TransferOwnership(newOwner string) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("tempOwner", ADDRESS_RAW(newOwner))
40 RETURN 0
End Function

Function CancelTransferOwnership() Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 DELETE("tempOwner")
40 RETURN 0
End Function

Function ClaimOwnership() Uint64
10 IF LOAD("tempOwner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE("owner", SIGNER())
40 DELETE("tempOwner")
50 RETURN 0
End Function