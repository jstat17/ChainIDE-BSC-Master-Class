// COOL token using ERC-20/BEP-20 standard
pragma solidity ^0.8.0;

contract CoolToken{
    string public name = "Cool Token";
    string public symbol = "COOL";
    uint8 public decimals = 8;
    uint256 public totalSupply = 1e18; // 10^18
    mapping(address => uint256) public balances;
    mapping(address => mapping(address => uint256)) public allowed;

     event Transfer(
         address indexed _from,
         address indexed _to,
         uint256 _value
     );

     event Approve(
         address indexed _owner,
         address indexed _spender,
         uint256 _value
     );

    constructor() public{
        balances[msg.sender] = totalSupply;
    }

    function balanceOf(address _addr) public view returns(uint256){
        return balances[_addr];
    }

    function transfer(address _to, uint256 _value) public returns(bool success){
        require(_value <= balances[msg.sender], "Too small balance.");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint256 _value) public returns(bool success){
        require(_value <= balances[msg.sender], "Too small balance.");
        allowed[msg.sender][_spender] = _value;
        emit Approve(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint256 _value) public returns(bool success){
        require(_value <= balances[_from], "Too small balance.");
        require(_value <= allowed[_from][msg.sender], "Not enough allowance.");
        allowed[_from][msg.sender] -= _value;
        balances[_from] -= _value;
        balances[_to] += _value;
        emit Transfer(_from, _to, _value);
        return true;
    }

    function allowance(address _owner, address _spender) public view returns(uint256 remaining){
        return allowed[_owner][_spender];
    }
}