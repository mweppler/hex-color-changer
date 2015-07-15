#!/usr/bin/env ruby

class HexColorChanger
  def self.valid_hex?(hex)
    hex
  end

  def self.valid_lum?(lum)
    lum
  end

  def self.hex_to_rgb(hex)
    hex = hex[1..-1]
    {
      r: hex[0..1].to_i(16),
      g: hex[2..3].to_i(16),
      b: hex[4..5].to_i(16)
    }
  end

  def self.lum_percent(lum)
    lum =~ /^(\d{2})%\s(lighter|darker)$/
    case $2
    when 'darker'
      $1.to_i(10) / -100.0
    when 'lighter'
      $1.to_i(10) / 100.0
    else
      nil
    end
  end

  def self.calc_rgb_and_lum(rgb, lum)
    new_rgb = rgb.each_pair.inject({}) do |hash, value|
      chg = value.last + (value.last * lum)
      hex = [[0, chg].max, 255].min.round.to_s(16)
      hash[value.first] = ('00' + hex)[hex.size..-1]
      hash
    end
    '#' <<  new_rgb.inject("") { |str, val| str << val.last }
  end
end

if __FILE__ == $0
  if ARGV.size == 2
    rgb = HexColorChanger.hex_to_rgb(ARGV[0])
    lum = HexColorChanger.lum_percent(ARGV[1])
    puts HexColorChanger.calc_rgb_and_lum(rgb, lum)
    exit 0
  else
    puts "hex color changer requires a hex string: '#coffee' and a luminosity value: '20% lighter' or '50% darker'"
    puts "$ hex_color_changer.rb '#coffee' '20% lighter'"
    exit 1
  end
end
