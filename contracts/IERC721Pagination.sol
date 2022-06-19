// SPDX-License-Identifier: MIT
// https://github.com/muturgan/erc721_pagination
// https://www.npmjs.com/package/erc721_pagination
pragma solidity ^0.8.12;

interface IERC721Pagination {
	function getAllTokens(uint _pageNumber, uint _pageSize) external view returns(string memory);
	function getTokensOf(address _holder, uint _pageNumber, uint _pageSize) external view returns(string memory);
}
