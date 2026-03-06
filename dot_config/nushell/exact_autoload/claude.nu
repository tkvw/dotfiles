def --wrapped docker-claude-code [...rest: string] {
  let ssh_sock = $env.SSH_AUTH_SOCK
  let args = [
    "run" "-it" "--rm"
    "-v" "mise-cache:/home/dennie/.local/share/mise"
    "-v" "claude_code_home:/home/code"
    "-v" $"($env.PWD):/code"
    "-v" $"($ssh_sock):/ssh-agent"
    "-e" "SSH_AUTH_SOCK=/ssh-agent"
    "mise"
    "mise" "x" "claude" "--" "claude" "--dangerously-skip-permissions"
    ...$rest
  ]
  docker ...$args
}

def --wrapped docker-claude-code-bash [...rest: string] {
  let ssh_sock = $env.SSH_AUTH_SOCK
  let args = [
    "run" "-it" "--rm"
    "-v" "mise-cache:/home/dennie/.local/share/mise"
    "-v" "claude_code_home:/home/code"
    "-v" $"($env.PWD):/code"
    "-v" $"($ssh_sock):/ssh-agent"
    "-e" "SSH_AUTH_SOCK=/ssh-agent"
    "mise"
    "bash"
    ...$rest
  ]

  docker ...$args
}
