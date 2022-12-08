import { ethers } from "hardhat";

async function main() {
    const Order = await ethers.getContractFactory("Order");
    const order = await Order.deploy();

    const Orderbook = await ethers.getContractFactory("Orderbook");
    const orderbook = await Orderbook.deploy();
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
});
