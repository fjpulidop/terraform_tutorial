# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Set noninteractive installation mode, this is useful to avoid prompts during build
ENV DEBIAN_FRONTEND=noninteractive

# Update repositories and install dependencies including curl and unzip
RUN apt-get update && apt-get install -y wget gnupg software-properties-common lsb-release git curl unzip zip vim

# Clone tfenv into ~/.tfenv
RUN git clone --depth=1 https://github.com/tfutils/tfenv.git ~/.tfenv

# Clone Codely tutorials 
RUN git clone https://github.com/CodelyTV/terraform-course.git /root/terraform-course

# Set PATH such that tfenv is available in the shell
ENV PATH="/root/.tfenv/bin:$PATH"

# Link tfenv to /usr/local/bin to make it available system-wide
RUN ln -s /root/.tfenv/bin/* /usr/local/bin

# Download HashiCorp GPG key and add it to the keyring
RUN wget -qO - https://apt.releases.hashicorp.com/gpg | gpg --dearmor > /usr/share/keyrings/hashicorp-archive-keyring.gpg

# Ensure that the key is correctly installed
RUN gpg --no-default-keyring --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg --list-keys

# Add the HashiCorp repository
RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" > /etc/apt/sources.list.d/hashicorp.list

# Update repositories again
RUN apt-get update

# Install Terraform using tfenv
RUN tfenv install 1.3.0
RUN tfenv use 1.3.0

# Download Terragrunt binary for Linux ARM64
RUN wget https://github.com/gruntwork-io/terragrunt/releases/download/v0.53.2/terragrunt_linux_arm64

# Make the Terragrunt binary executable
RUN chmod u+x terragrunt_linux_arm64

# Move the Terragrunt binary to a location in the system PATH
RUN mv terragrunt_linux_arm64 /usr/local/bin/terragrunt

WORKDIR /root

# Set the default command when starting the container
CMD ["bash"]

