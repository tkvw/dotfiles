$env.config.show_banner = false
$env.config.buffer_editor = "nvim"


mkdir ($nu.data-dir | path join "vendor/autoload")
if (which starship | is-not-empty) {
  starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}
if (which zoxide | is-not-empty) {
  zoxide init nushell | save -f ($nu.data-dir | path join "vendor/autoload/zoxide.nu")
}
if (which carapace | is-not-empty) {
  carapace _carapace nushell | save -f ($nu.data-dir | path join "vendor/autoload/carapace.nu")
}
if (which mise | is-not-empty) {
  mise activate nu | save -f ($nu.data-dir | path join "vendor/autoload/mise.nu")
}
