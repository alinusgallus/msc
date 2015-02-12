namespace :load_table do
	
	desc "this task loads companies' data from MSC website to the table company"
	task :load_table => :environment do
		require 'open-uri'
		require 'nokogiri'
		require 'uri'

#empty table
		Company.delete_all
#fget xml with open-uri
		comp_list_url = "http://sc.mscmalaysia.my/companydbtest/connector_mssql.asp"
		comp_xml = open(comp_list_url,'User-Agent' => 'ruby')

#create nokogiri object
		comp_list_xml = Nokogiri::XML(comp_xml)

		comp_list_xml.search('row').each do | r|
			comp_data = r.search('cell')
			n  = comp_data[0].text.split("^")[0]
			y = comp_data[1].text
			c = comp_data[2].text

			detail = URI.escape("http://sc.mscmalaysia.my/companydbtest/" + comp_data[0].text.split("^")[1]) 

			begin 
			comp_detail = Nokogiri::HTML(open(detail))

			a = comp_detail.css('.general')[3].text.gsub("Address:","").tr("\\\r","").tr("\\\n","").split.join(" ") unless comp_detail.css('.general')[3].nil?
			l = comp_detail.css('a').text
			rescue

			end

			company = Company.new( name: n , year_of_approval: y, category: c , address: a, link: l )
			company.save



		end




	end

end