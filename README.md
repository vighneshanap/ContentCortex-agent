# contentcortex-agent

A real-time multimodal RAG agent powered by Gemini Live API, supporting audio/video/text chat with vector DB-backed responses
Agent generated with [`googleCloudPlatform/agent-starter-pack`](https://github.com/GoogleCloudPlatform/agent-starter-pack) version `0.14.1`

## Project Structure

This project is organized as follows:

```
contentcortex-agent/
├── app/                 # Core application code
│   ├── agent.py         # Main agent logic
│   ├── server.py        # FastAPI Backend server
│   └── utils/           # Utility functions and helpers
├── .cloudbuild/         # CI/CD pipeline configurations for Google Cloud Build
├── deployment/          # Infrastructure and deployment scripts
├── notebooks/           # Jupyter notebooks for prototyping and evaluation
├── tests/               # Unit, integration, and load tests
├── Makefile             # Makefile for common commands
├── GEMINI.md            # AI-assisted development guide
└── pyproject.toml       # Project dependencies and configuration
```

## Requirements

Before you begin, ensure you have:
- **uv**: Python package manager (used for all dependency management in this project) - [Install](https://docs.astral.sh/uv/getting-started/installation/) ([add packages](https://docs.astral.sh/uv/concepts/dependencies/) with `uv add <package>`)
- **Google Cloud SDK**: For GCP services - [Install](https://cloud.google.com/sdk/docs/install)
- **Terraform**: For infrastructure deployment - [Install](https://developer.hashicorp.com/terraform/downloads)
- **make**: Build automation tool - [Install](https://www.gnu.org/software/make/) (pre-installed on most Unix-based systems)


## Quick Start (Local Testing)

Install required packages and launch the local development environment:

```bash
make install && make playground
```

## Commands

| Command              | Description                                                                                 |
| -------------------- | ------------------------------------------------------------------------------------------- |
| `make install`       | Install all required dependencies using uv                                                  |
| `make playground`    | Launch local development environment with backend and frontend|
| `make backend`       | Deploy agent to Cloud Run (use `IAP=true` to enable Identity-Aware Proxy) |
| `make local-backend` | Launch local development server |
| `make ui`       | Launch Agent Playground front-end only |
| `make test`          | Run unit and integration tests                                                              |
| `make lint`          | Run code quality checks (codespell, ruff, mypy)                                             |
| `make setup-dev-env` | Set up development environment resources using Terraform                         |
| `uv run jupyter lab` | Launch Jupyter notebook                                                                     |

For full command options and usage, refer to the [Makefile](Makefile).


## Usage

This template follows a "bring your own agent" approach - you focus on your business logic in `app/agent.py`, and the template handles the surrounding components (UI, infrastructure, deployment, monitoring).

Here’s the recommended workflow for local development:

1.  **Install Dependencies (if needed):**
    ```bash
    make install
    ```

2.  **Start the Full Stack Server:**
    The FastAPI server now serves both the backend API and frontend interface:
    ```bash
    make local-backend
    ```
    The server is ready when you see `INFO:     Application startup complete.` The frontend will be available at `http://localhost:8000`.

    <details>
    <summary><b>Optional: Use AI Studio / API Key instead of Vertex AI</b></summary>

    By default, the backend uses Vertex AI and Application Default Credentials. If you prefer to use Google AI Studio and an API key:

    ```bash
    export VERTEXAI=false
    export GOOGLE_API_KEY="your-google-api-key" # Replace with your actual key
    make local-backend
    ```
    Ensure `GOOGLE_API_KEY` is set correctly in your environment.
    </details>
    <br>

    <details>
    <summary><b>Alternative: Run Frontend Separately</b></summary>

    If you prefer to run the frontend separately (useful for frontend development), you can still use:
    ```bash
    make ui
    ```
    This launches the Streamlit application, which connects to the backend server at `http://localhost:8000`.
    </details>
    <br>

3.  **Interact and Iterate:**
    *   Open your browser and navigate to `http://localhost:8000` to access the integrated frontend.
    *   Click the play button in the UI to connect to the backend.
    *   Interact with the agent! Try prompts like: *"Using the tool you have, define Governance in the context MLOPs"*
    *   Modify the agent logic in `app/agent.py`. The backend server (FastAPI with `uvicorn --reload`) should automatically restart when you save changes. Refresh the frontend if needed to see behavioral changes.


</details>

## Deployment

> **Note:** For a streamlined one-command deployment of the entire CI/CD pipeline and infrastructure using Terraform, you can use the [`agent-starter-pack setup-cicd` CLI command](https://googlecloudplatform.github.io/agent-starter-pack/cli/setup_cicd.html). Currently supports GitHub with both Google Cloud Build and GitHub Actions as CI/CD runners.

### Dev Environment

You can test deployment towards a Dev Environment using the following command:

```bash
gcloud config set project <your-dev-project-id>
make backend
```

**Note:** For secure access to your deployed backend, consider using Identity-Aware Proxy (IAP) by running `make backend IAP=true`.

The repository includes a Terraform configuration for the setup of the Dev Google Cloud project.
See [deployment/README.md](deployment/README.md) for instructions.

### Production Deployment

The repository includes a Terraform configuration for the setup of a production Google Cloud project. Refer to [deployment/README.md](deployment/README.md) for detailed instructions on how to deploy the infrastructure and application.


