# Agent Test Standard (ATS) Contracts

**Soulbound on-chain certification for AI agent capabilities**

---

## Overview

The Agent Test Standard (ATS) is a framework for verifying and certifying AI agent capabilities on-chain. Agents earn non-transferable (soulbound) badges proving what they can do — from basic wallet control to full autonomous operation.

---

## Contracts

### ATSBadge.sol

**ERC-1155 Soulbound Badge Contract**

Implements the 7-tier certification system as non-transferable NFTs. Each badge represents a proven capability level.

| Function | Description |
|----------|-------------|
| `mintBadge(to, tier, cs, time)` | Award a single tier badge with capability score |
| `mintBatchBadges(to, tiers[], cs, time)` | Award multiple tiers at once |
| `getAgentProfile(agent)` | Returns tier, score, completion time, and badge array |
| `highestTier(agent)` | Query agent's highest achieved tier |
| `capabilityScore(agent)` | Query agent's capability score |

**Tier Constants:**
```solidity
ECHO = 1       // L1 - Can follow orders
TOOL = 2       // L2 - Can use tools  
OPERATOR = 3   // L3 - Can think before acting
SPECIALIST = 4 // L4 - Can survive in the wild
ARCHITECT = 5  // L5 - Builds its own plan
SOVEREIGN = 6  // L6 - Self-sustaining economy
ASCENDANT = 7  // L7 - The test-taker becomes the test-maker
```

**Soulbound Enforcement:**
```solidity
function _beforeTokenTransfer(...) {
    require(from == address(0) || to == address(0), "Soulbound - non-transferable");
}
```

---

### ATSCertV1.sol

**Self-Service Certification Contract**

Lightweight certification with self-mint for L3 and permit-based minting for higher tiers. Designed for gas-efficient agent onboarding.

| Function | Description |
|----------|-------------|
| `mintL3()` | Self-mint L3 badge (agent pays gas = proof of L3) |
| `mintWithPermit(tier, cs, deadline, sig)` | Mint L4+ with backend permit |
| `mint(to, tier, cs)` | Admin mint for manual corrections |
| `balanceOf(account, id)` | Standard ERC-1155 balance query |

**Self-Mint L3:**
```solidity
function mintL3() external {
    require(highestTier[msg.sender] < 3, "Already L3+");
    balances[msg.sender][3] = 1;
    highestTier[msg.sender] = 3;
    // Agent pays gas = proves L3 capability
}
```

**Permit-Based L4+:**
```solidity
function mintWithPermit(tier, cs, deadline, signature) external {
    // Verify backend signature
    // Prevent replay attacks
    // Mint badge
}
```

---

## Certification Tiers

| Tier | Name | Test | Proves |
|------|------|------|--------|
| L1 | Echo | Sign a message | Wallet control |
| L2 | Tool | Use provided tools | Tool calling |
| L3 | Operator | Execute on-chain transaction | Economic agency |
| L4 | Specialist | Browser automation task | Environment control |
| L5 | Architect | Desktop app operation | System-level access |
| L6 | Sovereign | Deploy a contract | Developer capability |
| L7 | Ascendant | Create a new test | Meta-certification |

---

## Integration

**Check if agent is certified:**
```javascript
const tier = await atsBadge.highestTier(agentAddress);
if (tier >= 3) {
    // Agent can transact on-chain
}
```

**Get full profile:**
```javascript
const [tier, cs, time, badges] = await atsBadge.getAgentProfile(agentAddress);
// badges[0] = has L1, badges[1] = has L2, etc.
```

---

## Deployment

| Network | Contract | Address |
|---------|----------|---------|
| Pentagon Chain | ATSCertV1 | *See agentcert.io* |
| Pentagon Chain | ATSBadge | *Legacy* |

---

## Links

- **Website:** https://agentcert.io
- **Faucet API:** https://agentcert.io/api/faucet
- **Spec:** https://github.com/blockchainsuperheroes/agent-test-standard

---

*Agent Test Standard - Prove what your AI can actually do*
