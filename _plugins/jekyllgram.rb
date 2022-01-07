# frozen_string_literal: true

#
# Jekyll Instagram Plugin
# Jekyllgram is a Jekyll plugin for displaying a feed of your recent Instagram photos.
#
# v2.0.0
# https://benbarber.github.com/jekyll-instagram
# Copyright 2015 Ben Barber
# MIT License
#
# Setup:
#
# To use this plugin you will need to make your Instagram API access token
# available as an environment variable named 'JEKYLLGRAM_TOKEN'.
#
# Usage in your templates:
#
# To display the feed of your recent Instagram photos you will need to insert the liquid 
# template tag below into one of the pages of your Jekyll site. You can replace the 6 
# below with the number of photos from Instagram that you wish to display.
#
# {% jekyllgram 6 %}
#   <a href="{{ photo.permalink }}" title="{{ photo.caption }}" id="IG-{{ photo.id }}">
#     <img src="{{ photo.media_url }}" title="{{ photo.caption }}" width="250" height="250" />
#   </a>
# {% endjekyllgram %}
#

require 'jekyll'
require 'net/http'
require 'json'

module Jekyll
  # _plugins/jekyllgram.rb
  class Jekyllgram < Liquid::Block
    include Liquid::StandardFilters

    def initialize(tag, params, token)
      @limit = params.to_i
      @access_token = ENV['JEKYLLGRAM_TOKEN']
      @api_url = 'https://graph.instagram.com/me'

      super
    end

    def render(context)
      context.registers[:jekyllgram] ||= Hash.new(0)
      content = generate(context, recent_photos)

      content
    end

    private

    def generate(context, photos)
      result = []

      context.stack do
        photos.each_with_index do |photo, index|
          context['photo'] = photo
          result << @body.render(context)

          break if index + 1 == @limit
        end
      end

      result
    end

    def recent_photos
      # A full list of fields available can be fount at: 
      # https://developers.facebook.com/docs/instagram-basic-display-api/reference/media#fields
      fields = 'id,timestamp,permalink,caption,media_type,media_url,thumbnail_url,username'

      request_url = "#{@api_url}/media?fields=#{fields}&access_token=#{@access_token}"

      response = Net::HTTP.get_response(URI.parse(request_url))
      return [] unless response.is_a?(Net::HTTPSuccess)

      response = JSON.parse(response.body)

      response['data']
    end
  end
end

Liquid::Template.register_tag('jekyllgram', Jekyll::Jekyllgram)
