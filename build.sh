podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk/app \
  -v ~/Workspace/Personal/zmk:/workspaces/zmk \
  -v ~/Workspace/Personal/zmk-config:/workspaces/zmk-config \
  -p 3000:3000 \
  zmk west build -b nice_nano -- -DSHIELD=cosmos-dactyl_left -DZMK_CONFIG="/workspaces/zmk-config/config"
