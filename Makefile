.PHONY: help setup create-structure

# Default target
help:
	@echo "Available targets:"
	@echo "  setup              - Run Ansible playbook on local machine"
	@echo "  create-structure   - Create lab directory structure"
	@echo "  help               - Show this help message"

# Run Ansible playbook
setup:
	@echo "Running Ansible playbook on local machine..."
	ansible-playbook playbook.yml --ask-become-pass

# Create lab directory structure
create-structure:
	@./scripts/create-structure.sh