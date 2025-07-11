#!/bin/bash

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

# 42BleachClean - Hybrid Cleaner for 42/1337 Students
# Author: Youssef Mazini
# LinkedIn: https://www.linkedin.com/in/youssef-mazini/
# GitHub: https://github.com/yomazini/42BleachClean
# Compatible with both Linux and macOS

#++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++#

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
BLINK='\033[5m'


spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='⠋⠙⠹⠸⠼⠴⠦⠧⠇⠏'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

progress_bar() {
    local duration=$1
    local width=50
    local progress=0
    local filled=0

    while [ $progress -le $duration ]; do
        filled=$((progress * width / duration))
        printf "\r${CYAN}["
        for ((i=0; i<filled; i++)); do printf "█"; done
        for ((i=filled; i<width; i++)); do printf "░"; done
        printf "] %d%%${RESET}" $((progress * 100 / duration))
        sleep 0.1
        ((progress++))
    done
    echo
}

animate_banner_line() {
    local line="$1"
    local delay=0.000002

    for ((i=0; i<${#line}; i++)); do
        printf "%s" "${line:$i:1}"
        sleep $delay
    done
    echo
} 

# OS detection

detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        echo "macOS"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        echo "Linux"
    else
        echo "Unknown"
    fi
}

show_header() {
    clear
    echo -e "${PURPLE}${BOLD}"
    
    local banner_lines=(
        "████████████████████████████████████████████████████████████████████████"
        "██                                                                    ██"
        "██  ██████╗ ██╗     ███████╗ █████╗  ██████╗██╗  ██╗                  ██"
        "██  ██╔══██╗██║     ██╔════╝██╔══██╗██╔════╝██║  ██║                  ██"
        "██  ██████╔╝██║     █████╗  ███████║██║     ███████║                  ██"
        "██  ██╔══██╗██║     ██╔══╝  ██╔══██║██║     ██╔══██║                  ██"
        "██  ██████╔╝███████╗███████╗██║  ██║╚██████╗██║  ██║                  ██"
        "██  ╚═════╝ ╚══════╝╚══════╝╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝                  ██"
        "██                                                                    ██"
        "██   ██████╗██╗     ███████╗ █████╗ ███╗   ██╗███████╗██████╗         ██"
        "██  ██╔════╝██║     ██╔════╝██╔══██╗████╗  ██║██╔════╝██╔══██╗        ██"
        "██  ██║     ██║     █████╗  ███████║██╔██╗ ██║█████╗  ██████╔╝        ██"
        "██  ██║     ██║     ██╔══╝  ██╔══██║██║╚██╗██║██╔══╝  ██╔══██╗        ██"
        "██  ╚██████╗███████╗███████╗██║  ██║██║ ╚████║███████╗██║  ██║        ██"
        "██   ╚═════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝╚══════╝╚═╝  ╚═╝        ██"
        "██                                                                    ██"
        "████████████████████████████████████████████████████████████████████████"
    )
    
    for line in "${banner_lines[@]}"; do
        animate_banner_line "$line"
    done
    
    echo -e "${RESET}"
    
    echo -e "${YELLOW}✨${CYAN}${BOLD} The Ultimate System Cleaner ${YELLOW}✨${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
    
    # //TODO: Detect and display OS for user validtion 
    OS=$(detect_os)
    echo -e "${WHITE}👋 Hello ${BOLD}${YELLOW}$USER${RESET}${WHITE}! Welcome to BLEACH CLEANER${RESET}"
    echo -e "${BLUE}🖥️  Operating System: ${BOLD}$OS${RESET}"
    echo
    
    # Show curr disk usage
	# curl -L https://github.com/Canop/dysk/releases/download/v2.10.1/dysk_2.10.1.zip 
    
	if [[ "$OS" == "macOS" ]]; then
        disk_info=$(df -h "$HOME" | tail -1)
        total=$(echo $disk_info | awk '{print $2}')
        used=$(echo $disk_info | awk '{print $3}')
        available=$(echo $disk_info | awk '{print $4}')
        usage_percent=$(echo $disk_info | awk '{print $5}')
    else
        disk_info=$(df -h "$HOME" | tail -1)
        total=$(echo $disk_info | awk '{print $2}')
        used=$(echo $disk_info | awk '{print $3}')
        available=$(echo $disk_info | awk '{print $4}')
        usage_percent=$(echo $disk_info | awk '{print $5}')
    fi
    
    echo -e "${GREEN}💾 Current Disk Usage for $HOME:${RESET}"
    echo -e "   ${BOLD}Total:${RESET} $total | ${BOLD}Used:${RESET} $used | ${BOLD}Available:${RESET} $available | ${BOLD}Usage:${RESET} $usage_percent"
    echo
    
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${PURPLE}🔗 LinkedIn: ${BOLD}https://www.linkedin.com/in/youssef-mazini/${RESET}"
    echo -e "${PURPLE}📧 GitHub: ${BOLD}https://github.com/yomazini/42BleachClean${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
}

show_help() {
    echo -e "${CYAN}${BOLD}📖 42BleachClean Help & Usage Guide${RESET}"
    echo
    echo -e "${WHITE}${BOLD}USAGE:${RESET}"
    echo -e "  ${GREEN}bleachclean${RESET}                    🧹 Run normal cleaning process"
    echo -e "  ${GREEN}bleachclean update${RESET}             🔄 Update to latest version"
    echo -e "  ${GREEN}bleachclean --help${RESET}             📚 Show this help message"
    echo -e "  ${GREEN}bleachclean --deep${RESET}             🕳️  Deep clean with file analysis"
    echo -e "  ${GREEN}bleachclean --quiet${RESET}            🤫 Run in quiet mode"
    echo -e "  ${GREEN}bleachclean --preview${RESET}          👀 Preview what will be cleaned"
    echo
    echo -e "${WHITE}${BOLD}FEATURES:${RESET}"
    echo -e "  ✨ ${CYAN}Cross-platform support${RESET} (macOS & Linux)"
    echo -e "  🚀 ${CYAN}Intelligent cache detection${RESET}"
    echo -e "  🎯 ${CYAN}42/1337 specific optimizations${RESET}"
    echo -e "  📊 ${CYAN}Detailed storage analysis${RESET}"
    echo -e "  🔍 ${CYAN}Large file detection (>42MB)${RESET}"
    echo -e "  🗑️  ${CYAN}Duplicate file removal${RESET}"
    echo -e "  🎨 ${CYAN}Beautiful progress indicators${RESET}"
    echo
    echo -e "${WHITE}${BOLD}EXAMPLES:${RESET}"
    echo -e "  ${DIM}# Basic cleaning${RESET}"
    echo -e "  ${YELLOW}$ bleachclean${RESET}"
    echo
    echo -e "  ${DIM}# Update the script${RESET}"
    echo -e "  ${YELLOW}$ bleachclean update${RESET}"
    echo
    echo -e "  ${DIM}# Deep clean with file analysis${RESET}"
    echo -e "  ${YELLOW}$ bleachclean --deep${RESET}"
    echo
    echo -e "${RED}⚠️  ${BOLD}IMPORTANT:${RESET} ${RED}This script is designed for 42/1337 students without sudo privileges${RESET}"
    echo
}

update_script() {
    echo -e "${YELLOW}🔄 Checking for updates...${RESET}"
    
    temp_dir="/tmp/42bleachclean_update_$$"
    
    if ! git clone --quiet https://github.com/yomazini/42BleachClean.git "$temp_dir" &>/dev/null; then
        echo -e "${RED}❌ Failed to check for updates. Please check your internet connection.${RESET}"
        exit 1
    fi
    
    if [ "" == "$(diff "$HOME/bleachclean.sh" "$temp_dir/bleachclean.sh" 2>/dev/null)" ]; then
        echo -e "${GREEN}✅ You already have the latest version!${RESET}"
        rm -rf "$temp_dir"
        exit 0
    fi
    
    cp -f "$temp_dir/bleachclean.sh" "$HOME/" &>/dev/null
    rm -rf "$temp_dir" &>/dev/null
    chmod +x "$HOME/bleachclean.sh"
    
    echo -e "${GREEN}🎉 Successfully updated to the latest version!${RESET}"
    exit 0
}

get_dir_size() {
    local dir="$1"
    if [[ -d "$dir" ]]; then
        if [[ "$OS" == "macOS" ]]; then
            du -sk "$dir" 2>/dev/null | awk '{print $1}'
        else
            du -sk "$dir" 2>/dev/null | awk '{print $1}'
        fi
    else
        echo "0"
    fi
}

clean_system() {
    local total_saved=0
    local preview_mode=${1:-false}
    
    echo -e "${CYAN}🧹 ${BOLD}Starting System Cleanup...${RESET}"
    echo
    
    declare -a clean_targets_macos=(
        "$HOME/Library/Application Support/BraveSoftware/Brave-Browser/Crashpad/completed/*"
        "$HOME/Library/Application Support/Spotify/PersistentCache/*"
        "$HOME/Library/Application Support/Chromium/*/File System"
        "$HOME/Library/*.42*"
        "$HOME/Library/Application Support/Google/Chrome/*/File System"
        "$HOME/Library/Application Support/discord/Cache/*"
        "$HOME/Library/Application Support/Code/CachedData/*"
        "$HOME/Library/Application Support/discord/Code Cache/js*"
        "$HOME/.zcompdump*"
        "$HOME/Library/Application Support/BraveSoftware/Brave-Browser/*/File System"
        "$HOME/.Trash/*"
        "$HOME/Library/Caches/*"
        "$HOME/Library/Application Support/Code/User/workspaceStorage/*"
        "$HOME/*.42*"
        "$HOME/Library/Application Support/discord/Crashpad/completed/*"
        "$HOME/Library/Application Support/Code/Cache/*"
        "$HOME/Desktop/**/*/.DS_Store"
        "$HOME/Library/Application Support/Code/Crashpad/completed/*"
        "$HOME/Library/Application Support/Google/Chrome/*/Service Worker/CacheStorage/*"
        "$HOME/Library/Application Support/Google/Chrome/*/Application Cache/*"
        "$HOME/Library/Application Support/Caches/*"
        "$HOME/Library/Application Support/Slack/Service Worker/CacheStorage/*"
        "$HOME/Library/Application Support/Slack/Cache/*"
        "$HOME/.cocoapods.42_cache_bak*"
        "$HOME/Library/Application Support/Google/Chrome/Crashpad/completed/*"
        "$HOME/Library/Application Support/BraveSoftware/Brave-Browser/*/Service Worker/CacheStorage/*"
        "$HOME/Library/Application Support/BraveSoftware/Brave-Browser/*/Application Cache/*"
    )
    
    declare -a clean_targets_linux=(
        "$HOME/.var/app/com.discordapp.Discord/config/discord/Cache/*"
        "$HOME/.var/app/com.google.Chrome/config/google-chrome/*/Service Worker/ScriptCache/*"
        "$HOME/.var/app/com.google.Chrome/config/google-chrome/*/Service Worker/CacheStorage/*"
        "$HOME/.var/app/org.mozilla.firefox/cache/*"
        "$HOME/.var/app/com.spotify.Client/cache/*"
        "$HOME/.var/app/com.visualstudio.code/config/Code/Cache/*"
        "$HOME/.var/app/*/cache/*"
        "$HOME/.var/app/com.visualstudio.code/config/Code/CachedData/*"
        "$HOME/.var/app/com.visualstudio.code/config/Code/CachedExtensionVSIXs/*"
        "$HOME/.cache/*"
		#"ymazini/.localshit/bin/shitty_devops_scripts/Cch/*"
        "$HOME/.var/app/com.discordapp.Discord/cache/*"
        "$HOME/.var/app/com.google.Chrome/config/google-chrome/*/File System/*"
		 #"ymazini/.localshit/bin/serp/logs/*"
        "$HOME/.bun/install/cache/*"
        "$HOME/.var/app/com.google.Chrome/cache/*"
        "$HOME/.npm/_cacache/*"	
		 #"ymazini/.localshit/bin/iptv/logs/*"
        "$HOME/.local/share/Trash/*"
        "$HOME/.var/app/com.google.Chrome/config/google-chrome/extensions_crx_cache/*"
        "$HOME/.var/app/com.google.Chrome/config/google-chrome/component_crx_cache/*"
        "$HOME/.var/app/com.visualstudio.code/cache/*"
    )
    
    if [[ "$OS" == "macOS" ]]; then
        clean_targets=("${clean_targets_macos[@]}")
    else
        clean_targets=("${clean_targets_linux[@]}")
    fi
    
    local total_items=${#clean_targets[@]}
    local current_item=0
    
    for target in "${clean_targets[@]}"; do
        current_item=$((current_item + 1))
        
        shopt -s nullglob
        expanded_paths=($target)
        shopt -u nullglob
        
        if [ ${#expanded_paths[@]} -gt 0 ]; then
            for path in "${expanded_paths[@]}"; do
                if [[ -e "$path" ]]; then
                    size=$(get_dir_size "$path")
                    
                    if [[ $size -gt 0 ]]; then
                        total_saved=$((total_saved + size))
                        
                        #  human readable
                        if [[ $size -lt 1024 ]]; then
                            size_display="${size}KB"
                        elif [[ $size -lt 1048576 ]]; then
                            size_display="$((size / 1024))MB"
                        else
                            size_display="$((size / 1048576))GB"
                        fi
                        
                        if [[ "$preview_mode" == "true" ]]; then
                            echo -e "  ${YELLOW}📁 Would clean:${RESET} $(basename "$path") (${size_display})"
                        else
                            echo -e "  ${GREEN}🗑️  Cleaning:${RESET} $(basename "$path") (${size_display})"
                            rm -rf "$path" &>/dev/null
                        fi
                    fi
                fi
            done
        fi
        
        local progress=$((current_item * 100 / total_items))
        printf "\r${CYAN}Progress: [%-20s] %d%% (%d/%d)${RESET}" \
               "$(printf '#%.0s' $(seq 1 $((progress / 5))))" \
               "$progress" "$current_item" "$total_items"
    done
    
    echo -e "\n"
    
    if [[ $total_saved -lt 1024 ]]; then
        saved_display="${total_saved}KB"
    elif [[ $total_saved -lt 1048576 ]]; then
        saved_display="$((total_saved / 1024))MB"
    else
        saved_display="$((total_saved / 1048576))GB"
    fi
    
    if [[ "$preview_mode" == "true" ]]; then
        echo -e "${YELLOW}📊 Preview Complete! Would save approximately: ${BOLD}$saved_display${RESET}"
    else
        echo -e "${GREEN}✅ System cleanup complete! Saved: ${BOLD}$saved_display${RESET}"
    fi
    
    echo "$total_saved"
}

find_large_files() {
    echo -e "${PURPLE}🔍 Scanning for large files (>42MB) not used in the last week...${RESET}"
    echo
    
    local large_files=()
    
    local search_paths=(
        "$HOME/Documents"
        "$HOME/Pictures"
        "$HOME/Movies"
        "$HOME/Music"
        "$HOME/Library"
        "$HOME/.local" 
        "$HOME/.config"
        "$HOME/goinfre"
    )
    
    for search_path in "${search_paths[@]}"; do
        if [[ -d "$search_path" ]]; then
            echo -e "${DIM}Scanning: $search_path${RESET}"
            
            while IFS= read -r -d '' file; do
                large_files+=("$file")
            done < <(find "$search_path" -type f -size +41M -atime +7 -print0 2>/dev/null)
        fi
    done
    
    if [[ ${#large_files[@]} -eq 0 ]]; then
        echo -e "${GREEN}✅ No large unused files found!${RESET}"
        return
    fi
    
    echo -e "${YELLOW}📋 Found ${#large_files[@]} large unused files:${RESET}"
    echo
    
    for file in "${large_files[@]}"; do
        if [[ -f "$file" ]]; then
            size=$(du -h "$file" 2>/dev/null | cut -f1)
            last_access=$(stat -c %x "$file" 2>/dev/null || stat -f %Sa "$file" 2>/dev/null)
            echo -e "  ${CYAN}📄 ${file}${RESET}"
            echo -e "     ${DIM}Size: $size | Last accessed: $last_access${RESET}"
        fi
    done
    
    echo
    handle_file_deletion "${large_files[@]}"
}

find_duplicates() {
    echo -e "${PURPLE}🔍 Scanning for duplicate files...${RESET}"
    echo
    
    declare -A file_hashes
    local duplicates=()
    
    # Search in common directories
    local search_paths=(
        "$HOME/Music"
        "$HOME/Documents"
        "$HOME/Movies"
        "$HOME/Pictures"
    )
    
    for search_path in "${search_paths[@]}"; do
        if [[ -d "$search_path" ]]; then
            echo -e "${DIM}Scanning for duplicates in: $search_path${RESET}"
            
            while IFS= read -r -d '' file; do
                if [[ -f "$file" ]]; then
                    basename_file=$(basename "$file")
                    if [[ "$basename_file" =~ \([0-9]+\)$ ]] || [[ "$basename_file" =~ \ copy$ ]] || [[ "$basename_file" =~ \ Copy$ ]]; then
                        duplicates+=("$file")
                    fi
                fi
            done < <(find "$search_path" -type f -print0 2>/dev/null)
        fi
    done
    
    if [[ ${#duplicates[@]} -eq 0 ]]; then
        echo -e "${GREEN}✅ No obvious duplicates found!${RESET}"
        return
    fi
    
    echo -e "${YELLOW}📋 Found ${#duplicates[@]} potential duplicates:${RESET}"
    echo
    
    for file in "${duplicates[@]}"; do
        if [[ -f "$file" ]]; then
            size=$(du -h "$file" 2>/dev/null | cut -f1)
            echo -e "  ${CYAN}📄 ${file}${RESET} ${DIM}($size)${RESET}"
        fi
    done
    
    echo
    handle_file_deletion "${duplicates[@]}"
}

handle_file_deletion() {
    local files=("$@")
    local total_files=${#files[@]}
    
    if [[ $total_files -eq 0 ]]; then
        return
    fi
    
    local prompts=(
		"Are_you_absolutely_sure_you_want_to_delete_these_files?"
		"Double-checking:_Are_you_certain_about_deleting_these_files?"
		"Final_confirmation:_Should_I_really_delete_these_files?"
		"Last_chance_to_reconsider._Delete_these_files?"
		"Are_you_100%_confident_about_removing_these_files?"
		"This_will_permanently_remove_the_files._Continue?"
		"Wax_Mt2ark_A3chiri,_Ndo5lo_3liha_?_"
		"Confirm_deletion_of_the_selected_files?"
		"Ready_to_permanently_delete_these_files?"
    )
    
    echo -e "${YELLOW}⚠️  You have two options:${RESET}"
    echo -e "  ${GREEN}[1]${RESET} Review and delete files one by one"
    echo -e "  ${GREEN}[2]${RESET} Batch delete all files (requires 3 confirmations)"
    echo -e "  ${GREEN}[3]${RESET} Exit without deleting anything"
    echo
    
    read -p "Choose an option [1-3]: " choice
    
    case $choice in
        1)
            local deleted_count=0
            local saved_space=0
            
            for file in "${files[@]}"; do
                if [[ -f "$file" ]]; then
                    size_kb=$(du -k "$file" 2>/dev/null | cut -f1)
                    size_human=$(du -h "$file" 2>/dev/null | cut -f1)
                    
                    echo
                    echo -e "${CYAN}📄 File: ${BOLD}$file${RESET}"
                    echo -e "${DIM}   Size: $size_human${RESET}"
                    
                    # 3 random prompts
                    local random_prompts=()
                    for i in {1..3}; do
                        random_prompts+=(${prompts[$RANDOM % ${#prompts[@]}]})
                    done
                    
                    local confirmed=0
                    for prompt in "${random_prompts[@]}"; do
                        echo -e "${YELLOW}$prompt${RESET}"
                        read -p "Type 'y', 'Y', or 'yes': " answer
                        # //TODO: need to be parsed 
                        if [[ "$answer" =~ ^[Yy]$|^[Yy][Ee][Ss]$ ]]; then
                            ((confirmed++))
                        else
                            break
                        fi
                    done
                    
                    if [[ $confirmed -eq 3 ]]; then
                        rm -f "$file" &>/dev/null
                        if [[ $? -eq 0 ]]; then
                            echo -e "${GREEN}✅ Deleted successfully${RESET}"
                            ((deleted_count++))
                            saved_space=$((saved_space + size_kb))
                        else
                            echo -e "${RED}❌ Failed to delete${RESET}"
                        fi
                    else
                        echo -e "${BLUE}⏭️  Skipped${RESET}"
                    fi
                fi
            done
            
            echo
            echo -e "${GREEN}🎉 Deleted $deleted_count files, saved $(( saved_space / 1024 ))MB${RESET}"
            ;;
            
        2)
            # Batch deletion
            echo
            echo -e "${RED}${BOLD}⚠️  BATCH DELETION MODE${RESET}"
            echo -e "${DIM}This will delete ALL $total_files files listed above${RESET}"
            echo
            
            # Calculate total size
            local total_size=0
            for file in "${files[@]}"; do
                if [[ -f "$file" ]]; then
                    size_kb=$(du -k "$file" 2>/dev/null | cut -f1)
                    total_size=$((total_size + size_kb))
                fi
            done
            
            echo -e "${YELLOW}Total space to be freed: $(( total_size / 1024 ))MB${RESET}"
            echo
            
            # usr confirmations
            local random_prompts=()
            for i in {1..3}; do
                random_prompts+=(${prompts[$RANDOM % ${#prompts[@]}]})
            done
            
            local confirmed=0
            for prompt in "${random_prompts[@]}"; do
                echo -e "${RED}$prompt${RESET}"
                read -p "Type 'y', 'Y', or 'yes': " answer
                
                if [[ "$answer" =~ ^[Yy]$|^[Yy][Ee][Ss]$ ]]; then
                    ((confirmed++))
                else
                    echo -e "${BLUE}❌ Batch deletion cancelled${RESET}"
                    return
                fi
            done
            
            if [[ $confirmed -eq 3 ]]; then
                echo
                echo -e "${RED}🗑️  Deleting all files...${RESET}"
                
                local deleted_count=0
                for file in "${files[@]}"; do
                    if [[ -f "$file" ]]; then
                        rm -f "$file" &>/dev/null
                        if [[ $? -eq 0 ]]; then
                            ((deleted_count++))
                        fi
                    fi
                done
                
                echo -e "${GREEN}🎉 Batch deletion complete! Deleted $deleted_count files, saved $(( total_size / 1024 ))MB${RESET}"
            fi
            ;;
            
        3)
            echo -e "${BLUE}👋 Exiting without deleting any files${RESET}"
            return
            ;;
            
        *)
            echo -e "${RED}❌ Invalid option. Exiting.${RESET}"
            return
            ;;
    esac
}

show_results() {
    local saved_before=$1
    local saved_cleaning=$2
    local saved_extra=$3
    
    echo
    echo -e "${PURPLE}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════════════════╗"
    echo "║                          🎉 CLEANUP COMPLETE! 🎉                    ║"
    echo "╚══════════════════════════════════════════════════════════════════════╝"
    echo -e "${RESET}"
    
    # Get current disk info
    if [[ "$OS" == "macOS" ]]; then
        disk_info=$(df -h "$HOME" | tail -1)
        available_after=$(echo $disk_info | awk '{print $4}')
        usage_after=$(echo $disk_info | awk '{print $5}')
    else
        disk_info=$(df -h "$HOME" | tail -1)
        available_after=$(echo $disk_info | awk '{print $4}')
        usage_after=$(echo $disk_info | awk '{print $5}')
    fi
    
    # Convert KB to human readable
    local cleaning_mb=$((saved_cleaning / 1024))
    local extra_mb=$((saved_extra / 1024))
    local total_mb=$((cleaning_mb + extra_mb))
    
    echo -e "${GREEN}💾 ${BOLD}Storage Results:${RESET}"
    echo -e "   ${WHITE}Available Space After Cleanup:${RESET} ${GREEN}${BOLD}$available_after${RESET}"
    echo -e "   ${WHITE}Current Usage:${RESET} $usage_after"
    echo
    echo -e "${CYAN}🧹 ${BOLD}Space Saved:${RESET}"
    echo -e "   ${WHITE}System Cleanup:${RESET} ${GREEN}${cleaning_mb}MB${RESET}"
    if [[ $extra_mb -gt 0 ]]; then
        echo -e "   ${WHITE}File Analysis:${RESET} ${GREEN}${extra_mb}MB${RESET}"
    fi
    echo -e "   ${YELLOW}${BOLD}Total Saved: ${total_mb}MB${RESET}"
    echo
    
    # Calculate percentage saved (Rough estimate)
    if [[ $total_mb -gt 0 ]]; then
        echo -e "${PURPLE}📊 ${BOLD}Performance Impact:${RESET}"
        if [[ $total_mb -lt 100 ]]; then
            echo -e "   ${GREEN}✨ Small but effective cleanup${RESET}"
        elif [[ $total_mb -lt 500 ]]; then
            echo -e "   ${YELLOW}🚀 Good space recovery${RESET}"
        elif [[ $total_mb -lt 1000 ]]; then
            echo -e "   ${CYAN}💪 Excellent cleanup results${RESET}"
        else
            echo -e "   ${PURPLE}🎯 Outstanding space optimization${RESET}"
        fi
        echo
    fi
    
    #  footer
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo -e "${CYAN}🐙 ${BOLD}Enjoyed 42BleachClean?${RESET}"
    echo -e "   ${WHITE}⭐ Star us on GITHUB:${RESET} ${BLUE}${BOLD}https://github.com/yomazini/42BleachClean${RESET}"
    echo -e "   ${WHITE}🐛 Report issues or contribute:${RESET} ${DIM}We welcome your feedback!${RESET}"
    echo -e "${DIM}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${RESET}"
    echo
}

main() {
    # Parse args

	#//TODO: Adding feature; ==> add atreboot {after x min} of kernal into prog 
	# ==> usr preference and usr select nmr of min {deamons | systmD units | cronjobs};
	# //TODO: each X hours run blc  ==> usr preference for this as well 
	# //TODO: adding logs file ==> deleted files || delete logs file {weekly} if not {usr specif it}

	case "${1:-}" in
        "update")
            show_header
            update_script
            ;;
        "--help"|"-h")
            show_header
            show_help
            exit 0
            ;;
        "--preview")
            show_header
            clean_system true
            exit 0
            ;;
        "--deep")
            deep_clean=true
            ;;
        "--quiet")
            quiet_mode=true
            ;;
        "")
            ;;
        *)
            echo -e "${RED}❌ Unknown option: $1${RESET}"
            echo -e "Use ${YELLOW}bleachclean --help${RESET} for usage information"
            exit 1
            ;;
    esac
    
    OS=$(detect_os)
    
    if [[ "$OS" == "Unknown" ]]; then
        echo -e "${RED}❌ Unsupported operating system${RESET}"
        echo -e "42BleachClean supports macOS and Linux only"
        exit 1
    fi
    
    if [[ "${quiet_mode:-false}" != "true" ]]; then
        show_header
        sleep 2
    fi
    
    saved_cleaning=$(clean_system false)
    
    if [[ "${quiet_mode:-false}" != "true" ]]; then
        echo
        echo -e "${PURPLE}🎯 ${BOLD}Advanced Cleanup Options${RESET}"
        echo
        
        echo -e "${YELLOW}🔍 Would you like to scan for large files (>42MB) not used in the last week?${RESET}"
        echo -e "   ${DIM}This will help you find potentially unnecessary large files${RESET}"
        
        while true; do
            read -p "Scan for large files? [y/N]: " yn
            case $yn in
                [Yy]*) 
                    find_large_files
                    saved_extra_large=${saved_extra_large:-0}
                    break 
                    ;;
                [Nn]*|"") 
                    saved_extra_large=0
                    break 
                    ;;
                *) 
                    echo -e "${RED}Please answer yes (y) or no (n)${RESET}" 
                    ;;
            esac
        done
        
        echo
        
        if [[ $saved_extra_large -eq 0 ]]; then
            echo -e "${YELLOW}🔍 Would you like to scan for duplicate files?${RESET}"
            echo -e "   ${DIM}This will find files with names like 'file (1).txt' or 'file copy.txt'${RESET}"
            
            while true; do
                read -p "Scan for duplicates? [y/N]: " yn
                case $yn in
                    [Yy]*) 
                        find_duplicates
                        saved_extra_duplicates=${saved_extra_duplicates:-0}
                        break 
                        ;;
                    [Nn]*|"") 
                        saved_extra_duplicates=0
                        break 
                        ;;
                    *) 
                        echo -e "${RED}Please answer yes (y) or no (n)${RESET}" 
                        ;;
                esac
            done
        fi
        
        total_extra_saved=$((${saved_extra_large:-0} + ${saved_extra_duplicates:-0}))
        
        show_results 0 "${saved_cleaning:-0}" "${total_extra_saved:-0}"
    else
        # show basic results //TODO: need to be enhanced
        if [[ $saved_cleaning -gt 0 ]]; then
            saved_mb=$((saved_cleaning / 1024))
            echo "Cleanup complete: ${saved_mb}MB freed"
        fi
    fi
}

trap 'echo -e "\n${YELLOW}⚠️  Cleanup interrupted by user${RESET}"; exit 130' INT

create_installer() {
    cat << 'EOF' > "$HOME/install_bleachclean.sh"
#!/bin/bash
# 42BleachClean Installer 

echo -e "\n\033[1;36m🚀 Installing 42BleachClean...\033[0m\n"

# Copy script to home directory
cp "$(dirname "$0")/bleachclean.sh" "$HOME/"
chmod +x "$HOME/bleachclean.sh"

# Detect shell and add alias
shell_name=$(basename "$SHELL")
shell_rc="$HOME/.${shell_name}rc"

# Remove old aliases if they exist
sed -i.bak '/alias.*bleachclean/d' "$shell_rc" 2>/dev/null

# Add new alias

echo "alias bleachclean='bash $HOME/bleachclean.sh'" >> "$shell_rc"
echo "alias bleachclean='bash $HOME/bleachclean.sh'" >> ~/.bashrc
echo "alias blc='bash $HOME/bleachclean.sh'" >> "$shell_rc"
echo "alias blc='bash $HOME/bleachclean.sh'" >> ~/.bashrc

echo -e "\033[1;32m✅ Installation complete!\033[0m"
echo -e "\033[1;33m📝 Please run: source $shell_rc\033[0m"
echo -e "\033[1;33m🧹 Then use: bleachclean\033[0m\n"
EOF
    
	#chmod 777 "$HOME/install_bleachclean.sh"
	#chmod 777 "$HOME/logs_creator.sh"

    chmod +x "$HOME/install_bleachclean.sh"

}

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then

    main "$@"
fi
