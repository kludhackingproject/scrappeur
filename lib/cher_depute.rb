require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

def get_deputes_name

  deputes_name_array = []
  # Régister URL of the needed website
  page_url_deputes = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

  depute_page = Nokogiri::HTML(open(page_url_deputes))

  # From the website, get an array of the city name, convert it to string, put in downcase and replace " " to "-" if any space
  return deputes_name_array = depute_page.xpath("//*[contains(@id, 'deputes-list')]/div/ul/li/a/text()").map {|x| x.to_s }
end


def get_deputes_link

  deputes_name_array = []
  # Régister URL of the needed website
  page_url_deputes = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

  depute_page = Nokogiri::HTML(open(page_url_deputes))

  # From the website, get an array of the city name, convert it to string, put in downcase and replace " " to "-" if any space
  return deputes_name_array = depute_page.xpath("//*[contains(@id, 'deputes-list')]/div/ul/li/a/@href").map {|x| x.to_s }
end


def get_deputes_email (deputes_names)

  deputes_email_array = []

  # Loop on each cities in the array to get the email
  for n in 0...10

      page_url_deputes = "http://www2.assemblee-nationale.fr/#{deputes_names[n]}"

      depute_page = Nokogiri::HTML(open(page_url_deputes))

      # If bug to get any email
      begin
        # Put each email in an array "ville_email_array"
        deputes_email_array << depute_page.xpath("//*[contains(@class, 'deputes-liste-attributs')]/dd[4]/ul/li[2]/a/text()").to_s

      rescue => e

        deputes_email_array << " "

      end
  end

  return deputes_email_array
end

# Merge ville array with email array
puts email_ville_result = Hash[get_deputes_name.zip(get_deputes_email(get_deputes_link))]
