# DERO SC Standards

This is a repository where I post all of my Smart Contract standards for the Dero Community.  

## G45-AT

This standard is a real private/public DERO Asset Token.  
The SCID is the token unique hash and the balance represent owners/prints/supply. An NFT is usually a frozen supply of 1.  

Status: `DONE - VERIFIED`  

## G45-C

This standard describe a collection of Smart Contracts or any type of assets.  

Status: `DONE - VERIFIED`  

## G45-FAT

A simple form of G45-AT to express a fixed amount of supply.  

Status: `DONE - VERIFIED`  

## G45-NFT

This is the simplest Smart Contract for representing a Native Dero NFT.  
Cheap to mint (unless you have a lot of metadata) with less functionality than G45-AT or G45-FAT.  

Status: `DONE - VERIFIED`  

## G45-NAME

Register names as NFT instead of address string.  

Status: `PROPOSAL - NOT TESTED`  

## T345

This standard uses one Smart Contract to represent an entire collection of assets.  
The Asset unique id is the SCID() + index number. It is not a real asset token.  

Status: `UNDER DEVELOPMENT - USELESS I WOULD SAY`  

## Meanings

`G45` and `T345` has no meaning, it's just letters that are part of my username.  
`AT` = Asset Token  
`C` = Collection  
`NFT` = Non Fungible Token - unique and non-divisible (supply of 1)  
`FAT` = Fixed Asset Token  

## Comparison Overview

A quick comparison between G45-AT and T345.  

![sc standard comparison](https://github.com/g45t345rt/DERO-SC-Standards/blob/master/sc_comparison.png?raw=true)
