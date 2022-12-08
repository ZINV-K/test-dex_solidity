import { time, loadFixture } from "@nomicfoundation/hardhat-network-helpers";
import { anyValue } from "@nomicfoundation/hardhat-chai-matchers/withArgs";
import { expect } from "chai";
import { ethers } from "hardhat";
import { Wallet } from "ethers";

describe("DEX", function () {
    async function config() {
        // Contracts are deployed using the first signer/account by default
        const [signer, otherAccount] = await ethers.getSigners();

        const Order = await ethers.getContractFactory("Order");
        const order = await Order.deploy();

        const Orderbook = await ethers.getContractFactory("Orderbook");
        const orderbook = await Orderbook.deploy();

        const amount = 123;
        const quantity = 234;

        return { order, orderbook, signer, amount, quantity };
    }

    async function token() {
        const MOCK_DAI = await ethers.getContractFactory("MockDaiToken");
        const DAI = await MOCK_DAI.deploy();

        const MOCK_MECA = await ethers.getContractFactory("MockMecaToken");
        const MECA = await MOCK_MECA.deploy();

        return { DAI, MECA };
    }

    describe("Order", async function () {
        const { signer, order, amount, quantity } = await loadFixture(config);
        const { DAI, MECA } = await loadFixture(token);
        it("Do ordering", async function () {
            // 테스트 주문을 실행함
            const data = await order.ordering(
                DAI.address,
                amount,
                MECA.address,
                quantity
            );
            await expect(data).to.be.revertedWith(
                "Something wrong in your order"
            );
        });

        it("Should set the right owner", async function () {
            // order에 등록된 주문을 꺼내 주문자가 맞는지 확인함
            const data = await order.getOrder(0);
            await expect(data.maker).to.equal(signer.address);
        });

        it("Should set the right token to sell", async function () {
            // order에 등록된 주문을 꺼내 매도 토큰이 맞는지 확인
            const data = await order.getOrder(0);
            await expect(data.tokenSell).to.equal(DAI.address);
        });

        it("Should set the right amount", async function () {
            // order에 등록된 주문을 꺼내 매도량이 맞는지 확인함
            const data = await order.getOrder(0);
            await expect(data.amount).to.equal(amount);
        });

        it("Should set the right token to buy", async function () {
            // order에 등록된 주문을 꺼내 매수 토큰이 맞는지 확인
            const data = await order.getOrder(0);
            await expect(data.tokenBuy).to.equal(MECA.address);
        });

        it("Should set the right quantity", async function () {
            // order에 등록된 주문을 꺼내 매수량이 맞는지 확인
            const data = await order.getOrder(0);
            await expect(data.quantity).to.equal(quantity);
        });
    });
});
