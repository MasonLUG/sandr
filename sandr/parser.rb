# ==============================================================================
#
#       parser.rb
#
#   Last Modified: Jan 31, 2014 2:29 AM EST
#
#   Author: masonlug
#
# Markdown, reStructuredText and textile parser to html
#
# ==============================================================================

require 'maruku'

def parse(infile)
    contents = File.read('page1.markdown')
    parser = Maruku.new(contents)
    File.write(infile.split('.')[0],parser.to_html)
end


