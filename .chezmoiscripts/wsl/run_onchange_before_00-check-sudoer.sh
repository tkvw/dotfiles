#!/bin/bash

# Check if user is in sudo group
if ! groups | grep -q sudo; then
  echo "ERROR: $USER is not a member of the sudo group."
  echo ""
  echo "Run the following as root:"
  echo "  usermod -aG sudo $USER"
  echo ""
  echo "In WSL you can do this from PowerShell:"
  echo "  wsl -u root -d <distro> usermod -aG sudo $USER"
  exit 1
fi

# Check if NOPASSWD is configured
if ! sudo -n true 2>/dev/null; then
  echo "ERROR: $USER does not have NOPASSWD sudo."
  echo ""
  echo "Run the following as root:"
  echo "  echo '$USER ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/$USER"
  echo "  chmod 0440 /etc/sudoers.d/$USER"
  echo ""
  echo "In WSL you can do this from PowerShell:"
  echo "  wsl -u root -d <distro> bash -c \"echo '$USER ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/$USER && chmod 0440 /etc/sudoers.d/$USER\""
  exit 1
fi

echo "OK: $USER has NOPASSWD sudo configured."
