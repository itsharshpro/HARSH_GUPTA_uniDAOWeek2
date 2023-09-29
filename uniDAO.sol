// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract DeadmansSwitch {
    address public owner;
    address public beneficiary;
    uint256 public lastCheckBlock;
    
    constructor(address _beneficiary) {
        owner = msg.sender;
        beneficiary = _beneficiary;
        lastCheckBlock = block.number;
    }
    
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
    
    function stillAlive() external onlyOwner {
        lastCheckBlock = block.number;
    }
    
    function executeSwitch() external {
        require(block.number - lastCheckBlock >= 10, "Still alive check not reached 10 blocks");
        payable(beneficiary).transfer(address(this).balance);
    }
}
