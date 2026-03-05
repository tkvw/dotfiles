def ccd [] {
  let args = [
    "run" "-it" "--rm"
    "-v" "claude_code_home:/home/claude"
    "-v" $"($env.PWD):/code"
    "claude-code"
  ]
  docker ...$args
}
