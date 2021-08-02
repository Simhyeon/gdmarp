### Gdmarp is a fine, yet not perfect

Gdmarp is not my first approach to make game design process faster and better.
However it is also true that I have few development experiences to make things
right and perfect from the start. Which turns out that I cannot continue
developing gdmarp unless I drop my initial ardor. Well my conclusion was obvious
, this is the time to start a new implementation.

### Problems of current implementation

#### Gdmarp is inherently Shell script

Don't get me wrong, I'm a linux enthusiast and I love shell scripting even
posix compliant scripting has some pungent taste. However gdmarp aims to become
a cross platform software which supports unix-like and also Windows. (At least
I'm not planning to support embedded chips) Thus, shell script is not the best
choice of tool.

Plus, size of gdmarp has grown too big, so maintenance became quite a burden. I
could utilize dedicated linting, debugging software If I were to use other
programming languages.

#### Docker distribution is trivial

There are so many dependencies required. Some are often installed in linux
distributions but for windows, hardly it is. Currently best choice of
distribution for windows is soley a docker container. Using docker desktop is
fine if you are used to, maybe podman if you more inclined to do, however not
every game developers are familiar with docker technolgies.

#### M4 macros are not an easiest language to extend

Because gdmarp uses m4 macro inherently, it is devastatingly hard to maintain.
There are hardly any syntax highliting for m4 and creating language server
protocol(LSP) or development tools are harder because gddt(which is a file
format gdmarp utilizes) can also utilize m4 macros inside.

### What's next?

I'm planning to reimplement the whole logic in rust. I tried to make a rust
implementation of gdmarp before, yet I gave up on the way because I was using
alpine linux for the docker container which was using musl-libc instead of
glibc. Rust used glibc by default and needed some non trivial setups to use
musl (and there was huge regression in performance with pure musl linking)
