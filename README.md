# Mery Claire - A minimal but complete blog static generator

There are lots of site and blog static generators. Most of them are full of tons of features and configuration options that needs pages of documentation and tutorias to get started.
Mery Claire is a tiny blog generator, with just the feature you need.

### Getting started
1) Clone this repository and install the dependencies (`mix deps.get`)
2) Customize the files in the `_templates` folder. These are the containers of your blog, so you can style them adding images and css classes (use the `_assets` forlder for external files like css)
3) Add some posts in the `_posts` folder. These are your articles written in markdown. In the header section you can define as many attribute as you like and you can use them in the templates (like `title`)
4) Test you blog running `mix serve` and openin your browser at `https://localhost:4000`
5) If everything seems ok your blog is ready in the `docs` folder, push on your own hosting or on Github.

You can change the folders names editing the `config.exs` file. I'm using `docs` for outoput so it's easy to host the site on github pages.


## Commands
`mix gen` generates the output in the destination folder
`mix serve` generates the output and run a webserver to test the pages. When the server is active a watcher rebuilds all the pages when something change