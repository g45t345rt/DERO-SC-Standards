Function nftKey(index String, key String) String
10 RETURN "nftitem_" + index + "_" + key
End Function

Function Initialize() Uint64
10 STORE("owner", SIGNER())
20 STORE("type", "G45-NFT")
30 RETURN 0
End Function

Function InitStore(name String, supply Uint64, canBurn Uint64, royaltyFees Uint64) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF EXISTS("name") == 0 THEN GOTO 50
40 RETURN 1
50 STORE("name", name)
60 STORE("nft_supply", supply)
70 STORE("can_burn", canBurn)
80 STORE("royalty_fees", royaltyFees)
90 RETURN 0
End Function

Function Mint(index Uint64, metadata String) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF index > 0 THEN GOTO 50
40 RETURN 1
50 IF index <= LOAD("nft_supply") THEN GOTO 70
60 RETURN 1
70 IF EXISTS(nftKey(index, "owner")) == 0 THEN GOTO 90
80 RETURN 1
90 STORE(nftKey(index, "owner"), SIGNER())
100 STORE(nftKey(index, "metadata"), metadata)
110 STORE(nftKey(index, "mintTimestamp"), BLOCK_TIMESTAMP())
120 RETURN 0
End Function

Function Transfer(index Uint64, newOwner String, assetToken String, price Uint64) Uint64
10 IF LOAD(nftKey(index, "owner")) == SIGNER() THEN GOTO 30
20 RETURN 1
30 STORE(nftKey(index, "transferOwner"), ADDRESS_RAW(newOwner))
40 STORE(nftKey(index, "transferAssetToken"), assetToken)
50 STORE(nftKey(index, "transferPrice"), price)
60 STORE(nftKey(index, "transferTimestamp"), BLOCK_TIMESTAMP())
70 RETURN 0
End Function

Function ClaimTransfer(index Uint64) Uint64
10 DIM assetToken, signer as String
20 DIM price as Uint64
30 LET signer = SIGNER()
40 IF LOAD(nftKey(index, "transferOwner")) != signer THEN GOTO 240
50 LET assetToken = LOAD(nftKey(index, "transferAssetToken"))
60 LET price = LOAD(nftKey(index, "transferPrice"))
70 LET royaltyFees = LOAD("royalty_fees")
80 LET royaltyCut = price * royaltyFees / 100
90 IF price == 0 THEN GOTO 180
100 IF assetToken != "" THEN GOTO 140
110 IF DEROVALUE() != price THEN GOTO 240
120 SEND_DERO_TO_ADDRESS(LOAD(nftKey(index, "owner")), price - royaltyCut)
130 SEND_DERO_TO_ADDRESS(LOAD("owner"), royaltyCut)
140 IF assetToken != "" THEN GOTO 150
150 IF ASSETVALUE(assetToken) != price THEN GOTO 240
160 SEND_ASSET_TO_ADDRESS(LOAD(nftKey(index, "owner")), price - royaltyCut, assetToken)
170 SEND_ASSET_TO_ADDRESS(LOAD("owner"), royaltyCut, assetToken)
180 STORE(nftKey(index, "owner", signer))
190 DELETE(nftKey(index, "transferOwner"))
200 DELETE(nftKey(index, "transferAssetToken"))
210 DELETE(nftKey(index, "transferPrice"))
220 DELETE(nftKey(index, "transferTimestamp"))
230 RETURN 0
240 RETURN 1
End Function

Function CancelTransfer(index Uint64) Uint64
10 IF LOAD(nftKey(index, "owner")) == SIGNER() THEN GOTO 30
20 RETURN 1
30 DELETE(nftKey(index, "transferOwner"))
40 DELETE(nftKey(index, "transferAssetToken"))
50 DELETE(nftKey(index, "transferPrice"))
60 DELETE(nftKey(index, "transferTimestamp"))
70 RETURN 0
End Function

Function Burn(index Uint64) Uint64
10 IF LOAD(nftKey(index, "owner")) == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF LOAD("can_burn") == 1 THEN GOTO 50
40 RETURN 1
50 DELETE(nftKey(index, "owner"))
60 DELETE(nftKey(index, "metadata"))
70 DELETE(nftKey(index, "mintTimestamp"))
80 RETURN 0
End Function

Function SetRoyaltyFees(amount Uint64) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF amount <= 100 THEN GOTO 50
40 RETURN 1
50 STORE("royalty_fees", amount)
60 RETURN 0
End Function

Function SetBurn(value Uint64) Uint64
10 IF LOAD("owner") == SIGNER() THEN GOTO 30
20 RETURN 1
30 IF amount < 1 THEN GOTO 50
40 RETURN 1
50 STORE("can_burn", value)
60 RETURN 0
End Function