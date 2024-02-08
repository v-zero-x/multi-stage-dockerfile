# Multi-stage Dockerfile

This project showcases a multi-stage Docker build process for creating lightweight Docker images for both staging and production environments. This project was built as a human-AI collaboration.

> Note from the human involved: ChatGPT did all the work, wrote all the files, including this entire README. I just ran the files on my macbook according to instructions and guided it through some debugging iterations. YMMV.
> 
> This is the GPT we used: [iterative-coding GPT](https://chat.openai.com/g/g-ZfQ1k76Cv-iterative-coding)


## Table of Contents

- [Flask Web Application](#flask-web-application)
  - [Table of Contents](#table-of-contents)
  - [Quick Start](#quick-start)
  - [Installation](#installation)
    - [Prerequisites](#prerequisites)
    - [Dependencies](#dependencies)
  - [Usage](#usage)
    - [Building Docker Containers](#building-docker-containers)
    - [Testing Docker Containers](#testing-docker-containers)
    - [Cleaning Up](#cleaning-up)
    - [Additional Commands](#additional-commands)
  - [Contributing](#contributing)
  - [License](#license)

## Quick Start

To quickly set up and run this project on your MacBook Pro:

1. Clone the repository:
   ```
   git clone https://github.com/v-zero-x/multi-stage-dockerfile.git
   ```
2. Navigate to the project directory:
   ```
   cd multi-stage-dockerfile
   ```
3. Build the Docker container for staging:
   ```
   make build-staging
   ```

## Installation

### Prerequisites

- Docker: Follow the [official Docker installation guide](https://docs.docker.com/docker-for-mac/install/) for macOS.
- Git: Install Git using Homebrew with `brew install git` or download it from the [official website](https://git-scm.com/download/mac).

### Dependencies

This project requires no additional software dependencies to be installed on your machine, as all required packages are containerized in Docker. See `requirements.txt` for the Python packages needed by the application.

## Usage

### Building and Testing Staging Docker Container

  ```bash
  make build-staging
  ```

  ```bash
  make test-staging
  ```

### Building and Testing Production Docker Container

  ```bash
  make build-production
  ```

  ```bash
  make test-production
  ```

### Cleaning Up

To clean up Docker images and containers created during development and testing:
```bash
make clean
```

### Additional Commands

- Debugging the staging container:
  ```bash
  make shell-staging
  ```
- Debugging the production container:
  ```bash
  make shell-production
  ```
- Display all available `make` commands:
  ```bash
  make help
  ```

## Contributing

We welcome contributions! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch: `git checkout -b feature-branch-name`.
3. Make your changes and commit them: `git commit -am 'Add some feature'`.
4. Push to the original branch: `git push origin feature-branch-name`.
5. Create the pull request.

Alternatively, see the GitHub documentation on [creating a pull request](https://help.github.com/articles/creating-a-pull-request/).

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details. The MIT License allows you to do anything with the code, provided you include the original copyright notice and disclaimer in any copy of the software/source.

By contributing to this project, you agree that your contributions will be licensed under its MIT License.
