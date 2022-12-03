pragma solidity ^0.8.13;

library Calculate {
    // 수수료 계산기
    function fee(uint _qty, uint fee) internal pure returns (uint){
        return (_qty * fee) / 100;
    }
}