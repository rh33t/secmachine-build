.PHONY: help setup create-structure check install-ansible

# Default target
help:
	@echo "Available targets:"
	@echo "  install-ansible    - Install Ansible and required collections"
	@echo "  setup              - Run Ansible playbook on local machine"
	@echo "  create-structure   - Create lab directory structure"
	@echo "  check              - Check playbook syntax"
	@echo "  help               - Show this help message"

# Run Ansible playbook
setup:
	@echo "Running Ansible playbook on local machine..."
	ansible-playbook playbook.yml --ask-become-pass

# Create lab directory structure
create-structure:
	@./scripts/create-structure.sh

# Check playbook syntax
check:
	@echo "Checking playbook syntax..."
	ansible-playbook playbook.yml --syntax-check