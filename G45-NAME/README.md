# Proposal for Address Names as Native Token

## Problem

Names are currently associated with an address only.  
You can transfer it to another address but can't really sell it in a trustless manner.  

## Solution

Match a name to a native token instead.  
The owner of the token can then decide to associate the name with his address.
The name could also be sold trustlessly on a NFT plaform like <https://deronfts.com>

## Steps to mint/register a name

1. Create a G45-NFT-1 Smart Contract
2. Choose a name with the scid and call `RegisterName` function from the Names Smart Contract. The scid will forever be linked with the name.
3. Profit?!?!

## Notes

1. If you burn the token you can never change the address back.
2. Someone can mint a token which is not an NFT and associate it with a name. This basically give the possibility to have multiple owners changing the address. Thats bad because someone could sell the token and then change the address back to himself after :S To avoid this the website would only sell verified real G45-NAME NFT.
