pragma solidity ^0.8.13;


contract Order {
    uint id;
    address tokenBuy;
    address tokenSell;
    uint price;
    uint tick;
    uint fee;
}


enum OrderType{
    Asks,
    Bids
}

interface IOrderbook {
    struct Bids {
        IOrder[] bids;
        IOrder[] asks;
    }

    // tokenBuy의 address가 이 토큰인 경우의 배열에서
    // 주문을 추가하거나 삭제함
    function addBid(IOrder _order) external returns (IOrder[] calldata);
    function removeBids(IOrder _order) external returns (IOrder[] calldata);

    // tokenSell의 address가 이 토큰인 경우의 배열에서
    // 주문을 추가하거나 삭제함
    function addAsk(IOrder _order) external returns (IOrder[] calldata);
    function removeAsk(IOrder _order) external returns (IOrder[] calldata);
}