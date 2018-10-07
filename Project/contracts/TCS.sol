pragma solidity ^0.4.18;

import "./dependencies/IExchange.sol";


contract TSC {
	// We define an exchange using the 0x exchange interface.
	IExchange internal EXCHANGE;

	// The creator of the current contract.
	address owner;

	// The agents who are able to sign 0x orders.
	mapping (address => bool) public authorizedAgents;

	event AgentAuthorized(address agent);

	event AgentRemoved(address agent);

	// 0x Order.
	struct Order {
		address makerAddress;           // Address that created the order.
		address takerAddress;           // Address that is allowed to fill the order. If set to 0, any address is allowed to fill the order.
		address feeRecipientAddress;    // Address that will recieve fees when order is filled.
		address senderAddress;          // Address that is allowed to call Exchange contract methods that affect this order. If set to 0, any address is allowed to call these methods.
		uint256 makerAssetAmount;       // Amount of makerAsset being offered by maker. Must be greater than 0.
		uint256 takerAssetAmount;       // Amount of takerAsset being bid on by maker. Must be greater than 0.
		uint256 makerFee;               // Amount of ZRX paid to feeRecipient by maker when order is filled. If set to 0, no transfer of ZRX from maker to feeRecipient will be attempted.
		uint256 takerFee;               // Amount of ZRX paid to feeRecipient by taker when order is filled. If set to 0, no transfer of ZRX from taker to feeRecipient will be attempted.
		uint256 expirationTimeSeconds;  // Timestamp in seconds at which order expires.
		uint256 salt;                   // Arbitrary number to facilitate uniqueness of the order's hash.
		bytes makerAssetData;           // Encoded data that can be decoded by a specified proxy contract when transferring makerAsset. The last byte references the id of this proxy.
		bytes takerAssetData;           // Encoded data that can be decoded by a specified proxy contract when transferring takerAsset. The last byte references the id of this proxy.
	}

	constructor(address _owner, address _exchange) public {
		EXCHANGE = IExchange(_exchange);

		this.owner = _owner;
	}

	modifier onlyOwner() {
		if (msg.sender == owner) _;
	}

	modifier senderIsAuthorizedAgent() {
		if (authorizedAgents[msg.sender]) _;
	}

	function public addAuthorizedAgent(address agent) {
		AgentAuthorized(agent);

		authorizedAgents[agent] = true;
	}

	function public removeAuthorizedAgent(address agent) onlyOwner {
		AgentRemoved(agent);

		authorizedAgents[agent] = false;
	}

	function public fillOrder(
		Order memory order,
		uint256 takerAssetFillAmount,
		uint256 salt,
		bytes memory orderSignature
	) returns (bool) senderIsAuthorizedAgent {
		// Encode arguments into byte array.
		bytes memory data = abi.encodeWithSelector(
			EXCHANGE.fillOrder.selector,
			order,
			takerAssetFillAmount,
			orderSignature
		);

		EXCHANGE.executeTransaction(
			salt,
			address(this),
			data,
			TX_ORIGIN_SIGNATURE
		);
	}

	// Returns true if any of the authorized agents signed the order.
	isValidSignature(
		bytes32 orderHash,
		address signer,
		bytes signatures
	) public view returns(bool)
	{
		if (authorizedAgents[signer]) {
				

			return true;
		}

		return false;
	}
}
