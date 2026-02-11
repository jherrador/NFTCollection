// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.30;

import {Script} from "forge-std/Script.sol";
import {BANFTCollection} from "../src/BANFTCollection.sol";

contract BANFTCollectionScript is Script {
    function run() external {
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        string memory name_ = "Blockchain Accelerator NFT";
        string memory symbol_ = "BANFT";
        uint256 maxSupply_ = 2;
        uint256 nftPrice_ = 1 ether;
        address owner_ = vm.addr(deployerPrivateKey);
        uint256 saleStartBlock_ = 2;
        string memory baseUri_ = "ipfs://bafybeihjmeqbjcjvzyytoycyaks7exwi74oqmea7cuxtdij7rw3gfxodla/";

        BANFTCollection nftCollection =
            new BANFTCollection(name_, symbol_, maxSupply_, nftPrice_, owner_, saleStartBlock_, baseUri_);

        vm.stopBroadcast();
    }
}

