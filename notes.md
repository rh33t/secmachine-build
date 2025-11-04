# General Notes

## VMware Shared Folders

1. **Install VMware Tools:**

```bash
   sudo apt-get install open-vm-tools open-vm-tools-desktop
```

2. **Enable in VMware Workstation:**
   VM → Settings → Options → Shared Folders → Add folder (name: `storage`)

3. **Create mount point & add to fstab:**

```bash
   mkdir -p ~/work
   echo '.host:/storage /home/triplea/work fuse.vmhgfs-fuse allow_other,uid=1000,gid=1003 0 0' | sudo tee -a /etc/fstab
   sudo systemctl daemon-reload
   sudo mount -a
```

4. **Verify:**

```bash
   ls ~/work
```

## GDB Installation error Fix (Parrot OS 6.4)

Use backports to install GDB from debian bookworm-backports

```bash
echo "deb http://deb.debian.org/debian bookworm-backports main" | sudo tee /etc/apt/sources.list.d/backports.list
sudo apt update && sudo apt install -t bookworm-backports gdb
```