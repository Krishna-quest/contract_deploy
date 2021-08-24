module.exports = async function ({ getNamedAccounts, deployments }) {
    const { deploy } = deployments
  
    const { deployer } = await getNamedAccounts()
    //const Forwarder = (await deployments.get("Forwarder")).address
    const forwarderAddress = ""
    await deploy("MONETAS", {
      from: deployer,
      //args: [forwarderAddress],
      log: true,
      deterministicDeployment: false
    })
  }
  
  module.exports.tags = ["MONETAS", "AMM"]
 