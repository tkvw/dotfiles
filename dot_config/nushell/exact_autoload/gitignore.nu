module gitignore {
  # Not exported — only visible inside the module
  def templates [] {
    http get "https://www.toptal.com/developers/gitignore/api/list"
    | split row ","
  }

  def fetch [query: string] {
    http get $"https://www.toptal.com/developers/gitignore/api/($query)"
    | save -f .gitignore
    print $"✓ .gitignore created with: ($query)"
  }

  # Exported — visible after `use gitignore`
  export def main [...templates: string] {
    if not ($templates | is-empty) {
      fetch ($templates | str join ",")
      return
    }

    let raw = (templates | to text | fzf --multi --prompt="Select templates: " | str trim)

    if ($raw == "") {
      print "No templates selected."
      return
    }

    let selected = $raw | split row "\n" | each { str trim } | where { $in != "" }
    fetch ($selected | str join ",")
  }
}

use gitignore
