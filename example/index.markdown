---
# Feel free to add content and custom Front Matter to this file.
# To modify the layout, see https://jekyllrb.com/docs/themes/#overriding-theme-defaults

layout: home
---

### A Jekyll plugin to show a feed of recent Instagram photos

This is a working demo using the [{{ site.title }} plugin](https://github.com/benbarber/jekyll-instagram/) to show a feed of recent instagram photos. 

You can get the full source code on [GitHub](https://github.com/benbarber/jekyll-instagram/).


## Recent Instagram Photos

{% jekyllgram 6 %}
  <a href="{{ photo.permalink }}" title="{{ photo.caption }}" id="IG-{{ photo.id }}" style="float:left;margin:5px;">
    <img src="{{ photo.media_url }}" title="{{ photo.caption }}" width="250" height="250" />
  </a>
{% endjekyllgram %}

<div style="clear:both;padding-top: 25px;"></div>
