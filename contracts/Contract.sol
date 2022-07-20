pragma solidity ^0.8.0;

contract Contract {
    uint public counter;
    address public owner;
    uint public entropy = 0xf1;
    uint public diff;

    constructor(){
        entropy = 0xffffaaaa;
        counter = 10;
        owner = msg.sender;
    }

    function getCounter() public view returns(uint){
        return counter;
    }

    function setCounter() public{
        counter++;
    }

    function setOwner(address _owner) public returns(address){
        
        return owner = _owner;
    }

    function random() public view returns (uint){
        //diff = block.difficulty;
        return uint(keccak256(abi.encodePacked((block.difficulty ^ entropy), block.timestamp))) % 101;
    }
    
    function setEntropy(uint _entropy) public returns(uint){
        require(msg.sender == owner, 'You are not owner');
        return entropy = _entropy;
    }
    function getOwner() public view returns(address){
        return owner;
    }
    
    function playDice(bool _direction) public payable returns(uint8){
        require(msg.sender.balance >= msg.value, 'Not avalable balance');
        uint8 _size = random();

        if(_direction){
            if(_size > 50){
                msg.sender.transfer(msg.value * 2);
            }
        }else{
            if(_size < 49){
                msg.sender.transfer(msg.value * 2);
            }                                                   
        }
        return _size;
    }
}

















