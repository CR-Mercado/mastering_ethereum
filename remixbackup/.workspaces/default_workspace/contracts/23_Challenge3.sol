//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

/*
Challenge #3

Consider this Smart Contract.

contract MyTokens{
    string[] public tokens = ['BTC', 'ETH'];
    
    function changeTokens() public view{
        string[] memory t = tokens;
        t[0] = 'VET';
    }
    
}

Modify the changeTokens() function in such a way that it changes the state variable called tokens.
*/

contract MyTokens{
    string[] public tokens = ['BTC', 'ETH'];
    
    function changeTokens() public { // remove view, we are modifying the blockchain 
        string[] memory t = tokens;
        t[0] = 'VET';
        tokens = t; // overwrite storage location with string made in memory.
    }
    
}

/*
Recommended Solution: 
- Remove view, then simply change t to storage, t and tokens share the same location in storage so they are mutually modifiable. 
//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract MyTokens{
    string[] public tokens = ['BTC', 'ETH'];
    
    function changeTokens() public {
        string[] storage t = tokens;
        t[0] = 'VET';
    }
    
}
*/