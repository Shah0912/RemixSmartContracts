pragma solidity >=0.4.22 <0.7.0;

contract Coin {
    address public minter;
    mapping (address => uint) public balance;
    
    event sent(address from, address to, uint amount);
    
    constructor () public {
        minter = msg.sender;
    }
    
    function mint (address receiver, uint amount) public {
        if(msg.sender != minter)
            return;
        balance[receiver] += amount;
    }
    
    function send (address receiver, uint amount) public {
        if(balance[msg.sender] < amount)
            return;
        balance[msg.sender] -= amount;
        balance[receiver] += amount;
        
        emit sent(msg.sender, receiver, amount);
    }
    
}