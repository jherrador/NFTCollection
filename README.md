# 🎨 NFTCollection

![Ethereum](https://img.shields.io/badge/Ethereum-Blockchain-3C3C3D?logo=ethereum&logoColor=white)
![Solidity](https://img.shields.io/badge/Solidity-%5E0.8.x-363636?logo=solidity)
![ERC721](https://img.shields.io/badge/Standard-ERC721-blue)
![License](https://img.shields.io/badge/License-Unlicensed-lightgrey)

NFTCollection is a smart contract application built in Solidity that allows the creation and minting of an **ERC721 NFT collection**.

The contract defines:
- A **mint price** per NFT
- A **platform revenue model** (mint payments remain in the contract)
- A **starting block number** from which minting becomes available

This project demonstrates how NFT collections are structured, launched, and monetized on Ethereum.

---

## 🧠 Project Overview

NFTCollection implements a standard **ERC721 token** with additional sale logic:

- Users can mint NFTs only after a specific **block number**
- Each mint requires payment of a predefined **mint price**
- The Ether collected from minting remains in the contract
- Each minted NFT is uniquely identified and assigned to the minter

This structure simulates a real-world NFT drop with a scheduled launch.

---

## 🏗️ Core Features

### 🎟️ ERC721 NFT Standard
- Fully compliant ERC721 token
- Unique token IDs
- Ownership tracking

### ⛓️ Scheduled Sale Start
- Minting is disabled until a specific **block number**
- Prevents early minting before official launch

### 💰 Paid Minting
- Each NFT has a fixed mint price
- Users must send the correct ETH amount
- Funds are retained by the platform (contract)

### 🛑 Validation Logic
- Minting conditions are validated before execution
- Ensures correct timing and payment

---

## 📦 Project Structure

```text
.
├── lib/
├── script/
├── src/
└── test/
```

- `src/` — NFT smart contract
- `test/` — Unit tests
- `script/` — Deployment scripts
- `lib/` — Dependencies

---

## 🛠 Tech Stack

- **Solidity**
- **ERC721**
- **Foundry**
- **Forge**
- **Ethereum**

---

## 🚀 Getting Started

### Prerequisites

- Foundry installed

---

## 🧪 Build & Test

### Compile contracts

```bash
forge build
```

### Run tests

```bash
forge test
```

---

## ⚠️ Important Notes

- Minting before the start block will revert.
- Incorrect ETH payment will revert.
- The contract retains mint funds unless a withdrawal function is implemented.

---

## 🔮 Upcoming Improvements

- Add whitelist functionality
- Add metadata URI management
- Add royalty support (ERC2981)
- Add withdrawal mechanism for platform earnings

---

## 👤 Author

Developed by **Javier Herrador** as part of his Solidity and Blockchain development journey.