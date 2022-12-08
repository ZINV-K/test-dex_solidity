// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

library Calculate {
    // 수수료 계산기
    function fee(uint _qty, uint _fee) internal pure returns (uint){
        return (_qty * _fee) / 100;
    }
}