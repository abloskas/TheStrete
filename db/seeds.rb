# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


require 'nokogiri'
require 'httparty'
require 'byebug'

#SCRAPER FOR NEW HOME SOURCE COMMUNITIES **NOT HOMES**

def scraper 
    url = "https://www.newhomesource.com/communityresults/texas/dallas-area"
    u_p = HTTParty.get(url)
    p_p = Nokogiri::HTML(u_p)
    homes = Array.new
    nhs = p_p.css('div.nhs_CommResItem')
    page = 1
    per_page = nhs.count #10/page
    total = p_p.css('span#nhs_viewHeaderTotal1').text.split(' ')[0].to_i
    last_page = (total.to_f / per_page.to_f).round
    while page <= last_page
        pagination_url = "https://www.newhomesource.com/communityresults/texas/dallas-area/page-#{page}"
        puts pagination_url
        puts "Page: #{page}"
        puts ''
        pagination_u_p = HTTParty.get(pagination_url)
        pagination_p_p = Nokogiri::HTML(pagination_u_p)
        pagination_nhs = pagination_p_p.css('div.nhs_CommResItem')
        pagination_nhs.each do |home_list|
            home = {
                community: home_list.css('p.nhs_CommTitle').text.strip,
                price: home_list.css('p.nhs_Price').text,
                location: home_list.css('div.nhs_Location').text.strip,
                url: "https://www.newhomesource.com" +nhs.css('a')[0].attributes["href"].value,
                img: home_list.css('div.nhs_ItemImages').css('div.mainImage img').attribute('data-src').value
            }
            Community.find_or_create_by(community:home[:community], price:home[:price], location:home[:location], url:home[:url], img:home[:img])
            homes << home
            puts "Added #{home[:community]}"
            puts ""
        end
        page += 1
    end
    byebug
end

scraper
