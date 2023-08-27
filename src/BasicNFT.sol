//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract BasicNFT is ERC721 {
    mapping(uint256 => string) private s_tokenIdToTokenURIs;

    uint256 private s_tokenCounter;

    constructor() ERC721("BasicNFT", "BNFT") {
        s_tokenCounter = 0;
    }

    // function createNFT(address recipient, string memory tokenURI) public returns (uint256) {
    //     uint256 newItemId = s_tokenCounter;
    //     _safeMint(recipient, newItemId);
    //     _setTokenURI(newItemId, tokenURI);
    //     s_tokenCounter = s_tokenCounter + 1;
    //     return newItemId;
    // }

    function mintNFT(string memory NFTTokenURI) public {
        s_tokenIdToTokenURIs[s_tokenCounter] = NFTTokenURI;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        return s_tokenIdToTokenURIs[tokenId];
    }
}
