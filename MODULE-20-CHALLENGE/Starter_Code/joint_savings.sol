/*
Joint Savings Account
---------------------

To automate the creation of joint savings accounts, you will create a solidity smart contract that accepts two user addresses that are then able to control a joint savings account. Your smart contract will use ether management functions to implement various requirements from the financial institution to provide the features of the joint savings account.

The Starting file provided for this challenge contains a `pragma` for solidity version `5.0.0`.
You will do the following:

1. Create and work within a local blockchain development environment using the JavaScript VM provided by the Remix IDE.

2. Script and deploy a **JointSavings** smart contract.

3. Interact with your deployed smart contract to transfer and withdraw funds.

*/

pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {

    // Variables to store the addresses of the two account holders
    address payable public accountOne;
    address payable public accountTwo;

    // Variables to track the last withdrawal details
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;

    // Define a function named `withdraw` that will accept two arguments:
    // - A `uint` variable named `amount`
    // - A `payable address` named `recipient`
    function withdraw(uint amount, address payable recipient) public {

        // Check if the recipient is one of the account holders
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");

        // Check if the contract has enough balance to perform the withdrawal
        require(address(this).balance >= amount, "Insufficient funds!");

        // Update the lastToWithdraw if the recipient is different from the last to withdraw
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }

        // Transfer the specified amount to the recipient
        recipient.transfer(amount);

        // Update the lastWithdrawAmount with the amount withdrawn
        lastWithdrawAmount = amount;

        // Update the contract balance
        contractBalance = address(this).balance;
    }

    // Define a `public payable` function named `deposit` to receive funds
    function deposit() public payable {
        // Update the contract balance
        contractBalance = address(this).balance;
    }

    // Define a `public` function named `setAccounts` that receives two `address payable` arguments
    function setAccounts(address payable account1, address payable account2) public {
        // Set the values of `accountOne` and `accountTwo`
        accountOne = account1;
        accountTwo = account2;
    }

    // Define a fallback function to accept Ether sent directly to the contract
    function() external payable {
        // Update the contract balance
        contractBalance = address(this).balance;
    }
}

