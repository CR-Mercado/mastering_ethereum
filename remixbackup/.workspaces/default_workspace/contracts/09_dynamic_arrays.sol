//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

contract DynamicArrays {  // can hold elements of any type
    uint[] public numbers;  // empty numbers array - has 3 implicit methods: length, push, pop
    
    // 3 methods 
    
    // how many elements inside numbers array
    function getLength() public view returns(uint){ 
        return numbers.length;     
    }
    
    // add an element to the array 
    
    function AddElement(uint item) public { 
        numbers.push(item); // push item at the end of array 
    } 
    
    // custom getter function with an error check
    // view is for read only - unlike pure, which neither reads or writes from the chain
    function getElement(uint index) public view returns(uint){ 
     if( index < numbers.length ){ 
         return numbers[index]; 
        } else { 
         return 0;
         }
    }
    
    // remove last element 
    function popElement() public { 
        numbers.pop();
    }
    
    // push and pop are not available in memory because arrays in 
    // memory cannot be resized. 
    
    // Notice this function is pure - it does not read or write from the blockchain
    // you can create arrays in memory
    
    // dynamic array y, in memory contains 3 uint elements
    function newArray() public pure { 
     uint[] memory y = new uint[](3); // new creates a placeholder array - but cannot be resized in memory
        y[0] = 10;
        y[1] = 20;
        y[2] = 30;
    }
    
    // notice that trying to overwrite numbers with y
    // interacts with the blockchain so it is not pure
    // can overwrite numbers because it is in storage
    function updateNum() public { 
        uint[] memory y = new uint[](3);
        y[0] = 10;
        y[1] = 20;
        y[2] = 30;
        numbers = y; // overwrites AddElement() 
    }
        
    
    
    
    
}