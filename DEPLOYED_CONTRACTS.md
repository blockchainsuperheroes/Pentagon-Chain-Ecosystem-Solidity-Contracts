# Pentagon Chain Deployed Contracts

**Network:** Pentagon Chain (3344)
**Explorer:** https://explorer.pentagon.games

---

## PentaSwap DEX Contracts (Verified)

| Contract | Address | Description |
|----------|---------|-------------|
| PentaswapV2Factory | `0xC75C7E9352bC1475d7c308E65C0a21969DcEdEe7` | Factory for creating pairs |
| PentaswapV2Router | `0x60b70E46178CEf34E71B61BDE2E79bbB7bA41706` | Router for swaps |
| WPC (Wrapped PC) | `0xAA3d9411DD08FDA149d4545089e241E62EE87860` | Wrapped native token |

### Trading Pairs
- BANANA/WPC
- ZOR/WPC
- ZOR/BANANA
- WPC/MN
- PROF/WPC

**Related Repos:**
- Frontend: [swapfive_web](https://github.com/blockchainsuperheroes/swapfive_web)
- SDK: [pentaswap-sdk](https://github.com/blockchainsuperheroes/pentaswap-sdk)
- V2 Frontend: [pentaswap-v2](https://github.com/blockchainsuperheroes/pentaswap-v2)
- Backend API: [pen-wallet-backend](https://github.com/blockchainsuperheroes/pen-wallet-backend)

---

## Verified Contracts

| Contract | Address | Description |
|----------|---------|-------------|
| POW_SBT_2025 | `0x350994eef2fb018d43ce0b3dc3d2a590a9ecf65b` | Proof of Work Soulbound Token |
| Blockchain_Superheroes_V2 | `0x35a31e23fb1aad207ad4075c52e981dc9165059b` | BCSH Hero NFT |
| Blockchain_Superheroes_V2 | `0x2444d26cc268848f2b1bd837456537510f1aac81` | BCSH Hero NFT (v2) |
| Blockchain_Superheroes_V2 | `0xf8c869a5575f44fb9b68f670e6b158b30fb8ccf5` | BCSH Hero NFT (v2) |
| Blockchain_Superheroes_V2 | `0xe0f550acb3909909eca46d7e63bd916dbbc5c200` | BCSH Hero NFT (v2) |
| BCSH_Distributor_V2 | `0x90007b61ba3430f7e28f97ba8da2d462330bd532` | Hero Mint Distributor |
| BCSH_Distributor_V2 | `0x2954dd800e711eca3a8ef8073201bbff118c3ce3` | Hero Mint Distributor |
| BCSH_Distributor_V2 | `0xd776b45cc853f7773c019ec55b400307429e58cd` | Hero Mint Distributor |
| BCSH_Distributor_V2 | `0x5d546810492041b827537c95e0773098fc213237` | Hero Mint Distributor |
| EchoVault | `0x06635df7b6a565839e51e88deb58f31be9f2172c` | EmotiCoin Vault Implementation |
| EchoVaultFactory | `0xadbbdca1c0cba9667f0359ea8ccec2c773fcf174` | EmotiCoin Factory |
| EchoVaultFactory | `0x81ae670e1d6227df349e73fbcf209b950c657fe0` | EmotiCoin Factory (v2) |
| EchoVaultFactoryProxy | `0x7a2190fc4d89dab75dbc06d9a35b38a748e80c44` | EmotiCoin Factory Proxy |
| ProxyAdmin | `0x7928864e73536238f52910c6caa2e1bbecaa92fb` | Proxy Admin |
| ProxyAdmin | `0x45e3cbe0646c8eb3fad4edbe951ff39cf98808f2` | Proxy Admin |
| ProxyAdmin | `0xad356074075d7a011daa568cac288fad6b75c42b` | Proxy Admin |
| Rug | `0x7691824c572a745b9caf1b915f64424681c6324d` | Rug NFT |
| Rug | `0xd77f88ef51b2589d132d6eb61068079f61dfe4a3` | Rug NFT |
| RugDistributor | `0x978c45ea78ce8ccdc0a7a6bcd80311362744e390` | Rug Mint + ZOR Rewards |
| RugDistributor | `0xba6c21b3217cf12f54627b10df34532f32c7d9ab` | Rug Mint + ZOR Rewards |
| RugAirdrop | `0x7e7b5d8f379a518a79b9b72614c3a3c874345ec9` | Rug Airdrop |
| RugAirdrop | `0x4d251efbdd7dec3b9ac67ca4f1da9d1e56925a2e` | Rug Airdrop |
| SToken | `0x915962d73dea132a55e990c70c376954ead8f6d2` | S Token (ERC20) |
| SToken | `0x286707449222de7dd620640926dfb0967cf88140` | S Token (ERC20) |
| ERC1967Proxy | `0x4fa3e2410f01dfbc99db01e68f5bef75961c22ce` | Upgradeable Proxy |
| TransparentUpgradeableProxy | `0xd414f7015e44c65139db92dd8a7eea48b61e5980` | Transparent Proxy |
| MyToken | `0x265d9a7b4815f96495f9feb4ae5ab71ce313a396` | Sample ERC20 |

---

## Unverified Contracts

| Address | Notes |
|---------|-------|
| `0xc60224d2919150df9f92be30898995f91e4bef2a` | Unknown |
| `0x77795b82d6e8f36da81e25151fbbac8f36b14628` | Unknown |
| `0x73c872d5704b57a50a4ab5169292f2f3b3589ac2` | Unknown |
| `0x1bf585b68217cd88741919b68da672b52df89672` | Unknown |
| `0x0fa205c0446cd9eedcc7538c9e24bc55ad08207f` | Unknown |

---

## Contract Categories

### NFT Collections
- **Blockchain_Superheroes_V2**: Main hero NFT
- **POW_SBT_2025**: Soulbound proof of work
- **Rug**: Rug NFT collection

### Token Infrastructure
- **EchoVault/EchoVaultFactory**: EmotiCoin (pump.fun-style) bonding curve tokens
- **SToken**: Standard ERC20 token

### Distribution
- **BCSH_Distributor_V2**: Hero mint distribution
- **RugDistributor**: Rug mint + ZOR rewards
- **RugAirdrop**: Batch airdrops

### Upgradeable Infrastructure
- **ProxyAdmin**: Manages upgradeable proxies
- **TransparentUpgradeableProxy**: UUPS proxy pattern

---

*Last updated: 2026-02-21*

---

## Security

**CertiK Audit:** https://skynet.certik.com/projects/pentagon-games
