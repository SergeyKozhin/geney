#!/usr/bin/env bash

# Starting from the very beginning of the message should be a type which might be one of the listed,
# the type should be followed by a colon and whitespace, then goes a subject that is allowed to be 50
# chars long at most, then after an empty line goes optional body each line of which may not exceed 72
# characters length. The body is considered everything until the end of the message.
# Please, the find the full style guide under the docs/git-commit-message-style-guide.md
pattern="^(feat|fix|docs|style|refactor|test|chore):[ ](.{1,50})("$'\n'"("$'\n'"[^"$'\n'"]{0,72})+)?$"
guide="docs/git-commit-message-style-guide.md"

# The message text except for the commented lines.
message=$(grep --invert-match "^#" < "${1}")

if [[ "${message}" =~ ${pattern} ]]; then
  exit 0
else
  echo "The commit message does not accord with the style guide that is used on the project."
  echo "For more details see: ${guide}"
  exit 1
fi
