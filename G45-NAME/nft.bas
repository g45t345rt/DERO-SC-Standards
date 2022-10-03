Function InitializePrivate()
1 IF EXISTS("minter") == 1 THEN GOTO 6
2 SEND_ASSET_TO_ADDRESS(SIGNER(), 1, SCID())
3 STORE("minter", SIGNER())
4 STORE("type", "G45-NFT-1")
5 RETURN 0
6 RETURN 1
End Function