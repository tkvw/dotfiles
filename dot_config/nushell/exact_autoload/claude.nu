def docker-claude-base [] {
  let ssh_sock = $env.SSH_AUTH_SOCK
  [
    "run" "-it" "--rm"
    "-v" $"($env.HOME)/.local/share/mise:/home/code/.local/share/mise"
    "-v" $"($env.HOME)/.local/share/pnpm:/home/code/.local/share/pnpm"
    "-v" "claude_code_home:/home/code"
    "-v" $"($env.PWD):/code"
    "-v" $"($ssh_sock):/ssh-agent"
    "-e" "SSH_AUTH_SOCK=/ssh-agent"
    "mise"
  ]
}

def --wrapped docker-claude-code [...rest: string] {
  docker ...(docker-claude-base) "mise" "x" "claude" "--" "claude" "--dangerously-skip-permissions" ...$rest
}

def --wrapped docker-claude-code-bash [...rest: string] {
  docker ...(docker-claude-base) "bash" ...$rest
}
