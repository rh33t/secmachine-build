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

Use lory backports to install GDB

```bash
sudo apt update && sudo apt install -t lory-backports gdb
```
