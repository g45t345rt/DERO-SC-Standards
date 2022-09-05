Function Initialize(metadataFormat String, metadata String, freezeCollection Uint64, freezeMetadata Uint64) Uint64
1 IF EXISTS("owner") == 1 THEN GOTO 14
2 IF freezeCollection > 1  THEN GOTO 14
3 IF freezeMetadata > 1  THEN GOTO 14
4 STORE("owner", SIGNER())
5 STORE("originalOwner", SIGNER())
6 STORE("type", "G45-ATC")
7 STORE("frozenCollection", 0)
8 STORE("frozenMetadata", 0)
9 STORE("metadataFormat", metadataFormat)
10 STORE("metadata", metadata)
11 STORE("assetCount", 0)
12 STORE("timestamp", BLOCK_TIMESTAMP())
13 RETURN 0
14 RETURN 1
End Function

Function Freeze(collection Uint64, metadata Uint64) Uint64
1 IF LOAD("owner") != SIGNER() THEN GOTO 7
2 IF collection == 0 THEN GOTO 4
3 STORE("frozenCollection", 1)
4 IF metadata == 0 THEN GOTO 6
5 STORE("frozenMetadata", 1)
6 RETURN 0
7 RETURN 1
End Function

Function SetAsset(asset String, index Uint64) Uint64
1 IF LOAD("owner") != SIGNER() THEN GOTO 7
2 IF LOAD("frozenCollection") == 1 THEN GOTO 7
3 IF EXISTS("asset_" + asset) == 1 THEN GOTO 5
4 STORE("assetCount", LOAD("assetCount") + 1)
5 STORE("asset_" + asset, index)
6 RETURN 0
7 RETURN 1
End Function

Function DelAsset(asset String) Uint64
1 IF LOAD("owner") != SIGNER() THEN GOTO 7
2 IF LOAD("frozenCollection") == 1 THEN GOTO 7
3 IF EXISTS("asset_" + asset) == 0 THEN GOTO 7
4 DELETE("asset_" + asset)
5 STORE("assetCount", LOAD("assetCount") - 1)
6 RETURN 0
7 RETURN 1
End Function

Function SetMetadata(format String, metadata String) Uint64
1 IF LOAD("owner") != SIGNER() THEN GOTO 6
2 IF LOAD("frozenMetadata") == 1 THEN GOTO 6
3 STORE("metadataFormat", format)
4 STORE("metadata", metadata)
5 RETURN 0
6 RETURN 1
End Function

Function TransferOwnership(newOwner string) Uint64
1 IF LOAD("owner") != SIGNER() THEN GOTO 4
2 STORE("tempOwner", ADDRESS_RAW(newOwner))
3 RETURN 0
4 RETURN 1
End Function

Function CancelTransferOwnership() Uint64
1 IF LOAD("owner") != SIGNER() THEN GOTO 4
2 DELETE("tempOwner")
3 RETURN 0
4 RETURN 1
End Function

Function ClaimOwnership() Uint64
1 IF LOAD("tempOwner") != SIGNER() THEN GOTO 5
2 STORE("owner", SIGNER())
3 DELETE("tempOwner")
4 RETURN 0
5 RETURN 1
End Function