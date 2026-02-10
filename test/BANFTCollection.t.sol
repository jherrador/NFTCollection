// SPDX-License-Identifier: LGPL-3.0

pragma solidity 0.8.30;

import "forge-std/Test.sol";
import "../src/BANFTCollection.sol";

contract BANFTCollectionTest is Test {

    BANFTCollection nftCollection;
    function setUp() external {
        string memory name_ = "Blockchain Accelerator NFT";
        string memory symbol_ ="BANFT";
        uint256 maxSupply_ = 2;
        uint256 nftPrice_ = 1 ether;
        address owner_ = msg.sender;
        uint256 saleStartBlock_ = 2;
        string memory baseUri_ = "ipfs://bafybeihjmeqbjcjvzyytoycyaks7exwi74oqmea7cuxtdij7rw3gfxodla/";
        
        nftCollection = new BANFTCollection(name_, symbol_, maxSupply_, nftPrice_, owner_, saleStartBlock_, baseUri_ );
    }

    function testMaxSupply() external {
        assertEq(nftCollection.maxSupply(), 2);
        
    }

    function testMintRevertSaleNotStarted() external {
        vm.expectRevert("Sale not started");
        nftCollection.mint{value: 1 ether}();

        console.log(block.number);
        assert(block.number < nftCollection.saleStartBlock());
    }

    function testMintRevertNotEnoughEther() external {
        vm.expectRevert("Not enough Ether");
        nftCollection.mint{value: 1 }();

        console.log(block.number);
        assert(block.number < nftCollection.saleStartBlock());
    }

    function testMintCorrectly() external {
        _mint();
    }

    // Helper
    function _mint() private {
        address random = vm.addr(1);
        vm.deal(random, 100 ether);

        vm.startPrank(random);
        vm.roll(block.number + 1);
        nftCollection.mint{value: 1 ether}();
        assert(nftCollection.currentTokenId() == 1);
        assert(nftCollection.salesStarted());

        vm.stopPrank();
    }
}