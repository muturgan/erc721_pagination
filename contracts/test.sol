// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import './ERC721Pagination.sol';


contract TestPagination is ERC721Pagination
{
	uint private _tokenIdCounter;

	constructor() ERC721('Test', 'TST') ERC721Pagination(20, 100) {}

	function mintItem(address to, string memory uri) public returns (uint256) {
		unchecked {
			_tokenIdCounter += 1;
		}
		uint256 tokenId = _tokenIdCounter;
		_safeMint(to, tokenId);
		_setTokenURI(tokenId, uri);
		return tokenId;
	}

	function burn(uint256 tokenId) external {
		_burn(tokenId);
	}


	// <<<<< The following functions are overrides required by Solidity.
	function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721Pagination) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function _burn(uint256 tokenId) internal override(ERC721Pagination) {
		super._burn(tokenId);
	}

	function tokenURI(uint256 tokenId) public view override(ERC721Pagination) returns (string memory) {
		return super.tokenURI(tokenId);
	}

	function supportsInterface(bytes4 interfaceId) public view override(ERC721Pagination) returns (bool) {
		return super.supportsInterface(interfaceId);
	}
	// >>>> These functions are overrides required by Solidity.
}

contract BadConstructor1 is ERC721Pagination
{
	constructor() ERC721('Test', 'TST') ERC721Pagination(0, 100) {}

	// <<<<< The following functions are overrides required by Solidity.
	function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721Pagination) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function _burn(uint256 tokenId) internal override(ERC721Pagination) {
		super._burn(tokenId);
	}

	function tokenURI(uint256 tokenId) public view override(ERC721Pagination) returns (string memory) {
		return super.tokenURI(tokenId);
	}

	function supportsInterface(bytes4 interfaceId) public view override(ERC721Pagination) returns (bool) {
		return super.supportsInterface(interfaceId);
	}
	// >>>> These functions are overrides required by Solidity.
}

contract BadConstructor2 is ERC721Pagination
{
	constructor() ERC721('Test', 'TST') ERC721Pagination(10, 5) {}

	// <<<<< The following functions are overrides required by Solidity.
	function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal override(ERC721Pagination) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function _burn(uint256 tokenId) internal override(ERC721Pagination) {
		super._burn(tokenId);
	}

	function tokenURI(uint256 tokenId) public view override(ERC721Pagination) returns (string memory) {
		return super.tokenURI(tokenId);
	}

	function supportsInterface(bytes4 interfaceId) public view override(ERC721Pagination) returns (bool) {
		return super.supportsInterface(interfaceId);
	}
	// >>>> These functions are overrides required by Solidity.
}
