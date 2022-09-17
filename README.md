# Jekyll Instagram Plugin

Jekyllgram is a Jekyll plugin for displaying a feed of your recent Instagram photos.


### Installation and Setup

To install this plugin into your project you will need to copy _plugins/jekyllgram.rb into the _plugins directory
in your Jekyll project.

Then for the plugin to be able to communicate with Instagram you will need to register an application with the Instagram Basic Display API and then make your access token available as an environment variable on your dev/build machine named `JEKYLLGRAM_TOKEN`.

There is an easy step by step guide for getting your Instagram access token available [here](https://essential-addons.com/elementor/how-to-get-instagram-access-token/).

Your instagram account will need to be public for this to work correctly. To avoid making your main account public you can create a separate Instagram account just for your public feed and use that account.


### Working Example

There is a working example of a basic Jekyll site using this plugin that is available in the `example` directory of this repo.


### Displaying the results in your templates

To display the feed of your recent Instagram photos you will need to insert the liquid template tag below into one of the pages of your Jekyll site. You can replace the 6 below with the number of photos from Instagram that you wish to display.

```liquid
{% jekyllgram 6 %}
  <a href="{{ photo.permalink }}" title="{{ photo.caption }}" id="IG-{{ photo.id }}">
    <img src="{{ photo.media_url }}" title="{{ photo.caption }}" width="250" height="250" />
  </a>
{% endjekyllgram %}
```


### Contributors

- [Zachary Wright](https://github.com/zachwright)
- [Jason](https://github.com/jschee)

### Changelog

- (v1.0.0) Initial release
