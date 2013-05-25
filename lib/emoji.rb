require 'oj'

class Emoji

  def initialize
    @emoji_map = Oj.load_file 'lib/vendor/emoji-data/emoji.json'
  end

  def chars
    @chars ||= self.codepoints.map { |cp| Emoji.codepoint_to_char(cp) }
  end

  def codepoints
    @codepoints ||= @emoji_map.map { |es| es['unified'] }
  end

  def self.char_to_codepoint(char)
    char.unpack('U'*char.length).collect {|x| x.to_s 16}.join.upcase
  end

  def self.codepoint_to_char(cp)
    [ cp.hex ].pack("U")
  end

  def codepoint_to_obj(cp)
    @emoji_map.detect { |emoji_symbol| emoji_symbol['unified'] == cp}
  end

end