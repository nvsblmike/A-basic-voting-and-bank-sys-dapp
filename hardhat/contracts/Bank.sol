//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Bank {
    struct Account {
        uint256 balance;
        bool exists;
    }
    mapping(address => Account) accounts;

    function creatAccount() public {
        require(!accounts[msg.sender].exists, "Account already exists");
        accounts[msg.sender] = Account({
            balance: 0,
            exists: true
        });
    }

    function deposit() public payable {
        require(accounts[msg.sender].exists == true, "Don't have an account. Please create one.");
        accounts[msg.sender].balance += msg.value;
    }

    function withdrawFunds(uint256 amount) public {
        require(accounts[msg.sender].exists, "You don't have an account");
        require(accounts[msg.sender].balance != 0, "You don't have anything to withdraw");
        payable(msg.sender).transfer(amount);
        accounts[msg.sender].balance -= amount;
    }

    function getBalance() view public returns(uint256 bal) {
        require(accounts[msg.sender].exists, "You don't have an account");
        bal = accounts[msg.sender].balance;
    }
}