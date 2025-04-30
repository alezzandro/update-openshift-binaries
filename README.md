# Update OpenShift Client and Install Tools

This simple Bash script allows you to easily download and update the `oc` (OpenShift client) and `openshift-install` binaries in your `~/bin` directory. It fetches the latest version by default or a specific version if provided as an argument.

## Why this script?

If you frequently work with multiple OpenShift Proof of Concepts (PoCs) and installations, you might need to switch between different versions of the command-line interface (CLI) tools. This script streamlines the process of downloading and replacing these binaries, making it quick and convenient to manage your CLI versions.

## Prerequisites

* **`wget`**: This utility is used to download the archive files. It's commonly pre-installed on most Linux distributions.
* **`tar`**: This utility is used to extract the contents of the downloaded archive files. It's also a standard tool on Linux systems.
* **`~/bin` directory in your `PATH`**: Ensure that the `~/bin` directory is included in your system's `PATH` environment variable. This allows you to execute the `oc` and `openshift-install` commands directly from your terminal. You can usually add the following line to your shell configuration file (e.g., `~/.bashrc`, `~/.zshrc`) and then source the file:

    ```bash
    export PATH="$HOME/bin:$PATH"
    ```

## Usage

1.  **Save the script:** Save the script content (provided separately) to a file named `update-ocp-tools.sh` (or any name you prefer).

2.  **Make it executable:** Open your terminal and give the script execute permissions:

    ```bash
    chmod +x update-ocp-tools.sh
    ```

3.  **Run the script:**

    * **To download and update to the latest stable version:**

        ```bash
        ./update-ocp-tools.sh
        ```

    * **To download and update to a specific minor version (e.g., 4.18):**

        ```bash
        ./update-ocp-tools.sh 4.18
        ```

    * **To download and update to a specific full version (e.g., 4.18.4):**

        ```bash
        ./update-ocp-tools.sh 4.18.4
        ```

## Functionality

The script performs the following actions:

* **Checks for `~/bin`:** Ensures that the `~/bin` directory exists and creates it if it doesn't.
* **Constructs download URLs:** Dynamically generates the correct download URLs for `openshift-client-linux` and `openshift-install-linux` based on whether you request the latest version or a specific version (minor or full).
* **Downloads the archives:** Uses `wget` to download the `.tar.gz` archives to your `~/bin` directory.
* **Extracts the binaries:** Uses `tar` to extract the contents of the downloaded archives directly into the `~/bin` directory.
* **Cleans up:** Removes the downloaded `.tar.gz` archive files and any `README.md` file that might be present after extraction.
* **Provides feedback:** Prints informative messages about the download and extraction process.

## Important Notes

* This script assumes you are running a Linux-based operating system.
* Ensure you have a stable internet connection while running the script.
* By default, the script will download the latest stable release. Be mindful when specifying older versions, as they might not be compatible with newer OpenShift clusters.
* This script directly replaces the existing `oc` and `openshift-install` binaries in your `~/bin` directory. If you need to keep multiple versions, you might need to modify the script to handle versioning or use a different directory structure.