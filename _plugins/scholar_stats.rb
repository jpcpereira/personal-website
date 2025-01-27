require 'open-uri'
require 'nokogiri'

module Jekyll
  class ScholarStats < Generator
    # Replace `SCHOLAR_ID` with your own Google Scholar ID
    SCHOLAR_ID = 'WCiItYkAAAAJ&hl'.freeze
    SCHOLAR_URL = 'http://scholar.google.com/citations?hl=en&user='.freeze
    def generate(site)
      doc = Nokogiri::HTML(URI.parse(SCHOLAR_URL + SCHOLAR_ID).open)
      tbl = doc.css('tbody')

      papers = tbl.xpath("//*[@class=\"gsc_a_tr\"]")
      citation_counts = papers.xpath("//*[@class=\"gsc_a_c\"]").css('a').map(&:text)

      puts citation_counts
      #tbl.css('tr.gsc_a_tr').each do |tr|
      # puts tr
      #doc.xpath("//*[@class=\"gsc_a_tr\"]").each('a').map(&:text)
      #  puts text
      #tbl.xpath("//*[@class=\"gsc_a_c\"]").each do |a|
      #  puts a.content

      row = tbl.xpath("//*[@class=\"gsc_a_c\"]")
      title = tbl.xpath("//*[@class=\"gsc_a_at\"]").css('a').map(&:text)
      #puts title
      tbl_data = { 'id' => SCHOLAR_ID }
      row.css('td').each do |td|
        row_content = td.css('a').map(&:text)
        #puts row_content
      end

      x = Hash[(0...citation_counts.size).zip citation_counts]
      x = x.transform_keys(&:to_s)

      site.data['scholar'] = x

      puts site.data['scholar']
    end
  end
end