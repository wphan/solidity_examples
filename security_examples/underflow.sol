pragma solidity ^0.4.24;

contract FundTransfer {
  uint public a;
  mapping (address => uint) balances;

  // desposit funds into account
  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }
  
  // transfer funds to another address
  function transfer(uint value, address beneficiary) public {
    require(balances[msg.sender] > 0);
    require(balances[msg.sender] - value >= 0);
    
    beneficiary.transfer(value);
  }
}

