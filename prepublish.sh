npm run clean
npm run compile
mkdir -p build/contracts
cp ./artifacts/contracts/ERC721Pagination.sol/ERC721Pagination.json ./build/contracts/ERC721Pagination.json
cp ./artifacts/contracts/ERC721PaginationInterfaceId.sol/ERC721PaginationInterfaceId.json ./build/contracts/ERC721PaginationInterfaceId.json
cp ./artifacts/contracts/IERC721Pagination.sol/IERC721Pagination.json ./build/contracts/IERC721Pagination.json
head -n -6 typechain-types/index.ts > temp.txt && mv temp.txt typechain-types/index.ts
rm -rf typechain-types/factories/contracts/test.sol/
rm -rf typechain-types/contracts/test.sol/
tail -n +5 typechain-types/factories/contracts/index.ts > temp.txt && mv temp.txt typechain-types/factories/contracts/index.ts
tail -n +6 typechain-types/contracts/index.ts > temp.txt && mv temp.txt typechain-types/contracts/index.ts
