pragma solidity ^0.8.13;

// ERC20인 토큰 컨트랙트에 있는 기능을 가져와서 인터페이스에 매핑시켜 사용.
interface IERC20 {
    struct ERC20 {
        bool lock;
    }

    // 토큰의 총 발행량을 반환함
    function totalSupply() external view returns (uint);
    // account에 보유하고 있는 balance를 반환함
    function balaceOf(address account) external view returns (uint);
    // recipient에게 amount만큼 토큰 전송, 성공/실패 값 반환
    function transfer(address recipient, uint amount) external returns (bool);
    // ERC-20 표준은 주소가 다른 주소에서 토큰을 검색할 수 있도록 허용할 수 있도록 허용합니다.
    // 이 getter는 지출자가 소유자를 대신하여 소비할 수 있는 남은 토큰 수를 반환합니다.
    // 이 함수는 getter이며 계약 상태를 수정하지 않으며 기본적으로 0을 반환해야 합니다.
    function allowance(address owner, address speneder) external view returns (uint);
    // 서명(승인), 승인자로 부터 서명비용인 amount를 소비하고 성공/실패 값 반환
    function approve(address spender, uint amount) external returns (bool);
    // sender로부터 recipient에게 amount만큼 토큰 전송, 성공/실패 값 반환
    function transferFrom(
        address sender,
        address recipient,
        uint amount
    ) external returns (bool);

    // 이 이벤트는 발신 주소에서 수신 주소로 토큰(값)의 양을 보낼 때 발생합니다.
    event Transfer(address indexed from, address indexed to, uint value);
    // 이 이벤트는 토큰(가치)의 양을 지출자가 사용하도록 소유자가 승인할 때 발생합니다.
    event Approval(address indexed owner, address indexed speneder, uint value);
}