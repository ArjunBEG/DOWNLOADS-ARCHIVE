#!/usr/bin/env fish

# Usage: fish take_screenshots.fish sites.txt
# Where sites.txt has one URL (without URI scheme) per line.

for file in $argv
  if test -f $file
    echo "Processing $file..."
    for line in (cat $file)
      echo -s "Visiting " (set_color --bold green) $line (set_color normal)
      ./screenshots.js $line
    end
  else
    echo "$file is not a valid file"
  end
end