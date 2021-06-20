//SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;
 
contract Deposit{
    address public owner;
     
    constructor(){
        owner = msg.sender;    
     }
     
    function sendEther() public payable{}
     
    function getBalance() public view returns(uint){
         return address(this).balance;
     }
 }