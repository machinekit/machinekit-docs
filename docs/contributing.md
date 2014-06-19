---
layout: docs
title: Contributing
next_section: maintainers
permalink: /docs/contributing/
---

## Background

MachineKit adheres to the [C4 Collective Code Construction Contract][1],
which describes a [Fork/Pull model of development][2]:

> The Fork & Pull Model lets anyone fork an existing repository and
> push changes to their personal fork without requiring access be
> granted to the source repository. The changes must then be pulled
> into the source repository by the project maintainer. This model
> reduces the amount of friction for new contributors and is popular
> with open source projects because it allows people to work
> independently without upfront coordination.

This means that, as long as you are able to create a patch that
follows a few simple rules, your code will be accepted and merged
quickly into the Machinekit project. You do not need commit access to
contribute, and there are no 'gatekeepers' to slow or prevent your
contribution. From C4, the rules that define a 'correct' patch are:

- A patch SHOULD be a minimal and accurate answer to exactly one
  identified and agreed problem.

- A patch MUST adhere to the code style guidelines of the project if
  these are defined.

- A patch MUST adhere to the "Evolution of Public Contracts"
  guidelines

- A patch SHALL NOT include non-trivial code from other projects
  unless the Contributor is the original author of that code.

- A patch MUST compile cleanly and pass project self-tests on at least
  the principle target platform.

- A patch commit message SHOULD consist of a single short (less than
  50 character) line summarizing the change, optionally followed by a
  blank line and then a more thorough description.

## Setting up to contribute

Download and install git on your system. Scott Chacon’s online book,
[Pro Git][6], describes how to get it, how to configure it, and how to use
it. Thankfully, the Fork/Pull model requires very little git
expertise, so chapters 1 & 2 will be likely all you need. Please do
make sure to configure git with your real name or a well-known alias:

    $ git config --global user.name "Your Name"
    $ git config --global user.email your.name@example.com

Create a [Github account][3], and [create a personal fork][4] of the
[Machinekit repository][5].

## Development process

The C4 contract outlines the development process in detail, but the
short version is:

- Clearly define the problem you want to solve, and log it on the
  [Machinekit issue tracker][7].

  - The problem definition MUST NOT be a feature request—it should be a
    concise description of a problem that you intend to fix.

- Develop in your forked repository.

- Make sure that the code you develop is 'correct' as defined above.

- [Submit a pull request][8].

Your patch will be reviewed by a [Maintainer][9], and if it is 'correct'
the Maintainer will merge it. Maintainers do not provide value
judgment, and they are not responsible for testing your code to make
sure it actually fixes the problem you defined on the issue
tracker.  This is your responsibility. If the Maintainer has an issue
with your patch, he or she SHOULD ask for improvements to incorrect
patches and SHOULD reject incorrect patches if you do not respond
constructively (see [C4][1]).

[1]: /docs/C4/
[2]: https://help.github.com/articles/using-pull-requests/
[3]: https://github.com/join
[4]: https://help.github.com/articles/fork-a-repo
[5]: https://github.com/machinekit/machinekit
[6]: http://git-scm.com/book
[7]: https://github.com/machinekit/machinekit/issues
[8]: https://help.github.com/articles/creating-a-pull-request
[9]: /docs/maintainers/
