var Sheetcoin = artifacts.require('./Sheetcoin.sol')
var SheetcoinController = artifacts.require('./SheetcoinController.sol')
let _ = '        '

module.exports = (deployer, helper, accounts) => {

  deployer.then(async () => {
    try {
      // Deploy Sheetcoin.sol
      await deployer.deploy(Sheetcoin)
      let sheetcoin = await Sheetcoin.deployed()
      console.log(_ + 'Sheetcoin deployed at: ' + sheetcoin.address)

      await deployer.deploy(SheetcoinController, sheetcoin.address)
      let sheetcoinController = await SheetcoinController.deployed()
      console.log(_ + 'SheetcoinController deployed at: ' + sheetcoinController.address)

    } catch (error) {
      console.log(error)
    }
  })
}
