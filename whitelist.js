const { ethers } = require('ethers');
const { MerkleTree } = require('merkletreejs');
const { keccak256 } = ethers.utils;

const whitelist = [
    "0xaC246edF4A1db50029A3ee30432719d2Cf0f6d63",
    "0x79Ea2d536b5b7144A3EabdC6A7E43130199291c0",
    "0x18c37f21D3C29f9a53A96CA678026DC660180065",
  ];

const padBuffer = (addr) => {
    return Buffer.from(addr.substr(2).padStart(32 * 2, 0), "hex");
};

const leaves = whitelist.map((address) => padBuffer(address));
const tree = new MerkleTree(leaves, keccak256, { sort: true });

const merkleRoot = tree.getHexRoot();

console.log("Merkle Root: ", merkleRoot);

const merkleProof = tree.getHexProof(padBuffer(whitelist[0]));
console.log("Merkle Proof: ", merkleProof);