const ERC20Token = artifacts.require("./erc20token.sol");
const SupplyChain = artifacts.require("./SupplyChain.sol");

module.exports = function(deployer) {
    deployer.deploy(ERC20Token, 10000, "TotalSem Token", 18, "TotalSem");
    deployer.deploy(SupplyChain);
};
