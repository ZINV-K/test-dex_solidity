pragma solidity ^0.8.13;

import "./interface/IOrder.sol";
import "./interface/IOrderbook.sol";

contract Orderbook is IOrderbook{
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
    // Bids에 접수된 구매 주문들
    IOrder[] bids;
    // Asks에 접수된 판매 주문들
    IOrder[] asks;
    // 현재 이 마켓에서 발생하는 거래에 적용될 공통 수수료율
    uint fee;

    mapping(uint => IOrder) orders;

    // bids에서 접수된 주문을 id로 찾아서 bids배열에 추가
    function addBid(IOrder _order) returns (bool) {
        // 주문을 bids배열에 끝에 추가함
        bids.push(_order);
        return true;
    };

    // asks에서 접수된 주문을 id로 찾아서 bids배열에 추가
    function removeBid(IOrder _order) returns (bool) {
        // 주문을 bids에서 찾아서 삭제함
        // To do
        bids.filter(_order);
        return true;
    };
    
    function addAsk(IOrder _order) returns (bool) {
        // 주문을 bids배열에 끝에 추가함
        bids.push(_order);
        return true;
    };

    // asks에서 접수된 주문을 id로 찾아서 bids배열에 추가
    function removeAsk(IOrder _order) returns (bool) {
        // 주문을 bids에서 찾아서 삭제함
        // To do
        bids.match(_order);
        return true;
    };
}