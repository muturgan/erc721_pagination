export { abi } from './build/contracts/ERC721Pagination.json';
export { ERC721Pagination, ERC721Pagination__factory } from './typechain-types';

export type TokenData = [number, string];
export interface ITokensList {
	readonly tokens: TokenData[];
}