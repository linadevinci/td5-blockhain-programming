// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import {ERC223Token} from "src/ERC223.sol";

contract MyERC223Token is ERC223Token{
    constructor () ERC223Token ("LinaToken223", "LTK223", 18){
        _mint ( 200000);
    }
}
