#!/bin/bash

BUILD_DIR=$(mktemp -d)

trap "rm -rf $BUILD_DIR" EXIT

build_parser() {
    local url="$1"
    local output_name="$2"
    local so_path="${3:-}"
    local repo_name
    repo_name=$(basename "$url" .git)


    # Clone
    cd "$BUILD_DIR"
    git clone --depth=1 "$url"
    cd "$repo_name"

    # Build
    mkdir build && cd build
    cmake ..
    cmake --build .

    # Locate parser
    local so_file
    if [[ -n "$so_path" ]]; then
        so_file="$so_path"
        if [[ ! -f "$so_file" ]]; then
            echo "ERROR: Specified file '$so_path' not found in build dir" >&2
            exit 1
        fi
    else
        # Find first .so
        so_file=$(find . -name "*.so" | head -n1)
        if [[ -z "$so_file" ]]; then
            echo "ERROR: No .so found for $repo_name" >&2
            exit 1
        fi
    fi

    # Copy to Neovim
    cp "$so_file" "$HOME/.local/share/nvim/site/parser/$output_name"
    cd "$BUILD_DIR"
    rm -rf "$repo_name"
}

build_parser "https://github.com/tree-sitter/tree-sitter-cpp"            "cpp.so"
build_parser "https://github.com/tree-sitter/tree-sitter-c-sharp"        "c_sharp.so"
build_parser "https://github.com/tree-sitter/tree-sitter-java"           "java.so"
build_parser "https://github.com/tree-sitter/tree-sitter-python"         "python.so"
build_parser "https://github.com/tree-sitter/tree-sitter-go"             "go.so"
build_parser "https://github.com/tree-sitter/tree-sitter-typescript"     "typescript.so"   "tree-sitter-typescript/libtree-sitter-typescript.so"
build_parser "https://github.com/tree-sitter/tree-sitter-typescript"     "tsx.so"   "tree-sitter-tsx/libtree-sitter-tsx.so"
build_parser "https://github.com/tree-sitter/tree-sitter-html"           "html.so"
build_parser "https://github.com/tree-sitter/tree-sitter-css"            "css.so"
build_parser "https://github.com/tree-sitter/tree-sitter-json"           "json.so"
