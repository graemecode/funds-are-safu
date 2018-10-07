pragma solidity ^0.4.18;

contract TSC {
	address owner;

	mapping (address => uint) stuff;

	event Something(address indexed _from, address indexed _to, uint256 _value);

	constructor(address owner) public {
		this.owner = owner;
	}

	function doSomething() public returns(bool success) {
		// STUB.
	}

	isValidSignature(bytes32[] signatures) public view returns(bool)
	{
		// STUB.
	}
}
