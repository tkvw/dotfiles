#!/bin/sh
{{ $version := .packages.age.version -}}
{{ $dir := joinPath .chezmoi.homeDir ".local" "bin" | quote }} 
mkdir -p {{$dir}}
curl -L https://github.com/FiloSottile/age/releases/download/v{{$version}}/age-v{{$version}}-linux-arm64.tar.gz | \
    tar -xz --strip-components=1 \
        -C {{ $dir }} \
        age/age \
        age/age-keygen