const ethers = require("ethers");
const fs = require("fs");
require("dotenv").config();

async function main() {
  // ginache rpc url: http:0.0.0.0:8545
  const provider = new ethers.JsonRpcProvider(process.env.RPC_URL);
  //const provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);

  const wallet = new ethers.Wallet(process.env.PRIVATE_KEY, provider);

  const abi = fs.readFileSync("./SimpleStorage_sol_SimpleStorage.abi", "utf8");
  const binary = fs.readFileSync(
    "./SimpleStorage_sol_SimpleStorage.bin",
    "utf8"
  );
  const contractFactory = new ethers.ContractFactory(abi, binary, wallet);
  console.log("deploying, please wait....");
  const contract = await contractFactory.deploy();
  console.log(contract);

  // const deploymentReceipt = await contract.deployTransaction.wait(1);
  // console.log(deploymentReceipt);

  const currentFavoriteNumber = await contract.retrieve();
  console.log(
    `the current favorite number is ${currentFavoriteNumber.toString()}`
  );

  const transactionResponse = await contract.store("7");
  const receipt = transactionResponse.wait(1);
  const updatedFavoriteNumber = await contract.retrieve();

  console.log(`the updated favorite number is ${updatedFavoriteNumber}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
