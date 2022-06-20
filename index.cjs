const { abi } = require('./build/contracts/ERC721Pagination.json');
const { abi: interfaceIdAbi } = require('./build/contracts/ERC721PaginationInterfaceId.json');
const { abi: interfaceAbi } = require('./build/contracts/IERC721Pagination.json');
module.exports.abi = abi;
module.exports.interfaceIdAbi = interfaceIdAbi;
module.exports.interfaceAbi = interfaceAbi;
module.exports.ERC721_PAGINATION_INTREFACE_ID = '0xfca7958f';
