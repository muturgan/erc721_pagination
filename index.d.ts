import { BigNumberish, CallOverrides } from 'ethers';

export { abi } from './build/contracts/ERC721Pagination.json';

export type TokenData = [number, string];
export interface ITokensList {
	readonly tokens: TokenData[];
}

export interface IERC721Pagination {
	getAllTokens(
    _pageNumber: BigNumberish | Promise<BigNumberish>,
    _pageSize: BigNumberish | Promise<BigNumberish>,
    overrides?: CallOverrides,
  ): Promise<string>;

	getTokensOf(
    holder: string | Promise<string>,
    _pageNumber: BigNumberish | Promise<BigNumberish>,
    _pageSize: BigNumberish | Promise<BigNumberish>,
    overrides?: CallOverrides,
  ): Promise<string>;
}
