#!/usr/bin/env nu

# Downloads latest version of Microsoft.CodeAnalysis.LanguageServer for the current platform

def main [] {
  let org = "azure-public"
  let project = "vside"
  let feed = "vs-impl"

  # Bepaal platform suffix op basis van OS + architectuur
  let os = $nu.os-info.name
  let arch = $nu.os-info.arch

  let platform = match $os {
    "windows" => (if $arch == "aarch64" { "win-arm64" } else { "win-x64" })
    "linux" => (if $arch == "aarch64" { "linux-x64" } else { "linux-x64" })  # TODO: musl/alpine detectie
    "macos" => (if $arch == "aarch64" { "osx-arm64" } else { "osx-x64" })
    _ => { error make { msg: $"Unsupported OS: ($os)" } }
  }

  let package_name = $"Microsoft.CodeAnalysis.LanguageServer.($platform)"

  # Haal alle pakketten op in één query
  let api_url = $"https://feeds.dev.azure.com/($org)/($project)/_apis/packaging/Feeds/($feed)/packages?packageNameQuery=Microsoft.CodeAnalysis.LanguageServer&api-version=7.1"
  print $"Fetching package list..."

  let packages = (http get $api_url | get value)

  # Filter het juiste pakket voor ons platform
  let pkg = ($packages | where name == $package_name)

  if ($pkg | is-empty) {
    error make { msg: $"Package not found: ($package_name)" }
  }

  let version = ($pkg | first | get versions | sort-by normalizedVersion | last | get normalizedVersion)
  print $"Package: ($package_name)"
  print $"Version: ($version)"

  # Download URL samenstellen
  let download_url = $"https://pkgs.dev.azure.com/($org)/($project)/_apis/packaging/feeds/($feed)/nuget/packages/($package_name)/versions/($version)/content"


let install_dir = "~/.local/share/nvim/roslyn" | path expand

mkdir ($install_dir | path dirname)

  # Download
  let nupkg = $"($package_name).($version).nupkg"
  print $"Downloading..."
  http get $download_url | save -f $nupkg

  # Uitpakken
  let unzip_dir = $"($package_name)_extracted"
  mkdir $unzip_dir
  ^tar -xf $nupkg -C $unzip_dir
  # Installeren
  rm -rf $install_dir
  mv $"($unzip_dir)/content/LanguageServer/($platform)" $install_dir

  # Versie opslaan
  $version | save -f $"($install_dir)/.version"

  # Opruimen
  rm -f $nupkg
  rm -rf $unzip_dir

  print $"Installed Roslyn ($version) for ($platform) to ($install_dir)"
}
