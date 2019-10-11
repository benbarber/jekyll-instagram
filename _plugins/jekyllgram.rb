# frozen_string_literal: true

#
# Jekyllgram
#
# A Jekyll plugin to pull in your latest Instagram photos
# v0.01
# http://benbarber.uk
# Copyright 2015 Ben Barber
# MIT License
#
# Setup:
#
# To use this plugin you will need to make your Instagram API access token
# available as an environment variable like below:
#
# ENV['JEKYLLGRAM_TOKEN'] = {{ INSTAGRAM_ACCESS_TOKEN }}
#
# Usage in your templates:
# You can replace the 6 below with the number of photos you wish to display
#
# {% jekyllgram 6 %}
#    <a href="{{ photo.link }}" title="{{ photo.caption.text }}">
#      <img src="{{ photo.images.thumbnail.url }}"
#           title="{{ photo.caption.text }}" />
#    </a>
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
      @api_url = 'https://api.instagram.com/v1'

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
      method = '/users/self/media/recent'
      keys = "/?access_token=#{@access_token}"

      response = Net::HTTP.get_response(URI.parse(@api_url + method + keys))
      return [] unless response.is_a?(Net::HTTPSuccess)

      response = JSON.parse(response.body)

      response['data']
    end
  end
end

Liquid::Template.register_tag('jekyllgram', Jekyll::Jekyllgram)
