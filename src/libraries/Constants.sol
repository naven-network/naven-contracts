// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Constants {
    /// @notice WAD precision (18 decimals - 1e18)
    uint256 public constant WAD = 1e18;

    /// @notice Role identifier for operators who can operate
    /// @dev Keccak256 hash of "OPERATOR_ROLE"
    bytes32 public constant OPERATOR_ROLE = keccak256('OPERATOR_ROLE');

    /// @notice Role identifier for operators who can mint without payment
    /// @dev Keccak256 hash of "MINTER_ROLE"
    bytes32 public constant MINTER_ROLE = keccak256('MINTER_ROLE');
}
