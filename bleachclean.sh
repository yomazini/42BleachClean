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
    echo -e "${PURPLE}${BOLD}AUTOMATION (Personal Laptops Only):${RESET}"
    echo -e "  ${GREEN}bleachclean --setup-auto${RESET}       ⏰ Setup automatic cleaning"
    echo -e "  ${GREEN}bleachclean --disable-auto${RESET}     🛑 Disable automatic cleaning"
    echo -e "  ${GREEN}bleachclean --setup-notify${RESET}     🔔 Enable disk space notifications"
    echo -e "  ${GREEN}bleachclean --disable-notify${RESET}   🔕 Disable notifications"
    echo -e "  ${GREEN}bleachclean --status${RESET}           📊 Show automation status"
    echo
    echo -e "${WHITE}${BOLD}FEATURES:${RESET}"
    echo -e "  ✨ ${CYAN}Cross-platform support${RESET} (macOS & Linux)"
    echo -e "  🚀 ${CYAN}Intelligent cache detection${RESET}"
    echo -e "  🎯 ${CYAN}42/1337 specific optimizations${RESET}"
    echo -e "  📊 ${CYAN}Detailed storage analysis${RESET}"
    echo -e "  🔍 ${CYAN}Advanced duplicate file detection${RESET}"
    echo -e "  🤖 ${CYAN}Smart environment detection${RESET}"
    echo -e "  ⏰ ${CYAN}Automatic cleaning (personal laptops)${RESET}"
    echo -e "  🔔 ${CYAN}Low disk space notifications${RESET}"
    echo
    echo -e "${WHITE}${BOLD}AUTOMATION DETAILS:${RESET}"
    echo -e "${YELLOW}🔒 Safety First:${RESET}"
    echo -e "  ${DIM}• Auto-cleaning only removes safe cache files${RESET}"
    echo -e "  ${DIM}• Never touches personal documents, pictures, or projects${RESET}"
    echo -e "  ${DIM}• Only enabled on personal laptops (not school computers)${RESET}"
    echo
    echo -e "${YELLOW}🔔 Notifications:${RESET}"
    echo -e "  ${DIM}• Alerts when disk space drops below 500MB${RESET}"
    echo -e "  ${DIM}• Uses system notifications (macOS/Linux)${RESET}"
    echo -e "  ${DIM}• Requires user permission during setup${RESET}"
    echo
    echo -e "${WHITE}${BOLD}EXAMPLES:${RESET}"
    echo -e "  ${DIM}# Basic cleaning${RESET}"
    echo -e "  ${YELLOW}$ bleachclean${RESET}"
    echo
    echo -e "  ${DIM}# Setup daily auto-cleaning (personal laptops only)${RESET}"
    echo -e "  ${YELLOW}$ bleachclean --setup-auto${RESET}"
    echo
    echo -e "  ${DIM}# Enable low disk space notifications${RESET}"
    echo -e "  ${YELLOW}$ bleachclean --setup-notify${RESET}"
    echo
    echo -e "  ${DIM}# Check automation status${RESET}"
    echo -e "  ${YELLOW}$ bleachclean --status${RESET}"
    echo
    echo -e "${RED}⚠️  ${BOLD}IMPORTANT:${RESET}"
    echo -e "  ${RED}• Designed for 42/1337 students (no sudo required)${RESET}"
    echo -e "  ${RED}• Auto-features only available on personal laptops${RESET}"
    echo -e "  ${RED}• All automation requires explicit user consent${RESET}"
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
#safer for nvim cachee

# if nt using nvim this is better 
	
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
           find "$HOME/.cache" -mindepth 1 -maxdepth 1 -not -name "nvim" -exec rm -rf {} +
 
	   # "$HOME/.cache/*"
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
    echo -e "${PURPLE}🔍 Scanning for duplicate files using advanced detection...${RESET}"
    echo
    
    declare -A file_hashes
    declare -A size_groups
    local duplicates=()
    local processed=0
    local total_files=0
    
    # Search paths
    local search_paths=(
        "$HOME/Documents"
        "$HOME/Pictures" 
        "$HOME/Movies"
        "$HOME/Music"
        "$HOME/goinfre"
        #"$HOME/Desktop"
        "$HOME/Downloads"
    )
    
    echo -e "${CYAN}📊 Phase 1: Collecting files by size...${RESET}"
    
    # First pass: Group files by size (much faster than hashing everything)
    for search_path in "${search_paths[@]}"; do
        if [[ -d "$search_path" ]]; then
            echo -e "${DIM}Scanning: $(basename "$search_path")${RESET}"
            
            while IFS= read -r -d '' file; do
                if [[ -f "$file" ]]; then
                    # Get file size in bytes
                    if [[ "$OSTYPE" == "darwin"* ]]; then
                        size=$(stat -f%z "$file" 2>/dev/null)
                    else
                        size=$(stat -c%s "$file" 2>/dev/null)
                    fi
                    
                    if [[ -n "$size" && "$size" -gt 1024 ]]; then  # Only files > 1KB
                        if [[ -n "${size_groups[$size]}" ]]; then
                            size_groups[$size]="${size_groups[$size]}|$file"
                        else
                            size_groups[$size]="$file"
                        fi
                        ((total_files++))
                    fi
                fi
            done < <(find "$search_path" -type f -size +1k -print0 2>/dev/null)
        fi
    done
    
    if [[ $total_files -eq 0 ]]; then
        echo -e "${GREEN}✅ No files found to analyze!${RESET}"
        return
    fi
    
    echo -e "${CYAN}📊 Found $total_files files. Phase 2: Hash comparison...${RESET}"
    echo
    
    # Second pass: Only hash files that have the same size
    for size in "${!size_groups[@]}"; do
        IFS='|' read -ra files <<< "${size_groups[$size]}"
        
        if [[ ${#files[@]} -gt 1 ]]; then
            # Multiple files with same size - need to hash them
            echo -e "${DIM}Checking ${#files[@]} files of size $(( size / 1024 ))KB${RESET}"
            
            for file in "${files[@]}"; do
                if [[ -f "$file" ]]; then
                    ((processed++))
                    
                    # Progress indicator
                    if (( processed % 10 == 0 )); then
                        printf "\r${YELLOW}Processed: $processed/$total_files files${RESET}"
                    fi
                    
                    # Generate hash based on file size for performance
                    local hash=""
                    if [[ $size -lt 5242880 ]]; then
                        # Files < 5MB: Full MD5 hash
                        hash=$(md5sum "$file" 2>/dev/null | cut -d' ' -f1)
                    elif [[ $size -lt 52428800 ]]; then
                        # Files 5MB-50MB: Hash first and last 1MB
                        hash1=$(head -c 1048576 "$file" 2>/dev/null | md5sum | cut -d' ' -f1)
                        hash2=$(tail -c 1048576 "$file" 2>/dev/null | md5sum | cut -d' ' -f1)
                        hash="${hash1}_${hash2}_${size}"
                    else
                        # Large files >50MB: Sample-based hash
                        hash1=$(head -c 1048576 "$file" 2>/dev/null | md5sum | cut -d' ' -f1)
                        hash2=$(dd if="$file" bs=1048576 skip=$(( size / 2097152 )) count=1 2>/dev/null | md5sum | cut -d' ' -f1)
                        hash3=$(tail -c 1048576 "$file" 2>/dev/null | md5sum | cut -d' ' -f1)
                        hash="${hash1}_${hash2}_${hash3}_${size}"
                    fi
                    
                    if [[ -n "$hash" ]]; then
                        if [[ -n "${file_hashes[$hash]}" ]]; then
                            # Found duplicate!
                            duplicates+=("$file")
                            echo -e "\r${YELLOW}🔄 Duplicate found: $(basename "$file")${RESET}"
                        else
                            file_hashes[$hash]="$file"
                        fi
                    fi
                fi
            done
        fi
    done
    
    echo -e "\r${GREEN}✅ Analysis complete: $processed files processed${RESET}"
    echo
    
    if [[ ${#duplicates[@]} -eq 0 ]]; then
        echo -e "${GREEN}🎉 No duplicate files found! Your system is clean.${RESET}"
        return
    fi
    
    echo -e "${YELLOW}📋 Found ${BOLD}${#duplicates[@]}${RESET}${YELLOW} duplicate files:${RESET}"
    echo
    
    local total_duplicate_size=0
    
    for file in "${duplicates[@]}"; do
        if [[ -f "$file" ]]; then
            # Get file info
            if [[ "$OSTYPE" == "darwin"* ]]; then
                size_bytes=$(stat -f%z "$file" 2>/dev/null)
                modified=$(stat -f "%Sm" "$file" 2>/dev/null)
            else
                size_bytes=$(stat -c%s "$file" 2>/dev/null)
                modified=$(stat -c "%y" "$file" 2>/dev/null | cut -d' ' -f1)
            fi
            
            # Human readable size
            if [[ $size_bytes -lt 1024 ]]; then
                size_display="${size_bytes}B"
            elif [[ $size_bytes -lt 1048576 ]]; then
                size_display="$((size_bytes / 1024))KB"
            elif [[ $size_bytes -lt 1073741824 ]]; then
                size_display="$((size_bytes / 1048576))MB"
            else
                size_display="$((size_bytes / 1073741824))GB"
            fi
            
            total_duplicate_size=$((total_duplicate_size + size_bytes))
            
            echo -e "  ${CYAN}📄 $(basename "$file")${RESET}"
            echo -e "     ${DIM}Path: $file${RESET}"
            echo -e "     ${DIM}Size: $size_display | Modified: $modified${RESET}"
            echo
        fi
    done
    
    if [[ $total_duplicate_size -gt 0 ]]; then
        if [[ $total_duplicate_size -lt 1048576 ]]; then
            savings_display="$((total_duplicate_size / 1024))KB"
        elif [[ $total_duplicate_size -lt 1073741824 ]]; then
            savings_display="$((total_duplicate_size / 1048576))MB"
        else
            savings_display="$((total_duplicate_size / 1073741824))GB"
        fi
        
        echo -e "${PURPLE}💾 Potential space savings: ${BOLD}$savings_display${RESET}"
        echo
    fi
    
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



setup_auto_cleaning() {
    echo -e "${CYAN}🔄 Setting up automatic cleaning...${RESET}"
    echo
    
    echo -e "${YELLOW}⚠️  Auto-cleaning will ONLY remove safe cache files, not personal data${RESET}"
    echo -e "${DIM}   • Browser caches, temp files, .42* files${RESET}"
    echo -e "${DIM}   • NO personal documents, pictures, or project files${RESET}"
    echo
    
    echo -e "${WHITE}Choose auto-cleaning frequency:${RESET}"
    echo -e "  ${GREEN}[1]${RESET} Daily (recommended for heavy users)"
    echo -e "  ${GREEN}[2]${RESET} Every 3 days (balanced)"
    echo -e "  ${GREEN}[3]${RESET} Weekly (light cleaning)"
    echo -e "  ${GREEN}[4]${RESET} Disable auto-cleaning"
    echo
    
    while true; do
        read -p "Choose option [1-4]: " choice
        case $choice in
            1)
                cron_schedule="0 3 * * *"  # Daily 3 AM
                schedule_name="Daily"
                break
                ;;
            2)
                cron_schedule="0 3 */3 * *"  # Every 3 days 3 AM
                schedule_name="Every 3 days"
                break
                ;;
            3)
                cron_schedule="0 3 * * 0"  # Weekly on Sunday 3 AM
                schedule_name="Weekly"
                break
                ;;
            4)
                disable_auto_cleaning
                return
                ;;
            *)
                echo -e "${RED}Invalid option. Please choose 1-4.${RESET}"
                ;;
        esac
    done
    
    # Create the auto-clean script
    cat > "$HOME/.42bleachclean_auto.sh" << 'EOF'
#!/bin/bash
# 42BleachClean Auto-Cleaner (Safe Cache Only)

LOG_FILE="$HOME/.42bleachclean_auto.log"
DATE=$(date '+%Y-%m-%d %H:%M:%S')

echo "[$DATE] Starting auto-cleanup..." >> "$LOG_FILE"

# Only clean safe cache directories - NO personal files
declare -a safe_targets_macos=(
    "$HOME/Library/Caches/*"
    "$HOME/Library/Application Support/Code/Cache/*"
    "$HOME/Library/Application Support/Google/Chrome/*/Cache/*"
    "$HOME/Library/Application Support/discord/Cache/*"
    "$HOME/.Trash/*"
    "$HOME/*.42*"
    "$HOME/.zcompdump*"
)

declare -a safe_targets_linux=(
    "$HOME/.cache/*"
    "$HOME/.var/app/*/cache/*"
    "$HOME/.npm/_cacache/*"
    "$HOME/.local/share/Trash/*"
    "$HOME/*.42*"
)

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    targets=("${safe_targets_macos[@]}")
else
    targets=("${safe_targets_linux[@]}")
fi

total_saved=0

for target in "${targets[@]}"; do
    if [[ -e $target ]]; then
        size_before=$(du -sk $target 2>/dev/null | awk '{print $1}' || echo 0)
        rm -rf $target 2>/dev/null
        total_saved=$((total_saved + size_before))
    fi
done

saved_mb=$((total_saved / 1024))
echo "[$DATE] Auto-cleanup completed. Saved: ${saved_mb}MB" >> "$LOG_FILE"

# Rotate log file if it gets too big (keep only last 50 lines)
if [[ $(wc -l < "$LOG_FILE" 2>/dev/null || echo 0) -gt 50 ]]; then
    tail -50 "$LOG_FILE" > "$LOG_FILE.tmp" && mv "$LOG_FILE.tmp" "$LOG_FILE"
fi
EOF
    
    chmod +x "$HOME/.42bleachclean_auto.sh"
    
    # Add to crontab
    (crontab -l 2>/dev/null | grep -v "42bleachclean"; echo "$cron_schedule $HOME/.42bleachclean_auto.sh") | crontab -
    
    echo -e "${GREEN}✅ Auto-cleaning enabled: $schedule_name${RESET}"
    echo -e "${CYAN}📝 Logs will be saved to: ~/.42bleachclean_auto.log${RESET}"
    echo
}

disable_auto_cleaning() {
    echo -e "${BLUE}🛑 Disabling auto-cleaning...${RESET}"
    
    # Remove from crontab
    (crontab -l 2>/dev/null | grep -v "42bleachclean") | crontab -
    
    # Remove auto-clean script
    rm -f "$HOME/.42bleachclean_auto.sh"
    rm -f "$HOME/.42bleachclean_auto.log"
    
    echo -e "${GREEN}✅ Auto-cleaning disabled${RESET}"
    echo
}

check_auto_cleaning_status() {
    if crontab -l 2>/dev/null | grep -q "42bleachclean"; then
        schedule=$(crontab -l 2>/dev/null | grep "42bleachclean" | cut -d' ' -f1-5)
        echo -e "${GREEN}✅ Auto-cleaning is enabled${RESET}"
        echo -e "${DIM}   Schedule: $schedule${RESET}"
        
        if [[ -f "$HOME/.42bleachclean_auto.log" ]]; then
            last_run=$(tail -1 "$HOME/.42bleachclean_auto.log" 2>/dev/null)
            echo -e "${DIM}   Last run: $last_run${RESET}"
        fi
    else
        echo -e "${YELLOW}⏸️  Auto-cleaning is disabled${RESET}"
    fi
}

setup_notifications() {
    echo -e "${CYAN}🔔 Setting up disk space notifications...${RESET}"
    echo
    
    echo -e "${YELLOW}This will notify you when disk space is low${RESET}"
    echo -e "${DIM}   • Checks available space every hour${RESET}"
    echo -e "${DIM}   • Notifies when less than 500MB available${RESET}"
    echo -e "${DIM}   • Uses system notifications (no internet required)${RESET}"
    echo
    
    while true; do
        read -p "Enable low disk space notifications? [y/N]: " yn
        case $yn in
            [Yy]*)
                break
                ;;
            [Nn]*|"")
                echo -e "${BLUE}🔕 Notifications disabled${RESET}"
                return
                ;;
            *)
                echo -e "${RED}Please answer yes (y) or no (n)${RESET}"
                ;;
        esac
    done
    
    # Create notification script
    cat > "$HOME/.42bleachclean_notify.sh" << 'EOF'
#!/bin/bash
# 42BleachClean Notification System

# Get available space in MB
if [[ "$OSTYPE" == "darwin"* ]]; then
    available_kb=$(df "$HOME" | tail -1 | awk '{print $4}')
else
    available_kb=$(df "$HOME" | tail -1 | awk '{print $4}')
fi

available_mb=$((available_kb / 1024))

# If less than 500MB available, send notification
if [[ $available_mb -lt 500 ]]; then
    message="⚠️ Low disk space: Only ${available_mb}MB available. Run 'bleachclean' to free up space!"
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        # macOS notification
        osascript -e "display notification \"$message\" with title \"42BleachClean\""
    else
        # Linux notification
        if command -v notify-send &> /dev/null; then
            notify-send "42BleachClean" "$message"
        fi
    fi
fi
EOF
    
    chmod +x "$HOME/.42bleachclean_notify.sh"
    
    # Add to crontab (check every hour)
    (crontab -l 2>/dev/null | grep -v "42bleachclean_notify"; echo "0 * * * * $HOME/.42bleachclean_notify.sh") | crontab -
    
    echo -e "${GREEN}✅ Notifications enabled${RESET}"
    echo -e "${CYAN}📝 Will notify when less than 500MB available${RESET}"
    echo
}

disable_notifications() {
    echo -e "${BLUE}🔕 Disabling notifications...${RESET}"
    
    (crontab -l 2>/dev/null | grep -v "42bleachclean_notify") | crontab -
    
    rm -f "$HOME/.42bleachclean_notify.sh"
    
    echo -e "${GREEN}✅ Notifications disabled${RESET}"
    echo
}

# Personal laptop detection
detect_environment() {
    local is_personal=false
    
    # Check for personal laptop indicators or 13 usr
    if [[ "$USER" != "guest" ]] && [[ ! "$HOME" =~ ^/nfs/ ]] && [[ ! "$HOME" =~ ^/sgoinfre/ ]]; then
        # Check if we can write to system locations (verfy personal laptop)
        if [[ -w "/usr/local" ]] || [[ -w "/opt" ]] || [[ "$HOME" =~ ^/Users/ ]] || [[ "$HOME" =~ ^/home/ ]]; then
            is_personal=true
        fi
    fi
    
    if [[ "$is_personal" == "true" ]]; then
        echo -e "${GREEN}🏠 Personal laptop detected${RESET}"
        echo -e "${CYAN}💡 Enhanced features available (auto-clean, notifications)${RESET}"
        return 0
    else
        echo -e "${BLUE}🏫 School/shared computer detected${RESET}"
        echo -e "${DIM}   Auto-features disabled for safety${RESET}"
        return 1
    fi
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
    
    # Get current disk info later TODO duf mac dysk linux intefrated 
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
        "--setup-auto")
            show_header
            if detect_environment; then
                setup_auto_cleaning
            else
                echo -e "${YELLOW}⚠️  Auto-cleaning is only available on personal laptops${RESET}"
                echo -e "${DIM}   This is disabled on school/shared computers for safety${RESET}"
            fi
            exit 0
            ;;
        "--disable-auto")
            show_header
            disable_auto_cleaning
            exit 0
            ;;
        "--setup-notify")
            show_header
            if detect_environment; then
                setup_notifications
            else
                echo -e "${YELLOW}⚠️  Notifications are only available on personal laptops${RESET}"
                echo -e "${DIM}   This is disabled on school/shared computers${RESET}"
            fi
            exit 0
            ;;
        "--disable-notify")
            show_header
            disable_notifications
            exit 0
            ;;
        "--status")
            show_header
            echo -e "${CYAN}📊 42BleachClean Automation Status${RESET}"
            echo
            detect_environment
            echo
            check_auto_cleaning_status
            echo
            if crontab -l 2>/dev/null | grep -q "42bleachclean_notify"; then
                echo -e "${GREEN}🔔 Notifications: Enabled${RESET}"
            else
                echo -e "${YELLOW}🔕 Notifications: Disabled${RESET}"
            fi
            exit 0
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

echo "# 42BleachClean aliases - Added by installer" >> "$shell_rc"
echo "# 42BleachClean aliases - Added by installer" >> ~/.bashrc

echo "alias bleachclean='bash \$HOME/bleachclean.sh'" >> "$shell_rc"
echo "alias bleachclean='bash \$HOME/bleachclean.sh'" >> ~/.bashrc

echo "alias blc='bash \$HOME/bleachclean.sh --quiet'" >> "$shell_rc"
echo "alias blc='bash \$HOME/bleachclean.sh --quiet'" >> ~/.bashrc


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
