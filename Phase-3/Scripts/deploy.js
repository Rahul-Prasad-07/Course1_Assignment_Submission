async function main() {
    const KycContract = await ethers.getContractFactory("Kyc");
    const kyc = await KycContract.deploy();
    console.log("Contract Address ", kyc.address);
}

main()
    .then(() => process.exit(0))
    .catch((e) => {
        console.log(e);
        process.exit(1);
    });
/*
Contract Address  0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0

 */