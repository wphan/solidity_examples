pragma solidity ^0.4.24;

// deploy me first, then use the address of this contract to call the functions in CallingContract
contract UseMeForMyFunctions {
    uint public stateVariable = 0;
  
    function regularFunction(uint value) public returns(bool) {
        stateVariable = value;
        
        return true;
    }
}

contract CallingContract {
    uint public stateVariable = 0;

    function callMeRegular(address otherContract, uint value) public {
        // this will modify UseMeForMyFunctions' stateVariable
        require(otherContract.call(bytes4(keccak256("regularFunction(uint256)")), value));
    }

    function callMeDelegate(address otherContract, uint value) public {
        // this will modify CallingContract's stateVariable
        require(otherContract.delegatecall(bytes4(keccak256("regularFunction(uint256)")), value));
    }
}
