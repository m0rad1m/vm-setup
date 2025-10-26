# VM-Setup

This repo serves a guideline to setup VMs using [Vagrant](https://developer.hashicorp.com/vagrant)
and [Multipass](https://canonical.com/multipass)

## Specific setup when running Vagrant from WSL

1. Vagrant must be able to access the Windows Root System.
   On WSL run:

   ```shell
   export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
   ```

2. Vagrant has some issues with VBGuest additions. Therefore I installed
   a forked version: <https://github.com/dheerapat/vagrant-vbguest>

   ```shell
   # Uninstall any previous installations of the plugin
   vagrant plugin uninstall vagrant-vbguest
   # Install ruby, as 'vagrant-vbguest' is based on ruby
   sudo apt install ruby
   # Clone, build, and install the extension
   git clone https://github.com/dheerapat/vagrant-vbguest.git
   cd vagrant-vbguest
   gem build vagrant-vbguest.gemspec
   vagrant plugin install vagrant-vbguest-0.32.1.gem
   ```

3. In order to bind folders from WSL to the the created VMs,
   an additional Vagrant plugin is required:

   ```shell
   vagrant plugin install vagrant-bindfs
   ```
