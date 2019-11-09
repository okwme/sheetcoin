pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/ERC20Mintable.sol";
import "@openzeppelin/contracts/token/ERC20/ERC20Detailed.sol";

/**
 * The Sheetcoin contract does this and that...
 */
contract Sheetcoin is ERC20Detailed, ERC20Mintable {
    constructor()
        public
        ERC20Detailed("Sheetcoin", "SHT", 0) {
            mint(msg.sender, 420);
        }
}