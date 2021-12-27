# BartR - zsh Completion Sample

![License](https://img.shields.io/badge/license-MIT-green.svg)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](code_of_conduct.md)

- This is a sample of how to create a zsh completion script for an application / CLI
- The application doesn't exist but the completion can still be tested

Install zsh completions

```bash

# these may already be set
unsetopt complete_aliases
autoload -U compinit

# displays a "header"
zstyle ':completion:*:descriptions' format '%d'

# set permissions to avoid compaudit errors    
chmod -R go-w .

# reloads the file you're editing
alias rz='unfunction _bartr; autoload -Uz _bartr'

```

Load the sample completion

```bash

cd completions

# add current folder to fpath
export fpath=($(pwd) $fpath)
compinit

# this will show any file perm issues
# since we reset the permissions, there shouldnt be any
compaudit

# this will reset any file perm issues
compaudit | xargs chmod -R go-w

```

Test the completion

```text

#<tab> means press the tab key to activate the completion

bartr <tab>

# output
commands
app  -- App commands
ls   -- List the apps
new  -- Create a new app

# press <tab> a few more times to cycle through the menu

# when app is highighted, press <space>
# press <tab>

# output
application commands
create  -- Create a new app
info    -- Get application info
set     -- Set application values

# press i <tab> <tab>
# command line
bartr app info --help

# press <enter> (ignore the command not found message)

# Type bartr <space> a <tab> s <tab><tab><tab>

# output
$ bartr app set --
option
--app-name         -- Application name
--cpu-limit        -- CPU Limit
--cpu-request      -- CPU Request
--force            -- Force overwriting config
--help             -- Display help and usage
--image            -- Image name
--liveness-probe   -- Liveness Probe path
--memory-limit     -- Memory Limit
--memory-request   -- Memory Request
--namespace        -- Kubernetes namespace
--node-port        -- NodePort for app
--port             -- Port app exposes
--readiness-probe  -- Readiness Probe path

# enter no<tab><tab><tab>
# this will select --node-port
# you can select one of the values or enter your own

# you can select other options - some have options, some don't

```

## Links

These links helped me get started - thank you!

- <https://github.com/zsh-users/zsh-completions>
  - the `src` directory has a lot of examples
- <https://www.dolthub.com/blog/2021-11-15-zsh-completions-with-subcommands/>
- <https://thevaluable.dev/zsh-completion-guide-examples/>

## Support

This project uses GitHub Issues to track bugs and feature requests. Please search the existing issues before filing new issues to avoid duplicates.  For new issues, file your bug or feature request as a new issue.

## Contributing

This project welcomes contributions and suggestions and has adopted the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html).

For more information see [Contributing.md](./.github/CONTRIBUTING.md)

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Any use of third-party trademarks or logos are subject to those third-party's policies.
