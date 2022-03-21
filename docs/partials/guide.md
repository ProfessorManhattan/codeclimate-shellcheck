## Configuring Shellcheck

This CodeClimate engine / linter currently does not allow any configuration. It runs Shellcheck while ignoring a hard-coded set of files/directories which you can see by checking out the `local/codeclimate-shellcheck` file. It also is hard-coded to ignore certain Shellcheck errors which you can also check out in the `local/codeclimate-shellcheck` file. If you come up with a good way of accepting parsing configuration data then please open a pull request.

### Sample CodeClimate Configuration

```yaml
---
engines:
  shellcheck:
    enabled: true
```
