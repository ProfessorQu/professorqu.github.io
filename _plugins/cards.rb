# _plugins/cards.rb
require 'uri'
require 'net/http'

module Jekyll
  class CardTag < Liquid::Tag
    def initialize(tag_name, text, tokens)
      super
      @card_name = text
    end

    def render(context)
      uri = URI("https://api.scryfall.com/cards/named?exact=#{@card_name}")
      res = Net::HTTP.get_response(uri)
      if res.is_a?(Net::HTTPSuccess)
        url = JSON.parse(res.body)['scryfall_uri']

        "<a href='#{url}'>#{@card_name}</a>"
      end
    end
  end

  class CardsBlock < Liquid::Block
    def render(context)
      content = ""

      images = super.strip
      images = images.split('!').drop(1)

      images.each { |img|
        name = img.match(/\[(.*)\]/).captures.first

        uri = URI("https://api.scryfall.com/cards/named?exact=#{name}")
        res = Net::HTTP.get_response(uri)

        if res.is_a?(Net::HTTPSuccess)
          img_url = JSON.parse(res.body)['image_uris']['large']
        else
          img_url = img.match(/\((.*)\)/).captures.first
        end

        content += "<a href='#{img_url}' class='popup img-link'><img src='#{img_url}' alt=\"#{name}\" loading='lazy'></a>"
      }

      "<div class='cards-container'>" + content + "</div>"
    end
  end
end

Liquid::Template.register_tag('card', Jekyll::CardTag)
Liquid::Template.register_tag('cards', Jekyll::CardsBlock)
