# Ansible Collection - plasticrake.duplicacy

Roles to setup and configure [Duplicacy](https://github.com/gilbertchen/duplicacy).

## Requirements

Works on Linux, FreeBSD, and macOS systems. Ansible target hosts require python and bash. Some roles require target hosts to have [duplicacy](https://github.com/gilbertchen/duplicacy), [duplicacy-util](https://github.com/jeffaco/duplicacy-util), and/or [jq](https://stedolan.github.io/jq/) (to read the duplicacy JSON configuration files); the `duplicacy_install` role will install duplicacy and duplicacy-util.

## Roles

While these roles can be used in isolation if needed, they were designed to be used together and do share some common variables that can be overridden in a particular role if needed.

**Role Common Variables**
`duplicacy_repositories[]`
Most roles loop over the `duplicacy_repositories` list variable to setup repositories.

`duplicacy_user`/`duplicacy_group`
Most roles can take a specific user/group variable for the role, but default to these common variables if not. Usually the user/group will be the owner of the files created by the role, or the role will execute commands using the specified user.

**The roles listed below are ordered as they would most likely be used in a playbook.**

- [duplicacy_setup_user](#duplicacy_setup_user)
- [duplicacy_storage_sftp](#duplicacy_storage_sftp) (available soon)
- [duplicacy_install](#duplicacy_install)
- [duplicacy_tokens](#duplicacy_tokens) (available soon)
- [duplicacy_repository](#duplicacy_repository) (available soon)
- [duplicacy_filter](#duplicacy_filter) (available soon)
- [duplicacy_symlink](#duplicacy_symlink) (available soon)
- [duplicacy_util](#duplicacy_util) (available soon)
- [duplicacy_cron](#duplicacy_cron) (available soon)
- [duplicacy_launchd (macOS)](#duplicacy_launchd-macos) (available soon)

### duplicacy_setup_user

[Role Documentation](https://github.com/plasticrake/ansible-collection-duplicacy/blob/master/roles/duplicacy_setup_user/README.md)

An Ansible Role that sets up users for Duplicacy and sets facts used by other roles in this collection.

### duplicacy_install

[Role Documentation](https://github.com/plasticrake/ansible-collection-duplicacy/blob/master/roles/duplicacy_install/README.md)

Installs [Duplicacy CLI](https://github.com/gilbertchen/duplicacy) and/or [duplicacy-util](https://github.com/jeffaco/duplicacy-util)
