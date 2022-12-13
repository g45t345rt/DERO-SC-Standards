# Proposal for Address Names as Native Token

**NOT TESTED**

## Problem

Names are currently associated with an address only.  
You can transfer it to another address but can't really sell it in a trustless manner.  

## Solution

Bind the name to a native token instead of an address. The NFT becomes the key to bind the address.  
The name can now be sold trustlessly on a NFT plaform like <https://deronfts.com>  
Make it so that you have at least a year to renew the name. Expired name can be overwrite by anyone.  
Free to attach a name and renew.  

## Functions

- Attach (register name with NFT smart contract)
- Detach (remove name, nft & address binding)
- BindAddress (set or change wallet address associated with the signer)
- Renew (reset expiration date, block_timestam+1year)

## Note

Someone can deploy a token smart contract instead of an NFT.  
This basically give the possibility to have multiple owners binding the signer address. Best to verify smart contract code associated with the name and see if it's an actual NFT.  
(NFT verification can be done programmatically)  
