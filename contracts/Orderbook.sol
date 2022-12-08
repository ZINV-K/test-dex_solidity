// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./Order.sol";
// import "./interface/IOrder.sol";
// import "./interface/IOrderbook.sol";

contract Orderbook{
    // 오더북 컨트롤(운영) 권한
    address auth;
    // 오더북 구분을 위한 unique id (BTC/USDT, ETH/USDT 등의 마켓을 구분할때 사용)
    uint id;
    // BTC/USDT (대상통화)/(기축통화)
    // 대상통화
    address token0;
    // 기축통화
    address token1;
    // 현재 시장가
    uint price;
    // 틱
    uint tick;
    // 현재 이 마켓에서 발생하는 거래에 적용될 공통 수수료율
    uint fee;

    struct Data{
        // Bids에 접수된 구매 주문들
        Order.Data[] asks;
        // Asks에 접수된 판매 주문들
        Order.Data[] bids;
    }
    Data orderbook;

    constructor() {
        auth = msg.sender;
    }

    function addAsk(Order.Data calldata _order) public {
        // 주문을 배열 끝에 추가함
        orderbook.asks.push(_order);
    }

    function getAsk(uint _id) public view returns (Order.Data memory) {
        // 접수된 주문을 id로 찾아서 반환
        return orderbook.asks[_id];
    }

    function getAsks() public view returns (Order.Data[] memory) {
        // 접수된 주문 배열을 반환
        return orderbook.asks;
    }
}