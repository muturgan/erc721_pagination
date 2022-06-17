import dotenv from 'dotenv';
import { HardhatUserConfig } from 'hardhat/config';

import 'hardhat-deploy';
import 'hardhat-deploy-ethers';
import '@typechain/hardhat';
import 'solidity-coverage';
import '@nomiclabs/hardhat-etherscan';

dotenv.config();


// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

const config: HardhatUserConfig = {
	solidity: {
		version: '0.8.0',
		settings: {
			optimizer: {
				enabled: true,
				runs: 200,
			},
		},
	},
	defaultNetwork: 'hardhat',
	networks: {
		hardhat: {
			// the url is 'http://localhost:8545' but you should not define it
		},
		rinkeby: {
			url: `https://rinkeby.infura.io/v3/${process.env.INFURA_ID}`,
			accounts: [process.env.DEPLOYER_PRIVATE_KEY_TEST as string],
		},
	},
	etherscan: {
		apiKey: process.env.ETHERSCAN_API_KEY,
	},
	namedAccounts: {
		deployer: 0,
		dnaOwner: 1,
	},
};

export default config;
