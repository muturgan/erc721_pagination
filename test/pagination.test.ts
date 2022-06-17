import { assert, expect } from './chai';
import { deployments, ethers, getNamedAccounts } from 'hardhat';
import { ZERO_ADDRESS } from '../constants';
import { TestPagination } from '../typechain-types';

describe('Pagination', () => {
	it('Constructor 1', async () => {
		const factory = await ethers.getContractFactory('BadConstructor1');
		await expect(factory.deploy())
			.to.be.revertedWith(`invalid defaultPageSize`);
	});

	it('Constructor 2', async () => {
		const factory = await ethers.getContractFactory('BadConstructor2');
		await expect(factory.deploy())
			.to.be.revertedWith(`invalid maxPageSize`);
	});

	it('Should paginate correctly', async () => {
		await deployments.fixture('TestPagination');
		const testPagination = await ethers.getContract<TestPagination>('TestPagination');

		const { deployer, user1, user2 } = await getNamedAccounts();

		const notMintedJson = await testPagination.getAllTokens(1, 10);
		const notMintedTokens = JSON.parse(notMintedJson);

		await testPagination.mintItem(deployer, 'url1');
		await testPagination.mintItem(deployer, 'url2');
		await testPagination.mintItem(deployer, 'url3');
		await testPagination.mintItem(deployer, 'url4');
		await testPagination.mintItem(deployer, 'url5');

		await testPagination.transferFrom(deployer, user1, 3);
		await testPagination.transferFrom(deployer, user1, 4);

		const skipAllJson = await testPagination.getAllTokens(100500, 10);
		const skipAllTokens = JSON.parse(skipAllJson);

		const json00 = await testPagination.getAllTokens(1, 10);
		const tokents00 = JSON.parse(json00);
		const json01 = await testPagination.getAllTokens(2, 3);
		const tokents01 = JSON.parse(json01);

		const zeroAddressJson = await testPagination.getTokensOf(ZERO_ADDRESS, 1, 2);
		const zeroAddressTokens = JSON.parse(zeroAddressJson);
		const user2Json = await testPagination.getTokensOf(user2, 1, 2);
		const user2Tokens = JSON.parse(user2Json);

		const json11 = await testPagination.getTokensOf(deployer, 1, 2);
		const tokents11 = JSON.parse(json11);
		const json12 = await testPagination.getTokensOf(deployer, 2, 2);
		const tokents12 = JSON.parse(json12);

		const json2 = await testPagination.getTokensOf(user1, 2, 10);
		const tokents2 = JSON.parse(json2);

		assert.strictEqual(notMintedTokens.tokens.length, 0);
		assert.strictEqual(skipAllTokens.tokens.length, 0);
		assert.strictEqual(zeroAddressTokens.tokens.length, 0);
		assert.strictEqual(user2Tokens.tokens.length, 0);

		assert.strictEqual(tokents00.tokens.length, 5);
		assert.strictEqual(tokents01.tokens.length, 2);
		assert.strictEqual(tokents11.tokens.length, 2);
		assert.strictEqual(tokents12.tokens.length, 1);
		assert.strictEqual(tokents2.tokens.length, 0);

		const isErc165 = await testPagination.supportsInterface('0x01ffc9a7');
		assert.strictEqual(isErc165, true);

		const balanceBefore = await testPagination.balanceOf(user1);
		await testPagination.burn(3);
		const balanceAfter = await testPagination.balanceOf(user1);
		assert.strictEqual(Number(balanceBefore) - Number(balanceAfter), 1);
	});
});
