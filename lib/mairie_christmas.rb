require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'



def get_ville

  ville_name_array = []
  # Régister URL of the needed website
  page_url_region = "https://www.annuaire-des-mairies.com/val-d-oise.html"

  region_page = Nokogiri::HTML(open(page_url_region))

  # From the website, get an array of the city name, convert it to string, put in downcase and replace " " to "-" if any space
  return ville_name_array = region_page.xpath("//a[contains(@class, 'lientxt')]/text()").map {|x| x.to_s.downcase.gsub(" ", "-") }
end

def get_email

  ville_email_array = []

  for n in 0...get_ville.length

      page_url_ville = "https://www.annuaire-des-mairies.com/95/#{get_ville[n]}.html"

      ville_page = Nokogiri::HTML(open(page_url_ville))

      # begin
      ville_email_array << ville_page.xpath("//html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()").to_s
      # rescue => e
      #   ville_email_array << "lol" #résultat que tu veux voir en lieu et place d'une erreur terminal
      # end
  end

  return ville_email_array
end

puts get_email

# # From the website, get an array of the currencies price and convert it to string
# currency_value_array = page.xpath("//tr/td/a[contains(@class, 'price')]/text()").map {|x| x.to_s }
#
# # Convert the 2 arrays into hash
# currency_result = Hash[currency_name_array.zip(currency_value_array)]
#
# puts currency_result
