# jekyll-github

Pull information from the Github API and print it on your static Jekyll website.  See [this page](http://ryanpriebe.com/projects) to see exactly what this plugin generates.

Still in progress!

TODO:
* More data options (user, stars, followers, etc)

## Installation

1. Extract the zip file contents to `YOUR_SITE_DIR/_plugins`
2. Run `bundle install` inside `YOUR_SITE_DIR/_plugins/jekyll-github`
3. Add one of the shortcodes to the page and run `jekyll serve`
4. You're done.

## Usage

[Add](http://jekyllrb.com/docs/plugins/#tags) any of the following Liquid tags to your site's pages:
* repos
* repos_short
* user