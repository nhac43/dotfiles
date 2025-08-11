# https://mise.jdx.dev/getting-started.html
if ! command -v mise &> /dev/null; then
    echo "mise not found. Installing..."
    curl https://mise.run | sh
    echo "eval \"\$(~/.local/bin/mise activate bash)\"" >> ~/.bashrc
fi
