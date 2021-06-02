//SPDX-License-Identifier: GPL-3.0

pragma solidity >= 0.5.0 <0.9.0;

// Structs are key-value pairs, similar to a mapping except that values can have different types 
// A struct is a complex data type composed of elementary data types. 
// Structs - singular thing with properties (e.g. Car)
//  example:
/* struct Car { 
        string brand;
        uint year;
        uint value;
    }
*/
// Mappings are collections of things, (collection of cars)
// Structs are saved in storage by default, when called within a function, it is assumed to be in storage
// putting a struct outside of a function makes it accessible to other contracts 

struct Instructor {
    uint age;
    string name;
    address addr; 
}

// Instructor struct accessible to both contracts 
contract Academy { 
    
    // Create a public Instructor (struct) called academyInstructor; 
    Instructor public academyInstructor;
    
    // initialize academyInstructor within constructor (i.e. with values chosen at contract deployment)
    // given age, given name, but address is global variable msg.sender (the creator of the contract)
    
    constructor(uint _age, string memory _name){
            
            // recall: strings are reference variables, so they are cheapest in memory
            // The 3 types of ways to save data: 
                // Storage - on blockchain, expensive
                // Stack - holds local variables inside functions as long as they don't require reference types (i.e. int) 
                // Memory - free, but must be declared with memory. works with reference types (string, array, struct, mapping)
    
        academyInstructor.age = _age; // no default, must be declared upon deployment
        academyInstructor.name = _name; // no default, must be declared upon deployment
        academyInstructor.addr = msg.sender; // deployer 
        
    }


    // to change the struct, overwrite it in storage with a new struct
    function changeInstructor(uint _age, string memory _name, address _addr) public { 
    
    // overwrite Instructor in memory with newInstructor (of class Instructor() with new values)
     Instructor memory newInstructor = Instructor({
         age : _age,
         name : _name,
         addr : _addr
     }
     );
     
     academyInstructor = newInstructor;
     
    }
     
        
    }
    

contract School { 
    Instructor public schoolInstructor;
} 



