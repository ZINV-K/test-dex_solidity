pragma solidity ^0.8.13;

interface IOrder{
    struct Order{
        address maker;
        address taker;
        // 주문상태
        Status[] status;
        // 매도할 토큰
        address tokenSell;
        // 사게될 토큰
        address tokenBuy;
        // 거래 기준가
        uint price;
        // 기준가에 매도할 토큰의 수량
        uint amount;
        // 기준가에 사게될 토큰의 수량
        uint qty;
        // 수수료
        uint fee;
    }

    // 주문 접수
    // 필요한 정보: 접수자, 파려는 토큰, 사려는 토큰, 가격, 수량 정보를 받음
    // 자동생성 정보: 수령자(풀 or 다른유저), 수수료(계산 필요)
    // public(공개), external(외부호출용), internal(내부사용)일지는 연산 방식에 의한 판단이 필요함
    function ordering(address _maker, address _tokenBuy, address _tokenSell, uint price, uint amount, uint qty) external;

    // 주문 취소
    // 주문을 생성한 maker(owner)가 맞는지 확인하고 주문을 취소함
    // public(공개), external(외부호출용), internal(내부사용)일지는 연산 방식에 의한 판단이 필요함
    function canceling(address _maker) external;

    // 주문 응하기
    // 주문에 응한사람 taker의 주문을 받아 특정 주문에 매칭
    function matching(address _taker) external;
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