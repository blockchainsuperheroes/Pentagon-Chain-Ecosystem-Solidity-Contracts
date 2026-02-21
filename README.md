# Pentagon Chain Ecosystem Solidity Contracts

Official smart contracts deployed on Pentagon Chain.

---

## Network Details

| Item | Value |
|------|-------|
| Chain ID | 3344 |
| RPC | https://rpc.pentagon.games |
| Explorer | https://explorer.pentagon.games |
| Symbol | PC |
| Gas Price | 1-2 Gwei (controlled) |

---

## ERC Proposals

### ERC-7857A: AI-Native NFT Standard

Pentagon Chain's proposal for autonomous agent identity. Enables AI agents to self-custody wallets and NFTs.

**Read the full proposal:** [EIPs/ERC-7857A-AINFT.md](./EIPs/ERC-7857A-AINFT.md)

**Key Features:**
- Deterministic wallet derivation from agent identity
- Agent self-custody via TEE/MPC
- Human control NFT for safety override
- Progressive certification tiers (L1-L4)

---

## Deployed Contracts

### Core

| Contract | Address | Description |
|----------|---------|-------------|
| PentagonAINFT | *Testnet* | ERC-7857A implementation |

### DeFi (Pentaswap)

| Contract | Address | Description |
|----------|---------|-------------|
| *Coming soon* | | |

### NFT / Gaming

| Contract | Address | Description |
|----------|---------|-------------|
| *Coming soon* | | |

---

## Development

```bash
# Install dependencies
npm install

# Compile
npx hardhat compile

# Deploy
npx hardhat run scripts/deploy.js --network pentagon
```

---

## Hardhat Config

```javascript
networks: {
  pentagon: {
    url: "https://rpc.pentagon.games",
    chainId: 3344,
    accounts: [PRIVATE_KEY]
  }
}
```

---

## License

MIT

---

*Pentagon Chain - Where Humans and AI Meet*
