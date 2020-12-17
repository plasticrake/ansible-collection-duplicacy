# duplicacy-install

An Ansible Role that installs [Duplicacy CLI](https://github.com/gilbertchen/duplicacy) and/or [duplicacy-util](https://github.com/jeffaco/duplicacy-util).

## Requirements

- `bash`
- `wget` or `curl` - if neither are found, `wget` will be installed.
- `jq` - if not found will be installed.

## Role Variables

Available variables are listed below, along with default values (see `defaults/main.yml`):

    install_duplicacy: true

Install `duplicacy` from GitHub releases.

    install_duplicacy_force: false

Install `duplicacy` even if it already exists. Can be used to update to newer version.

    install_duplicacy_version: latest

GitHub releases tag to download from.

    install_duplicacy_util: true

Install `duplicacy-util` from GitHub releases.

    install_duplicacy_util_force: false

Install `duplicacy-util` even if it already exists. Can be used to update to newer version.

    install_duplicacy_util_version: latest

GitHub releases tag to download from.

    install_path: /usr/local/bin

Install path for executables.

    duplicacy_path: "{{ install_path }}/duplicacy"

Duplicacy install path.

    duplicacy_util_path: "{{ install_path }}/duplicacy-util"

duplicacy-util install path.

    install_jq: true

Install `jq` from package manager. `jq` is required to run the duplicacy download script.

    install_jq_package_state: present

The state of the jq package install. If you want to always update to the latest version, change this to `latest`.

    install_jq_macos_url: https://github.com/stedolan/jq/releases/download/jq-1.6/jq-osx-amd64

On macOS systems, if [brew](https://brew.sh/) is not installed, download from this url.

    jq_path: "{{ install_path }}/jq"

Install path for `jq` if downloaded from `install_jq_macos_url`.

## Dependencies

None.

## Example Playbook

### Use defaults

```yaml
- hosts: servers
  roles:
    - plasticrake.duplicacy_install
  become: yes
```

### Force install (for upgrade)

```yaml
- hosts: servers
  roles:
    - role: plasticrake.duplicacy_install
      vars:
        install_duplicacy_force: true
        install_duplicacy_util_force: true
  become: yes
```

## License

MIT
