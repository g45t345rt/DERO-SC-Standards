# G45-C Standard

`DO NOT USE - STILL UNDER REVIEW`

This is just a smart contract to list your assets in a decentalized way.  
You can pair this with G45-AT/G45-FAT/G45-NFT to create an NFT collection.  

## Functions

### Initialize/InitializePrivate

Set initial collection values - metadataFormat, metadata, freezeMetadata, freezeCollection.

- metadataFormat = define metadata format usually json but can be anything
- metadata = The values/attributes describing the collection
- freezeMetadata = Immutable metadata - 0 is false, 1 is true

### SetAssets

Set assets to the collection.

- assets = a json object with SCIDs  (max 100)
- index = whatever index/number representing the asset list

### DelAssets

Remove asset from collection

- index = assets index variable

### Freeze

Freeze metadata or assets. Make variables immutable.  

- assets = 0:skip, 1:freeze
- metadata = 0:skip, 1:freeze

### SetMetadata

Change collection metadata if not frozen

- format = declare metadata format (usually json)
- metadata = Check InitStore metadata example

### TransferOwnership

Initiate new smart contract ownership

- newOwner = wallet address

### CancelOwnership

Cancel pending ownership transfer

### ClaimOwnership

Claim pending ownership
