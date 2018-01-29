#!/usr/bin/env ruby
# -*- encoding : utf-8 -*-

# The RGB values of the typical heatmap progression.
HEATMAP_PROGRESSION = [
  [0.0, 0.0, 0.0], # Black
  [0.0, 0.0, 1.0], # Blue
  [0.0, 1.0, 1.0], # Cyan
  [0.0, 1.0, 0.0], # Green
  [1.0, 1.0, 0.0], # Yellow
  [1.0, 0.0, 0.0], # Red
  [1.0, 0.0, 1.0], # Purple
]

# Return the text supplied with ANSI 256-color coloring applied.
def ansi_color(color, text)
  "\x1b[38;5;#{color}m#{text}\x1b[0m"
end

# Zero and 1/8 through 8/8 illustrations.
BLOCK_CHARS_V = ["░", "▁ ", "▂ ", "▃ ", "▄ ", "▅ ", "▆ ", "▇ ", "█ "]
BLOCK_CHARS_H = ["░", "▏ ", "▎ ", "▍ ", "▌ ", "▋ ", "▊ ", "▉ ", "█ "]

COLOR_SPACING_PRIME = 999983

# Return a string with a possibly colored filled block for use in printing
# to an ANSI-capable Unicode-enabled terminal.
def filled_block(fraction, identifier=nil, block_chars=BLOCK_CHARS_V)
  if fraction == 0.0
    block = block_chars[0]
  else
    parts = (fraction.to_f * (block_chars.size.to_f-1)).floor
    block = block_chars[[block_chars.size-1, parts+1].min]
  end
  if identifier
    # ANSI 256-color mode, color palette starts at 10 and contains 216 colors.
    color = 16 + ((identifier * COLOR_SPACING_PRIME)  % 216)
    ansi_color(color, block)
  else
    block
  end
end

used_fraction = 1.0

for i in 1..10 do
  puts "%s" % [filled_block(used_fraction, i)]
end
