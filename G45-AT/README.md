# G45-AT Standard

`DO NOT USE - STILL UNDER REVIEW`

A real private/public DERO Asset Token.  
The SCID is the token unique hash and the balance represent owners/prints/supply usually 1 for a NFT.  

You can use the standard for basically anything like representing a single piece of art, artwork collection to event tickets, prints or simply a token.  
The beauty of the standard is that if you modify the code it is very easy to know it's not authentic.  

`No code audit needed to validate smart contract legitimacy.`  

For an NFT collection you need

- One G45-AT Smart Contract per NFT with frozen supply of 1 (not efficient but only way to get real Asset Token)
- One G45-ATC Smart Contract for listing all NFTs in the collection (not required though)

## What are the functionalities?

- You can verify the authenticity of the asset with the minter/originalMinter address
- You can prove that you own the asset with your balance or by using `DisplayToken` to publicly prove ownership (for dapps).
- You can transfer/trade the asset to another wallet or send the asset token to other smart contracts
- The asset values/attributes (metadata) can be immutable
- The asset supply can be immutable
- The asset collection SCID can be immutable
- You can burn the asset publicly or privately
- You can increase supply and sell multiple instances of the same NFT/Asset. Total supply is transaparent and minter can't cheat.  

## Private or Public?

Change `InitializePrivate()` function to `Initialize()` for public asset token. In that case, the balance will not be encrypted.  
Do not change the code other than the initialize function or the smart contract will not be a valid G45-AT.  

## Functions

### Initialize/InitializePrivate

Set initial asset values - supply, metadata, metadataFormat, freezeMetadata, freezeSupply, freezeCollection.

- collection = The SCID of the master smart contract (can be empty if you did not deploy a collection)
- supply - Amount of asset prints in atomic value
- metadataFormat = define metadata format usually json but can be anything
- metadata = The values/attributes describing the asset - Dero Seals example: `{"id":2,"rarity":271.51,"attributes":{"background":33,"base":31,"eyes":8,"hair_and_hats":12,"shirts":2}}`
- freezeCollection = Immutable collection SCID - 0 is false, 1 is true
- freezeMetadata = Immutable metadata - 0 is false, 1 is true
- freezeSupply = Immutable supply - 0 is false, 1 is true

### SetMetadata

Change metadata if not frozen

- format = declare metadata format (usually json)
- metadata = Check InitStore metadata example

### Mint

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
