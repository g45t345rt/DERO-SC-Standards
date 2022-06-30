# T345-NFT Standard (PRIVATE)

The SCID is the NFT token unique hash and the balance represent prints/supply usually 1.  
This NFT Standard uses multiple Smart Contracts to avoid copycats and creator disloyalty.  

- One smart contract per NFTs
- One master smart contract listing all NFTs SCID

If you modify the code, it won't be seen as a valid T345-NFT-Standard within community apps.  

## T345-NFT

The T345-NFT SC_CODE checksum is `0D2C8E42A57CA68D661B8D8767D93DE1A742B5E667D13F98D26CCD034B055F30` <= this will change until I finish  

This smart contract represent the actual NFT. It contains a bunch of required metadata including custom unique attributes.  
It should be minted for each NFT in your collection.  

### InitStore

Apply NFT supply and metadata once.

- collection = The SCID of the master smart contract
- supply - Amount of NFT prints in atomic value
- metadata = The NFT values/attributes - preferably in URLSearchParams format but I have no control over this so you can put whatever you want
Dero Seals example: `background=33&base=31&hairAndHats=12&shirts=4`

## T345-NFT-COLLECTION

The T345-NFT-Collection SC_CODE checksum is `772B68CDBC673E34DFB03F5F75870A7047CE3663848D42F954E60811DCAA4D04` <= this will change until I finish  

This represent your NFT Collection.  
To distinguize orignal nfts from copycat you need a collection/master smart contract.  
Make sure owner match with minter.
This is necessary in order to verify authenticity of the NFT.  

### Add

Include new minted NFT to collection

- nft = SCID of the NFT smart contract

## What are the functionalities?

- You can verify the authenticity of the NFT with the minter address
- You can prove that you own the NFT with your balance
- You can transfer/trade the NFT to another wallet
- The NFT values/attributes are immutable
- You can burn the NFT by sending the balance to a null address (I think?)
