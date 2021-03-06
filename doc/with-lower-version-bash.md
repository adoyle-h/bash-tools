# With Lower Version Bash

If you want use Lobash with Bash 4.3 and lower versions, there are some knowledges you should know.

## TOC

<!-- MarkdownTOC GFM -->

- [Compatible with different versions](#compatible-with-different-versions)
    - [4.4](#44)
    - [4.3](#43)
    - [4.2](#42)
    - [4.1](#41)
    - [4.0](#40)
        - [Not test with Bash 4.0 in MacOS](#not-test-with-bash-40-in-macos)
- [What you should do with Lobash in different Bash versions](#what-you-should-do-with-lobash-in-different-bash-versions)
    - [4.4](#44-1)
    - [4.3](#43-1)
    - [4.2](#42-1)
    - [4.1](#41-1)
    - [4.0](#40-1)

<!-- /MarkdownTOC -->


## Compatible with different versions

This section only show the compatibilities with different Bash versions.

There is [a list](http://mywiki.wooledge.org/BashFAQ/061) of which features were added to specific releases (versions) of Bash.

### 4.4

Completely supported.

### 4.3

- `shopt -s inherit_errexit` is new feature in Bash v4.4. There is no workaround in v4.3.

### 4.2

- The Nameref is new feature in Bash v4.3. Use `eval` as workaround.

### 4.1

- `declare -g var=str` not supported util v4.2, use `read -r var <<< "str"` instead.

- `$(( "$i" + 1 ))` not work in Bash 4.1, use `$(( i + 1))` instead.

- `[[ $'\e' == $'\u001b' ]]` is `false` in Bash less than v4.2. **No workaround**.

- `printf "%($1)T\\n" "-1"` not work in v4.1. **No workaround**.

### 4.0

- `exec {_sleep_fd}<> <(true)` is not supported util v4.1. **No workaround**.

- Empty `$@` and `$*` will throw error "unbound variable" with `set -u` in v4.0. It is a bug of Bash. See https://unix.stackexchange.com/a/16565

#### Not test with Bash 4.0 in MacOS

**Lobash not test with Bash 4.0 in MacOS. It seems a bug of Bash 4.0 in MacOS. Please contact me if you solved this problem.**

To reproduce the problem,

```sh
> BASHVER=4.0 ./tools/test-in-bash
bash(38696,0x7fff989c2380) malloc: *** error for object 0x1061ad800: pointer being freed was not allocated
```

## What you should do with Lobash in different Bash versions

Lobash will not include modules whose metadata `Bash` higher than target Bash version when build.

You can implement similar functions by reading Lobash source codes as references.

### 4.4

Nothing else.

### 4.3

Because there is no workaround and similar mechanism for fast-failing (inherit_errexit),
it is your responsibility to keep the program always on right processing.
Test your script with complete boundary testings. Make sure your script never get unexpected trapped.

Still add this line `(shopt -p inherit_errexit &>/dev/null) && shopt -s inherit_errexit` to
your script to keep compatible with higher versions.

### 4.2

Same to 4.3.

### 4.1

Same to 4.3.

### 4.0

Same to 4.3.
