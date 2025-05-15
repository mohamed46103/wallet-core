# Contributing to Wallet Core

First off, thank you for taking the time to contribute to **Wallet Core** — a modular, secure, and gas-optimized implementation of EIP-7702.

We welcome contributions from the community and are grateful for your support!

---

## 🧑‍💻 How to Contribute

### 1. Fork and Clone

```bash
git clone https://github.com/okx/wallet-core.git
cd wallet-core
```

### 2. Create a Feature Branch

```bash
git checkout -b feature/my-feature
```

### 3. Make Your Changes

- Follow the existing coding style (Solidity + TypeScript)
- Write tests for your changes (Foundry/Hardhat)
- Ensure the code compiles and passes all existing tests

### 4. Run Tests

```bash
# Foundry
forge test
```

### 5. Commit and Push

```bash
git commit -m "feat: <short description>"
git push origin feature/my-feature
```

### 6. Open a Pull Request

- Go to GitHub and open a PR from your branch.
- Fill out the PR template with context and checklist.

---

## ✅ Pull Request Requirements

- Follow the [GPL-3.0 License](./LICENSE)
- Write clear commit messages and PR descriptions
- Link any related issues using `Fixes #123`
- Keep PRs focused and minimal (no unrelated changes)

---

## 📂 Project Structure

```
src/           # EIP-7702 smart wallet contracts
 ├─ validator/       # Validator
 └─ interfaces/      # External/public interfaces
test/                # Foundry tests
scripts/             # Deployment and upgrade scripts
```

---

## 🛡 Security Reporting

If you discover a security issue, please **do not** open a public issue.  
Instead, report it to: [security](https://web3.okx.com/security)

---

## 💬 Questions or Feedback?

Open a [GitHub Discussion](https://github.com/okx/wallet-core/discussions) or create an issue for bugs/requests.

We appreciate your interest and contributions!
