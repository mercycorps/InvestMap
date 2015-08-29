# INVEST Tour

> A self-guided, map-based tour prototype based on [CartoDB](https://cartodb.com/) and [Middleman](http://middlemanapp.com/).

Mercy Corps has commissioned an interactive storytelling tool to more quickly deliver insights and progress reports for benefactors of internal programs. Expository content and data are brought together in a polished, browser-based single-page user experience, with supplemental pages for information about the program.

## Technology

The prototype relies heavily on [CartoDB](https://cartodb.com/) via their [CartoDB.js](http://docs.cartodb.com/cartodb-platform/cartodb-js.html) library.

To keep our codebase lean and avoid managing raw HTML, CSS and JS, we're using Middleman, a free and open-source static site generator.

## Getting Started

Middleman requires a modern Ruby installation.

```
$ git clone https://github.com/mercycorps/InvestMap invest-map
$ cd invest-map
$ bundle install
```

Bundler will fetch the project's dependences, declared in its `Gemfile`. This may take a moment, based on your local cache of gems and network conditions.

Run the development server with:

```
$ middleman server
```

Changes to any files in the `source` directory will trigger a rebuild.

If you need a package for distribution outside GitHub Pages, a quick `$ middleman build` will render the site into a new `build` directory, or update it, if it exists.

## Publishing

To publish changes to the `gh-pages` branch, navigate to your repository and run:

```
$ middleman deploy
```

Please only deploy from `master`. Verify your changes at the project's [public-facing endpoint](http://mercycorps.github.io/InvestMap/).
