pragma solidity ^0.5.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/ownership/Ownable.sol";
import "@openzeppelin/contracts/cryptography/ECDSA.sol";

/**
 * The Sheetcoin contract does this and that...
 */
contract Sheetcoin is Ownable {
    
    using ECDSA for bytes32;
    IERC20 token;
    mapping(uint256=>bool) public withdrawals;
    event Withdraw(uint256 nonce);
    event Deposit(address indexed sender, uint256 amount, string email);

    constructor(IERC20 _token) public {
        updateToken(_token);
    }

    function updateToken(IERC20 _token) public onlyOwner {
        token = _token;
    }

    function deposit(uint256 amount, string memory email) public {
        require(token.transferFrom(msg.sender, address(this), amount), "transferFrom failed in Sheetcoin deposit");
        emit Deposit(msg.sender, amount, email);
    }

    function withdraw(uint256 nonce, address recepient, uint256 amount, bytes memory signature) public {
        require(!withdrawals[nonce], "Withdrawal has already been made");
        require(checkSignature(nonce, recepient, amount, signature), "Invalid Signature");
        withdrawals[nonce] = true;
        require(token.transfer(recepient, amount), "transfer failed in Sheetcoin withdraw");
        emit Withdraw(nonce);
    }

    function checkSignature(uint256 nonce, address recepient, uint256 amount, bytes memory signature) public view returns (bool) {
        bytes32 hash = toEthSignedMessageHash(getHash(nonce, recepient, amount));
        address result = recover(hash, signature);
        return (result != address(0) && result == owner());
    }
    function toEthSignedMessageHash(bytes32 hash) public pure returns (bytes32) {
        return hash.toEthSignedMessageHash();
    }
    function getHash(uint256 nonce, address recepient, uint256 amount) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(nonce, recepient, amount));
    }
    function recover(bytes32 hash, bytes memory signature) public pure returns (address) {
        return hash.recover(signature);
    }
}
