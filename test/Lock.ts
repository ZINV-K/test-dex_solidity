import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Wallet } from "ethers";

const { expect } = require("chai");
describe("Escrow", function () {
    let contract;

    let happyPathAccount;
    let unhappyPathAccount;
    const amount = ethers.utils.parseUnits("10.0");

    before(async function () {
        /**
         * Deploy ERC20 token
         * */
        const MOCK_DAI_TOKEN = await ethers.getContractFactory("MockDaiToken");
        const dai = await MOCK_DAI_TOKEN.deploy();
        await dai.deployed();

        const MOCK_MECA_TOKEN = await ethers.getContractFactory(
            "MockMecaToken"
        );
        const meca = await MOCK_MECA_TOKEN.deploy();
        await meca.deployed();
        /**
         * Get test accounts
         * */
        const accounts = await ethers.getSigners();
        const owner = accounts[0];
        /**
         * Transfer some ERC20s to happyPathAccount
         * */
        const SEND_DAI = await dai.transfer(
            owner.address,
            "80000000000000000000"
        );
        await SEND_DAI.wait();
        const SEND_MECA = await dai.transfer(
            owner.address,
            "80000000000000000000"
        );
        await SEND_MECA.wait();
        /**
         * Deploy Escrow Contract
         *
         * - Add ERC20 address to the constructor
         * - Add escrow admin wallet address to the constructor
         * */
        const Order = await ethers.getContractFactory("Order");
        const order = await Order.deploy(owner, {
            value: {
                token0: dai.address,
                token1: meca.address,
                amount0: 1,
            },
        });
        await order.deployed();

        /**
         * Seed ERC20 allowance
         * */
        // const erc20WithSigner = erc20.connect(happyPathAccount);
        // const approveTx = await erc20WithSigner.approve(
        //     contract.address,
        //     "90000000000000000000"
        // );
        await approveTx.wait();
    });
});
