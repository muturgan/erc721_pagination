// SPDX-License-Identifier: MIT
// https://github.com/muturgan/erc721_pagination
// https://www.npmjs.com/package/erc721_pagination
pragma solidity ^0.8.12;

import './IERC721Pagination.sol';


abstract contract ERC721PaginationInterfaceId
{
	function erc721PaginationInterface() public pure returns(bytes4) {
		return type(IERC721Pagination).interfaceId;
	}
}
