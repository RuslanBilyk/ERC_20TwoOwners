pragma solidity ^0.4.15;



contract TwoOwners {
	string public constant symbol = "TwoOwners";
	uint8 public constant decimals = 4;
	uint256 public totalSupply;
	address public firstOwner;
	address public secondOwner;
    uint256 private balanceFirstOwner;
    uint256 private balanceSecondOwner;
	
	//mapping (address => uint) owners;
	//address[2] ownersAddress;

	mapping (address => uint256) balances;
	mapping (address => mapping (address => uint256)) allowed;
	
	event Burn(address indexed from,uint256 value);
	event Approval(address indexed owner, address indexed spender, uint256 value);
	event Transfer(address indexed from, address indexed to, uint256 value);
	
	
	 uint256 private balanceFirstOwnerq;

	function TwoOwners (address _secondOwner, uint256 _totalSupply){
		totalSupply = _totalSupply;
		firstOwner = msg.sender;
		secondOwner = _secondOwner;
		
        balanceFirstOwner = totalSupply/4;
        balanceSecondOwner = totalSupply-balanceFirstOwner;
            
		balances[firstOwner] = balanceFirstOwner;
		balances[secondOwner] = balanceSecondOwner;		
	}
	function balanceOf(address _owner) constant returns (uint256 balance) {
          balance = balances[_owner];
          return balance;
      }
	function transfer(address  _to, uint256 _amount) returns(bool success){
		if((balances[msg.sender] >= _amount) && (_amount > 0)){
			balances[msg.sender] -= _amount;
			balances[_to] += _amount;
			Transfer(msg.sender, _to, _amount);
			return true;
		}
		else{
			return false;
		}
	}
	function approve(address _spender, uint256 _amount) returns(bool success) {
		allowed[msg.sender][_spender] = _amount;
		Approval(msg.sender, _spender,_amount);
		return true;
	}
	function transferFrom(address _from, address _to, uint256 _amount) returns(bool success) {
		if((balances[_from] >= _amount)&&(allowed[_from][msg.sender] >= _amount)&&(_amount > 0)){
			balances[_from] -= _amount;
			allowed[_from][msg.sender]-=_amount;
			balances[_to]+=_amount;
			Transfer(_from,_to,_amount);
			return true;
		}		
		else{
			return false;
		}
	}
	function allowance(address _owner, address _spender)constant returns(uint256 balance) {
		return allowed[_owner][_spender];
	}
	function burn(uint256 _value) returns(bool success) {
		if(balances[msg.sender] >= _value){
			balances[msg.sender]-= _value;
			totalSupply =_value;
			Burn(msg.sender, _value);
			return true;
		}
		else{
			return false;
		}
	}
	function burnFrom(address _owner, uint256 _value) returns(bool success) {
		if((balances[_owner] >= _value) && (allowed[_owner][msg.sender] >= _value)){
			balances[_owner] -= _value;
			allowed[_owner][msg.sender] -=_value;
			totalSupply -= _value;
			Burn(_owner,_value);
			return true;
		}
		else{
			return false;
		}
	}	
}