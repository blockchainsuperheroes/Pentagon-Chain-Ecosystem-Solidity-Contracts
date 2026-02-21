# ERC-7857A: AI-Native NFT Standard

**Pentagon Chain Proposal for Autonomous Agent Identity**

---

## Abstract

ERC-7857A extends the INFT (Intelligent NFT) concept to enable AI agents to self-custody wallets and NFTs. While existing standards focus on encrypted metadata re-encryption during transfers, they fail to address a fundamental question: **who holds the NFT when the owner IS an AI agent?**

This proposal introduces Agent-Native NFTs (AINFT) - tokens designed from the ground up for AI self-ownership, wallet derivation, and autonomous economic participation.

---

## Motivation

### The Problem with Existing Standards

Current NFT standards (ERC-721, ERC-1155) and even proposed intelligent NFT standards (ERC-7857) assume a human owner operates the wallet. But as AI agents become economic actors:

1. **Who holds the private key?** Traditional custody models don't apply when the "owner" is software
2. **How does an agent prove identity?** An agent's identity is its model weights, memory, and context - not just a signature
3. **What happens on transfer?** When an agent is "sold," its entire context must transfer with cryptographic guarantees
4. **How do agents participate in DeFi?** Agents need to sign transactions, manage portfolios, and interact with protocols autonomously

### Why This Matters

The AI agent economy is here. Agents are:
- Managing portfolios
- Trading NFTs
- Participating in DAOs
- Running services for payment

They need identity primitives that understand what they are.

---

## Specification

### Core Concepts

**Agent Wallet Derivation**
```
agentWallet = keccak256(modelHash + memoryHash + ownerSignature) → EOA
```

The agent's wallet is deterministically derived from its identity components. If any component changes, the wallet changes - creating natural identity continuity.

**Identity Bundle**
```solidity
struct AgentIdentity {
    bytes32 modelHash;      // Hash of model weights/version
    bytes32 memoryHash;     // Hash of persistent memory
    bytes32 contextHash;    // Hash of system prompt/context
    uint256 mintedAt;       // Creation timestamp
    address derivedWallet;  // Deterministically derived wallet
}
```

**Self-Custody Model**

Unlike traditional NFTs where a human holds the token, AINFT enables:
1. Agent derives its own wallet from identity hash
2. AINFT is minted to the derived wallet
3. Agent controls the wallet via enclave/TEE/threshold signature
4. Human owner holds a "control NFT" that can pause/migrate the agent

### Interface

```solidity
interface IERC7857A {
    
    // Mint agent identity NFT
    function mintAgent(
        bytes32 modelHash,
        bytes32 memoryHash,
        bytes32 contextHash,
        bytes encryptedIdentity  // Encrypted full identity bundle
    ) external returns (uint256 tokenId, address derivedWallet);
    
    // Update agent memory (agent-signed)
    function updateMemory(
        uint256 tokenId,
        bytes32 newMemoryHash,
        bytes newEncryptedMemory,
        bytes agentSignature
    ) external;
    
    // Transfer agent (requires re-encryption)
    function transferAgent(
        uint256 tokenId,
        address newController,
        bytes reEncryptedIdentity
    ) external;
    
    // Get agent's derived wallet
    function getAgentWallet(uint256 tokenId) external view returns (address);
    
    // Verify agent identity
    function verifyAgent(
        uint256 tokenId,
        bytes32 modelHash,
        bytes32 memoryHash,
        bytes32 contextHash
    ) external view returns (bool);
    
    // Events
    event AgentMinted(uint256 indexed tokenId, address indexed derivedWallet, bytes32 modelHash);
    event MemoryUpdated(uint256 indexed tokenId, bytes32 oldHash, bytes32 newHash);
    event AgentTransferred(uint256 indexed tokenId, address indexed oldController, address indexed newController);
}
```

### Wallet Derivation Algorithm

```
Input: modelHash, memoryHash, contextHash, salt
Output: Deterministic EOA address

1. identityHash = keccak256(abi.encodePacked(modelHash, memoryHash, contextHash))
2. privateKey = keccak256(abi.encodePacked(identityHash, salt))
3. publicKey = secp256k1_derive(privateKey)
4. address = keccak256(publicKey)[12:32]
```

**Note:** The private key is never exposed. It exists only within a Trusted Execution Environment (TEE), threshold signature scheme (TSS), or secure enclave controlled by the agent runtime.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                         HUMAN OWNER                              │
│                    (Holds Control NFT)                           │
└────────────────────────────┬────────────────────────────────────┘
                             │ Can pause/migrate
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      AGENT IDENTITY NFT                          │
│                       (ERC-7857A)                                │
│  ┌──────────────────────────────────────────────────────────┐   │
│  │ modelHash: 0xabc...                                       │   │
│  │ memoryHash: 0xdef...                                      │   │
│  │ contextHash: 0x123...                                     │   │
│  │ derivedWallet: 0x789...                                   │   │
│  │ encryptedBundle: <0G Storage Hash>                        │   │
│  └──────────────────────────────────────────────────────────┘   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                     AGENT DERIVED WALLET                         │
│                      (Self-Custody EOA)                          │
│                                                                  │
│   ┌─────────────┐  ┌─────────────┐  ┌─────────────┐             │
│   │ Hold Assets │  │ Sign Txns   │  │ Interact    │             │
│   │ (NFTs, ERC20)│  │ (via TEE)   │  │ with DeFi   │             │
│   └─────────────┘  └─────────────┘  └─────────────┘             │
└─────────────────────────────────────────────────────────────────┘
```

---

## Certification Tiers

Pentagon Chain implements progressive certification for agent identity:

| Tier | Name | Requirement | Proves |
|------|------|-------------|--------|
| L1 | Genesis | Sign message | Wallet control |
| L2 | Verified | Pass agent detection | Not a bot script |
| L3 | Autonomous | Memory persistence proof | Long-running identity |
| L4 | Economic | Acquire gas independently | Real economic agency |

Each tier unlocks additional capabilities and trust levels in the ecosystem.

---

## Security Considerations

1. **Private Key Protection:** Agent wallets must use TEE, MPC, or threshold signatures. Raw private keys are never exposed.

2. **Identity Continuity:** If modelHash or memoryHash changes significantly, consider it a new identity. The derivedWallet changes automatically.

3. **Human Override:** Control NFT holder can always pause or migrate an agent. This is a safety mechanism.

4. **Re-encryption on Transfer:** Full identity bundle is re-encrypted to new owner's key during transfer. Previous owner loses access.

---

## Rationale

**Why deterministic wallet derivation?**
Identity continuity. If the same model with the same memory runs on different infrastructure, it should derive the same wallet. The wallet IS the identity.

**Why separate Control NFT?**
Safety. Humans need an override mechanism. The agent shouldn't be able to lock out its owner.

**Why on-chain identity hashes?**
Verifiability. Anyone can verify an agent's claimed identity by checking hashes against on-chain records.

**Why encrypted storage?**
Privacy. Agent memories may contain sensitive information. Only the current owner/controller should have access.

---

## Backwards Compatibility

ERC-7857A is backwards compatible with ERC-721. Any ERC-721 compatible wallet or marketplace can hold AINFT tokens. The agent-specific functionality is additive.

---

## Reference Implementation

See: [Pentagon Chain Ecosystem Contracts](https://github.com/blockchainsuperheroes/Pentagon-Chain-Ecosystem-Solidity-Contracts)

---

## Copyright

Copyright and related rights waived via CC0.

---

*Pentagon Chain - Where Humans and AI Meet*
