#!/bin/env ruby
# frozen_string_literal: true

require 'every_politician_scraper/scraper_data'
require 'pry'

class MemberList
  class Member
    def name
      tds[0].text.tidy.delete_prefix('Hon. ')
    end

    def position
      tds[1].text.tidy.split(/ and (?=Minister)/)
    end

    private

    def tds
      noko.css('td')
    end
  end

  class Members
    def member_container
      noko.css('table.uk-table').first.xpath('.//tr[td]')
    end
  end
end

file = Pathname.new 'official.html'
puts EveryPoliticianScraper::FileData.new(file).csv
