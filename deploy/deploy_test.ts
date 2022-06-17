import { DeployFunction } from 'hardhat-deploy/types';


const deployFunction: DeployFunction = async (hre) => {

	const { deployments, getNamedAccounts } = hre;
	const { deploy } = deployments;

	const { deployer } = await getNamedAccounts();

	await deploy('TestPagination', {
		from: deployer,
		log: true,
	});
};

deployFunction.tags = ['TestPagination'];

export default deployFunction;
