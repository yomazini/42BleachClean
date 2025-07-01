#!/bin/bash
# 42BleachClean Installer
# The Ultimate Hybrid Cleaner for 42/1337 Students

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

# Animated header
show_install_header() {
    clear
    echo -e "${CYAN}${BOLD}"
    echo "████████████████████████████████████████████████████████████████████████"
    echo "██                                                                    ██"
    echo "██      ██████╗ ██╗     ███████╗ █████╗  ██████╗██╗  ██╗              ██"
    echo "██      ██╔══██╗██║     ██╔════╝██╔══██╗██╔════╝██║  ██║              ██"
    echo "██      ██████╔╝██║     █████╗  ███████║██║     ███████║              ██"
    echo "██      ██╔══██╗██║     ██╔══╝  ██╔══██║██║     ██╔══██║              ██"
    echo "██      ██████╔╝███████╗███████╗██║  ██║╚██████╗██║  ██║              ██"
    echo "██      ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝              ██"
    echo "██                                                                    ██"
    echo "██     ██╗███╗   ██╗███████╗████████╗ █████╗ ██╗     ██╗              ██"
    echo "██     ██║████╗  ██║██╔════╝╚══██╔══╝██╔══██╗██║     ██║              ██"
    echo "██     ██║██╔██╗ ██║███████╗   ██║   ███████║██║     ██║              ██"
    echo "██     ██║██║╚██╗██║╚════██║   ██║   ██╔══██║██║     ██║              ██"
    echo "██     ██║██║ ╚████║███████║   ██║   ██║  ██║███████╗███████          ██"
    echo "██     ╚═╝╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚═╝  ╚═╝╚══════╝╚══════╝         ██"
    echo "██                                                                    ██"
    echo "████████████████████████████████████████████████████████████████████████"
    echo -e "${RESET}"
    
    echo -e "${WHITE}${BOLD}🚀 42BleachClean Installer${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${CYAN}The Ultimate Hybrid Cleaner for 42/1337 Students${RESET}"
    echo -e "${PURPLE}✨ Cross-platform support (macOS & Linux)${RESET}"
    echo -e "${PURPLE}🎯 Optimized for 42/1337 environments${RESET}"
    echo -e "${PURPLE}🧹 Advanced cleaning algorithms${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
}

# Progress animation
progress_animation() {
    local duration=$1
    local message=$2
    local width=50
    local progress=0
    
    echo -e "${CYAN}$message${RESET}"
    
    while [ $progress -le $duration ]; do
        local filled=$((progress * width / duration))
        printf "\r${YELLOW}["
        for ((i=0; i<filled; i++)); do printf "█"; done
        for ((i=filled; i<width; i++)); do printf "░"; done
        printf "] %d%%${RESET}" $((progress * 100 / duration))
        sleep 0.1
        ((progress++))
    done
    echo
}

# Detect OS
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Linux"
    else
        echo "Unknown"
    fi
}

# Check requirements
check_requirements() {
    echo -e "${BLUE}🔍 Checking system requirements...${RESET}"
    
    OS=$(detect_os)
    
    if [[ "$OS" == "Unknown" ]]; then
        echo -e "${RED}❌ Unsupported operating system${RESET}"
        echo -e "42BleachClean supports macOS and Linux only"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Operating System: $OS${RESET}"
    
    # Check if we have write permissions to home directory
    if [[ ! -w "$HOME" ]]; then
        echo -e "${RED}❌ No write permission to home directory${RESET}"
        exit 1
    fi
    
    echo -e "${GREEN}✅ Home directory writable${RESET}"
    
    # Check for required commands
    local required_commands=("find" "du" "rm" "cp" "chmod")
    for cmd in "${required_commands[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo -e "${RED}❌ Required command not found: $cmd${RESET}"
            exit 1
        fi
    done
    
    echo -e "${GREEN}✅ All required commands available${RESET}"
    echo
}

# Installation confirmation
confirm_installation() {
    echo -e "${YELLOW}${BOLD}📋 Installation Overview:${RESET}"
    echo
    echo -e "${WHITE}42BleachClean will:${RESET}"
    echo -e "  ${CYAN}🧹 Clean caches and temporary files${RESET}"
    echo -e "  ${CYAN}🗑️  Remove trash and unused data${RESET}"
    echo -e "  ${CYAN}📱 Clean app-specific caches (VS Code, Chrome, Discord, etc.)${RESET}"
    echo -e "  ${CYAN}🔍 Analyze large and duplicate files${RESET}"
    echo -e "  ${CYAN}📊 Provide detailed cleanup reports${RESET}"
    echo
    echo -e "${YELLOW}${BOLD}⚠️  This tool will:${RESET}"
    echo -e "  ${DIM}• Install to your home directory${RESET}"
    echo -e "  ${DIM}• Add an alias to your shell configuration${RESET}"
    echo -e "  ${DIM}• Only clean user-owned files (no sudo required)${RESET}"
    echo -e "  ${DIM}• Work safely within 42/1337 environment constraints${RESET}"
    echo
    
    while true; do
        echo -e "${WHITE}${BOLD}Do you want to proceed with the installation?${RESET}"
        read -p "Type 'yes' to continue or 'no' to exit: " yn
        case $yn in
            [Yy]es|[Yy]) 
                break 
                ;;
            [Nn]o|[Nn]) 
                echo -e "${BLUE}👋 Installation cancelled by user${RESET}"
                exit 0 
                ;;
            *) 
                echo -e "${RED}Please answer 'yes' or 'no'${RESET}" 
                ;;
        esac
    done
}

# Perform installation
install_bleachclean() {
    echo -e "${CYAN}🚀 Starting installation...${RESET}"
    echo
    
    # Check if already installed
    if [[ -f "$HOME/bleachclean.sh" ]]; then
        echo -e "${YELLOW}⚠️  42BleachClean is already installed${RESET}"
        
        while true; do
            read -p "Do you want to update/reinstall? [y/N]: " yn
            case $yn in
                [Yy]*) 
                    echo -e "${BLUE}🔄 Updating existing installation...${RESET}"
                    break 
                    ;;
                [Nn]*|"") 
                    echo -e "${GREEN}✅ Keeping existing installation${RESET}"
                    echo -e "${CYAN}💡 Use 'bleachclean update' to get the latest version${RESET}"
                    exit 0 
                    ;;
                *) 
                    echo -e "${RED}Please answer yes (y) or no (n)${RESET}" 
                    ;;
            esac
        done
    fi
    
    # Copy main script
    if [[ -f "./bleachclean.sh" ]]; then
        progress_animation 20 "📁 Copying main script..."
        cp "./bleachclean.sh" "$HOME/"
        chmod +x "$HOME/bleachclean.sh"
        echo -e "${GREEN}✅ Main script installed${RESET}"
    else
        echo -e "${RED}❌ bleachclean.sh not found in current directory${RESET}"
        exit 1
    fi
    
    # Setup shell alias
    progress_animation 15 "🔧 Configuring shell alias..."
    
    shell_name=$(basename "$SHELL")
    shell_rc="$HOME/.${shell_name}rc"
    
    # Backup existing shell config
    if [[ -f "$shell_rc" ]]; then
        cp "$shell_rc" "${shell_rc}.42bleachclean.backup.$(date +%s)" 2>/dev/null
    fi
    
    # Remove old aliases
    if [[ -f "$shell_rc" ]]; then
        sed -i.tmp '/alias.*bleachclean/d' "$shell_rc" 2>/dev/null
        rm -f "${shell_rc}.tmp" 2>/dev/null
    fi
    
    # Add new alias
    echo "# 42BleachClean alias - Added by installer" >> "$shell_rc"
    echo "alias bleachclean='bash \$HOME/bleachclean.sh'" >> "$shell_rc"
    echo "alias bleachclean='bash \$HOME/bleachclean.sh'" >> ~/.bashrc
    
    echo -e "${GREEN}✅ Shell alias configured${RESET}"
    
    # Final verification
    progress_animation 10 "🔍 Verifying installation..."
    
    if [[ -f "$HOME/bleachclean.sh" ]] && grep -q "alias bleachclean" "$shell_rc" 2>/dev/null; then
        echo -e "${GREEN}✅ Installation verification successful${RESET}"
    else
        echo -e "${RED}❌ Installation verification failed${RESET}"
        exit 1
    fi
}

# Show completion message
show_completion() {
    echo
    echo -e "${GREEN}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                    🎉 INSTALLATION COMPLETE! 🎉                     ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    shell_name=$(basename "$SHELL")
    shell_rc="$HOME/.${shell_name}rc"
    
    echo -e "${CYAN}${BOLD}🚀 Next Steps:${RESET}"
    echo
    echo -e "${WHITE}1.${RESET} ${YELLOW}Reload your shell configuration:${RESET}"
    echo -e "   ${CYAN}source $shell_rc${RESET}"
    echo
    echo -e "${WHITE}2.${RESET} ${YELLOW}Start using 42BleachClean:${RESET}"
    echo -e "   ${CYAN}bleachclean${RESET}           ${DIM}# Run normal cleanup${RESET}"
    echo -e "   ${CYAN}bleachclean --help${RESET}    ${DIM}# Show help and options${RESET}"
    echo -e "   ${CYAN}bleachclean --deep${RESET}    ${DIM}# Deep clean with file analysis${RESET}"
    echo -e "   ${CYAN}bleachclean update${RESET}    ${DIM}# Update to latest version${RESET}"
    echo
    echo -e "${PURPLE}${BOLD}🌟 Pro Tips:${RESET}"
    echo -e "   ${DIM}• Run bleachclean regularly to keep your system optimized${RESET}"
    echo -e "   ${DIM}• Use --preview to see what will be cleaned before doing it${RESET}"
    echo -e "   ${DIM}• Check for updates periodically with 'bleachclean update'${RESET}"
    echo
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${BLUE}🐙 ${BOLD}Support & Contributions:${RESET}"
    echo -e "   ${WHITE}🔗 GitHub:${RESET} ${CYAN}https://github.com/yomazini/42BleachClean${RESET}"
    echo -e "   ${WHITE}🔗 LinkedIn:${RESET} ${CYAN}https://www.linkedin.com/in/youssef-mazini/${RESET}"
    echo -e "   ${WHITE}Issues:${RESET} ${DIM}Report bugs and request features${RESET}"
    echo -e "   ${WHITE}Stars:${RESET} ${YELLOW}⭐ Give us a star if you find it useful!${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
}

# Main installer function
main() {
    show_install_header
    sleep 1
    
    check_requirements
    sleep 1
    
    confirm_installation
    echo
    
    install_bleachclean
    echo
    
    show_completion
}

# Handle interruptions
trap 'echo -e "\n${YELLOW}⚠️  Installation interrupted by user${RESET}"; exit 130' INT

# Run installer
main "$@"

  
