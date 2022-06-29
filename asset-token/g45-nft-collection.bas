// To distinguize orignal nfts from copycat you need a collection/master smart contract
// This is necessary in order to verify authenticity of the NFT
// The sc contains all the original minted nfts SCID
// This is use to make sure the original artist does not mint multiple of the same NFT

Function Initialize() Uint64
10 STORE("owner", SIGNER())
20 STORE("type", "G45-NFT-COLLECTION")
// STORE("name", "{value}")
// STORE("nft_count", {total_amount})
// STORE("nft_{SCID}", {nft_index})
// DERO Seals NFT example
// STORE("name", "Dero Seals")
// STORE("nft_count", 3500)
// STORE("nft_cc7096b195f3a7cba04710daae91693f987a78f9663c0b019b8dd0c16bb50a20", 1)
// STORE("nft_8864daabc4071d7436c6f30ad073400342e2f3f28ae5c07a7f82212e38fbb9f4", 2)
// STORE("nft_ea42dac3de8f883e98232d978d8ae0c15c590e244282fda7d73bba5096de6a4b", 3)
30 RETURN 0
End Function