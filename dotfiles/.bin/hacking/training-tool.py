#!/usr/bin/python3
import os
import sys
import re
import unicodedata
from typing import List

class Colors:
    RED = '\033[91m'
    GREEN = '\033[92m'
    BLUE = '\033[94m'
    YELLOW = '\033[93m'
    RESET = '\033[0m'

    @staticmethod
    def red(text: str) -> str:
        return f"{Colors.RED}{text}{Colors.RESET}"

    @staticmethod
    def green(text: str) -> str:
        return f"{Colors.GREEN}{text}{Colors.RESET}"

    @staticmethod
    def blue(text: str) -> str:
        return f"{Colors.BLUE}{text}{Colors.RESET}"

    @staticmethod
    def yellow(text: str) -> str:
        return f"{Colors.YELLOW}{text}{Colors.RESET}"

class TrainingManager:
    """Unified manager for both CTF challenges and training boxes"""
    
    # CTF categories
    CTF_CATEGORIES = [
        "web-exploitation",
        "reverse-engineering", 
        "general-skills",
        "forensics",
        "binary-exploitation",
        "osint",
        "misc"
    ]
    
    # Box platforms
    BOX_PLATFORMS = [
        "tryhackme",
        "hackthebox",
    ]

    def __init__(self, mode: str, base_directory: str = os.getcwd()):
        self.mode = mode.lower()
        self.base_directory = os.path.abspath(os.path.expanduser(base_directory))
        
        # Set temp file based on mode
        if self.mode == "ctf":
            self.temp_file = '/tmp/challenger_path'
        elif self.mode == "box":
            self.temp_file = '/tmp/box_path'
        else:
            raise ValueError(f"Invalid mode: {mode}. Use 'ctf' or 'box'")
        
        try:
            os.makedirs(self.base_directory, exist_ok=True)
        except Exception as e:
            print(Colors.red(f"Error creating base directory: {e}"))
            sys.exit(1)

    @staticmethod
    def slugify(text: str) -> str:
        text = text.lower()
        text = unicodedata.normalize('NFKD', text).encode('ascii', 'ignore').decode('utf-8')
        # Replace underscores with hyphens
        text = text.replace('_', '-')
        # Keep only alphanumeric characters, spaces, and hyphens
        text = re.sub(r'[^a-z0-9\s-]', '', text)
        # Replace multiple spaces/hyphens with single hyphen
        text = re.sub(r'[-\s]+', '-', text).strip('-')
        return text

    def get_existing_items(self, directory: str) -> List[str]:
        if not os.path.exists(directory):
            return []
        return [d for d in os.listdir(directory) if os.path.isdir(os.path.join(directory, d))]

    def create_or_select_item(self, item_type: str, parent_directory: str, predefined_list: List[str] = None) -> str:
        print(f"\n{item_type.upper()} SELECTION")
        print("-" * 30)

        if predefined_list:
            print(f"Available {item_type}s:")
            for i, item in enumerate(predefined_list, 1):
                print(f"{i}. {item}")
            print(f"{len(predefined_list) + 1}. Other (custom)")

            while True:
                try:
                    choice = int(input(f"Select {item_type} (1-{len(predefined_list) + 1}): "))
                    if 1 <= choice <= len(predefined_list):
                        return predefined_list[choice - 1]
                    elif choice == len(predefined_list) + 1:
                        break
                    else:
                        print(Colors.red("Invalid choice. Please try again."))
                except (ValueError, KeyboardInterrupt):
                    print(Colors.red("\nOperation cancelled."))
                    sys.exit(0)

        existing_items = self.get_existing_items(parent_directory)
        if existing_items:
            print(f"0. Create new {item_type}")
            print(f"Existing {item_type}s:")
            for i, item in enumerate(existing_items, 1):
                print(f"{i}. {item}")

            while True:
                try:
                    choice = int(input(f"Select {item_type} (0-{len(existing_items)}): "))
                    if choice == 0:
                        break
                    elif 1 <= choice <= len(existing_items):
                        return existing_items[choice - 1]
                    else:
                        print(Colors.red("Invalid choice. Please try again."))
                except (ValueError, KeyboardInterrupt):
                    print(Colors.red("\nOperation cancelled."))
                    sys.exit(0)

        while True:
            try:
                new_item = input(f"Enter new {item_type} name: ").strip()
                if new_item:
                    slugified_name = self.slugify(new_item)
                    if slugified_name != new_item:
                        print(f"Name will be slugified to: {slugified_name}")
                        confirm = input("Continue? (y/n): ").lower().strip()
                        if confirm != 'y':
                            continue
                    return slugified_name
                print(Colors.red("Please enter a valid name."))
            except KeyboardInterrupt:
                print(Colors.red("\nOperation cancelled."))
                sys.exit(0)

    def generate_default_categories(self, platform_directory: str):
        print("Generating default CTF categories...")
        for category in self.CTF_CATEGORIES:
            os.makedirs(os.path.join(platform_directory, category), exist_ok=True)
        print(Colors.green("Default categories created."))

    def create_box_template(self, box_directory: str, platform: str, box: str):
        print("Creating box template...")

        notes_content = f"""# Notes for {box}

## Box Information
- Platform: {platform}
- Box Name: {box}
- Difficulty:
- IP Address: 
- Target OS: 

## Initial Reconnaissance
```bash
# Nmap scan
nmap -sC -sV -oA initial {box}

# Full port scan
nmap -p- --min-rate=1000 -T4 {box}
```

## Enumeration

### Commands & tools used
```bash
# something great
```

## Exploitation

### Initial Access
```bash
# Exploit commands
```

## Privilege Escalation

### Local Enumeration
```bash
# Enumeration commands
```

### Escalation
```bash
# Privilege escalation commands
```

### Loot
- User Flag: 
- Root Flag: 

## Errors Made
- 

## Lessons Learned
- 

## References
- 
"""

        with open(os.path.join(box_directory, "notes.md"), 'w') as f:
            f.write(notes_content)

        print(Colors.green("Box template created."))

    def run_ctf_mode(self):
        print(Colors.blue("CTF Challenge Manager"))
        print("=" * 30)

        # Select or create platform
        platform = self.create_or_select_item("platform", self.base_directory)
        platform_directory = os.path.join(self.base_directory, platform)
        os.makedirs(platform_directory, exist_ok=True)

        # Generate default categories if it's a new platform
        if not self.get_existing_items(platform_directory):
            generate_defaults = input("Generate default categories? (y/n): ").lower().strip()
            if generate_defaults == 'y':
                self.generate_default_categories(platform_directory)

        # Select or create category
        category = self.create_or_select_item("category", platform_directory)
        category_directory = os.path.join(platform_directory, category)
        os.makedirs(category_directory, exist_ok=True)

        # Select or create challenge
        challenge = self.create_or_select_item("challenge", category_directory)
        challenge_directory = os.path.join(category_directory, challenge)
        os.makedirs(challenge_directory, exist_ok=True)

        # Change to challenge directory
        os.chdir(challenge_directory)
        print(Colors.green(f"\nWorking directory: {challenge_directory}"))

        # Write path to temp file for shell usage
        with open(self.temp_file, 'w') as f:
            f.write(challenge_directory)

    def run_box_mode(self):
        print(Colors.yellow("Training Box Manager"))
        print("=" * 30)

        # Select platform
        platform = self.create_or_select_item("platform", self.base_directory, self.BOX_PLATFORMS)
        platform_directory = os.path.join(self.base_directory, platform)
        os.makedirs(platform_directory, exist_ok=True)

        # Create or select box
        box = self.create_or_select_item("box", platform_directory)
        box_directory = os.path.join(platform_directory, box)

        # Create box if it doesn't exist
        if not os.path.exists(box_directory):
            os.makedirs(box_directory, exist_ok=True)
            self.create_box_template(box_directory, platform, box)

        # Change to box directory
        os.chdir(box_directory)
        print(Colors.green(f"\nWorking directory: {box_directory}"))

        # Write path to temp file for shell usage
        with open(self.temp_file, 'w') as f:
            f.write(box_directory)

    def run(self):
        if self.mode == "ctf":
            self.run_ctf_mode()
        elif self.mode == "box":
            self.run_box_mode()
        else:
            print(Colors.red(f"Unknown mode: {self.mode}"))
            sys.exit(1)

def main():
    if len(sys.argv) < 2:
        print(Colors.blue("Training Manager - Unified CTF and Box Tool"))
        print("=" * 50)
        print("Usage: training-tool.py {ctf|box}")
        print("")
        print("Modes:")
        print("  ctf  - Manage CTF challenges")
        print("  box  - Manage training boxes (THM/HTB/vulnhub/etc.)")
        print("")
        print("Examples:")
        print("  training-tool.py ctf")
        print("  training-tool.py box")
        sys.exit(1)

    mode = sys.argv[1]
    
    # Get base directory based on mode
    hacking_lab = os.environ.get('HACKING_LAB', '~/work')
    if mode == "ctf":
        workspace = os.path.join(hacking_lab, "training/challenges/")
    elif mode == "box":
        workspace = os.path.join(hacking_lab, "training/boxes/")
    else:
        print(Colors.red(f"Invalid mode: {mode}. Use 'ctf' or 'box'"))
        sys.exit(1)

    # Run the manager
    manager = TrainingManager(mode=mode, base_directory=workspace)
    manager.run()

if __name__ == "__main__":
    main()
