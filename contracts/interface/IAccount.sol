pragma solidity ^0.8.13;

interface IAccount{
    struct Account{
        address payable owner;
        mapping(address => uint) balances;
    }
}