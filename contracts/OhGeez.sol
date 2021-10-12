// SPDX-License-Identifier: MIT

pragma solidity =0.8.9;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "./MerkleProof.sol";

contract OhGeez is ERC20, MerkleProof {
    bytes32 public merkleRoot;
    mapping(address => bool) public claimed;

    constructor(bytes32 _merkleRoot) ERC20("Oh..Geez", "OH-GEEZ") {
        _mint(address(this), 333e18);
        merkleRoot = _merkleRoot;
    }

    function claim(bytes32 leaf, bytes32[] memory proof) external {
        require(!claimed[msg.sender], "FORBIDDEN");
        require(verify(merkleRoot, leaf, proof), "INVALID_PROOF");
        claimed[msg.sender] = true;
        transfer(msg.sender, 1e18);
    }
}