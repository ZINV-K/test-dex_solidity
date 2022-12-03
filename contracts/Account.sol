pragma solidity ^0.8.13;

import "./interface/IAccount.sol";
import "./interface/IERC20.sol";
import "./interface/IOrder.sol";

contract Account is IAccount {
    // 어카운트 주인 (유저)
    address payable owner;
    // 유저가 보유한 토큰과 잔액 등의 정보
    mapping(address => uint) balances;
    // 유저가 우리 dapp을 이용해 거래한 내역
    IOrder[] history;
}