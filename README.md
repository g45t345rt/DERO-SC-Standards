# G45-NFT-Standard (PUBLIC)

`DONT USE SMART CONTRACT - NOT TESTED - UNDER REVIEW`

This NFT Standard uses one Smart Contract for the entire NFT Collection.  
If you modify the code, it won't be seen as a valid G45-NFT-Standard within community apps.  

The G45-NFT-Standard SC_CODE data would be `F271598058703C36ACF57B144B894B46219C6ED55763E6225D890DF2C9693C2C` <= this will change until I finish

## Features

- You can verify the authenticity of the NFT Collection with the owner address
- You can prove that you own the NFT
- You can transfer/trade the NFT for DERO or any type of Asset Tokens
- The Smart Contract and NFT metadata are immutable
- You can burn the NFT - entirely deleted from Smart Contract (not just an empty owner address)
- Creator can set a percentage of Royalty Fees when an NFT is transfered
- Creator can set if NFTs can be burned at any time
- An NFT id is the SCID + index number

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

Arguments

- index = The NFT number

### SetRoyaltyFees

Set the royalty fees of your NFT Collection. Can only set a number lower than the current royalty fee.

Arguments

- amount = Royalty fees in percentage. The amount you get per successful transfer.

### SetBurn

Set if NFT owners can burn their NFTs.

Arguments

- value = 0 is false, 1 is true
