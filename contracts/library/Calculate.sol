pragma solidity ^0.8.13;

library Calculate {
    function fee(uint _qty, uint fee) internal pure returns (uint){
        return (_qty * fee) / 100;
    }
}