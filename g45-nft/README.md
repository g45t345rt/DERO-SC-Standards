# G45-NFT-Standard

`DO NOT USE - NOT TESTED - STILL UNDER REVIEW`

A real public/private DERO NFT Asset Token.  
The SCID is the NFT token unique hash and the balance represent prints/supply/ownership usually 1 for a traditional NFT.  
This NFT Standard uses multiple Smart Contracts to match NFT with a collection.  

- One smart contract per NFTs (not efficient but only way to get real Asset Token)
- One master smart contract listing all NFTs SCID from the collection

If you modify the code, it won't be seen as a valid G45-NFT-Standard within community apps.  

## What are the functionalities?

- You can verify the authenticity of the NFT with the minter/originalMinter address
- You can prove that you own the NFT with your balance or by using `DisplayToken` to publicly prove ownership (for dapps).
- You can transfer/trade the NFT to another wallet or send the asset token to whatever smart contract
- The NFT values/attributes can be immutable
- The NFT supply can be immutable
- The NFT collection SCID can be immutable
- You can burn the NFT publicly or privately
- You can increase supply and sell multiple instances of the same NFT. Total supply is transaparent and minter can't cheat.  

## G45-NFT Smart Contract

This smart contract represent the actual NFT.  
It contains the NFT metadata and can be initialize to be public or private.  

Use `Initialize()` for public NFT and the SC_CODE checksum should be
``

Use `InitializePrivate()` for private NFT and the SC_CODE checksum should be
``

### InitStore

Set initial NFT values - supply, metadata, freezeMetadata, freezeSupply, freezeCollection.

- collection = The SCID of the master smart contract (can be empty if you did not deploy a collection)
- supply - Amount of NFT prints in atomic value
- metadata = The NFT values/attributes - preferably in JSON Stringify format but I have no control over this so you can put whatever you want
Dero Seals example: `"{\"id\":2,\"rarity\":271.51,\"attributes\":{\"background\":33,\"base\":31,\"eyes\":8,\"hair_and_hats\":12,\"shirts\":2}}"`
- freezeCollection = Immutable collection SCID - 0 is false, 1 is true
- freezeMetadata = Immutable metadata - 0 is false, 1 is true
- freezeSupply = Immutable supply - 0 is false, 1 is true

### SetMetadata

Change NFT metadata if not frozen

- metadata = Check InitStore metadata example

### AddSupply

Increment NFT supply if not frozen

### Burn

Publicly burn NFT supply. In Dero you can burn any asset privately but use this if you want to apply changes to the `supply` variable.

### Freeze

Freeze supply, metadata or collection SCID. Make variables immutable.  

- supply = 0:skip, 1:freeze
- metadata = 0:skip, 1:freeze
- collection = 0:skip, 1:freeze

### DisplayToken

Because the token is private there is no way to know if you own the NFT within dapps.  
Use this function to send the token and display the signer address.  

### RetrieveToken

Retrieve the locked tokens within smart contract

- amount = The amount of token to retrieve

### TransferMinter

Initiate minter wallet address change

- newMinter = wallet address

### CancelTransferMinter

Cancel pending minter transfer

### ClaimMinter

Claim pending minter address

## G45-NFT-COLLECTION Smart Contract

The SC_CODE checksum is ``

This represent your NFT Collection and should list all minted NFTs.  
Make sure owner match with minter.  
You don't have to deploy a smart contract collection but it increases the authenticity of NFTs between minter and owner.  

### SetNft

Set a NFT to the collection. Increment `nftCount` if does not already exists.

- nft = SCID of the NFT smart contract
- index = whatever index/number representing the nft

### DelNft

Remove NFT from collection

- nft = SCID of the NFT smart contract

### Freeze

Freeze metadata or collection/nfts. Make variables immutable.  

- collection = 0:skip, 1:freeze
- metadata = 0:skip, 1:freeze

### SetMetadata

Change collection metadata if not frozen - preferably in JSON format

- metadata = Check InitStore metadata example

### TransferOwnership

Initiate new smart contract ownership

- newOwner = wallet address

### CancelOwnership

Cancel pending ownership transfer

### ClaimOwnership

Claim pending ownership
