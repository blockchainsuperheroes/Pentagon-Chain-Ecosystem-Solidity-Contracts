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

## Deployed Contracts

### Core

| Contract | Address | Description |
|----------|---------|-------------|
| *Coming soon* | | |

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
