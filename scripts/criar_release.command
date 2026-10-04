#!/bin/zsh

set -euo pipefail

script_dir="${0:A:h}"
project_dir="${script_dir:h}"
products_dir="$project_dir/build/products"
objects_dir="$project_dir/build/obj"
artifacts_dir="$project_dir/artifacts"
project_file="$project_dir/itlwm.xcodeproj/project.pbxproj"
sdk_dir="$project_dir/MacKernelSDK"

cd "$project_dir"

if ! command -v xcodebuild >/dev/null 2>&1; then
    printf 'Erro: instale o Xcode para compilar a kext.\n' >&2
    exit 1
fi

if [[ ! -f "$sdk_dir/Library/x86_64/libkmod.a" ]]; then
    printf 'Erro: MacKernelSDK não encontrado em %s.\n' "$sdk_dir" >&2
    exit 1
fi

version=$(awk '/MODULE_VERSION =/ {gsub(/;/, "", $3); print $3; exit}' "$project_file")
if [[ -z "$version" ]]; then
    printf 'Erro: não foi possível encontrar a versão do projeto.\n' >&2
    exit 1
fi

short_sha=$(git rev-parse --short HEAD 2>/dev/null || printf 'local')
archive="$artifacts_dir/AirportItlwm-Tahoe-v${version}-RELEASE-ptbr-${short_sha}.zip"

printf 'Compilando AirportItlwm.kext v%s em Release...\n' "$version"
xcodebuild \
    -project itlwm.xcodeproj \
    -scheme AirportItlwm-Tahoe \
    -configuration Release \
    -jobs 3 \
    ARCHS=x86_64 \
    SYMROOT="$products_dir" \
    OBJROOT="$objects_dir" \
    CODE_SIGNING_ALLOWED=NO \
    GIT_COMMIT="_$short_sha" \
    build

kext="$products_dir/Release/Tahoe/AirportItlwm.kext"
if [[ ! -d "$kext" ]]; then
    printf 'Erro: a kext não foi encontrada em %s.\n' "$kext" >&2
    exit 1
fi

mkdir -p "$artifacts_dir"
rm -f "$archive"
ditto -c -k --keepParent "$kext" "$archive"

printf '\nRelease criada com sucesso:\n%s\n' "$archive"
open -R "$archive"