require './hex_color_changer'
require 'test/unit'

class TestSomething < Test::Unit::TestCase
  def test_that_hex_string_is_valid
    hex = '#6699cc'
    assert_equal hex, HexColorChanger.valid_hex?('#6699cc')
  end

  def test_that_luminosity_string_is_valid
    lum = '20% lighter'
    assert_equal lum, HexColorChanger.valid_lum?('20% lighter')
    lum = '50% darker'
    assert_equal lum, HexColorChanger.valid_lum?('50% darker')
  end

  def test_that_hex_converts_to_rgb
    rgb = { r: 102, g: 153, b: 204 }
    assert_equal rgb, HexColorChanger.hex_to_rgb('#6699cc')
  end

  def test_that_lum_string_converts_to_percent
    lum_percent = 0.2
    assert_equal lum_percent, HexColorChanger.lum_percent('20% lighter')
    lum_percent = -0.5
    assert_equal lum_percent, HexColorChanger.lum_percent('50% darker')
    assert_equal nil, HexColorChanger.lum_percent('50% idk')
  end

  def test_that_luminosity_and_rgb_calculate
    assert_equal '#7ab8f5', HexColorChanger.calc_rgb_and_lum({ r: 102, g: 153, b: 204 }, 0.2)
    assert_equal '#334d66', HexColorChanger.calc_rgb_and_lum({ r: 102, g: 153, b: 204 }, -0.5)
    assert_equal '#000000', HexColorChanger.calc_rgb_and_lum({ r: 0, g: 0, b: 0 }, -0.75)
  end
end
