# G45-NFT Standard

`DO NOT USE - STILL UNDER REVIEW`

A real private/public DERO NFT.  
The SCID is the token unique hash the supply minted is 1.  

You can use the standard for basically anything like representing a single piece of art.  
The beauty of the standard is that if you modify the code it is very easy to know it's not authentic.  

`No code audit needed to validate smart contract legitimacy.`  

For an NFT collection you need

- One G45-NFT Smart Contract per NFT
- One G45-C Smart Contract for listing all NFTs in the collection (not required though)

## Private or Public?

Change `InitializePrivate()` function to `Initialize()` for public asset token. In that case, the balance will not be encrypted.  
Do not change the code other than the initialize function or the smart contract will not be a valid G45-AT.  

## Functions

### Initialize/InitializePrivate

Set initial asset values - supply, metadata, metadataFormat, freezeMetadata, freezeSupply, freezeCollection.

- collection = The SCID of the master smart contract (can be empty if you did not deploy a collection)
- metadataFormat = define metadata format usually json but can be anything
- metadata = The values/attributes describing the asset - Dero Seals example: `{"id":2,"rarity":271.51,"attributes":{"background":33,"base":31,"eyes":8,"hair_and_hats":12,"shirts":2}}`

### DisplayToken

Because the NFT is private there is no way to know if you own the asset within dapps.  
Use this function to send the token and display the NFT owner/signer address.  

### RetrieveToken

Retrieve the locked NFT within smart contract
