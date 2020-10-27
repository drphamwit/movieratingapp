var Ratings = artifacts.require("./Rating.sol");

module.exports = function(deployer, network, accounts) {
    deployer.deploy(Ratings, ['Tenant', 'Mulan'], {from: accounts[1], gas: 6700000});
}