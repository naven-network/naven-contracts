## Naven Contracts

Smart contract collection for the Naven Network.

### Prerequisites

- Node.js

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/naven-contracts.git
   cd naven-contracts
   ```

2. Install dependencies:
   ```bash
   npm install
   ```

3. Set up environment variables:
    - Copy the example environment file:
      ```bash
      cp .env.example .env
      ```
    - Open `.env` and configure:
        - `PRIVATE_KEY`: Your wallet private key
        - `RPC_URL`: Network RPC endpoint

### Deployment

To deploy the NFT collection:

```shell
make deploy-Collection
```
