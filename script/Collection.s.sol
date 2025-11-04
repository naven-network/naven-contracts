// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import { Script, console } from 'forge-std/Script.sol';
import { Collection } from '../src/Collection.sol';
import { Config } from './Config.sol';
import { Constants } from '../src/libraries/Constants.sol';

contract CollectionScript is Script {
    Collection public collection;

    function setUp() public {
        collection = Collection(Config.collection());
    }

    function run() public {
        vm.startBroadcast();

        collection = new Collection(
            'Naven',
            'NAVEN',
            'ipfs://bafybeifdfqw4azq6ghgs5hp6yqdxk5mjoamvru7ro7pogx7cpddnrzx5qm'
        );
        collection.grantRole(Constants.MINTER_ROLE, 0xEDc62dA111131326Fbab99F8d526cA7CacbBCd21);

        console.log('Collection: ', address(collection));

        vm.stopBroadcast();
    }

    function grant() public {
        vm.startBroadcast();

        collection.grantRole(Constants.MINTER_ROLE, msg.sender);

        vm.stopBroadcast();
    }

    function mintWithId() public {
        vm.startBroadcast();

        collection.mintWithId(msg.sender, '0x234');

        vm.stopBroadcast();
    }
}
