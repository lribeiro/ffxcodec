require "ffxcodec/version"
require "ffxcodec/core_ext/string"
require "ffxcodec/encrypt"
require "ffxcodec/encoder"

# Example (without encryption):
#
#     ffx = FFXCodec.new(40, 24)
#     ffx.encode(7183940, 99)          #=> 5084490834151041050
#     ffx.decode(5084490834151041050)  #=> [7183940, 99]
#
# Example (with encryption):
#
#     ffx = FFXCodec.new(40, 24)
#     ffx.setup_encryption("2b7e151628aed2a6abf7158809cf4f3c", "8675309")
#     ffx.encode(7183940, 99)          #=> 120526513111139
#     ffx.decode(5084490834151041050)  #=> [7183940, 99]
#
class FFXCodec
  def initialize(a_size, b_size)
    @encoder = Encoder.new(a_size, b_size)
  end

  def setup_encryption(key, tweak)
    @encoder.crypto = Encrypt.new(key, tweak, @encoder.size, 2)
  end

  def encode(a, b)
    @encoder.encode(a, b)
  end

  def decode(c)
    @encoder.decode(c)
  end

  # Show maximum representable base 10 value for each field
  def maximums
    [@encoder.a_max, @encoder.b_max]
  end
end