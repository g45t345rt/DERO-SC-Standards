# G45-AT(C) Standard

`DO NOT USE - NOT TESTED - STILL UNDER REVIEW`

A real private/public DERO Asset Token.  
The SCID is the token unique hash and the balance represent owners/prints/supply usually 1 for a NFT.  
The Standard uses multiple Smart Contracts to match nfts within a collection.  

You can use the standard for basically anything like representing a single piece of art, artwork collection to event tickets, prints & simply asset tokens.  
The beauty of the standard is that if you modify the code it is very easy to know that it's not authentic.  
This avoids the task of reading the code to validate legitimacy.  

For NFTs  

- One smart contract per NFT with frozen supply of 1 (not efficient but only way to get real Asset Token)
- One master smart contract listing all NFTs in the collection (not required)

## What are the functionalities?

- You can verify the authenticity of the asset with the minter/originalMinter address
- You can prove that you own the asset with your balance or by using `DisplayToken` to publicly prove ownership (for dapps).
- You can transfer/trade the asset to another wallet or send the asset token to whatever smart contract
- The asset values/attributes (metadata) can be immutable
- The asset supply can be immutable
- The asset collection SCID can be immutable
- You can burn the asset publicly or privately
- You can increase supply and sell multiple instances of the same NFT/Asset. Total supply is transaparent and minter can't cheat.  

## G45-AT Smart Contract - AT for Asset Token

This smart contract represent the actual asset.  
It contains the NFT/Asset metadata and can be initialize to be public or private.  

Use `Initialize()` for public asset and the SC_CODE checksum should be
``

Use `InitializePrivate()` for private asset and the SC_CODE checksum should be
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

Change metadata if not frozen

- metadata = Check InitStore metadata example

### AddSupply

Increment supply if not frozen

### Burn

Publicly burn supply. In Dero you can burn any asset privately but use this if you want to apply changes to the `supply` variable.

### Freeze

Freeze supply, metadata or collection SCID. Make variables immutable.  

- supply = 0:skip, 1:freeze
- metadata = 0:skip, 1:freeze
- collection = 0:skip, 1:freeze

### DisplayToken

Because the token is private there is no way to know if you own the asset within dapps.  
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

## G45-ATC Smart Contract - ATC for Asset Token Collection

The SC_CODE checksum is ``

This represent your asset collection and should list all minted NFTs or assets.  
Always nice that the owner of the collection match the asset minting address.  
You don't have to deploy a smart contract collection but it increases the authenticity of NFTs between minter and owner.  

### SetAsset

Set an asset to the collection. Increment `assetCount` if does not already exists.

- asset = SCID of the asset smart contract
- index = whatever index/number representing the asset

### DelAsset

Remove asset from collection

- asset = SCID of the asset smart contract

### Freeze

Freeze metadata or collection. Make variables immutable.  

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
