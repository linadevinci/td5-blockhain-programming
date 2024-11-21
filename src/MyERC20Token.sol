// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;
import "./MyERC20Token.sol";
import "lib/openzeppelin-contracts/contracts/token/ERC20/ERC20.sol";

contract MyERC20Token is ERC20 {
    constructor() ERC20("LinaToken", "LTK") {
        // Mint total supply to the deployer's address
        _mint(msg.sender, 10000 * 10 ** decimals());
    }

    function decimals() public pure override returns (uint8) {
        return 18; // Set the number of decimals
    }

    
}
