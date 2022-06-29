# G45-NFT Standard (PRIVATE)

As AssetToken with balance.  
This NFT Standard uses multiple Smart Contracts to avoid copycats and creator disloyalty.

- One smart contract per NFTs
- One master smart contract representing the NFT collection

## G45-NFT

This smart contract represent the actual NFT. It contains a bunch of required metadata including custom unique attributes.  
It should be minted for each NFT in your collection.  
Ownership of the NFT is in balance.

Keys

- minter = SIGNER() value on mint and can't be changed / orignal creator
- type = Standard type "G45-NFT" - to distinguish between other sc call and other format
- attr_{name} = Custom attribute. The value can be anything your NFT represent

## G45-NFT-COLLECTION

This represent your NFT Collection.

Keys

- owner = SIGNER() value on creation
- name = Name of the NFT Collection
- type = Standard collection type "G45-NFT-COLLECTION"
- nft_count = Total suply of NFTs
- nft_{SCID} = NFT Index - mint all your nfts first and then create this including the list of all hashes

## What are the functionalities?

- You can verify the authenticity of the NFT with the minter address
- You can prove that you own the NFT with your balance
- You can transfer/trade the NFT for DERO or any Asset Token
- The NFT values/attributes are immutable
- You can burn the NFT by sending the balance to a null address (I think?)
