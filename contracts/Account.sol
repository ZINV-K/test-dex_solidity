pragma solidity ^0.8.13;

import "./interface/IAccount.sol";
import "./interface/IERC20.sol";

contract Account is IAccount {
    address owner;
    mapping(address => uint) balances;
    [] history;
}