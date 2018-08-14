pragma solidity ^0.4.24;


contract SimpleForwarder {
  SimpleStore public storeContract;

  constructor(address storeContractAddress) public {
    storeContract = SimpleStore(storeContractAddress);
  }

  function () public payable {
    require(address(storeContract).call.value(msg.value)());
  }
}

contract SimpleStore {
  uint value;

  function () public payable {
    value = msg.value;
  }

  function get() public constant returns (uint) {
    return value;
  }
}
