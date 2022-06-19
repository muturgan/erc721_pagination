export { abi } from './build/contracts/ERC721Pagination.json';
export { abi as interfaceAbi } from './build/contracts/IERC721Pagination.json';
export { ERC721Pagination, ERC721Pagination__factory, IERC721Pagination, IERC721Pagination__factory } from './typechain-types';

export const ERC721_PAGINATION_INTREFACE_ID = '0xfca7958f';

export type TokenData = [number, string];
export interface ITokensList {
	readonly tokens: TokenData[];
}
