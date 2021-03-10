pragma solidity 0.8.0;

contract question11 {
    address public owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier only_owner {
        require(msg.sender == owner, "Error, not owner. Lack of permission.");
        _;
    }

    function change_owner(address new_owner) public only_owner {
        owner = new_owner;
    }    
}