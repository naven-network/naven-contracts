// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

library Errors {
    /// @notice Error when an invalid address is provided
    error InvalidAddress();

    /// @notice Error when an invalid string is provided
    error InvalidString();

    /// @notice Error when an invalid amount is provided
    error InvalidAmount();

    /// @notice Error when caller is not authorized to action
    error NotAuthorized();

    /// @notice Error when id is invalid
    error InvalidId();

    /// @notice Error when transfer fails
    error TransferFailed();
}
