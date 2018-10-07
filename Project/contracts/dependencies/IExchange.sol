pragma solidity ^0.4.24;
pragma experimental ABIEncoderV2;

// An interface to the 0x Exchange contract.
contract IExchange {
	// 0x Order, retrieved from 0x monorepo.
	struct Order {
		address makerAddress;           // Address that created the order.
		address takerAddress;           // Address that is allowed to fill the order. If set to 0, any address is allowed to fill the order.
		address feeRecipientAddress;    // Address that will receive fees when order is filled.
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

	struct FillResults {
		uint256 makerAssetFilledAmount;  // Total amount of makerAsset(s) filled.
		uint256 takerAssetFilledAmount;  // Total amount of takerAsset(s) filled.
		uint256 makerFeePaid;            // Total amount of ZRX paid by maker(s) to feeRecipient(s).
		uint256 takerFeePaid;            // Total amount of ZRX paid by taker to feeRecipients(s).
	}

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
	)  external;

	/// @dev Fills the input order.
	/// @param order Order struct containing order specifications.
	/// @param takerAssetFillAmount Desired amount of takerAsset to sell.
	/// @param signature Proof that order has been created by maker.
	/// @return Amounts filled and fees paid by maker and taker.
	function fillOrder(
		Order memory order,
		uint256 takerAssetFillAmount,
		bytes memory signature
	)  public  returns (FillResults memory fillResults);
}
