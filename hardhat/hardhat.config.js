require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config({path:".env"});

const QUICKNODE_HTTP_URL=process.env.RPC_URL;
const PRIVATE_KEY=process.env.PRIVATE_KEY;
const ETHERSCAN_API_KEY=process.env.ETHERSCAN_API_KEY;
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.19",
  networks: {
    sepolia: {
      url: QUICKNODE_HTTP_URL,
      accounts: [PRIVATE_KEY],
    }
  },
  etherscan: {
    apikey: ETHERSCAN_API_KEY,
  },
};