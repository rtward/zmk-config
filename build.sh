rm -rf firmware
mkdir -p firmware
rm -rf build

podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v ~/Workspace/Personal/zmk/:/workspaces/ \
  -p 3000:3000 \
  zmk west init -l /workspaces/zmk-config/config

podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v ~/Workspace/Personal/zmk/:/workspaces/ \
  -p 3000:3000 \
  zmk west update 

podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v ~/Workspace/Personal/zmk/:/workspaces/ \
  -p 3000:3000 \
  zmk west build \
  -s ./app/ \
  -d "/workspaces/build" \
  -b "nice_nano_v2" \
  -- \
  -DSHIELD="settings_reset"

cp build/zephyr/zmk.uf2 firmware/reset.uf2

rm -rf build

podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v ~/Workspace/Personal/zmk/:/workspaces/ \
  -p 3000:3000 \
  zmk west build \
  -s ./app/ \
  -d "/workspaces/build" \
  -b "nice_nano_v2" \
  -S zmk-usb-logging \
  -S studio-rpc-usb-uart \
  -- \
  -DZMK_CONFIG=/workspaces/zmk-config/config \
  -DSHIELD="cosmos_dactyl_left" \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-config \
  -DCONFIG_ZMK_STUDIO=y \
  -DCONFIG_ZMK_POINTING=y

cp build/zephyr/zmk.uf2 firmware/cosmos_dactyl_left.uf2

rm -rf build

podman run -it --rm \
  --security-opt label=disable \
  --workdir /workspaces/zmk \
  -v ~/Workspace/Personal/zmk/:/workspaces/ \
  -p 3000:3000 \
  zmk west build \
  -s ./app/ \
  -d "/workspaces/build" \
  -b "nice_nano_v2" \
  -S zmk-usb-logging \
  -S studio-rpc-usb-uart \
  -- \
  -DZMK_CONFIG=/workspaces/zmk-config/config \
  -DSHIELD="cosmos_dactyl_right" \
  -DZMK_EXTRA_MODULES=/workspaces/zmk-config \
  -DCONFIG_ZMK_POINTING=y

cp build/zephyr/zmk.uf2 firmware/cosmos_dactyl_right.uf2
