# duplicacy_setup_user

An Ansible Role that sets up users for Duplicacy and sets facts used by other roles in this collection.

## Requirements

None.

## Role Variables

Common variables used by this role:

- `duplicacy_user`
- `duplicacy_group`

Available variables are listed below, along with default values (see `defaults/main.yml`):

| Variable                        | Type         | Default                                                        | Description                                                              |
| ------------------------------- | ------------ | -------------------------------------------------------------- | ------------------------------------------------------------------------ |
| duplicacy_setup_user            | string       | `"{{ duplicacy_user \| default('duplicacy') }}"`               | User name, will be created if missing                                    |
| duplicacy_setup_user_is_system  | boolean      | `"{{ duplicacy_user_is_system \| default(false) }}"`           | Create user as system user                                               |
| duplicacy_setup_group           | string       | `"{{ duplicacy_group \| default('duplicacy') }}"`              | Group name, will be set as user's group, will be created if missing      |
| duplicacy_setup_group_is_system | boolean      | `"{{ duplicacy_group_is_system \| default(false) }}"`          | Created group is system                                                  |
| duplicacy_setup_groups          | list<string> | `"{{ duplicacy_groups \| default([duplicacy_setup_group]) }}"` | Groups to add to user                                                    |
| duplicacy_setup_user_type       | string       | `"repository"`                                                 | Determines which facts are set at end of role, to be used by other roles |

### duplicacy_setup_user_type

valid values: `repository`, `storage`

`storage` is intended to be used when setting up SFTP storage backends and the facts are used by the `duplicacy_storage_sftp` role.

Facts set when duplicacy_setup_user_type is:

**repository**:

- duplicacy_user - user name
- duplicacy_group - group name
- duplicacy_user_home - user home directory
- duplicacy_user_ssh_public_key - user ssh public key

**storage**:

- duplicacy_storage_user - storage user name
- duplicacy_storage_group - storage group name
- duplicacy_storage_user_home - storage user home directory
- duplicacy_storage_user_ssh_public_key - storage user ssh public key

## Dependencies

None.

## Example Playbook

### Use defaults

```yaml
- hosts: servers
  roles:
    - plasticrake.duplicacy.duplicacy_setup_user
  become: yes
```

###

```yaml
- hosts: servers
  roles:
    - role: plasticrake.duplicacy.duplicacy_setup_user
      vars:
        duplicacy_setup_user: backup
  become: yes
```

## License

MIT
