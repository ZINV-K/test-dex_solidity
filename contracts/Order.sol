pragma solidity ^0.8.13;

import "./Orderbook.sol";

import "./library/Calculate.sol";

import "./interface/IOrder.sol";
import "./interface/IERC20.sol";

contract Order is IOrder {
    uint id;
    address maker;
    address taker;
    Status[] status;
    address tokenBuy;
    address tokenSell;
    uint price;
    uint amount;
    uint qty;
    uint fee;

    constructor() {
        maker = msg.sender;
        tokenBuy = IERC20(msg.value.tokenBuy);
        tokenSell = IERC20(msg.value.tokenSell);
        qty = msg.value.qty;
        amount = msg.value.amount;
        price = qty / amount;
        fee = Calculate.fee(msg.value.qty, Orderbook.fee);
    };

    // 주문자 본인이 맞는지 확인
    modifier auth() {
        require(maker == msg.sender, "Not your order.");
        _;
    }

    // 거래하려는 토큰이 마켓에서 락이 걸린 상황인지 확인
    modifier lock() {
        require(tokenBuy.state == true && tokenSell.state == true, "Cannot");
        _;
    }

    // 주문을 접수함
    function order() public returns (bool) {
        Orderbook.addAsk
        return true
    }

    // 주문을 취소함
    function cancel() public returns (bool) {
        return true
    }
}