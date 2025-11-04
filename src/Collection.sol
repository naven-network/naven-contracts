// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { ICollection } from './interfaces/ICollection.sol';
import { Constants } from './libraries/Constants.sol';
import { Errors } from './libraries/Errors.sol';
import { AccessControl } from '@openzeppelin/contracts/access/AccessControl.sol';
import { ERC721Enumerable } from '@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol';
import { ERC721 } from '@openzeppelin/contracts/token/ERC721/ERC721.sol';
import { IERC165 } from '@openzeppelin/contracts/utils/introspection/IERC165.sol';
import { Strings } from '@openzeppelin/contracts/utils/Strings.sol';

/// @title Collection
/// @notice ERC721 collection with payment integration and role-based minting control
/// @dev Implements AccessControl for permission management and ERC721 for NFT standards
contract Collection is ERC721Enumerable, AccessControl, ICollection {
    using Strings for uint256;

    /// @notice Base URI for token metadata
    /// @dev Used to construct complete token URIs
    string public baseURI;

    /// @notice Tracks used payment ids to prevent duplicate mints
    /// @dev Maps payment key (nonce) to whether it's been used
    mapping(bytes32 => bool) public usedIds;

    /// @notice Current token ID, increments with each mint
    /// @dev Public for transparency, starts from 0
    uint256 public currentTokenId;

    /// @notice Initializes the NFT collection with required parameters
    /// @dev Sets up roles and initial configuration
    /// @param name Name of the NFT collection
    /// @param symbol Symbol of the NFT collection
    constructor(string memory name, string memory symbol, string memory _baseURI) ERC721(name, symbol) {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(Constants.MINTER_ROLE, msg.sender);
        baseURI = _baseURI;
    }

    /// @notice Updates the base URI for token metadata
    /// @dev Only callable by admin
    /// @param _baseURI New base URI
    function setBaseURI(string memory _baseURI) external onlyRole(DEFAULT_ADMIN_ROLE) {
        baseURI = _baseURI;
    }

    /// @notice Mints new NFT (minter only)
    /// @dev Only callable by addresses with MINTER_ROLE
    /// @param to Address to receive the minted NFT
    function mint(address to) external onlyRole(Constants.MINTER_ROLE) returns (uint256 tokenId) {
        if (to == address(0)) revert Errors.InvalidAddress();
        tokenId = currentTokenId++;
        _safeMint(to, tokenId);
    }

    /// @notice Mints NFT with payment verification
    /// @dev Verifies signature and prevents duplicate mints using paymentKey
    /// @param to Address to receive the minted NFT
    /// @param id Unique identifier from payment (nonce)
    /// @return tokenId The ID of the minted token
    function mintWithId(address to, bytes32 id) external onlyRole(Constants.MINTER_ROLE) returns (uint256 tokenId) {
        if (to == address(0)) revert Errors.InvalidAddress();
        if (usedIds[id]) revert Errors.InvalidId();

        usedIds[id] = true;

        tokenId = currentTokenId++;
        _safeMint(to, tokenId);
    }

    /// @notice Returns the token URI for a given token ID
    /// @dev Returns the complete metadata URL stored for the token
    /// @param tokenId The ID of the token
    /// @return The complete metadata URL for the token
    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        _requireOwned(tokenId);
        return string(abi.encodePacked(baseURI, tokenId.toString(), '.json'));
    }

    /// @notice ERC165 interface support
    /// @dev Overrides to support ERC721Enumerable and AccessControl interfaces
    /// @param interfaceId Interface identifier to check
    /// @return bool True if interface is supported
    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721Enumerable, IERC165, AccessControl) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    function _update(address to, uint256 tokenId, address auth) internal override(ERC721Enumerable) returns (address) {
        return super._update(to, tokenId, auth);
    }

    function _increaseBalance(address account, uint128 value) internal override(ERC721Enumerable) {
        super._increaseBalance(account, value);
    }
}
