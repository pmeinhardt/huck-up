# Huckleberry - Welcome home

My personal Raspberry Pi home server management.

Built using [Ansible](https://github.com/ansible/ansible).

## Getting started

There are a few things which you'll need to prepare. Here we go:

1. **Get your Pi up.** Huck-up automates server management using Ansible.
   Its playbooks are written with Raspbian/Debian systems in mind. If you don't
   have a Raspberry Pi operating system on an SD card yet, download
   [Raspbian](https://www.raspberrypi.org/downloads/raspbian/) and
   [install](https://www.raspberrypi.org/documentation/installation/installing-images/)
   it. Push the card into your Pi and power it up.

2. **Connect your Pi.** Your Raspberry Pi needs to be connected to your local
   network. Just hook it up to your router with an ethernet cable if you have
   one, or else configure
   [WiFi](https://www.raspberrypi.org/documentation/configuration/wireless/).

3. **Install Ansible.** On your local machine, install
   [Ansible](http://docs.ansible.com/ansible/intro_installation.html).
   Alternatively you can also run the huck-up playbook directly on your Pi.

4. **Clone this repo…**
   `git clone https://github.com/pmeinhardt/huck-up.git && cd huck-up`

**Now it is time you adapt the service and deployment configuration to your
needs.**

We recommend you keep these versioned in your own fork of this repository.

Right away, you'll want to edit `site.yml` to your liking and select the roles
you need. If you'd like to change the default configuration, copy
`vars/default.yml` to `vars/config.yml` and hack away.  You may want to encrypt
this file using Ansible Vault if you plan on keeping it in your repository – a
brief description is presented in a separate section below.

If you have made changes to your Pi already (in particular its hostname,
username or password) update the `raspberrypi` inventory file, create a
private copy or specify `-u USERNAME` and `-k` (asks for password)
on the commandline.

**Be sure not to commit passwords into public repos!**

You can verify your Pi is reachable by running `ssh pi@raspberrypi`.

**To bootstrap your Pi, run:**

```shell
ansible-playbook -i raspberrypi site.yml -e "@vars/config.yml"
```

or, if running [locally](http://docs.ansible.com/ansible/playbooks_delegation.html#local-playbooks) on your Pi:

```shell
# change the "hosts:" entry in site.yml to "hosts: 127.0.0.1", then run:
ansible-playbook site.yml -e "@vars/config.yml" --connection=local
```

This will get everything set up and you're good to go.

## Encrypting configuration files

If you keep application secrets in your configuration files, you can use
[Ansible Vault](http://docs.ansible.com/ansible/playbooks_vault.html) to
encrypt them.

When you override the default variables for a deployment for instance,
encrypt the variables file as follows:

```
ansible-vault encrypt vars/config.yml
```

This will prompt for a password and save the file as encrypted data.
When running a playbook containing Vault-encrypted files append
`--ask-vault-pass`, i.e. run:

```
ansible-playbook -i raspberrypi site.yml -e "@vars/config.yml" --ask-vault-pass
```

## Creating backups

To come.
