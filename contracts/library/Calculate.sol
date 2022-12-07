pragma solidity ^0.8.13;

library Calculate {
    // 수수료 계산기
    function fee(uint _qty, uint _fee) internal pure returns (uint){
        return (_qty * _fee) / 100;
    }
}