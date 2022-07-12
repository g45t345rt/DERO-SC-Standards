# G45-NFT-Standard

`DO NOT USE - NOT TESTED - STILL UNDER REVIEW`

A real public/private DERO NFT Asset Token.  
The SCID is the NFT token unique hash and the balance represent prints/supply usually 1.  
This NFT Standard uses multiple Smart Contracts to match NFT with a collection.  

- One smart contract per NFTs (not efficient but only way to get real Asset Token)
- One master smart contract listing all NFTs SCID from the collection

If you modify the code, it won't be seen as a valid G45-NFT-Standard within community apps.  

## G45-NFT Smart Contract

This smart contract represent the actual NFT.  
It contains the NFT metadata and can be initialize to be public or private.  

Use `Initialize()` for public NFT and the SC_CODE checksum should be
``

Use `InitializePrivate()` for private NFT and the SC_CODE checksum should be
``

### InitStore

Set initial NFT values - supply, metadata and frozen.

- collection = The SCID of the master smart contract
- supply - Amount of NFT prints in atomic value
- metadata = The NFT values/attributes - preferably in URLSearchParams format but I have no control over this so you can put whatever you want
Dero Seals example: `trait_background=33&trait_base=31&trait_hairAndHats=12&trait_shirts=4&fileNumber=1&rarity=243.12`
- frozenMetadata = Immutable metadata - 0 is false, 1 is true
- frozenSupply = Immutable supply - 0 is false, 1 is true

### SetMetadata

Change NFT metadata if not frozen

- metadata = The NFT values/attributes - preferably in URLSearchParams format but I have no control over this so you can put whatever you want
Dero Seals example: `trait_background=33&trait_base=31&trait_hairAndHats=12&trait_shirts=4&fileNumber=1&rarity=243.12`

A variable should be camelCase -> `fileNumber`  
A list should be represented by a prefix + underscore -> `trait_`  

### AddSupply

Increment NFT supply if not frozen

### FreezeMetadata

Set the metadata immutable if not already

### FreezeSupply

Set the supply immutable if not already

## G45-NFT-COLLECTION Smart Contract

The SC_CODE checksum is ``

This represent your NFT Collection and should list all minted NFTs.  
Make sure owner match with minter.
This is necessary in order to verify authenticity of the NFT.  

### Add

Include a new minted NFT to the collection.

- nft = SCID of the NFT smart contract

## What are the functionalities?

- You can verify the authenticity of the NFT with the minter address
- You can prove that you own the NFT with your balance
- You can transfer/trade the NFT to another wallet or send the asset token to whatever smart contract
- The NFT values/attributes can be immutable
- The NFT supply can be immutable
- You can burn the NFT by sending the balance to a null address (I think?)
