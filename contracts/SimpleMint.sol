// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";


contract SimpleMint is ERC721, Ownable {

    uint256 public mintPrice = 0.05 ether;
    uint256 public totalSupply;
    uint256 public maxSupply;
    bool public isMintEnabled;
    mapping(address => uint256) public mintedWallets;


    constructor() payable ERC721("Webmob Info", "TEJAS") {
        maxSupply = 2;
    }

    function toggleIsMintEnable() external onlyOwner {
        isMintEnabled = !isMintEnabled;
    }

    function setMaxSupply(uint256 maxSupply_) external onlyOwner {
        maxSupply = maxSupply_;
    }

    function mint() payable external {
        require(isMintEnabled, "Minting not enabled right now!");
        require(mintedWallets[msg.sender] < 1, "Minting Exceeded!");
        require(msg.value == mintPrice, "Wrong NFT Price!");
        require(maxSupply > totalSupply, "Sold Out!");

        mintedWallets[msg.sender]++;
        totalSupply++;
        uint256 tokenId = totalSupply;
        _safeMint(msg.sender, tokenId);
    }

}