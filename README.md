# Funds Are Safu
Created at the ETH San Francisco hackathon, 2018

## Inspiration
Many professional traders are reluctant to trade on decentralized exchanges because private key management is an extremely risky and unsolved problem. If you deploy your private key to a production or test environment and it gets owned, you can lose hundreds of thousands or even millions of $.

To solve this, we can build a smart contract that is able to generate orders and take orders, but can only withdraw to a pre-set account. This smart contract can be freely used in production, as the only thing risk is that someone steals a key and can generate a 0x order.

## What it does
Users who deploy FundsAreSafu (TCS) register a number of addresses they want to be able to use to sign orders
When someone attempts to fill one of those orders, FundsAreSafu will verify that the signature is legit and belongs to an authorized address
Users can also fill an outstanding order by sending it through the smart contract

## How I built it
Solidity + 0x. Looked for inspiration from 0x Forwarding contract and 0x V2.0
