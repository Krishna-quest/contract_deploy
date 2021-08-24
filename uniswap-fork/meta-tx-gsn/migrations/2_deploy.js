const StringOwner = artifacts.require('StringOwner.sol')

// we need to deploy a trusted forwarder specific to our dapp,
// every dapp needs to deploy it, because that will eventually
// save us from going through a very lengthy whole relayhub contract auditing
// process, and our contract can also be made to only accepting requests from
// specified forwarder or a set of forwarder, whom dapp developer trusts & deployed
// themselves.
const TrustedForwarder = artifacts.require('Forwarder.sol')

module.exports = async function deployFunc (deployer, network) {
  // checking whether forwarder already deployed or not
  let forwarder = await TrustedForwarder.deployed().then(c => c.address).catch(e => null)
  if (!forwarder) {
    forwarder = (await deployer.deploy(Forwarder)).address
  }
  console.log('Using forwarder: ', forwarder)
  // passing forwarder address in constructor of StringOwner
  await deployer.deploy(StringOwner, forwarder)
}