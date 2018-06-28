# Jekyllgram

Jekyll Instagram aka Jekyllgram is a Jekyll plugin for displaying a feed of your recent Instagram photos.



### Installation and Setup

To install this plugin into your project you will need to copy _plugins/jekyllgram.rb into the _plugins directory 
in your Jekyll project.

For the plugin to work you will need to register an application with the Instagram API and then make your user id, 
client id, and access token available as environment varibles below:

```ruby
ENV['JEKYLLGRAM_USER'] = {{ INSTAGRAM_USER_ID }}
ENV['JEKYLLGRAM_KEY'] = {{ INSTAGRAM_CLIENT_ID }}
ENV['JEKYLLGRAM_TOKEN'] = {{ INSTAGRAM_ACCESS_TOKEN }}
```



### Displaying the results in your templates

You can replace the 6 below with the number of photos you wish to display

```liquid
{% jekyllgram 6 %}
  <a href="{{ photo.link }}" title="{{ photo.caption.text }}">
    <img src="{{ photo.images.thumbnail.url }}" title="{{ photo.caption.text }}" />
  </a>
{% endjekyllgram %}
```
