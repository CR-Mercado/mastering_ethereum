/*
Challenge #6

Consider the solution from the previous challenge.

Add a new immutable state variable called admin and initialize it with the address of the account that deploys the contract;

Add a restriction so that only the admin can transfer the balance of the contract to another address;

Deploy and test the contract on Rinkeby Testnet.

*/

//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Deposit{
    
    address immutable public admin; 
    
    constructor(){ 
        admin = msg.sender; // contract deployer then immutable
    }
    
    receive() external payable {}
    
    // has to be public for this contract to see it!
    function getBalance() public view returns(uint){ 
     return address(this).balance;  
    } 
    
    function EmergencyWithdrawal(address payable _recipient) external returns(bool){ 
        
    require(msg.sender == admin, "Only Admin can call EmergencyWithdrawal"); 
        
     _recipient.transfer(getBalance());
     return true;
    }
}

// contract on Rinkeby: 0xc2292ff39b1d80d872d7d3d335431063c42629dd


/*
Recommended Solution: 
pragma solidity >=0.6.0 <0.9.0;
 
contract Deposit{
    address public immutable admin;
    
    constructor(){
        admin = msg.sender;
    }
    
    receive() external payable{}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function transferBalance(address payable recipient) public{
        require(admin == msg.sender);
        
        uint balance = getBalance();
        recipient.transfer(balance);
    }
}

*/