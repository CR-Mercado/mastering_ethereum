//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

/* Built in global variables include: 
msg - the account that generates the transaction + transaction/call info 
    msg.sender - account address that generates transaction 
    msg.value - ETH value (in wei) sent to this contract
    msg.gas - remaining gas (see: gasleft() ) 
    msg.data - data field from transaction/call

this - current contract address 
    this.balance - contract balance - requires address coercion see below 

gasLeft() - remaining gas after of transaction

block 
    block.timestamp - Unix epoch (see: now) 
    block.number
    block.difficulty
    block.gaslimit

tx.gasprice: gas price of transaction
*/

contract GlobalVariables { 
    
    // state variable: owner is a public address
    // state variable: sentValue is a public integer 
    address public owner;
    uint public sentValue; 
    
    // initiate owner value in constructor as address of contract deployer 
    // constructors only run once at contract launch; so msg. sender can change later if another function is called. 
    constructor(){ 
        owner = msg.sender;    
    }
    
    // new function that changes owner to whoever calls this function (as opposed to the constructor's owner = contract deployer)
    function changeOwner() public{ 
      owner = msg.sender;  
    } 
    
    // contracts can have ETH balances - defaults to 0 
    // contracts need some seed capital from deployer 
    // payable keyword means a function that accepts ETH 
    function sendEther() public payable { 
        sentValue = msg.value; // amount of wei sent with transaction 
    }
    
    // views the blockchain, doesn't write to it 
    function getBalance() public view returns(uint) { 
        return address(this).balance; // balance of this contract address  
    } 
    
    // how much gas is used in a for loop? 7,604 gas -- doesn't take into account of constant transaction cost ~21,000
    function HowMuchGas() public view returns(uint){ 
     uint start = gasleft();
     uint j = 1; 
     for(uint i = 1; i < 20; i++){ 
         j *= i; // j = j*i for programmers
     } 
     uint end = gasleft();
     return( start - end );  
    }
    
    // information available to the contract includes the information of the current block
    // note, best practice to put state variables at the top. 
    uint public this_moment = block.timestamp; // alias for 'now' which is deprecated - time the contract was launched 
    uint public block_number = block.number; // starts at 1 in JS VMs, but on ETH it is the actual block # 
    uint public difficulty = block.difficulty; // proof of work difficulty 
    uint public gaslimit = block.gaslimit; // ETH uses block gas limit instead of block size limit
    
} 