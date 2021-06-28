### Gdmarp 0.2 plan

**What is planned for 0.2 ?**

#### Highly modular components with config file

Formerly, m4 extensions were distributed with init commands. This was to make
binary distribution very easy. However extensions are getting bigger by time and
it became not so desirable to include the scripts inside working project
directories.

Therefore m4 extensions will be located in app setting directories both for
m4_ext and css. Also a style macro will be removed and module inclusion will be
defined by separate config file.

#### Diverse render forms and associated macro extensions

Currently only single render format is availble, which is a slide style. From
0.2 there will be multiple render forms. Thus script's name gdmarp will not only
mean game design marp automation, but game design macro processing.

Planned redner forms are as followed,

- Representation (Marp)
- Wiki page (Mediawiki)
- Web UI (Bootstrap CSS + html + some hand made javascripts)

Each render form is enabled as an extension module. Currently default m4 script
is both basic and representation macros. This will be changed in 0.2 and default
macro rules would only include non-representation directives. You have to enable
representation module if you want to render a slide form.

#### Ergonomic executable distribution

This is not about finalizing distribution process but about making it much more
ergonomic. This doesn't make independent windows build or something like that,
but about making end-user friendly install and command line wrapper script for
both window sand unix operating systems.

I found docker command execution is bit tedious and feels helpless when I don't
remember the exact commands. So gdmarp 0.2 will have separate script(sh or
powershell) to install and execute commands without recurring docker commands.

### Candidates for wiki backends

- mediawiki : Currently actively developed
Mature api, large userbase

- django-wiki
- wikijs
