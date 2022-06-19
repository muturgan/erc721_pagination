# erc721_pagination
![NPM Version Badge](https://img.shields.io/npm/v/erc721_pagination?logo=npm)
![Coverage Badge](https://img.shields.io/endpoint?url=https://gist.githubusercontent.com/muturgan/5456fa372e2a643b9560516090e7283f/raw/erc721_pagination_coverage.json)
![License Badge](https://img.shields.io/npm/l/erc721_pagination)

provides useful view functions for getting a ERC721 tokens list on your frontend

## Add view functions to your ERC721 contract
``` js
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12; // using erc721_pagination@^1.0.0 with a pragma solidity below 0.8.12

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
		console.log(`an uri of token with id ${tokenId} is ${tokenUri}`);
	});
})();
```

## Typescript usage
``` js
import { ERC721Pagination, ITokensList, TokenData } from 'erc721_pagination';

(async () => {
	const contract = await ethers.getContractAt<ERC721Pagination>(abi, 'contract address');
	const json = await contract.getAllTokens(1, 5);
	const tokensList: ITokensList = JSON.parse(json);
	tokensList.tokens.forEach(([tokenId, tokenUri]: TokenData) => {
		console.log(`${tokenId} -> ${tokenUri}`);
	});
})();
```