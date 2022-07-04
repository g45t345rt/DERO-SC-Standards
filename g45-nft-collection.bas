Function Initialize() Uint64
10 STORE("owner", SIGNER())
20 STORE("type", "G45-NFT-COLLECTION")
30 STORE("nft_count", 0)
40 RETURN 0
End Function

Function Add(nft String) Uint64
10 DIM ctr as Uint64
20 IF LOAD("owner") == SIGNER() THEN GOTO 40
30 RETURN 1
40 IF EXISTS("nft_" + nft) == 0 THEN GOTO 60
50 RETURN 1
60 LET ctr = LOAD("nft_count")
70 STORE("nft_" + ctr, nft)
80 STORE("nft_" + nft, "")
90 STORE("nft_count", ctr + 1)
100 RETURN 0
End Function