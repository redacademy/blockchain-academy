var Academy = artifacts.require("Academy");
var AcademyFactory = artifacts.require("AcademyFactory");

module.exports = function(deployer) {
  deployer.deploy(AcademyFactory);
  deployer.deploy(Academy);
};
