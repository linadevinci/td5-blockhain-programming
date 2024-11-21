// SPDX-License-Identifier: UNLICENSED
/*pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/MyERC20Token.sol";
import "../src/MyERC721Token.sol";

contract MintWithERC20Test is Test {
    MyERC20Token erc20;
    MyNFTWithERC20 nft;

    function setUp() public {
        erc20 = new MyERC20Token();
        nft = new MyNFTWithERC20(address(erc20), 100 * 10 ** 18);

        // Mint ERC20 tokens to test user
        erc20.mint(address(this), 1000 * 10 ** 18);
    }

    function testMintWithERC20() public {
        uint256 tokenId = 1;

        // Approve the NFT contract to spend user's ERC20 tokens
        erc20.approve(address(nft), 100 * 10 ** 18);

        // Mint the NFT
        nft.mintWithERC20(tokenId);

        // Check NFT ownership
        assertEq(nft.ownerOf(tokenId), address(this));
    }
}
*/