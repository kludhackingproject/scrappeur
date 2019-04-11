require 'pry'
require 'dotenv'
require 'rubygems'
require 'nokogiri'
require 'open-uri'

# This function return all the depute names from the website
def get_deputes_name

  deputes_name_array = []
  # Régister URL of the needed website
  page_url_deputes = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

  depute_page = Nokogiri::HTML(open(page_url_deputes))

  # From the website, get an array of the city name, convert it to string, put in downcase and replace " " to "-" if any space
  return deputes_name_array = depute_page.xpath("//*[contains(@id, 'deputes-list')]/div/ul/li/a/text()").map {|x| x.to_s }
end

# This function return all the link to the deputy email
def get_deputes_link

  deputes_name_array = []
  # Régister URL of the needed website
  page_url_deputes = "http://www2.assemblee-nationale.fr/deputes/liste/alphabetique"

  depute_page = Nokogiri::HTML(open(page_url_deputes))

  # From the website, get an array of the city name, convert it to string, put in downcase and replace " " to "-" if any space
  return deputes_name_array = depute_page.xpath("//*[contains(@id, 'deputes-list')]/div/ul/li/a/@href").map {|x| x.to_s }
end

# This function return all the depute email from the website
def get_deputes_email (deputes_names)

  deputes_email_array = []

  # Loop on each link an get deputy email
  # Use 10 to avoid a latency replace 10 to deputes_names.length to get all hashe
  for n in 0...10

    # get each link to the depute
    page_url_deputes = "http://www2.assemblee-nationale.fr/#{deputes_names[n]}"

    # Connect to the page
    depute_page = Nokogiri::HTML(open(page_url_deputes))

    # If any bug when trying to get any email
    begin

      # Put each email in an array "ville_email_array"
      deputes_email_array << depute_page.xpath("//*[contains(@class, 'deputes-liste-attributs')]/dd[4]/ul/li[2]/a/text()").to_s
    rescue => e

        deputes_email_array << " "
      end
  end

  # return the array of deputes emails
  return deputes_email_array
end

# Merge deputes name array with depute email array
puts email_ville_result = Hash[get_deputes_name.zip(get_deputes_email(get_deputes_link))]
