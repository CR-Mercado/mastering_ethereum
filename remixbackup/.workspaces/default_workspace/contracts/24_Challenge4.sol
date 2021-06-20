/*
Challenge #4

Consider this Smart Contract.

//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Deposit{
    
}

Add a function so that the contract can receive ETH by sending it directly to the contract address.
Return the contract’s balance.

Deploy and test the contract on Rinkeby Testnet.
*/

//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Deposit{
    
    receive() external payable { }
    
    function getBalance() external view returns(uint){ 
     return address(this).balance;  
    } 
}

// contract on Rinkeby: https://rinkeby.etherscan.io/address/0xeb789b7c624e244be2d70924774cd780af10b2c8
// sent it 0.00025 ETH! 

/*
Recommended Solution: 
pragma solidity >=0.6.0 <0.9.0;
 
contract Deposit{
    
    receive() external payable{}

    function getBalance() public view returns (uint) { // uses public, I think is is standard but technically more gas.
        return address(this).balance;
    }
}

*/

