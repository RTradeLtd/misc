# ansible-plays

## Notes

To use password authentication `--ask--pass` for normal authentication, for become (aka, sudo) `--ask-become-pass`

To run playbook `ansible-playbook <playbookname> -f <parallelismlevel>`

To generate ip addresses within a subnet range:

```Shell
echo "[$GROUPNAME]" | sudo tee --append /etc/ansible/hosts
seq -f "192.168.1.%g" 1 255 2>&1 | sudo tee --append /etc/ansible/hosts
```