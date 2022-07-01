Function Initialize() Uint64
10 STORE("owner", SIGNER())
20 STORE("type", "T345-NFT-COLLECTION")
30 STORE("nft_count", 0)
40 RETURN 0
End Function

Function Add(nft String) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF EXISTS("nft_" + nft) == 0 THEN GOTO 50
40 RETURN 1
50 STORE("nft_" + nft, "")
60 STORE("nft_count", LOAD("nft_count") + 1)
70 RETURN 0
End Function