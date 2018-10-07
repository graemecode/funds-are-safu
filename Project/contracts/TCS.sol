pragma solidity ^0.4.18;

contract TSC {
	mapping (address => uint) stuff;

	event Something(address indexed _from, address indexed _to, uint256 _value);

	constructor() public {
	}

	function doSomething() public returns(bool success) {

	}
}
