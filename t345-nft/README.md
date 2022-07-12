# T345-NFT-Standard (NOT AN ACTUAL TOKEN)

`DO NOT USE - NOT TESTED - STILL UNDER REVIEW`

This NFT Standard uses one Smart Contract for the entire NFT Collection.  
The NFT unique id is the SCID() + index number. It is not a real asset token.  

## Features

- You can verify the authenticity of the NFT Collection with the owner address
- You can prove that you own the NFT
- You can transfer/trade the NFT for DERO or any type of Asset Tokens
- The Smart Contract and NFT metadata are immutable
- You can burn the NFT - entirely deleted from Smart Contract (not just an empty owner address)
- Creator can set a percentage of Royalty Fees when an NFT is transfered
- Creator can set if NFTs can be burned at any time
- An NFT can be set to soulbound. It can't be tranfered after initial transfer.

## Smart Contract Functions

### InitStore

After deploying the Smart Contract. You can execute `InitStore` one time.

Arguments

- name = Name of your NFT Collection
- nftSupply = Maximum supply
- canBurn = Set if NFT owner can burn the NFT
- royaltyFees = Creator fees for each successful transfer (in percentage)

### Mint

Mint a single NFT. You cannot create more NFT than the max supply you set.
You cannot mint over an existing NFT.

Arguments

- index = The NFT index (1,2,3,4,5...)
- metadata = The NFT values/attributes - preferably in URLSearchParams format but I have no control over this so you can put whatever you want
Dero Seals example: `background=33&base=31&hairAndHats=12&shirts=4`
- soulbound = The NFT cannot be transfered - 0 is false, 1 is true
- frozen = NFT properties can't be changed - 0 is false, 1 is true

### SetNFT

You can change the metadata, soulbound or frozen state if the NFT is not already frozen

- index = The NFT number
- metadata = The NFT values/attributes - preferably in URLSearchParams
- soulbound = The NFT cannot be transfered - 0 is false, 1 is true
- frozen = Set to 1 to freeze nft (can't be undone)

### Transfer

Transfer your NFT to another owner in exchange for DERO, AssetToken or for free.

- index = The NFT number
- newOwner = The new owner DERO address to be
- assetToken = The assetToken to receive payment (empty for DERO)
- price = The price of exchange agreed before hand (0 for free)

### ClaimTransfer

Claim ownership of your new NFT.

Arguments

- index = The NFT number

### CancelTransfer

Cancel transfer of your NFT for whatever reason.

Arguments

- index = The NFT number

### Burn

The owner of the NFT can use this function to burn his NFT.  
Litteraly! Not just setting an empty owner address.  
Can't burn if NFT is in transfer.

Arguments

- index = The NFT number

### SetRoyaltyFees

Set the royalty fees of your NFT Collection.  
You can only set a number lower than the current royalty fee.

Arguments

- amount = Royalty fees in percentage. The amount you get per successful transfer.

### SetBurn

Set if NFT owners can burn their NFTs.

Arguments

- value = 0 is false, 1 is true
