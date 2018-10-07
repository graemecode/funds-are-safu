pragma solidity ^0.4.18;

// An interface to the 0x Exchange contract.
contract IExchange {
	/// @dev Executes an exchange method call in the context of signer.
	/// @param salt Arbitrary number to ensure uniqueness of transaction hash.
	/// @param signerAddress Address of transaction signer.
	/// @param data AbiV2 encoded calldata.
	/// @param signature Proof of signer transaction by signer.
	function executeTransaction(
		uint256 salt,
		address signerAddress,
		bytes data,
		bytes signature
	)
	external;
}
