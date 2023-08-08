const hre = require("hardhat");

async function sleep(ms) {
  return new Promise((resolve) => 
  setTimeout(resolve, ms));
}

async function main() {
  const votingContract = await hre.ethers.deployContract("Voting", ["Jagunlabi", "Ezemiano", "Musa", "Felix", "Bisola"]);

  await votingContract.waitForDeployment();

  console.log("votingContract Address: ", votingContract.target);

  await sleep(30 * 1000);

  await hre.run("verify: verify",
    { address: votingContract.target,
    constructorArguments: ["Jagunlabi", "Ezemiano", "Musa", "Felix", "Bisola"],
    });
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });