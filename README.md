# erc721_pagination
![NPM Version Badge](https://img.shields.io/npm/v/erc721_pagination?logo=npm)
![License Badge](https://img.shields.io/npm/l/erc721_pagination)

provides useful view functions for getting a ERC721 tokens list on your frontend

## Add view functions to your ERC721 contract
``` js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "erc721_pagination/contracts/ERC721Pagination.sol";

contract YourCollectible is ERC721Pagination
{
    constructor()
		ERC721("Your Collection Name", "YCN")
		ERC721Pagination(20, 100) // defaultPageSize, maxPageSize
	{}

    // ...
}
```

## Usage on frontend
``` js
import { ethers } from 'ethers';
import { abi } from 'erc721_pagination';

const provider = new ethers.providers.InfuraProvider('rinkeby'); // why not

const yourErc721 = new ethers.Contract(
	'contract address',
	abi,
	provider,
);

(async () => {
	const pageNumber = 1;
	const pageSize = 10;

	const json1 = await yourErc721.getAllTokens(pageNumber, pageSize);
	console.log(JSON.parse(json1)); // {tokens: [[1, "url1"], [2, "url2"], [3, "url3"]]}

	const json2 = await yourErc721.getTokensOf('some user address', pageNumber, pageSize);
	console.log(JSON.parse(json2)); // {tokens: [[1, "url1"], [2, "url2"]]}

	JSON.parse(json2).tokens.map(([tokenId, tokenUri]) => {
		console.log(`a uri of token with id ${tokenId} is ${tokenUri}`);
	});
})();
```