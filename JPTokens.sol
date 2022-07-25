// SPDX-License-Identifier: MIT
pragma solidity ^0.8.15;

contract JPTokens {

    // declaring variables
    string public name;
    string public symbol;
    uint256 public decimals;
    uint256 public totalSupply ;

    // mapping address to amount
    mapping(address => uint) balance;
    mapping(address => mapping(address => uint)) allowed;

    // event to be emitted;
    event Transfer(address indexed _from, address indexed _to, uint _amount);
    event Allowance(address indexed _from, address indexed _to, uint _amount);

    // The constructor function runs once 
    constructor (){
        name = 'JPTokens';
        symbol = 'JPT';
        decimals = 18;
        totalSupply = 1000000 * 10 ** 18;
        balance[msg.sender] = totalSupply;
    }

    // function to retrieve the balance of an account
    function balanceOf (address _account) public view returns (uint256 bal) {
        return balance[_account];
    }

    // function to transfer from an account
    function transfer (address _to, uint256 _amount) public returns (bool success) {
        require( balance[msg.sender] > balance[_to] && _amount > 0);
        balance[msg.sender] -= _amount;
        balance[_to] += _amount;

        emit Transfer(msg.sender, _to, _amount);

        return true;
    }

    // function approve transfer
    function Approve (address _spender, uint _amount) public returns (bool success){
        allowed[msg.sender][_spender] =_amount;
        emit Allowance(msg.sender, _spender, _amount);

        return true;
    }

    function transferFrom (address _from, address _to, uint _amount) public returns (bool success) {
        require( balance[_from] > _amount && allowed[_from][_to] > _amount );
        allowed[_from][msg.sender] = allowed[_from][msg.sender] - (_amount);

        emit Transfer(_from, _to, _amount);
        return true;
        
    }

    
}