def docker-claude-code [] {
  let args = [
    "run" "-it" "--rm"
    "-v" "mise-cache:/home/dennie/.local/share/mise"
    "-v" "claude_code_home:/home/code"
    "-v" $"($env.PWD):/code"
    "mise"
    "mise" "x" "claude" "--" "claude" "--dangerously-skip-permissions"
  ]
  docker ...$args
}

def docker-claude-code-bash [] {
  let args = [
    "run" "-it" "--rm"
    "-v" "mise-cache:/home/dennie/.local/share/mise"
    "-v" "claude_code_home:/home/code"
    "-v" $"($env.PWD):/code"
    "mise"
    "bash"
  ]
  docker ...$args
}
