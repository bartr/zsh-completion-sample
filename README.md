# zsh Completion Sample

![License](https://img.shields.io/badge/license-MIT-green.svg)
[![Contributor Covenant](https://img.shields.io/badge/Contributor%20Covenant-2.1-4baaaa.svg)](code_of_conduct.md)

- This is a sample of how to create a zsh completion script for an application / CLI
  - See the links section below for more information
  - The zsh completion system is very powerful and not particularly well documented
  - There is a lot more you can do - this is just a functional example
- The application doesn't exist but the completion can still be tested
  - This lets you use completions to design and test your CLI before you write a line of code
- The bash completion system is totally different - we will eventually support both

## Design

While creating the completion for one of the CLIs I'm helping a friend with, I found some design simplifications that would make the CLI more usable. Going forward, it's pretty easy to use `System.CommandLine` (or your favorite framework) and completions for design reviews of the CLI. The choice of sub-commands, arguments, and options can impact how you write your code and how easy your CLI is to use. Some completions are trivial to write (and automate!). Some aren't. Figuring that out late is a mistake to avoid.

Now that I understand completions better (not an expert by any means), my CLIs will be easier to use. `Developer Experience` is important and a good completion for a CLI is a must have IMO.

## Quick Start

> This only works with zsh - will not work with bash

- Install zsh completions

```bash

# these may already be set
# all my tests use .oh-my-zsh - please open an issue if something is missing
unsetopt complete_aliases
autoload -U compinit

# displays a "header" on completions
# see the links below for a lot more zstyle options
zstyle ':completion:*:descriptions' format '%d'

# set permissions to avoid compaudit errors
# ignore any errors from the .git directory
chmod -R go-w .

# reloads the file you're editing by running rz from the terminal
# this is a HUGE time saver during debug
# I found this in some of the links below - THANK YOU!
alias rz='unfunction _bartr; autoload -Uz _bartr'

```

Load the sample completion

```bash

cd completions

# add current folder to fpath
export fpath=($(pwd) $fpath)
compinit

# this will show any file perm issues
# since we reset the permissions
#    there shouldnt be any
#    use the chmod command above to fix any issues
compaudit

# if you're curious ...
# my fpath is pretty long
# I normally install completions in $HOME/.oh-my-zsh/completions
echo $fpath

```

Test the completion

- <tab> <space> <enter> <ctl-c> means to press the key(s) to see the completion work

```text

# activate the completion system on the "bartr" command
# this command doesn't actually exist and pressing <enter> will
#    create a command not found error (which can be ignored)
# <ctl-c> will clear the command line

bartr<space><tab>

# output
#   all of this is in completions/_bartr
#      more on that below
commands
app  -- App commands
ls   -- List the apps
new  -- Create a new app

# press <tab> a few more times to cycle through the menu
#    this is "free" behavior!

# when app is highighted, press <space> to add to command
# press <tab>

# output
application commands
create  -- Create a new app
info    -- Get application info
set     -- Set application values

# press i<tab> to use typeahead to add info to the command
# press <tab> to finish the completion with --help

# command line
bartr app info --help

# press <enter> (ignore the command not found message)
#    you could use <ctl-c> instead

# Type bartr<space><tab>s<tab><tab><tab>

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

# press no<tab><tab><tab>
# this will select --node-port
# you can select one of the values or enter your own
# cycle through the values by pressing <tab>
# press <space> to add selected to command line

# you can select other options - some take parameters, some don't

# notice that the selected options are automatically removed from the completion list

# play around and add issues if you hit a bug

```

## Completion file

- Check the comments in `completions/_bartr` for more explanations
- Comments on the different types of "options"

```bash

case $line[1] in
  # add options to create and set sub-commands
  create|set)
    _arguments \
    '--help[Display help and usage]' \
    
    # the + tells completion to expect a parameter
    # the :App name" is the completion text displayed
    '--app-name+[Application name]:App name:' \
    '--namespace+[Kubernetes namespace]:Namespace:' \
    '--image+[Image name]:Image and tag:' \
    
    # the (250m 500m 1000m 2000m) are suggestions you can tab through
    #    you can also enter a value
    # this is a good prompt to the user for the format of the value
    #    they will be sorted automatically
    '--cpu-limit+[CPU Limit]:CPU Limit:(250m 500m 1000m 2000m)' \
    '--memory-limit+[Memory Limit]:Memory Limit:(256Mi 512Mi 1024Mi 2048Mi)' \
    '--cpu-request+[CPU Request]:CPU Request:(250m 500m 1000m 2000m)' \
    '--memory-request+[Memory Request]:Memory Request:(256Mi 512Mi 1024Mi 2048Mi)' \
    '--readiness-probe+[Readiness Probe path]:Readiness Probe:(/readyz /healthz)' \
    
    # chose to add auto-fill as the "default"
    '--liveness-probe+[Liveness Probe path]:Liveness Probe:(/healthz)' \
    
    # these are big ranges - some reasonable values as suggestions
    '--port+[Port app exposes]:Port:(80 8080 8088)' \
    '--node-port+[NodePort for app]:Node Port:(30000 30080 30088 31000 31080 32000 32080)' \
    
    # booleans (flags) don't have a +
    #    "--force" == "--force true"
    #    either will work in most frameworks
    '--force[Force overwriting config]'
  ;;

```

## Automatically generate from CLI

Now that I have a general approach, I can automate the generation of the completion file relatively easily. For complete control, you can edit the file and copy to a directory on the fpath. You could also experiment with `annotations` to help your generator. I haven't gotten that far yet.

Check [here](https://github.com/bartr/system-commandline-sample) for an in-progress example with dotnet System.CommandLine.

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
