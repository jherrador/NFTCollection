// SPDX-License-Identifier: LGPL-3.0

pragma solidity 0.8.30;

import "forge-std/Test.sol";
import "../src/BANFTCollection.sol";

import {Strings} from "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract BANFTCollectionTest is Test {
    using Strings for uint256;

    BANFTCollection nftCollection;

    function setUp() external {
        string memory name_ = "Blockchain Accelerator NFT";
        string memory symbol_ = "BANFT";
        uint256 maxSupply_ = 2;
        uint256 nftPrice_ = 1 ether;
        address owner_ = msg.sender;
        uint256 saleStartBlock_ = 2;
        string memory baseUri_ = "ipfs://bafybeihjmeqbjcjvzyytoycyaks7exwi74oqmea7cuxtdij7rw3gfxodla/";

        nftCollection = new BANFTCollection(name_, symbol_, maxSupply_, nftPrice_, owner_, saleStartBlock_, baseUri_);
    }

    function testSetNftPriceCorrectly() external {
        uint256 newNftPrice_ = 2;
        vm.startPrank(msg.sender);

        uint256 nftPriceBefore = nftCollection.nftPrice();
        nftCollection.setNftPrice(newNftPrice_);
        uint256 nftPriceAfter = nftCollection.nftPrice();

        assert(nftPriceAfter == newNftPrice_);
        assert(nftPriceBefore != newNftPrice_);

        vm.stopPrank();
    }

    function testMintRevertSaleNotStarted() external {
        vm.expectRevert("Sale not started");
        nftCollection.mint{value: 1 ether}();

        assert(block.number < nftCollection.saleStartBlock());
    }

    function testMintRevertNotEnoughEther() external {
        vm.expectRevert("Not enough Ether");
        nftCollection.mint{value: 1}();

        assert(block.number < nftCollection.saleStartBlock());
    }

    function testMintCorrectly() external {
        _mint();
    }

    function testSetSalesStartBlockCorrectly() external {
        uint256 newStartBlock_ = 4;

        vm.startPrank(msg.sender);

        uint256 startBlockBefore = nftCollection.saleStartBlock();
        nftCollection.setSaleStartBlock(newStartBlock_);
        uint256 startBlockAfter = nftCollection.saleStartBlock();

        assert(startBlockAfter == newStartBlock_);
        assert(startBlockBefore != startBlockAfter);
        vm.stopPrank();
    }

    function testSetSalesStartBlockRevertSalesStarted() external {
        _mint();

        vm.startPrank(msg.sender);
        uint256 salesStartblockBefore = nftCollection.saleStartBlock();

        vm.expectRevert("Sale already started");
        nftCollection.setSaleStartBlock(4);

        assertEq(nftCollection.saleStartBlock(), salesStartblockBefore);

        vm.stopPrank();
    }

    function testTokenURI() external {
        uint256 tokenId_ = 0;
        _mint();
        string memory tokenUri_ = nftCollection.tokenURI(tokenId_);
        string memory expectedTokenUri_ = string.concat(nftCollection.baseUri(), tokenId_.toString(), ".json");

        assertEq(tokenUri_, expectedTokenUri_);
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
