// SPDX-License-Identifier: MIT
pragma solidity 0.8.8;

import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract Whitelist is ERC721 {

    uint32 public tokenIds;
    bytes32 immutable public merkleRoot;
    mapping(address => bool) public claimed;

    constructor (bytes32 _merkleRoot) ERC721("MerkleToken", "MTN") {
        merkleRoot = _merkleRoot;
    }

    function toBytes32 (address _addr) pure internal returns (bytes32) {
        return bytes32(uint256(uint160(_addr)));
    }

    function mint (bytes32[] calldata _merkleProof) public payable {
        require(claimed[msg.sender] == false, "NFT already claimed");

        claimed[msg.sender] = true;
        require(MerkleProof.verify(_merkleProof, merkleRoot, toBytes32(msg.sender)), "Invalid Proof");
        tokenIds++;
        _mint(msg.sender, tokenIds);
    }
}