 //SPDX-License-Identifier: GPL-3.0
 pragma solidity ^0.8.0; 
 
 /*
 admin starts a CrowdFunding campaign with specific money goal & time deadline
 contributors send ether
 admin makes Spending Request to spend money
 contributors can vote on the requests
 if > 50% contributors support, then admin can SEND eth balance to another wallet (i.e. spend the money)
 If Monetary goal is not reached by deadline, Contributors can get a refund 
 */
 
 
 contract CrowdFunding { 
    mapping(address => uint) public contributors; // mapping of contributors & amounts  
   address public admin; // administrator
   uint public numContributors; // number of contributors 
   uint public minContribution; // minimum eth 
   uint public deadline; // timestamp in SECONDS
   uint public goal; 
   uint public raisedAmount; // running balance 
   
   constructor(uint _goal, uint _deadline) { 
     goal = _goal; 
     deadline = block.timestamp + _deadline; 
     minContribution = 100; // at least 100 wei 
     admin = msg.sender; // admin is contract deployer
   }
   
   // public payable function to receive contributions 
   function contribute() public payable { 
      require(block.timestamp < deadline, "The deadline has passed."); 
      require(msg.value >= minContribution, "Your contribution is below the minimum.");
       
       // if this is their first contribution, increment numContributors
      if(contributors[msg.sender] == 0){ 
          numContributors++; // x = x + 1 but optimized
      }
      
      contributors[msg.sender] += msg.value; // x = x + y but optimized
      raisedAmount += msg.value; // x = x + y but optimized
   } 
     
    // allow contract to receive money 
    receive() payable external{ 
    contribute();
    } 
    
    // technically not needed, as raisedAmount is public and automatically gets a getter 
    function getBalance() public view returns(uint){ 
      return address(this).balance; // get the amount in the contract   
    } 
    
    
    function getRefund() public { 
      require(block.timestamp > deadline, "Refunds enabled if goal not met by deadline, please wait for deadline.");
      require(raisedAmount < goal, "Refunds only enabled if goal not met."); 
      require( contributors[msg.sender] > 0, "Only contributors can get refunds.");
        
        
        // cleaner version of: payable(msg.sender).transfer(contributors[msg.sender]);
        address payable recipient = payable(msg.sender); 
        uint value = contributors[msg.sender]; 
        
        // always clean out an account prior to sending it value.
        contributors[msg.sender] = 0; 
        
        // now it's safe to send
        recipient.transfer(value);
    } 
    
    
     
 } 