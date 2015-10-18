module MatchesHelper

 def parse
    @countries = ['africa', 'albania', 'algeria', 'argentina', 'austria', 'algeria', 'angola', 'armenia', 'asia', 'australia', 'azerbaijan', 'belarus', 'belgium', 'bolivia', 'bosnia', 'brazil', 'bulgaria', 'cameroon', 'canada', 'chile', 'china', 'colombia', 'concacaf', 'congo', 'croatia', 'cyprus', 'czech', 'costarica', 'denmark', 'equador', 'egypt', 'elsalvador', 'england', 'estonia', 'europe', 'finland', 'france', 'georgia', 'germany', 'ghana', 'greece', 'guatemala', 'holland', 'honduras', 'hungary', 'iceland', 'india', 'indonesia', 'international', 'iran', 'ireland', 'israel', 'italy', 'japan', 'jordan', 'kazakhstan', 'kenya', 'korea', 'kuwait', 'latvia', 'lithuania', 'macedonia', 'malaysia', 'malta', 'mexico', 'moldova', 'montenegro', 'morocco', 'newzealand', 'nigeria', 'norway', 'oceania', 'paraguay', 'peru', 'poland', 'portugal', 'qatar', 'romania', 'russia', 'saudiarabia', 'scotland', 'serbia', 'singapore', 'slovakia', 'slovenia', 'southafrica', 'southamerica', 'spain', 'sweden', 'switzerland', 'thailand', 'tunisia', 'turkey', 'uae', 'usa', 'ukraine', 'uruguay', 'uzbekistan', 'venezuela', 'vietnam', 'wales', 'worldcup']
    @countries.inject([]) do |memo, country|
    File.open("public/odds/#{country}.xml") do |f|
    xml = Nokogiri::XML(f)
    path = "//league/match/odds/type[@name='1x2']/bookmaker[1]"
      memo << xml.xpath(path).map do |x|
           { 'country' => x.parent.parent.parent.parent['country'],
           'league' => x.parent.parent.parent.parent['name'],
           'matchid' => x.parent.parent.parent['static_id'],
           'alternate_id' => x.parent.parent.parent['alternate_id_2'],
           'datetime' => x.parent.parent.parent['date'].to_date,
           'hometeam' => x.parent.parent.parent.children[0]['name'],
           'awayteam' => x.parent.parent.parent.children[1]['name'],
           'oddnameh' => x.children[0].attributes['name'].value,
           'oddnamea' => x.children[1].attributes['name'].value,
           'oddwina' => x.children[1].attributes['value'].value,
           'oddwinh' => x.children[0].attributes['value'].value,
           'oddnamed' => x.children[2].attributes['name'].value,
           'oddwind' => x.children[2].attributes['value'].value,
           'time' => [x.parent.parent.parent['date'], x.parent.parent.parent['time']].join(" ")}
         end
       end
     end
   end
   
end