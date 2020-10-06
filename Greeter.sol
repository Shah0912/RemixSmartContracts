pragma solidity >=0.4.22 <0.7.0;

contract Greeter {
    string public yourName;
    
    constructor () public {
        yourName = "World";
    }
    
    function set(string memory name) public {
        yourName = name;
    }
    
    function hello() view public returns (string memory) {
        return yourName;
    }
}