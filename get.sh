#!/usr/bin/env bash
set -e
REPO="Lilrootcause/rootcause-install"
PKG="rootcause-customer.zip"
URL="https://github.com/$REPO/releases/latest/download/$PKG"
WORK="$HOME/rootcause-install"

GRN=$'\033[0;32m'; YLW=$'\033[1;33m'; RED=$'\033[0;31m'; DIM=$'\033[2m'; OFF=$'\033[0m'

echo
echo "${GRN}==> RootCause installer${OFF}"
echo "${DIM}    downloading latest package...${OFF}"

command -v unzip >/dev/null 2>&1 || { apt-get update -qq && apt-get install -y unzip >/dev/null 2>&1; }

mkdir -p "$WORK"; cd "$WORK"

if ! curl -fSL "$URL" -o "$PKG"; then
  echo "${RED}download failed. contact t.me/rootcauseteam${OFF}"; exit 1
fi

echo "${GRN}==> unpacking...${OFF}"
unzip -o "$PKG" >/dev/null
cd customer-pkg

for L in "$HOME/license.key" "$WORK/license.key"; do
  [ -f "$L" ] && cp "$L" ./license.key && echo "${GRN}==> found license.key${OFF}" && break
done

echo "${GRN}==> running installer...${OFF}"
echo
bash install.sh
