// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

import "./IOrder.sol";

interface IOrderbook {
    struct Orderbook {
        IOrder[] bids;
        IOrder[] asks;
    }

    // tokenBuy의 address가 이 토큰인 경우의 배열에서
    // 주문을 추가하거나 삭제함
    function addBid(IOrder _order) external returns (bool);
    function removeBids(IOrder _order) external returns (bool);

    // tokenSell의 address가 이 토큰인 경우의 배열에서
    // 주문을 추가하거나 삭제함
    function addAsk(IOrder _order) external returns (bool);
    function removeAsk(IOrder _order) external returns (bool);
}

enum OrderType{
    Asks,
    Bids
}
