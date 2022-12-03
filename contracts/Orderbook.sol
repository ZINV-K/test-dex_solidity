pragma solidity ^0.8.13;

import "./interface/IOrder.sol";

contract Orderbook {
    uint id;
    address tokenBuy;
    address tokenSell;
    uint price;
    uint tick;
    IOrder[] bids;
    IOrder[] asks;
    uint fee;
    mapping(uint => IOrder) orders;

    function addBid(IOrder _order) returns (bool) {
        orders[_order.id] 
    };

    function removeBid(IOrder) returns (bool) {

    };
}