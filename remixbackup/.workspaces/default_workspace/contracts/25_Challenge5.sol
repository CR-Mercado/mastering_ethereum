/*
Challenge #5

Consider the solution from the previous challenge.

Add a function that transfers the entire balance of the contract to another address.

Deploy and test the contract on Rinkeby Testnet.
*/

//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Deposit{
    
    receive() external payable {}
    
    // has to be public for this contract to see it!
    function getBalance() public view returns(uint){ 
     return address(this).balance;  
    } 
    
    function EmergencyWithdrawal(address payable _recipient) external returns(bool){ 
     _recipient.transfer(getBalance());
     return true;
    }
}

//contract on Rinkeby: 0x02f73ea4f0b245e3b12468f9ff49f7980a34d9fb 

/*
Recommended Solution: 

 
pragma solidity >=0.6.0 <0.9.0;
 
contract Deposit{
    
    receive() external payable{}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
    
    function transferBalance(address payable recipient) public{
        uint balance = getBalance();
        recipient.transfer(balance);
    }
}


*/