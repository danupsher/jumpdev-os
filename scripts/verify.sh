#!/usr/bin/env bash
# JumpDev OS Gate Verification Script
# Checks requirements for each gate

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

pass() { echo -e "  ${GREEN}PASS${NC} $1"; }
fail() { echo -e "  ${RED}FAIL${NC} $1"; }
skip() { echo -e "  ${YELLOW}SKIP${NC} $1"; }

GATE1_PASS=0
GATE1_FAIL=0
GATE2_PASS=0
GATE2_FAIL=0

# Helper to increment counters (avoids set -e issues with ((var++)) returning 1)
inc() { eval "$1=\$((\$1 + 1))"; }

echo "JumpDev OS Gate Verification"
echo "========================="
echo ""

# Gate 1: Foundation
echo "Gate 1: Foundation"
echo "------------------"

# Check profiledef.sh
if [[ -f "$PROJECT_DIR/archiso/profiledef.sh" ]]; then
    pass "profiledef.sh exists"
    inc GATE1_PASS
else
    fail "profiledef.sh missing"
    inc GATE1_FAIL
fi

# Check packages.x86_64
if [[ -f "$PROJECT_DIR/archiso/packages.x86_64" ]]; then
    PKG_COUNT=$(grep -v '^#' "$PROJECT_DIR/archiso/packages.x86_64" | grep -v '^$' | wc -l)
    pass "packages.x86_64 exists ($PKG_COUNT packages)"
    inc GATE1_PASS
else
    fail "packages.x86_64 missing"
    inc GATE1_FAIL
fi

# Check pacman.conf
if [[ -f "$PROJECT_DIR/archiso/pacman.conf" ]]; then
    pass "pacman.conf exists"
    inc GATE1_PASS
else
    fail "pacman.conf missing"
    inc GATE1_FAIL
fi

# Check for ISO
ISO_PATH=$(ls -t "$PROJECT_DIR/out"/*.iso 2>/dev/null | head -n1 || true)
if [[ -n "$ISO_PATH" ]]; then
    ISO_SIZE=$(du -h "$ISO_PATH" | cut -f1)
    pass "ISO exists: $(basename "$ISO_PATH") ($ISO_SIZE)"
    inc GATE1_PASS
else
    skip "No ISO built yet"
fi

echo ""

# Gate 2: Core Experience
echo "Gate 2: Core Experience"
echo "-----------------------"

# Check config directories
for config in hyprland waybar foot nvim zsh starship fuzzel; do
    if [[ -d "$PROJECT_DIR/configs/$config" ]] && [[ -n "$(ls -A "$PROJECT_DIR/configs/$config" 2>/dev/null)" ]]; then
        pass "$config config exists"
        inc GATE2_PASS
    else
        skip "$config config not yet created"
    fi
done

echo ""

# Summary
echo "Summary"
echo "-------"
echo "Gate 1: $GATE1_PASS passed, $GATE1_FAIL failed"
echo "Gate 2: $GATE2_PASS passed (configs pending)"
echo ""

if [[ $GATE1_FAIL -eq 0 ]] && [[ $GATE1_PASS -ge 3 ]]; then
    echo -e "${GREEN}Gate 1 requirements: READY TO BUILD${NC}"
else
    echo -e "${YELLOW}Gate 1 requirements: IN PROGRESS${NC}"
fi
