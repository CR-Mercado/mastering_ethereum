//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;


//fixed arrays are less gas costly relative to dynamic arrays.
// making strings a useful type for when length is already known and index not relevant.

contract BytesAndStrings { 
   
   // bytes can be added to.
   bytes public b1 = 'abc'; // best practice is to use for arbitrary length byte data
   // stores the hexadecimal: 0x616263  0x, a (61), b (62), c (63)
   
   // Strings are bytes without length or index access; UTF-8 encoded 
   // thus, you cannot add to a string
   string public s1 = 'abc'; // best practice is to use for arbitrary length string UTF-8 encoded data
   
  // add elements to bytes
  function addElement() public { 
      b1.push('x'); // 0x61626378  Look at ASCII code for 'x', it's 78.
      
      // push not available to strings.
      // s1.push('x'); // error 
  }
  
  // index of bytes
  // have to specify only 1 byte is coming back - bytes1
  
  function getElement(uint i) public view returns(bytes1) {  
      return(b1[i]);
      
      // index not available to strings.
      // return(s1[i]); // error 
  }
  
  // length of bytes 
  // have to specify only 1 byte is coming back - bytes1
  
  function getLength() public view returns(uint) {  
      return(b1.length);
      
      // length not available to strings.
      // return( s1.length ); // error 
  }
  
      
    
}