// SPDX-License-Identifier: UNLICENSESD

pragma solidity 0.8.30;

import "../lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol";
import "../lib/openzeppelin-contracts/contracts/access/Ownable.sol";

import {Strings} from "../lib/openzeppelin-contracts/contracts/utils/Strings.sol";

contract BANFTCollection is ERC721, Ownable {
    using Strings for uint256;

    uint256 public currentTokenId;
    uint256 public maxSupply;
    uint256 public nftPrice;
    uint256 public saleStartBlock;
    bool public salesStarted;
    string public baseUri;

    event MintBANFT(address userAddress_, uint256 tokenId_);

    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxSupply_,
        uint256 nftPrice_,
        address owner_,
        uint256 saleStartBlock_,
        string memory baseUri_
    ) ERC721(name_, symbol_) Ownable(owner_) {
        maxSupply = maxSupply_;
        nftPrice = nftPrice_;
        saleStartBlock = saleStartBlock_;
        baseUri = baseUri_;
    }

    function mint() external payable {
        require(currentTokenId < maxSupply, "Sold Out");
        require(msg.value == nftPrice, "Not enough Ether");
        require(block.number >= saleStartBlock, "Sale not started");

        if (currentTokenId == 0) {
            salesStarted = true;
        }

        _safeMint(msg.sender, currentTokenId);
        currentTokenId++;

        emit MintBANFT(msg.sender, currentTokenId - 1);
    }

    function setNftPrice(uint256 nftPrice_) external onlyOwner {
        nftPrice = nftPrice_;
    }

    function setSaleStartBlock(uint256 saleStartBlock_) external onlyOwner {
        require(salesStarted == false, "Sale already started");
        saleStartBlock = saleStartBlock_;
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseUri;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        _requireOwned(tokenId);

        string memory baseURI = _baseURI();
        return bytes(baseURI).length > 0 ? string.concat(baseURI, tokenId.toString(), ".json") : "";
    }
}
