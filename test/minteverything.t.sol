// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.26;

import "forge-std/Test.sol";
import "../src/MyERC20Token.sol";
import "../src/MyERC223Token.sol";
import "../src/MyERC721Token.sol";

contract MintWithERC20AndERC223Test is Test {
    MyERC20Token erc20;
    MyERC223Token erc223;
    MyNFT nft;

    address user;

    function setUp() public {
        // Deploy ERC20 and ERC223 tokens
        erc20 = new MyERC20Token();
        erc223 = new MyERC223Token();

        // Deploy NFT contract with ERC20 and ERC223 minting prices
        uint256 priceERC20 = 100 * 10**18; // Price in ERC20 tokens
        uint256 priceERC223 = 50 * 10**18; // Price in ERC223 tokens
        nft = new MyNFT(address(erc20), address(erc223), priceERC20, priceERC223);

        address deployer = address(this); // Current test contract as the deployer
        erc20.transfer(user, 1000 * 10 ** 18);

        // Setup a test user and assign tokens
        address user = address(0x123);
        vm.startPrank(user);

        // Mint ERC20 and ERC223 tokens to the user
        erc20.transfer(user, 1000 * 10**18);
        erc223.transfer(user, 1000 * 10**18);

        console.log("Deployer balance before transfer:", erc20.balanceOf(address(this)));
        console.log("User balance before transfer:", erc20.balanceOf(user));

    }

    function testMintWithERC20() public {
        uint256 tokenId = 1;

        vm.startPrank(user);

        // Approve the NFT contract to spend user's ERC20 tokens
        erc20.approve(address(nft), 100 * 10**18);

        // Mint the NFT using ERC20 tokens
        nft.mintWithERC20(tokenId);

        // Verify NFT ownership
        assertEq(nft.ownerOf(tokenId), user);

        // Verify ERC20 balance deduction
        assertEq(erc20.balanceOf(user), 900 * 10**18);

        vm.stopPrank();
    }

    function testMintWithERC223() public {
        uint256 tokenId = 1;

        vm.startPrank(user);

        // Encode tokenId as data for the ERC223 transfer
        bytes memory data = abi.encode(tokenId);

        // Mint the NFT by transferring ERC223 tokens
        erc223.transfer(address(nft), 50 * 10**18, data);

        // Verify NFT ownership
        assertEq(nft.ownerOf(tokenId), user);

        // Verify ERC223 balance deduction
        assertEq(erc223.balanceOf(user), 950 * 10**18);

        vm.stopPrank();
    }

    function testMintWithERC20InsufficientBalance() public {
        uint256 tokenId = 1;

        vm.startPrank(user);

        // Reduce the user's ERC20 balance below the required amount
        erc20.transfer(address(0xdead), 950 * 10**18);

        // Expect revert due to insufficient balance
        vm.expectRevert("Insufficient ERC20 balance");
        nft.mintWithERC20(tokenId);

        vm.stopPrank();
    }

    function testMintWithERC223IncorrectAmount() public {
        uint256 tokenId = 1;

        vm.startPrank(user);

        // Attempt to mint with less than the required ERC223 amount
        bytes memory data = abi.encode(tokenId);
        vm.expectRevert("Incorrect payment amount");
        erc223.transfer(address(nft), 40 * 10**18, data);

        vm.stopPrank();
    }
}
