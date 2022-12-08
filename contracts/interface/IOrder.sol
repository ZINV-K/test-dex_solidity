// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface IOrder{
    struct Order{
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
    }

    // 주문 접수
    // 필요한 정보: 접수자, 파려는 토큰, 사려는 토큰, 가격, 수량 정보를 받음
    // 자동생성 정보: 수령자(풀 or 다른유저), 수수료(계산 필요)
    // public(공개), external(외부호출용), internal(내부사용)일지는 연산 방식에 의한 판단이 필요함
    function order(address _maker, address _token0, address _token1, uint price, uint amount0, uint amount1) external  returns (bool);

    // 주문 취소
    // 주문을 생성한 maker(owner)가 맞는지 확인하고 주문을 취소함
    // public(공개), external(외부호출용), internal(내부사용)일지는 연산 방식에 의한 판단이 필요함
    function cancel(address _maker) external returns (bool);

    // 주문 응하기
    // 주문에 응한사람 taker의 주문을 받아 특정 주문에 매칭
    function matching(address _taker) external returns (bool);
}

// 주문상태
enum State{
    // 대기
    Pending,
    // Filled 체결(NFT등 물품 거래 확장을 고려해 Complete로 표기)
    Complete,
    // 주문 대기중 취소
    Cancelled,
    // 주문 접수 or 체결 or 취소 시 에러 발생
    Error
}

struct Status{
    State states;
    uint time;
}