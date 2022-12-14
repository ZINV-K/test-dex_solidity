// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./interface/IERC20.sol";

import "./Orderbook.sol";
import "hardhat/console.sol";

// contract Order is IOrder {
contract Order {
    struct Data{
        // 유저가 접수한 현재 이 주문을 특정짓기 위한 unique id
        uint id;
        // 주문을 접수한 유저
        address maker;
        // 주문을 체결한 유저(주문이 체결되면 값이 추가됨)
        // 주문 체결은 유저가할수도 AMM인 컨트랙트가 할수도 있음
        address taker;
        // 주문의 상태
        // 주문의 상태는 순차적으로 주문에 상태와 상태가 변경된 시간 정보의 구조체를 배열로 저장
        // Status[] status;
        // 주문시 매도하는 토큰
        IERC20 tokenSell;
        // 주문시 매도하는 토큰의 수량
        uint amount;
        // 주문시 매수하는 토큰
        IERC20 tokenBuy;
        // 주문시 매수하는 토큰의 수량
        uint quantity;
        // 이 주문을 접수할 거래가
        // 이 주문가는 시장가거나 유저가 지정한 지정가 일 수 있음
        uint price;
        // 주문시 구매하는 토큰에 적용될 수수료 수량
        uint fee;
    }
    Data public data;

    Orderbook orderbook;

    uint id;
    uint fee;

    // 주문자 본인이 맞는지 확인
    modifier auth() {
        require(data.maker == msg.sender, "Not your order.");
        _;
    }

    // 거래하려는 토큰이 마켓에서 락이 걸린 상황인지 확인
    // 마켓락: 특정 토큰이 다른 프로토콜에서 해킹 이슈가 발생한 경우, 해당 토큰을 주문 시 주문접수를 거부함
    // 토큰주소로 락을 거는 이유: 이 토큰과 쌍을 이루는 여러가지 마켓을 한꺼번에 거래를 중단시키기 위함.
    modifier lock() {
        // require(data.token0.state == true && data.token1.state == true, "Cannot exchange this token.");
        _;
    }

    // 주문을 접수함
    // function order(address _maker, address _token0, address _token1, uint price, uint amount0, uint amount1) public returns (bool) {
    function ordering(address _tokenSell, uint _amount, address _tokenBuy, uint _quantity) public {
        fee = 3;
        data.id = id;
        data.maker = msg.sender;
        data.tokenSell = IERC20(_tokenSell);
        data.amount = _amount;
        data.tokenBuy = IERC20(_tokenBuy);
        data.quantity = _quantity;
        data.fee = (_amount * fee) / 100;
        orderbook.addAsk(data);
        ++id;
    }

    function getOrder(uint _id) public view returns (Data memory) {
        return orderbook.getAsk(_id);
    }
    
    function getOrders() public view returns (Data[] memory) {
        return orderbook.getAsks();
    }

    // // 주문을 취소함
    // function cancel(address _maker) public returns (bool) {
    //     // 해당 마켓의 대상 토큰이 사려고 하는 토큰이면 Bids에서 주문 삭제
    //     if (token0 == msg.value.token0) {
    //         Orderbook.removeBids(this);
    //         return true;
    //     // 해당 마켓의 대상 토큰이 팔려고 하는 토큰이면 Asks에서 주문 삭제
    //     } else {
    //         Orderbook.removeAsk(this);
    //         return true;
    //     }
    //     return false;
    // }
}