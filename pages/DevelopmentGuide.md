---
title: Development Guide
layout: content
toc: true
---

![Development Guide]({{ site.baseurl }}/img/PH-ROOT-icons-DG.png)

* Table of Contents 
{:toc}
<br>


# Description
In the context of projects IML, MILA and GSoC we wrote this guidelines 
to present the software which is under development. 
All the projects must be submitted to review through a pull request.



# Coding Conventions
To write a high quality software ROOT have a coding conventions 
that is based in Taligent Guide please read it carefully.


# VCS - Git/Github
All our code is manipulate with a ditributed VCS(Version Control System) called git and hosted in 
in a cloud platform called [http://github.com](http://github.com) that lets do visualization of the code easily. 
Lets open a free account and see the documentation at [https://guides.github.com/](https://guides.github.com/) and [https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control](https://git-scm.com/book/en/v2/Getting-Started-About-Version-Control) 
useful commands:

```sh
$ git checkout mybranch
$ git rebase --autosquash -x 'git clang-format master && git commit -a --amend --no-edit' master
```


# CMake/Autotools
We are using two software construction tools CMake and Autotools, all the software must support both.


# Portability (Multiple OS support)
Currently ROOT 6 have support for Gnu/Linux and MacOS and the software must support both platforms too.


# Documentation
The documentation is using doxygen [https://root.cern.ch/how/formatting-comments-doxygen](https://root.cern.ch/how/formatting-comments-doxygen) in the source files and Markdown for users guide, lets see userguides examples at [https://github.com/root-mirror/root/tree/master/documentation/users-guide](https://github.com/root-mirror/root/tree/master/documentation/users-guide)


# Build Monitoring Tools

[http://cdash.cern.ch/index.php?project=ROOT](http://cdash.cern.ch/index.php?project=ROOT)
[https://phsft-jenkins.cern.ch/job/root-incremental-master/](https://phsft-jenkins.cern.ch/job/root-incremental-master/)

