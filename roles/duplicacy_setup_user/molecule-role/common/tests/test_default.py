import os
import testinfra.utils.ansible_runner

testinfra_hosts = testinfra.utils.ansible_runner.AnsibleRunner(
    os.environ['MOLECULE_INVENTORY_FILE']).get_hosts('all')


def test_user(host):
    user = host.user('duplicacy')
    assert user.group == 'duplicacy'
    assert user.groups[0] == 'duplicacy'
