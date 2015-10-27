require 'nokogiri'
require 'open-uri'

class MainController < ApplicationController
before_filter :authenticate_user!




def merge()

	i = 0
	k = 1
	puts @result
	while i < @result.count
		while k < @result.count
			tmp_1 = DateTime.parse(@result[i].split('&')[4])
			tmp_2 = DateTime.parse(@result[k].split('&')[4])
			if tmp_1 > tmp_2
				@result[i], @result[k] = @result[k], @result[i]
			end
			k += 1
		end
		k = 0
		i += 1
	end

end

def resourse_parse(u, categ)
	url = open(u).read()
	xml = Nokogiri::XML(url)
	result_title = []
	result_date = []
	result_description = []
	result_link = []
	result_1 = []
	time = []
	xml.xpath('//item/link').each { |item|
		result_link << item.content
	}	
	xml.xpath('//item/title').each { |item|
		result_title << item.content
	}
	xml.xpath('//item/description').each { |item|
		result_description << item.content
	}
	xml.xpath('//item/pubDate').each { |item|
		result_date << item.content	
		time <<	((Time.now - DateTime.parse(item)) / 3600).to_i.to_s
	}
	result_title.count.times do |i|
		result_1[i] = categ + '&' + result_link[i] + '&' + result_title[i] + '&' + result_description[i] + 
		'&' + result_date[i].to_s + '&' + time[i]
	end
	# puts @result
	@result.concat(result_1)
	
end

	def index
		@result = Array.new()
		result_1 = Array.new()	
		result_title = Array.new()
		result_date = Array.new()
		result_description = Array.new()	
		result_link = Array.new()
		time = Array.new()
		@cat = current_user.category.split("").map {|s| s.to_i}				
		if @cat.include?(1)
			resourse_parse('http://lenta.ru/rss/last24', 'Главное')
		end
		if @cat.include?(2)
			resourse_parse('http://ria.ru/export/rss2/politics/index.xml', 'Политика')
		end
		# if @cat.include?(3)
		# 	resourse_parse('http://www.vsesmi.ru/rss/17/', 'Экономика')
		# end
		if @cat.include?(4)
			resourse_parse('http://sport.ria.ru/export/rss2/sport/index.xml', 'Спорт')
		end
		if @cat.include?(5)
			resourse_parse('http://ria.ru/export/rss2/science/index.xml', 'Наука')
		end
		if @cat.include?(6)
			resourse_parse('http://www.auto.vl.ru/export/xml/news.rss', 'Авто')
		end
		if @cat.include?(7)
			resourse_parse('http://ria.ru/export/rss2/culture/index.xml', 'Культура')
		end
		if @cat.include?(8)
			resourse_parse('http://ria.ru/export/rss2/world/index.xml', 'В мире')
		end
		merge()
		puts @result
	end
end
