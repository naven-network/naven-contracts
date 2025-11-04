// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { IERC721 } from '@openzeppelin/contracts/token/ERC721/IERC721.sol';

/// @notice Interface for interacting with the main Collection contract
/// @dev Defines required functions from the Collection contract
interface ICollection is IERC721 {
    /// @notice Function to mint NFT with minter privileges
    /// @param to Address to receive the NFT
    function mint(address to) external returns (uint256);

    /// @notice Function to get the current token ID
    /// @return Current token ID in the collection
    function currentTokenId() external view returns (uint256);

    error AlreadyMinted();
}
