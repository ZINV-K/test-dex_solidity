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

        return { order, orderbook, signer, amount };
    }

    describe("Order", async function () {
        const { signer, order, amount } = await loadFixture(config);
        it("Do ordering", async function () {
            // 테스트 주문을 실행함
            await expect(order.ordering(amount)).to.be.revertedWith(
                "You can't withdraw yet"
            );
        });

        it("Should set the right owner", async function () {
            // order에 등록된 주문을 꺼내 주문자가 맞는지 확인함
            expect(await (await order.getOrder(0)).maker).to.equal(
                signer.address
            );
        });

        it("Should set the right owner", async function () {
            // order에 등록된 주문을 꺼내 주문 수량이 맞는지 확인함
            expect(await (await order.getOrder(0)).amount).to.equal(
                signer.address
            );
        });
    });
});
