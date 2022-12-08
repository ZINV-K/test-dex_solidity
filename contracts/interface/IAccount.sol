// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

interface IAccount{
    struct Account{
        address payable owner;
        mapping(address => uint) balances;
    }
}