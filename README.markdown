First of all, there are obviously many static site generators out there.
We're making this in the hopes of learning and collaborating
to make an intuitive software that can be used by the mason community
for a quick and simple organisation/personal profile to host static websites 
    and update them easily.

##For the Developers
----
This is an overview of how sandr will be implemented.

What sandr should do:
* Seperate contents, layout and design
* Plugin support specially for schedule, announcements and meetings
    * should be easy and quick to use(announcements) and deployed asap
*

I suggest looking into projects like jekyll, octopress, wok all on github.
These projects are helpful to learn about current static site generators.


Folder structure:
---
.
|-- `content`
    |-- index.{html | md | markdown | mkd | txt | rst}
    |-- about.markdown
    '-- blog/
        |-- 2014-01-30-hello-world.markdown
|-- `media`
    |-- css/
    |-- js/
    '-- images/
|-- `templates/`
    |-- includes/
|-- `plugins`
    |-- announcements.rb
    |-- calendar.rb

|-- `output`
|-- `sandr`

----

A few differences than jekyll's default folder structure.
The structure is more compact.

+ content   :- where the actual text resides. **No layout or design here**
    * This will support file types html, markdown, reStructuredText and possibly
    textile.

+ media     :- all js, css and images reside here.

+ templates :- is the same as \_layouts/ in jekyll. Liquid is probably the most
prevalant template engine for ruby at the moment. There is an example of how 
liquid is used for basically appending header and footers in the directory.
More on that later.

---

Project based off of: [Octopress](https://github.com/imathis/octopress) and
(wok)[https://github.com/mythmon/wok]
