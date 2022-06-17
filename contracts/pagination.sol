// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import '@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol';
import '@openzeppelin/contracts/utils/Strings.sol';


abstract contract ERC721Pagination is ERC721Enumerable, ERC721URIStorage
{
	using Strings for uint256;

	uint public constant MIN_PAGE_NUMBER = 1;
	uint public immutable DEFAULT_PAGE_SIZE;
	uint public immutable MAX_PAGE_SIZE;

	constructor(uint defaultPageSize, uint maxPageSize) {
		require(defaultPageSize > 0, 'invalid defaultPageSize');
		DEFAULT_PAGE_SIZE = defaultPageSize;
		require(maxPageSize >= defaultPageSize, 'invalid maxPageSize');
		MAX_PAGE_SIZE = maxPageSize;
	}

	function getAllTokens(uint _pageNumber, uint _pageSize) external view returns(string memory) {
		uint totalSupply = this.totalSupply();
		if (totalSupply == 0) {
			return '{"tokens":[]}';
		}

		uint pageSize = _pageSize == 0
			? DEFAULT_PAGE_SIZE
			: _pageSize > MAX_PAGE_SIZE
				? MAX_PAGE_SIZE
				: _pageSize;
		uint pageNumber = _pageNumber == 0 ? MIN_PAGE_NUMBER : _pageNumber;

		uint skip = pageSize * (pageNumber - 1);
		if (skip > totalSupply) {
			return '{"tokens":[]}';
		}
		uint takeTo = skip + pageSize;
		takeTo = takeTo > totalSupply ? totalSupply : takeTo;

		bytes memory b;

		for (uint i = skip + 1; i <= takeTo; i++) {
			string memory closeTag = i == takeTo ? '"]' : '"],';
			b = abi.encodePacked(b, '[', i.toString(), ',"', this.tokenURI(i), closeTag);
		}

		b = abi.encodePacked('{"tokens":[', b, ']}');

		return string(b);
	}

	function getTokensOf(address holder, uint _pageNumber, uint _pageSize) external view returns(string memory) {
		if (holder == address(0)) {
			return '{"tokens":[]}';
		}

		uint holderBalance = balanceOf(holder);
		if (holderBalance == 0) {
			return '{"tokens":[]}';
		}

		uint pageSize = _pageSize == 0
			? DEFAULT_PAGE_SIZE
			: _pageSize > MAX_PAGE_SIZE
				? MAX_PAGE_SIZE
				: _pageSize;
		uint pageNumber = _pageNumber == 0 ? MIN_PAGE_NUMBER : _pageNumber;

		uint skip = pageSize * (pageNumber - 1);
		if (skip > holderBalance) {
			return '{"tokens":[]}';
		}

		uint counted;
		uint skiped;
		uint taken;
		bytes memory b;

		for (uint i = 1; i <= this.totalSupply(); i++) {
			if (ownerOf(i) == holder) {
					counted++;

					if (skiped < skip) {
						skiped++;
						continue;
					}

					taken++;
					bool isThatsAll = counted == holderBalance || taken == pageSize;
					string memory closeTag = isThatsAll ? '"]' : '"],';
					b = abi.encodePacked(b, '[', i.toString(), ',"', this.tokenURI(i), closeTag);
					if (isThatsAll) {
						break;
					}
			}
		}

		b = abi.encodePacked('{"tokens":[', b, ']}');

		return string(b);
	}


	// <<<<< The following functions are overrides required by Solidity.
	function _beforeTokenTransfer(address from, address to, uint256 tokenId) internal virtual override(ERC721, ERC721Enumerable) {
		super._beforeTokenTransfer(from, to, tokenId);
	}

	function _burn(uint256 tokenId) internal virtual override(ERC721, ERC721URIStorage) {
		super._burn(tokenId);
	}

	function tokenURI(uint256 tokenId) public view virtual override(ERC721, ERC721URIStorage) returns (string memory) {
		return super.tokenURI(tokenId);
	}

	function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721, ERC721Enumerable) returns (bool) {
		return super.supportsInterface(interfaceId);
	}
	// >>>> These functions are overrides required by Solidity.
}
