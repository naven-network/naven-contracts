// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

/// @title Config - A library for managing chain-specific contract addresses
/// @notice Provides functions to access contract addresses for different chains
library Config {
    function collection() internal view returns (address) {
        if (block.chainid == 196) return 0xE6B41f9f0d5c3B97Fe6c996B874B1301142873f6;
        revert('Unsupported network');
    }
}
