//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNFT is ERC721 {
    uint256 private s_tokenCounter;
    string private s_happy_svg_image_uri =
        "data:image/svg+xml;base64,PHN2ZyB2aWV3Qm94PSIwIDAgMjAwIDIwMCIgd2lkdGg9IjQwMCIgIGhlaWdodD0iNDAwIiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxjaXJjbGUgY3g9IjEwMCIgY3k9IjEwMCIgZmlsbD0ieWVsbG93IiByPSI3OCIgc3Ryb2tlPSJibGFjayIgc3Ryb2tlLXdpZHRoPSIzIi8+CiAgPGcgY2xhc3M9ImV5ZXMiPgogICAgPGNpcmNsZSBjeD0iNjEiIGN5PSI4MiIgcj0iMTIiLz4KICAgIDxjaXJjbGUgY3g9IjEyNyIgY3k9IjgyIiByPSIxMiIvPgogIDwvZz4KICA8cGF0aCBkPSJtMTM2LjgxIDExNi41M2MuNjkgMjYuMTctNjQuMTEgNDItODEuNTItLjczIiBzdHlsZT0iZmlsbDpub25lOyBzdHJva2U6IGJsYWNrOyBzdHJva2Utd2lkdGg6IDM7Ii8+Cjwvc3ZnPg==";
    string private s_sad_svg_image_uri =
        "data:image/svg+xml;base64,PD94bWwgdmVyc2lvbj0iMS4wIiBzdGFuZGFsb25lPSJubyI/Pgo8c3ZnIHdpZHRoPSIxMDI0cHgiIGhlaWdodD0iMTAyNHB4IiB2aWV3Qm94PSIwIDAgMTAyNCAxMDI0IiB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciPgogIDxwYXRoIGZpbGw9IiMzMzMiIGQ9Ik01MTIgNjRDMjY0LjYgNjQgNjQgMjY0LjYgNjQgNTEyczIwMC42IDQ0OCA0NDggNDQ4IDQ0OC0yMDAuNiA0NDgtNDQ4Uzc1OS40IDY0IDUxMiA2NHptMCA4MjBjLTIwNS40IDAtMzcyLTE2Ni42LTM3Mi0zNzJzMTY2LjYtMzcyIDM3Mi0zNzIgMzcyIDE2Ni42IDM3MiAzNzItMTY2LjYgMzcyLTM3MiAzNzJ6Ii8+CiAgPHBhdGggZmlsbD0iI0U2RTZFNiIgZD0iTTUxMiAxNDBjLTIwNS40IDAtMzcyIDE2Ni42LTM3MiAzNzJzMTY2LjYgMzcyIDM3MiAzNzIgMzcyLTE2Ni42IDM3Mi0zNzItMTY2LjYtMzcyLTM3Mi0zNzJ6TTI4OCA0MjFhNDguMDEgNDguMDEgMCAwIDEgOTYgMCA0OC4wMSA0OC4wMSAwIDAgMS05NiAwem0zNzYgMjcyaC00OC4xYy00LjIgMC03LjgtMy4yLTguMS03LjRDNjA0IDYzNi4xIDU2Mi41IDU5NyA1MTIgNTk3cy05Mi4xIDM5LjEtOTUuOCA4OC42Yy0uMyA0LjItMy45IDcuNC04LjEgNy40SDM2MGE4IDggMCAwIDEtOC04LjRjNC40LTg0LjMgNzQuNS0xNTEuNiAxNjAtMTUxLjZzMTU1LjYgNjcuMyAxNjAgMTUxLjZhOCA4IDAgMCAxLTggOC40em0yNC0yMjRhNDguMDEgNDguMDEgMCAwIDEgMC05NiA0OC4wMSA0OC4wMSAwIDAgMSAwIDk2eiIvPgogIDxwYXRoIGZpbGw9IiMzMzMiIGQ9Ik0yODggNDIxYTQ4IDQ4IDAgMSAwIDk2IDAgNDggNDggMCAxIDAtOTYgMHptMjI0IDExMmMtODUuNSAwLTE1NS42IDY3LjMtMTYwIDE1MS42YTggOCAwIDAgMCA4IDguNGg0OC4xYzQuMiAwIDcuOC0zLjIgOC4xLTcuNCAzLjctNDkuNSA0NS4zLTg4LjYgOTUuOC04OC42czkyIDM5LjEgOTUuOCA4OC42Yy4zIDQuMiAzLjkgNy40IDguMSA3LjRINjY0YTggOCAwIDAgMCA4LTguNEM2NjcuNiA2MDAuMyA1OTcuNSA1MzMgNTEyIDUzM3ptMTI4LTExMmE0OCA0OCAwIDEgMCA5NiAwIDQ4IDQ4IDAgMSAwLTk2IDB6Ii8+Cjwvc3ZnPgo=";

    enum Mood {
        HAPPY,
        SAD
    }

    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(
        string memory happy_svg_image_uri,
        string memory sad_svg_image_uri
    ) ERC721("Mood NFT", "MDNFT") {
        s_tokenCounter = 0;
        s_happy_svg_image_uri = happy_svg_image_uri;
        s_sad_svg_image_uri = sad_svg_image_uri;
    }

    function mintNft() public {
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenIdToMood[s_tokenCounter] = Mood.HAPPY;
        s_tokenCounter++;
    }

    function _baseURI() internal pure override returns (string memory) {
        //json prefix is needed to tell the browser that it is a json file
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        //data:image/svg+xml;base64,
        // string memory svgBase64EncodedData = Base64.encode(
        //     bytes(
        //         getSvgImage(tokenId)
        //     )
        // );
        string memory imageUri;
        if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
            imageUri = s_happy_svg_image_uri;
        } else {
            imageUri = s_sad_svg_image_uri;
        }

        //string.concat is good to concate strings but we need to have it converted to bytes
        // string memory tokenMetadata = string.concat(
        //     '{"name": "',
        //     name(),
        //     '", "description": "Chose your todays mood!", "attributes":[{"trait_types": "ArtOfMood", "value":100}], "image": "',
        //     getSvgImage(tokenId),
        //     '"}'
        // );

        // convert to bytes to be able to use the Base64 Encoder

        //step 6: wrap all as a string and return it
        return
            string(
                //step 5: concat the json prefix and the encoded json contents
                abi.encodePacked(
                    //step 4: grab the json prefix
                    _baseURI(),
                    //step 3: pass the whole to the base64 encoder
                    Base64.encode(
                        //step 2: convert to bytes
                        bytes(
                            //step 1: concat the strings using abi.encodePacked
                            abi.encodePacked(
                                '{"name": "',
                                name(),
                                '", "description": "Chose your todays mood!", "attributes":[{"trait_types": "ArtOfMood", "value":100}], "image": "',
                                imageUri,
                                '"}'
                            )
                        )
                    )
                )
            );
    }

    function flipMood(uint256 tokenId) public {
        if (msg.sender == ownerOf(tokenId)) {
            if (s_tokenIdToMood[tokenId] == Mood.HAPPY) {
                s_tokenIdToMood[tokenId] = Mood.SAD;
            } else {
                s_tokenIdToMood[tokenId] = Mood.HAPPY;
            }
        } else {
            revert("Not owner of that nft");
        }
    }
}
