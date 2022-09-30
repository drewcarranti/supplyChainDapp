pragma solidity <0.6.0;

import "./erc20Interface.sol";

contract ERC20Token is ERC20Interface {    mapping(address => uint256) public balances;
    mapping(address => mapping (address => uint256)) public allowed;

    uint256 public totSupply;       // total number of tokens
    string public name;             // descriptive name
    uint8 public decimals;          // how many decimals to use when displaying
    string public symbol;           // short identifier for token

    // create the new token and assign intial values, including intial amount
    constructor(
        uint256 _initialAmount,
        string memory _tokenName,
        uint8 _decimalUnits,
        string memory _tokenSymbol
    ) public {
        balances[msg.sender] = _initialAmount;       // the creator owns all the initial tokens
        totSupply = _initialAmount;                   // update total token supply
        name = _tokenName;                           // store the token name (used for display only)
        decimals = _decimalUnits;                    // store the number of decimals (used for display only)
        symbol = _tokenSymbol;                       // store the token symbol (used for display only)
    }

    // transfer tokens from msg.sender to a specified address
    function transfer(address _to, uint256 _value) public returns (bool success){
        require(balances[msg.sender] >= _value, "Insufficent funds for transfer source.");
        balances[msg.sender] -= _value;
        balances[_to] += _value;
        emit Transfer(msg.sender, _to, _value); // solhint-disable-line indent, no unused vars
        return true;
    }

    // transfer from one specified address to another specified address
    function tranfserFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        uint256 allowance = allowed[_from][msg.sender];
        require(balances[_from] >= _value && allowance >= _value, "Insufficent allowed funds for transfer source.");
        balances[_to] += _value;
        balances[_from] -= _value;
        if (allowance < MAX_UINT256) {
            allowed[_from][msg.sender] -= _value;
        }

        emit Transfer(_from, _to, _value);      // solhint-disable-line indent, no-unsued-vars
        return true;
    }

    // return the current balance (in tokens) of a specified address

    function balanceOf(address _owner) public view returns (uint256 balance){
        return balances[_owner];
    }

    // set
    function approve(address _spender, uint256 _value) public returns (bool success) {
        allowed[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);     // solhint-disable-line indent, no-unused-vars
        return true;
    }

    // return the
    function allowance(address _owner, address _spender) public view returns (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    // return the total number of tokens in circulation
    function totalSupply() public view returns (uint256 totSupp){
        return totSupply;
    }
}