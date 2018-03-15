pragma solidity ^0.4.17;

contract Welcome {
    address contractOwner;
    string greetMsg;

    function Welcome(string _greetMsg) public {
        contractOwner = msg.sender;
        greetMsg = _greetMsg;
    }

    function sendGreeting() public view returns (string) {
        if (msg.sender == contractOwner) {
            return "You are the Owner, why you need to be greeted!!";
        } else {
            return greetMsg;
        }
    }

    function kill() public {
        //require(msg.sender == contractOwner);
        if (msg.sender == contractOwner)
            selfdestruct(contractOwner);
    }

}