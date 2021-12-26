# BartR - zsh Completion Sample

![License](https://img.shields.io/badge/license-MIT-green.svg)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](code_of_conduct.md)

- This is a sample of how to create a zsh completion script for an application / CLI

## Links

These links helped me get started - thank you!

- <https://github.com/zsh-users/zsh-completions>
  - the `src` directory has a lot of examples
- <https://www.dolthub.com/blog/2021-11-15-zsh-completions-with-subcommands/>
- <https://thevaluable.dev/zsh-completion-guide-examples/>

Notes

```bash

# these may already be set
unsetopt complete_aliases
autoload -U compinit

# set permissions to avoid compaudit errors    
chmod -R go-w ..

# add current folder to fpath
export fpath=($(pwd) $fpath)
compinit

# this will show any file perm issues
compaudit

# this will reset any file perm issues
compaudit | xargs chmod -R go-w

# reloads the file you're editing
alias rz='unfunction _bartr; autoload -Uz _bartr'

# displays a "header"
zstyle ':completion:*:descriptions' format '%d'

```

## Support

This project uses GitHub Issues to track bugs and feature requests. Please search the existing issues before filing new issues to avoid duplicates.  For new issues, file your bug or feature request as a new issue.

## Contributing

This project welcomes contributions and suggestions and has adopted the [Contributor Covenant Code of Conduct](https://www.contributor-covenant.org/version/2/1/code_of_conduct.html).

For more information see [Contributing.md](./.github/CONTRIBUTING.md)

## Trademarks

This project may contain trademarks or logos for projects, products, or services. Any use of third-party trademarks or logos are subject to those third-party's policies.
