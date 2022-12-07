pragma solidity ^0.8.13;

import "./Orderbook.sol";

import "./library/Calculate.sol";

import "./interface/IOrder.sol";
import "./interface/IERC20.sol";


contract Order is IOrder {
    Calculate constant calculate;
    Orderbook constant orderbook;
    
    // 유저가 접수한 현재 이 주문을 특정짓기 위한 unique id
    uint id;
    // 주문을 접수한 유저
    address maker;
    // 주문을 체결한 유저(주문이 체결되면 값이 추가됨)
    // 주문 체결은 유저가할수도 AMM인 컨트랙트가 할수도 있음
    address taker;
    // 주문의 상태
    // 주문의 상태는 순차적으로 주문에 상태와 상태가 변경된 시간 정보의 구조체를 배열로 저장
    Status[] status;
    // 주문시 구매하는 토큰
    address token0;
    // 주문시 매도하는 토큰
    address token1;
    // 주문시 구매하는 토큰의 수량
    uint amount0;
    // 주문시 판매하는 토큰의 수량
    uint amount1;
    // 이 주문을 접수할 거래가
    // 이 주문가는 시장가거나 유저가 지정한 지정가 일 수 있음
    uint price;
    // 주문시 구매하는 토큰에 적용될 수수료 수량
    uint fee;

    constructor() {
        // 유저가 입력한 주문정보로 초기화
        maker = msg.sender;
        token0 = IERC20(msg.value.token0);
        token1 = IERC20(msg.value.token1);
        amount0 = msg.value.amount0;
        amount1 = msg.value.amount1;
        // 구매하려는 토큰의 수량 / 판매하려는 토큰 수량
        price = amount0 / amount1;
        // 구매하려는 토큰 수량 * 수수료율
        fee = Calculate.fee(msg.value.amount0, Orderbook.fee);
    }

    // 주문자 본인이 맞는지 확인
    modifier auth() {
        require(maker == msg.sender, "Not your order.");
        _;
    }

    // 거래하려는 토큰이 마켓에서 락이 걸린 상황인지 확인
    // 마켓락: 특정 토큰이 다른 프로토콜에서 해킹 이슈가 발생한 경우, 해당 토큰을 주문 시 주문접수를 거부함
    // 토큰주소로 락을 거는 이유: 이 토큰과 쌍을 이루는 여러가지 마켓을 한꺼번에 거래를 중단시키기 위함.
    modifier lock() {
        require(token0.state == true && token1.state == true, "Cannot exchange this token.");
        _;
    }

    // 주문을 접수함
    function order(address _maker, address _token0, address _token1, uint price, uint amount0, uint amount1) public returns (bool) {
        // 해당 마켓의 대상 토큰이 사려고 하는 토큰이면 Bids로 접수
        if (token0 == msg.value.token0) {
            Orderbook.addBids(this);
            return true;
        // 해당 마켓의 대상 토큰이 팔려고 하는 토큰이면 Asks로 접수
        } else {
            Orderbook.addAsk(this);
            return true;
        }
        return false;
    }

    // 주문을 취소함
    function cancel(address _maker) public returns (bool) {
        // 해당 마켓의 대상 토큰이 사려고 하는 토큰이면 Bids에서 주문 삭제
        if (token0 == msg.value.token0) {
            Orderbook.removeBids(this);
            return true;
        // 해당 마켓의 대상 토큰이 팔려고 하는 토큰이면 Asks에서 주문 삭제
        } else {
            Orderbook.removeAsk(this);
            return true;
        }
        return false;
    }
    
    function matching(address _taker) public returns (bool) {
        return true;
    };
}