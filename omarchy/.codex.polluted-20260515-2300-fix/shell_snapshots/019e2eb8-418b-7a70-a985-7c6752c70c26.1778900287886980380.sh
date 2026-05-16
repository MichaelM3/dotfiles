# Snapshot file
# Unset all aliases to avoid conflicts with functions
unalias -a 2>/dev/null || true
# Functions
VCS_INFO_formats () {
	setopt localoptions noksharrays NO_shwordsplit
	local msg tmp
	local -i i
	local -A hook_com
	hook_com=(action "$1" action_orig "$1" branch "$2" branch_orig "$2" base "$3" base_orig "$3" staged "$4" staged_orig "$4" unstaged "$5" unstaged_orig "$5" revision "$6" revision_orig "$6" misc "$7" misc_orig "$7" vcs "${vcs}" vcs_orig "${vcs}") 
	hook_com[base-name]="${${hook_com[base]}:t}" 
	hook_com[base-name_orig]="${hook_com[base-name]}" 
	hook_com[subdir]="$(VCS_INFO_reposub ${hook_com[base]})" 
	hook_com[subdir_orig]="${hook_com[subdir]}" 
	: vcs_info-patch-9b9840f2-91e5-4471-af84-9e9a0dc68c1b
	for tmp in base base-name branch misc revision subdir
	do
		hook_com[$tmp]="${hook_com[$tmp]//\%/%%}" 
	done
	VCS_INFO_hook 'post-backend'
	if [[ -n ${hook_com[action]} ]]
	then
		zstyle -a ":vcs_info:${vcs}:${usercontext}:${rrn}" actionformats msgs
		(( ${#msgs} < 1 )) && msgs[1]=' (%s)-[%b|%a]%u%c-' 
	else
		zstyle -a ":vcs_info:${vcs}:${usercontext}:${rrn}" formats msgs
		(( ${#msgs} < 1 )) && msgs[1]=' (%s)-[%b]%u%c-' 
	fi
	if [[ -n ${hook_com[staged]} ]]
	then
		zstyle -s ":vcs_info:${vcs}:${usercontext}:${rrn}" stagedstr tmp
		[[ -z ${tmp} ]] && hook_com[staged]='S'  || hook_com[staged]=${tmp} 
	fi
	if [[ -n ${hook_com[unstaged]} ]]
	then
		zstyle -s ":vcs_info:${vcs}:${usercontext}:${rrn}" unstagedstr tmp
		[[ -z ${tmp} ]] && hook_com[unstaged]='U'  || hook_com[unstaged]=${tmp} 
	fi
	if [[ ${quiltmode} != 'standalone' ]] && VCS_INFO_hook "pre-addon-quilt"
	then
		local REPLY
		VCS_INFO_quilt addon
		hook_com[quilt]="${REPLY}" 
		unset REPLY
	elif [[ ${quiltmode} == 'standalone' ]]
	then
		hook_com[quilt]=${hook_com[misc]} 
	fi
	(( ${#msgs} > maxexports )) && msgs[$(( maxexports + 1 )),-1]=() 
	for i in {1..${#msgs}}
	do
		if VCS_INFO_hook "set-message" $(( $i - 1 )) "${msgs[$i]}"
		then
			zformat -f msg ${msgs[$i]} a:${hook_com[action]} b:${hook_com[branch]} c:${hook_com[staged]} i:${hook_com[revision]} m:${hook_com[misc]} r:${hook_com[base-name]} s:${hook_com[vcs]} u:${hook_com[unstaged]} Q:${hook_com[quilt]} R:${hook_com[base]} S:${hook_com[subdir]}
			msgs[$i]=${msg} 
		else
			msgs[$i]=${hook_com[message]} 
		fi
	done
	hook_com=() 
	backend_misc=() 
	return 0
}
__arguments () {
	# undefined
	builtin autoload -XUz
}
__git_prompt_git () {
	GIT_OPTIONAL_LOCKS=0 command git "$@"
}
__nvm () {
	declare previous_word
	previous_word="${COMP_WORDS[COMP_CWORD - 1]}" 
	case "${previous_word}" in
		(use | run | exec | ls | list | uninstall) __nvm_installed_nodes ;;
		(alias | unalias) __nvm_alias ;;
		(*) __nvm_commands ;;
	esac
	return 0
}
__nvm_alias () {
	__nvm_generate_completion "$(__nvm_aliases)"
}
__nvm_aliases () {
	declare aliases
	aliases="" 
	if [ -d "${NVM_DIR}/alias" ]
	then
		aliases="$(command cd "${NVM_DIR}/alias" && command find "${PWD}" -type f | command sed "s:${PWD}/::")" 
	fi
	echo "${aliases} node stable unstable iojs"
}
__nvm_commands () {
	declare current_word
	declare command
	current_word="${COMP_WORDS[COMP_CWORD]}" 
	COMMANDS='
    help install uninstall use run exec
    alias unalias reinstall-packages
    current list ls list-remote ls-remote
    install-latest-npm
    cache deactivate unload
    version version-remote which' 
	if [ ${#COMP_WORDS[@]} == 4 ]
	then
		command="${COMP_WORDS[COMP_CWORD - 2]}" 
		case "${command}" in
			(alias) __nvm_installed_nodes ;;
		esac
	else
		case "${current_word}" in
			(-*) __nvm_options ;;
			(*) __nvm_generate_completion "${COMMANDS}" ;;
		esac
	fi
}
__nvm_generate_completion () {
	declare current_word
	current_word="${COMP_WORDS[COMP_CWORD]}" 
	COMPREPLY=($(compgen -W "$1" -- "${current_word}")) 
	return 0
}
__nvm_installed_nodes () {
	__nvm_generate_completion "$(nvm_ls) $(__nvm_aliases)"
}
__nvm_options () {
	OPTIONS='' 
	__nvm_generate_completion "${OPTIONS}"
}
_a2ps () {
	# undefined
	builtin autoload -XUz
}
_aap () {
	# undefined
	builtin autoload -XUz
}
_abcde () {
	# undefined
	builtin autoload -XUz
}
_absolute_command_paths () {
	# undefined
	builtin autoload -XUz
}
_ack () {
	# undefined
	builtin autoload -XUz
}
_acpi () {
	# undefined
	builtin autoload -XUz
}
_acpitool () {
	# undefined
	builtin autoload -XUz
}
_acroread () {
	# undefined
	builtin autoload -XUz
}
_adb () {
	# undefined
	builtin autoload -XUz
}
_add-zle-hook-widget () {
	# undefined
	builtin autoload -XUz
}
_add-zsh-hook () {
	# undefined
	builtin autoload -XUz
}
_alacritty () {
	# undefined
	builtin autoload -XUz
}
_alias () {
	# undefined
	builtin autoload -XUz
}
_aliases () {
	# undefined
	builtin autoload -XUz
}
_all_labels () {
	# undefined
	builtin autoload -XUz
}
_all_matches () {
	# undefined
	builtin autoload -XUz
}
_alsa-utils () {
	# undefined
	builtin autoload -XUz
}
_alternative () {
	# undefined
	builtin autoload -XUz
}
_analyseplugin () {
	# undefined
	builtin autoload -XUz
}
_ansible () {
	# undefined
	builtin autoload -XUz
}
_ant () {
	# undefined
	builtin autoload -XUz
}
_antiword () {
	# undefined
	builtin autoload -XUz
}
_apachectl () {
	# undefined
	builtin autoload -XUz
}
_apm () {
	# undefined
	builtin autoload -XUz
}
_approximate () {
	# undefined
	builtin autoload -XUz
}
_arch_archives () {
	# undefined
	builtin autoload -XUz
}
_arch_namespace () {
	# undefined
	builtin autoload -XUz
}
_arg_compile () {
	# undefined
	builtin autoload -XUz
}
_arguments () {
	# undefined
	builtin autoload -XUz
}
_arp () {
	# undefined
	builtin autoload -XUz
}
_arping () {
	# undefined
	builtin autoload -XUz
}
_arrays () {
	# undefined
	builtin autoload -XUz
}
_asciidoctor () {
	# undefined
	builtin autoload -XUz
}
_asciinema () {
	# undefined
	builtin autoload -XUz
}
_assign () {
	# undefined
	builtin autoload -XUz
}
_at () {
	# undefined
	builtin autoload -XUz
}
_attr () {
	# undefined
	builtin autoload -XUz
}
_augeas () {
	# undefined
	builtin autoload -XUz
}
_autocd () {
	# undefined
	builtin autoload -XUz
}
_avahi () {
	# undefined
	builtin autoload -XUz
}
_awk () {
	# undefined
	builtin autoload -XUz
}
_base64 () {
	# undefined
	builtin autoload -XUz
}
_basename () {
	# undefined
	builtin autoload -XUz
}
_basenc () {
	# undefined
	builtin autoload -XUz
}
_bash () {
	# undefined
	builtin autoload -XUz
}
_bash_complete () {
	local ret=1 
	local -a suf matches
	local -x COMP_POINT COMP_CWORD
	local -a COMP_WORDS COMPREPLY BASH_VERSINFO
	local -x COMP_LINE="$words" 
	local -A savejobstates savejobtexts
	(( COMP_POINT = 1 + ${#${(j. .)words[1,CURRENT-1]}} + $#QIPREFIX + $#IPREFIX + $#PREFIX ))
	(( COMP_CWORD = CURRENT - 1))
	COMP_WORDS=("${words[@]}") 
	BASH_VERSINFO=(2 05b 0 1 release) 
	savejobstates=(${(kv)jobstates}) 
	savejobtexts=(${(kv)jobtexts}) 
	[[ ${argv[${argv[(I)nospace]:-0}-1]} = -o ]] && suf=(-S '') 
	matches=(${(f)"$(compgen $@ -- ${words[CURRENT]})"}) 
	if [[ -n $matches ]]
	then
		if [[ ${argv[${argv[(I)filenames]:-0}-1]} = -o ]]
		then
			compset -P '*/' && matches=(${matches##*/}) 
			compset -S '/*' && matches=(${matches%%/*}) 
			compadd -f "${suf[@]}" -a matches && ret=0 
		else
			compadd "${suf[@]}" - "${(@)${(Q@)matches}:#*\ }" && ret=0 
			compadd -S ' ' - ${${(M)${(Q)matches}:#*\ }% } && ret=0 
		fi
	fi
	if (( ret ))
	then
		if [[ ${argv[${argv[(I)default]:-0}-1]} = -o ]]
		then
			_default "${suf[@]}" && ret=0 
		elif [[ ${argv[${argv[(I)dirnames]:-0}-1]} = -o ]]
		then
			_directories "${suf[@]}" && ret=0 
		fi
	fi
	return ret
}
_bash_completions () {
	# undefined
	builtin autoload -XUz
}
_bat () {
	# undefined
	builtin autoload -XUz
}
_baudrates () {
	# undefined
	builtin autoload -XUz
}
_baz () {
	# undefined
	builtin autoload -XUz
}
_beep () {
	# undefined
	builtin autoload -XUz
}
_bibtex () {
	# undefined
	builtin autoload -XUz
}
_bind_addresses () {
	# undefined
	builtin autoload -XUz
}
_bindkey () {
	# undefined
	builtin autoload -XUz
}
_bison () {
	# undefined
	builtin autoload -XUz
}
_bittorrent () {
	# undefined
	builtin autoload -XUz
}
_bluetoothctl () {
	# undefined
	builtin autoload -XUz
}
_bogofilter () {
	# undefined
	builtin autoload -XUz
}
_bootctl () {
	# undefined
	builtin autoload -XUz
}
_bpf_filters () {
	# undefined
	builtin autoload -XUz
}
_bpython () {
	# undefined
	builtin autoload -XUz
}
_brace_parameter () {
	# undefined
	builtin autoload -XUz
}
_brctl () {
	# undefined
	builtin autoload -XUz
}
_btrfs () {
	# undefined
	builtin autoload -XUz
}
_builtin () {
	# undefined
	builtin autoload -XUz
}
_busctl () {
	# undefined
	builtin autoload -XUz
}
_bwrap () {
	# undefined
	builtin autoload -XUz
}
_bzip2 () {
	# undefined
	builtin autoload -XUz
}
_bzr () {
	# undefined
	builtin autoload -XUz
}
_cabal () {
	# undefined
	builtin autoload -XUz
}
_cache_invalid () {
	# undefined
	builtin autoload -XUz
}
_cal () {
	# undefined
	builtin autoload -XUz
}
_calendar () {
	# undefined
	builtin autoload -XUz
}
_call_function () {
	# undefined
	builtin autoload -XUz
}
_call_program () {
	local -xi COLUMNS=999 
	local curcontext="${curcontext}" tmp err_fd=-1 clocale='_comp_locale;' 
	local -a prefix
	if [[ "$1" = -p ]]
	then
		shift
		if (( $#_comp_priv_prefix ))
		then
			curcontext="${curcontext%:*}/${${(@M)_comp_priv_prefix:#^*[^\\]=*}[1]}:" 
			zstyle -t ":completion:${curcontext}:${1}" gain-privileges && prefix=($_comp_priv_prefix) 
		fi
	elif [[ "$1" = -l ]]
	then
		shift
		clocale='' 
	fi
	if (( ${debug_fd:--1} > 2 )) || [[ ! -t 2 ]]
	then
		exec {err_fd}>&2
	else
		exec {err_fd}> /dev/null
	fi
	{
		if zstyle -s ":completion:${curcontext}:${1}" command tmp
		then
			if [[ "$tmp" = -* ]]
			then
				eval $clocale "$tmp[2,-1]" "$argv[2,-1]"
			else
				eval $clocale $prefix "$tmp"
			fi
		else
			eval $clocale $prefix "$argv[2,-1]"
		fi 2>&$err_fd
	} always {
		exec {err_fd}>&-
	}
}
_canonical_paths () {
	# undefined
	builtin autoload -XUz
}
_capabilities () {
	# undefined
	builtin autoload -XUz
}
_cargo () {
	# undefined
	builtin autoload -XUz
}
_cat () {
	# undefined
	builtin autoload -XUz
}
_ccal () {
	# undefined
	builtin autoload -XUz
}
_cd () {
	# undefined
	builtin autoload -XUz
}
_cdcd () {
	# undefined
	builtin autoload -XUz
}
_cdr () {
	# undefined
	builtin autoload -XUz
}
_cdrdao () {
	# undefined
	builtin autoload -XUz
}
_cdrecord () {
	# undefined
	builtin autoload -XUz
}
_chattr () {
	# undefined
	builtin autoload -XUz
}
_chcon () {
	# undefined
	builtin autoload -XUz
}
_chkconfig () {
	# undefined
	builtin autoload -XUz
}
_chmod () {
	# undefined
	builtin autoload -XUz
}
_choom () {
	# undefined
	builtin autoload -XUz
}
_chown () {
	# undefined
	builtin autoload -XUz
}
_chroot () {
	# undefined
	builtin autoload -XUz
}
_chrt () {
	# undefined
	builtin autoload -XUz
}
_chsh () {
	# undefined
	builtin autoload -XUz
}
_cksum () {
	# undefined
	builtin autoload -XUz
}
_clay () {
	# undefined
	builtin autoload -XUz
}
_cmdambivalent () {
	# undefined
	builtin autoload -XUz
}
_cmdstring () {
	# undefined
	builtin autoload -XUz
}
_cmp () {
	# undefined
	builtin autoload -XUz
}
_code () {
	# undefined
	builtin autoload -XUz
}
_column () {
	# undefined
	builtin autoload -XUz
}
_combination () {
	# undefined
	builtin autoload -XUz
}
_comm () {
	# undefined
	builtin autoload -XUz
}
_command () {
	# undefined
	builtin autoload -XUz
}
_command_names () {
	# undefined
	builtin autoload -XUz
}
_comp_locale () {
	# undefined
	builtin autoload -XUz
}
_compadd () {
	# undefined
	builtin autoload -XUz
}
_compdef () {
	# undefined
	builtin autoload -XUz
}
_complete () {
	# undefined
	builtin autoload -XUz
}
_complete_debug () {
	# undefined
	builtin autoload -XUz
}
_complete_help () {
	# undefined
	builtin autoload -XUz
}
_complete_help_generic () {
	# undefined
	builtin autoload -XUz
}
_complete_tag () {
	# undefined
	builtin autoload -XUz
}
_completers () {
	# undefined
	builtin autoload -XUz
}
_composer () {
	# undefined
	builtin autoload -XUz
}
_compress () {
	# undefined
	builtin autoload -XUz
}
_condition () {
	# undefined
	builtin autoload -XUz
}
_configure () {
	# undefined
	builtin autoload -XUz
}
_coredumpctl () {
	# undefined
	builtin autoload -XUz
}
_correct () {
	# undefined
	builtin autoload -XUz
}
_correct_filename () {
	# undefined
	builtin autoload -XUz
}
_correct_word () {
	# undefined
	builtin autoload -XUz
}
_cowsay () {
	# undefined
	builtin autoload -XUz
}
_cp () {
	# undefined
	builtin autoload -XUz
}
_cpio () {
	# undefined
	builtin autoload -XUz
}
_cplay () {
	# undefined
	builtin autoload -XUz
}
_cpupower () {
	# undefined
	builtin autoload -XUz
}
_crontab () {
	# undefined
	builtin autoload -XUz
}
_cryptsetup () {
	# undefined
	builtin autoload -XUz
}
_cscope () {
	# undefined
	builtin autoload -XUz
}
_csplit () {
	# undefined
	builtin autoload -XUz
}
_cssh () {
	# undefined
	builtin autoload -XUz
}
_ctags () {
	# undefined
	builtin autoload -XUz
}
_ctags_tags () {
	# undefined
	builtin autoload -XUz
}
_ctr () {
	# undefined
	builtin autoload -XUz
}
_curl () {
	# undefined
	builtin autoload -XUz
}
_cursor () {
	# undefined
	builtin autoload -XUz
}
_cut () {
	# undefined
	builtin autoload -XUz
}
_cvs () {
	# undefined
	builtin autoload -XUz
}
_darcs () {
	# undefined
	builtin autoload -XUz
}
_date () {
	# undefined
	builtin autoload -XUz
}
_date_formats () {
	# undefined
	builtin autoload -XUz
}
_dates () {
	# undefined
	builtin autoload -XUz
}
_dbus () {
	# undefined
	builtin autoload -XUz
}
_dconf () {
	# undefined
	builtin autoload -XUz
}
_dcop () {
	# undefined
	builtin autoload -XUz
}
_dd () {
	# undefined
	builtin autoload -XUz
}
_default () {
	# undefined
	builtin autoload -XUz
}
_defer_async_git_register () {
	case "${PS1}:${PS2}:${PS3}:${PS4}:${RPROMPT}:${RPS1}:${RPS2}:${RPS3}:${RPS4}" in
		(*(\$\(git_prompt_info\)|\`git_prompt_info\`)*) _omz_register_handler _omz_git_prompt_info ;;
	esac
	case "${PS1}:${PS2}:${PS3}:${PS4}:${RPROMPT}:${RPS1}:${RPS2}:${RPS3}:${RPS4}" in
		(*(\$\(git_prompt_status\)|\`git_prompt_status\`)*) _omz_register_handler _omz_git_prompt_status ;;
	esac
	add-zsh-hook -d precmd _defer_async_git_register
	unset -f _defer_async_git_register
}
_delimiters () {
	# undefined
	builtin autoload -XUz
}
_deno () {
	# undefined
	builtin autoload -XUz
}
_describe () {
	# undefined
	builtin autoload -XUz
}
_description () {
	# undefined
	builtin autoload -XUz
}
_devtodo () {
	# undefined
	builtin autoload -XUz
}
_df () {
	# undefined
	builtin autoload -XUz
}
_dhclient () {
	# undefined
	builtin autoload -XUz
}
_dict () {
	# undefined
	builtin autoload -XUz
}
_dict_words () {
	# undefined
	builtin autoload -XUz
}
_diff () {
	# undefined
	builtin autoload -XUz
}
_diff3 () {
	# undefined
	builtin autoload -XUz
}
_diff_options () {
	# undefined
	builtin autoload -XUz
}
_diffstat () {
	# undefined
	builtin autoload -XUz
}
_dig () {
	# undefined
	builtin autoload -XUz
}
_dir_list () {
	# undefined
	builtin autoload -XUz
}
_directories () {
	# undefined
	builtin autoload -XUz
}
_directory_stack () {
	# undefined
	builtin autoload -XUz
}
_dirs () {
	# undefined
	builtin autoload -XUz
}
_disable () {
	# undefined
	builtin autoload -XUz
}
_dispatch () {
	# undefined
	builtin autoload -XUz
}
_django () {
	# undefined
	builtin autoload -XUz
}
_dkms () {
	# undefined
	builtin autoload -XUz
}
_dmesg () {
	# undefined
	builtin autoload -XUz
}
_dmidecode () {
	# undefined
	builtin autoload -XUz
}
_dns_types () {
	# undefined
	builtin autoload -XUz
}
_doas () {
	# undefined
	builtin autoload -XUz
}
_docker () {
	# undefined
	builtin autoload -XUz
}
_domains () {
	# undefined
	builtin autoload -XUz
}
_dos2unix () {
	# undefined
	builtin autoload -XUz
}
_dotnet () {
	# undefined
	builtin autoload -XUz
}
_drill () {
	# undefined
	builtin autoload -XUz
}
_dropbox () {
	# undefined
	builtin autoload -XUz
}
_dsh () {
	# undefined
	builtin autoload -XUz
}
_dtruss () {
	# undefined
	builtin autoload -XUz
}
_du () {
	# undefined
	builtin autoload -XUz
}
_dust () {
	# undefined
	builtin autoload -XUz
}
_dvi () {
	# undefined
	builtin autoload -XUz
}
_dynamic_directory_name () {
	# undefined
	builtin autoload -XUz
}
_e2label () {
	# undefined
	builtin autoload -XUz
}
_ecasound () {
	# undefined
	builtin autoload -XUz
}
_echotc () {
	# undefined
	builtin autoload -XUz
}
_echoti () {
	# undefined
	builtin autoload -XUz
}
_ed () {
	# undefined
	builtin autoload -XUz
}
_elfdump () {
	# undefined
	builtin autoload -XUz
}
_elinks () {
	# undefined
	builtin autoload -XUz
}
_email_addresses () {
	# undefined
	builtin autoload -XUz
}
_emulate () {
	# undefined
	builtin autoload -XUz
}
_enable () {
	# undefined
	builtin autoload -XUz
}
_enscript () {
	# undefined
	builtin autoload -XUz
}
_entr () {
	# undefined
	builtin autoload -XUz
}
_env () {
	# undefined
	builtin autoload -XUz
}
_eog () {
	# undefined
	builtin autoload -XUz
}
_equal () {
	# undefined
	builtin autoload -XUz
}
_espeak () {
	# undefined
	builtin autoload -XUz
}
_etags () {
	# undefined
	builtin autoload -XUz
}
_ethtool () {
	# undefined
	builtin autoload -XUz
}
_evince () {
	# undefined
	builtin autoload -XUz
}
_exec () {
	# undefined
	builtin autoload -XUz
}
_expand () {
	# undefined
	builtin autoload -XUz
}
_expand_alias () {
	# undefined
	builtin autoload -XUz
}
_expand_word () {
	# undefined
	builtin autoload -XUz
}
_extensions () {
	# undefined
	builtin autoload -XUz
}
_external_pwds () {
	# undefined
	builtin autoload -XUz
}
_eza () {
	# undefined
	builtin autoload -XUz
}
_fakeroot () {
	# undefined
	builtin autoload -XUz
}
_fastfetch () {
	# undefined
	builtin autoload -XUz
}
_fc () {
	# undefined
	builtin autoload -XUz
}
_fd () {
	# undefined
	builtin autoload -XUz
}
_feh () {
	# undefined
	builtin autoload -XUz
}
_fetchmail () {
	# undefined
	builtin autoload -XUz
}
_ffmpeg () {
	# undefined
	builtin autoload -XUz
}
_figlet () {
	# undefined
	builtin autoload -XUz
}
_file_descriptors () {
	# undefined
	builtin autoload -XUz
}
_file_modes () {
	# undefined
	builtin autoload -XUz
}
_file_systems () {
	# undefined
	builtin autoload -XUz
}
_files () {
	# undefined
	builtin autoload -XUz
}
_find () {
	# undefined
	builtin autoload -XUz
}
_find_net_interfaces () {
	# undefined
	builtin autoload -XUz
}
_findmnt () {
	# undefined
	builtin autoload -XUz
}
_finger () {
	# undefined
	builtin autoload -XUz
}
_first () {
	# undefined
	builtin autoload -XUz
}
_flac () {
	# undefined
	builtin autoload -XUz
}
_flex () {
	# undefined
	builtin autoload -XUz
}
_fmt () {
	# undefined
	builtin autoload -XUz
}
_fold () {
	# undefined
	builtin autoload -XUz
}
_fortune () {
	# undefined
	builtin autoload -XUz
}
_free () {
	# undefined
	builtin autoload -XUz
}
_fsh () {
	# undefined
	builtin autoload -XUz
}
_functions () {
	# undefined
	builtin autoload -XUz
}
_fuse_arguments () {
	# undefined
	builtin autoload -XUz
}
_fuse_values () {
	# undefined
	builtin autoload -XUz
}
_fuser () {
	# undefined
	builtin autoload -XUz
}
_fusermount () {
	# undefined
	builtin autoload -XUz
}
_gcc () {
	# undefined
	builtin autoload -XUz
}
_gcore () {
	# undefined
	builtin autoload -XUz
}
_gdb () {
	# undefined
	builtin autoload -XUz
}
_geany () {
	# undefined
	builtin autoload -XUz
}
_gem () {
	# undefined
	builtin autoload -XUz
}
_generic () {
	# undefined
	builtin autoload -XUz
}
_genisoimage () {
	# undefined
	builtin autoload -XUz
}
_getconf () {
	# undefined
	builtin autoload -XUz
}
_getent () {
	# undefined
	builtin autoload -XUz
}
_getfacl () {
	# undefined
	builtin autoload -XUz
}
_getmail () {
	# undefined
	builtin autoload -XUz
}
_getopt () {
	# undefined
	builtin autoload -XUz
}
_gh () {
	# undefined
	builtin autoload -XUz
}
_ghostscript () {
	# undefined
	builtin autoload -XUz
}
_ghostty () {
	# undefined
	builtin autoload -XUz
}
_git () {
	# undefined
	builtin autoload -XUz
}
_git_log_prettily () {
	if ! [ -z $1 ]
	then
		git log --pretty=$1
	fi
}
_global () {
	# undefined
	builtin autoload -XUz
}
_global_tags () {
	# undefined
	builtin autoload -XUz
}
_globflags () {
	# undefined
	builtin autoload -XUz
}
_globqual_delims () {
	# undefined
	builtin autoload -XUz
}
_globquals () {
	# undefined
	builtin autoload -XUz
}
_gnome-gv () {
	# undefined
	builtin autoload -XUz
}
_gnu_generic () {
	# undefined
	builtin autoload -XUz
}
_gnupod () {
	# undefined
	builtin autoload -XUz
}
_gnutls () {
	# undefined
	builtin autoload -XUz
}
_go () {
	# undefined
	builtin autoload -XUz
}
_gpasswd () {
	# undefined
	builtin autoload -XUz
}
_gpg () {
	# undefined
	builtin autoload -XUz
}
_gphoto2 () {
	# undefined
	builtin autoload -XUz
}
_gprof () {
	# undefined
	builtin autoload -XUz
}
_gqview () {
	# undefined
	builtin autoload -XUz
}
_gradle () {
	# undefined
	builtin autoload -XUz
}
_graphicsmagick () {
	# undefined
	builtin autoload -XUz
}
_grep () {
	# undefined
	builtin autoload -XUz
}
_groff () {
	# undefined
	builtin autoload -XUz
}
_groups () {
	# undefined
	builtin autoload -XUz
}
_growisofs () {
	# undefined
	builtin autoload -XUz
}
_gsettings () {
	# undefined
	builtin autoload -XUz
}
_guard () {
	# undefined
	builtin autoload -XUz
}
_guilt () {
	# undefined
	builtin autoload -XUz
}
_gum () {
	# undefined
	builtin autoload -XUz
}
_gv () {
	# undefined
	builtin autoload -XUz
}
_gzip () {
	# undefined
	builtin autoload -XUz
}
_hash () {
	# undefined
	builtin autoload -XUz
}
_have_glob_qual () {
	# undefined
	builtin autoload -XUz
}
_head () {
	# undefined
	builtin autoload -XUz
}
_hexdump () {
	# undefined
	builtin autoload -XUz
}
_history () {
	# undefined
	builtin autoload -XUz
}
_history_complete_word () {
	# undefined
	builtin autoload -XUz
}
_history_modifiers () {
	# undefined
	builtin autoload -XUz
}
_host () {
	# undefined
	builtin autoload -XUz
}
_hostname () {
	# undefined
	builtin autoload -XUz
}
_hostnamectl () {
	# undefined
	builtin autoload -XUz
}
_hosts () {
	# undefined
	builtin autoload -XUz
}
_htop () {
	# undefined
	builtin autoload -XUz
}
_hyprctl () {
	# undefined
	builtin autoload -XUz
}
_hyprpm () {
	# undefined
	builtin autoload -XUz
}
_iconv () {
	# undefined
	builtin autoload -XUz
}
_iconvconfig () {
	# undefined
	builtin autoload -XUz
}
_id () {
	# undefined
	builtin autoload -XUz
}
_ifconfig () {
	# undefined
	builtin autoload -XUz
}
_iftop () {
	# undefined
	builtin autoload -XUz
}
_ignored () {
	# undefined
	builtin autoload -XUz
}
_imagemagick () {
	# undefined
	builtin autoload -XUz
}
_img2sixel () {
	# undefined
	builtin autoload -XUz
}
_in_vared () {
	# undefined
	builtin autoload -XUz
}
_init_d () {
	# undefined
	builtin autoload -XUz
}
_initctl () {
	# undefined
	builtin autoload -XUz
}
_insmod () {
	# undefined
	builtin autoload -XUz
}
_install () {
	# undefined
	builtin autoload -XUz
}
_ionice () {
	# undefined
	builtin autoload -XUz
}
_iostat () {
	# undefined
	builtin autoload -XUz
}
_ip () {
	# undefined
	builtin autoload -XUz
}
_ipsec () {
	# undefined
	builtin autoload -XUz
}
_ipset () {
	# undefined
	builtin autoload -XUz
}
_iptables () {
	# undefined
	builtin autoload -XUz
}
_irssi () {
	# undefined
	builtin autoload -XUz
}
_ispell () {
	# undefined
	builtin autoload -XUz
}
_iwconfig () {
	# undefined
	builtin autoload -XUz
}
_java () {
	# undefined
	builtin autoload -XUz
}
_java_class () {
	# undefined
	builtin autoload -XUz
}
_jobs () {
	# undefined
	builtin autoload -XUz
}
_jobs_bg () {
	# undefined
	builtin autoload -XUz
}
_jobs_builtin () {
	# undefined
	builtin autoload -XUz
}
_jobs_fg () {
	# undefined
	builtin autoload -XUz
}
_joe () {
	# undefined
	builtin autoload -XUz
}
_join () {
	# undefined
	builtin autoload -XUz
}
_journalctl () {
	# undefined
	builtin autoload -XUz
}
_jq () {
	# undefined
	builtin autoload -XUz
}
_kdeconnect () {
	# undefined
	builtin autoload -XUz
}
_kernel-install () {
	# undefined
	builtin autoload -XUz
}
_kfmclient () {
	# undefined
	builtin autoload -XUz
}
_kill () {
	# undefined
	builtin autoload -XUz
}
_killall () {
	# undefined
	builtin autoload -XUz
}
_knock () {
	# undefined
	builtin autoload -XUz
}
_kpartx () {
	# undefined
	builtin autoload -XUz
}
_kvno () {
	# undefined
	builtin autoload -XUz
}
_last () {
	# undefined
	builtin autoload -XUz
}
_ld_debug () {
	# undefined
	builtin autoload -XUz
}
_ldconfig () {
	# undefined
	builtin autoload -XUz
}
_ldd () {
	# undefined
	builtin autoload -XUz
}
_less () {
	# undefined
	builtin autoload -XUz
}
_lha () {
	# undefined
	builtin autoload -XUz
}
_libvirt () {
	# undefined
	builtin autoload -XUz
}
_limit () {
	# undefined
	builtin autoload -XUz
}
_limits () {
	# undefined
	builtin autoload -XUz
}
_links () {
	# undefined
	builtin autoload -XUz
}
_list () {
	# undefined
	builtin autoload -XUz
}
_list_files () {
	# undefined
	builtin autoload -XUz
}
_lldb () {
	# undefined
	builtin autoload -XUz
}
_ln () {
	# undefined
	builtin autoload -XUz
}
_loadkeys () {
	# undefined
	builtin autoload -XUz
}
_locale () {
	# undefined
	builtin autoload -XUz
}
_localectl () {
	# undefined
	builtin autoload -XUz
}
_localedef () {
	# undefined
	builtin autoload -XUz
}
_locales () {
	# undefined
	builtin autoload -XUz
}
_locate () {
	# undefined
	builtin autoload -XUz
}
_logger () {
	# undefined
	builtin autoload -XUz
}
_loginctl () {
	# undefined
	builtin autoload -XUz
}
_look () {
	# undefined
	builtin autoload -XUz
}
_losetup () {
	# undefined
	builtin autoload -XUz
}
_lp () {
	# undefined
	builtin autoload -XUz
}
_ls () {
	# undefined
	builtin autoload -XUz
}
_lsattr () {
	# undefined
	builtin autoload -XUz
}
_lsblk () {
	# undefined
	builtin autoload -XUz
}
_lsmod () {
	# undefined
	builtin autoload -XUz
}
_lsns () {
	# undefined
	builtin autoload -XUz
}
_lsof () {
	# undefined
	builtin autoload -XUz
}
_lsusb () {
	# undefined
	builtin autoload -XUz
}
_ltrace () {
	# undefined
	builtin autoload -XUz
}
_lua () {
	# undefined
	builtin autoload -XUz
}
_luarocks () {
	# undefined
	builtin autoload -XUz
}
_luarocks-admin () {
	# undefined
	builtin autoload -XUz
}
_lynx () {
	# undefined
	builtin autoload -XUz
}
_lz4 () {
	# undefined
	builtin autoload -XUz
}
_lzop () {
	# undefined
	builtin autoload -XUz
}
_machinectl () {
	# undefined
	builtin autoload -XUz
}
_mail () {
	# undefined
	builtin autoload -XUz
}
_mailboxes () {
	# undefined
	builtin autoload -XUz
}
_main_complete () {
	# undefined
	builtin autoload -XUz
}
_make () {
	# undefined
	builtin autoload -XUz
}
_mako () {
	# undefined
	builtin autoload -XUz
}
_makoctl () {
	# undefined
	builtin autoload -XUz
}
_man () {
	# undefined
	builtin autoload -XUz
}
_mat () {
	# undefined
	builtin autoload -XUz
}
_mat2 () {
	# undefined
	builtin autoload -XUz
}
_match () {
	# undefined
	builtin autoload -XUz
}
_math () {
	# undefined
	builtin autoload -XUz
}
_math_params () {
	# undefined
	builtin autoload -XUz
}
_matlab () {
	# undefined
	builtin autoload -XUz
}
_md5sum () {
	# undefined
	builtin autoload -XUz
}
_mdadm () {
	# undefined
	builtin autoload -XUz
}
_mencal () {
	# undefined
	builtin autoload -XUz
}
_menu () {
	# undefined
	builtin autoload -XUz
}
_mere () {
	# undefined
	builtin autoload -XUz
}
_meson () {
	# undefined
	builtin autoload -XUz
}
_message () {
	# undefined
	builtin autoload -XUz
}
_mh () {
	# undefined
	builtin autoload -XUz
}
_mii-tool () {
	# undefined
	builtin autoload -XUz
}
_mime_types () {
	# undefined
	builtin autoload -XUz
}
_mise () {
	# undefined
	builtin autoload -XUz
}
_mkdir () {
	# undefined
	builtin autoload -XUz
}
_mkfifo () {
	# undefined
	builtin autoload -XUz
}
_mkinitcpio () {
	# undefined
	builtin autoload -XUz
}
_mknod () {
	# undefined
	builtin autoload -XUz
}
_mktemp () {
	# undefined
	builtin autoload -XUz
}
_module () {
	# undefined
	builtin autoload -XUz
}
_module_math_func () {
	# undefined
	builtin autoload -XUz
}
_modutils () {
	# undefined
	builtin autoload -XUz
}
_mondo () {
	# undefined
	builtin autoload -XUz
}
_monotone () {
	# undefined
	builtin autoload -XUz
}
_moosic () {
	# undefined
	builtin autoload -XUz
}
_mosh () {
	# undefined
	builtin autoload -XUz
}
_most_recent_file () {
	# undefined
	builtin autoload -XUz
}
_mount () {
	# undefined
	builtin autoload -XUz
}
_mozilla () {
	# undefined
	builtin autoload -XUz
}
_mpc () {
	# undefined
	builtin autoload -XUz
}
_mplayer () {
	# undefined
	builtin autoload -XUz
}
_mpv () {
	# undefined
	builtin autoload -XUz
}
_mt () {
	# undefined
	builtin autoload -XUz
}
_mtools () {
	# undefined
	builtin autoload -XUz
}
_mtr () {
	# undefined
	builtin autoload -XUz
}
_multi_parts () {
	# undefined
	builtin autoload -XUz
}
_mupdf () {
	# undefined
	builtin autoload -XUz
}
_mutt () {
	# undefined
	builtin autoload -XUz
}
_mv () {
	# undefined
	builtin autoload -XUz
}
_my_accounts () {
	# undefined
	builtin autoload -XUz
}
_myrepos () {
	# undefined
	builtin autoload -XUz
}
_mysql_utils () {
	# undefined
	builtin autoload -XUz
}
_mysqldiff () {
	# undefined
	builtin autoload -XUz
}
_nautilus () {
	# undefined
	builtin autoload -XUz
}
_ncftp () {
	# undefined
	builtin autoload -XUz
}
_nedit () {
	# undefined
	builtin autoload -XUz
}
_net_interfaces () {
	# undefined
	builtin autoload -XUz
}
_netcat () {
	# undefined
	builtin autoload -XUz
}
_netscape () {
	# undefined
	builtin autoload -XUz
}
_netstat () {
	# undefined
	builtin autoload -XUz
}
_networkctl () {
	# undefined
	builtin autoload -XUz
}
_networkmanager () {
	# undefined
	builtin autoload -XUz
}
_newsgroups () {
	# undefined
	builtin autoload -XUz
}
_next_label () {
	# undefined
	builtin autoload -XUz
}
_next_tags () {
	# undefined
	builtin autoload -XUz
}
_nginx () {
	# undefined
	builtin autoload -XUz
}
_ngrep () {
	# undefined
	builtin autoload -XUz
}
_nice () {
	# undefined
	builtin autoload -XUz
}
_ninja () {
	# undefined
	builtin autoload -XUz
}
_nkf () {
	# undefined
	builtin autoload -XUz
}
_nl () {
	# undefined
	builtin autoload -XUz
}
_nm () {
	# undefined
	builtin autoload -XUz
}
_nmap () {
	# undefined
	builtin autoload -XUz
}
_normal () {
	# undefined
	builtin autoload -XUz
}
_nothing () {
	# undefined
	builtin autoload -XUz
}
_npm () {
	# undefined
	builtin autoload -XUz
}
_nsenter () {
	# undefined
	builtin autoload -XUz
}
_nslookup () {
	# undefined
	builtin autoload -XUz
}
_numbers () {
	# undefined
	builtin autoload -XUz
}
_numfmt () {
	# undefined
	builtin autoload -XUz
}
_objdump () {
	# undefined
	builtin autoload -XUz
}
_object_files () {
	# undefined
	builtin autoload -XUz
}
_od () {
	# undefined
	builtin autoload -XUz
}
_okular () {
	# undefined
	builtin autoload -XUz
}
_oldlist () {
	# undefined
	builtin autoload -XUz
}
_omz () {
	local -a cmds subcmds
	cmds=('changelog:Print the changelog' 'help:Usage information' 'plugin:Manage plugins' 'pr:Manage Oh My Zsh Pull Requests' 'reload:Reload the current zsh session' 'shop:Open the Oh My Zsh shop' 'theme:Manage themes' 'update:Update Oh My Zsh' 'version:Show the version') 
	if (( CURRENT == 2 ))
	then
		_describe 'command' cmds
	elif (( CURRENT == 3 ))
	then
		case "$words[2]" in
			(changelog) local -a refs
				refs=("${(@f)$(builtin cd -q "$ZSH"; command git for-each-ref --format="%(refname:short):%(subject)" refs/heads refs/tags)}") 
				_describe 'command' refs ;;
			(plugin) subcmds=('disable:Disable plugin(s)' 'enable:Enable plugin(s)' 'info:Get plugin information' 'list:List plugins' 'load:Load plugin(s)') 
				_describe 'command' subcmds ;;
			(pr) subcmds=('clean:Delete all Pull Request branches' 'test:Test a Pull Request') 
				_describe 'command' subcmds ;;
			(theme) subcmds=('list:List themes' 'set:Set a theme in your .zshrc file' 'use:Load a theme') 
				_describe 'command' subcmds ;;
		esac
	elif (( CURRENT == 4 ))
	then
		case "${words[2]}::${words[3]}" in
			(plugin::(disable|enable|load)) local -aU valid_plugins
				if [[ "${words[3]}" = disable ]]
				then
					valid_plugins=($plugins) 
				else
					valid_plugins=("$ZSH"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t) "$ZSH_CUSTOM"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t)) 
					[[ "${words[3]}" = enable ]] && valid_plugins=(${valid_plugins:|plugins}) 
				fi
				_describe 'plugin' valid_plugins ;;
			(plugin::info) local -aU plugins
				plugins=("$ZSH"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t) "$ZSH_CUSTOM"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t)) 
				_describe 'plugin' plugins ;;
			(plugin::list) local -a opts
				opts=('--enabled:List enabled plugins only') 
				_describe -o 'options' opts ;;
			(theme::(set|use)) local -aU themes
				themes=("$ZSH"/themes/*.zsh-theme(-.N:t:r) "$ZSH_CUSTOM"/**/*.zsh-theme(-.N:r:gs:"$ZSH_CUSTOM"/themes/:::gs:"$ZSH_CUSTOM"/:::)) 
				_describe 'theme' themes ;;
		esac
	elif (( CURRENT > 4 ))
	then
		case "${words[2]}::${words[3]}" in
			(plugin::(enable|disable|load)) local -aU valid_plugins
				if [[ "${words[3]}" = disable ]]
				then
					valid_plugins=($plugins) 
				else
					valid_plugins=("$ZSH"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t) "$ZSH_CUSTOM"/plugins/*/{_*,*.plugin.zsh}(-.N:h:t)) 
					[[ "${words[3]}" = enable ]] && valid_plugins=(${valid_plugins:|plugins}) 
				fi
				local -a args
				args=(${words[4,$(( CURRENT - 1))]}) 
				valid_plugins=(${valid_plugins:|args}) 
				_describe 'plugin' valid_plugins ;;
		esac
	fi
	return 0
}
_omz::changelog () {
	local version=${1:-HEAD} format=${3:-"--text"} 
	if (
			builtin cd -q "$ZSH"
			! command git show-ref --verify refs/heads/$version && ! command git show-ref --verify refs/tags/$version && ! command git rev-parse --verify "${version}^{commit}"
		) &> /dev/null
	then
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} [version]

NOTE: <version> must be a valid branch, tag or commit.
EOF
		return 1
	fi
	ZSH="$ZSH" command zsh -f "$ZSH/tools/changelog.sh" "$version" "${2:-}" "$format"
}
_omz::confirm () {
	if [[ -n "$1" ]]
	then
		_omz::log prompt "$1" "${${functrace[1]#_}%:*}"
	fi
	read -r -k 1
	if [[ "$REPLY" != $'\n' ]]
	then
		echo
	fi
}
_omz::help () {
	cat >&2 <<EOF
Usage: omz <command> [options]

Available commands:

  help                Print this help message
  changelog           Print the changelog
  plugin <command>    Manage plugins
  pr     <command>    Manage Oh My Zsh Pull Requests
  reload              Reload the current zsh session
  shop                Open the Oh My Zsh shop
  theme  <command>    Manage themes
  update              Update Oh My Zsh
  version             Show the version

EOF
}
_omz::log () {
	setopt localoptions nopromptsubst
	local logtype=$1 
	local logname=${3:-${${functrace[1]#_}%:*}} 
	if [[ $logtype = debug && -z $_OMZ_DEBUG ]]
	then
		return
	fi
	case "$logtype" in
		(prompt) print -Pn "%S%F{blue}$logname%f%s: $2" ;;
		(debug) print -P "%F{white}$logname%f: $2" ;;
		(info) print -P "%F{green}$logname%f: $2" ;;
		(warn) print -P "%S%F{yellow}$logname%f%s: $2" ;;
		(error) print -P "%S%F{red}$logname%f%s: $2" ;;
	esac >&2
}
_omz::plugin () {
	(( $# > 0 && $+functions[$0::$1] )) || {
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} <command> [options]

Available commands:

  disable <plugin> Disable plugin(s)
  enable <plugin>  Enable plugin(s)
  info <plugin>    Get information of a plugin
  list [--enabled] List Oh My Zsh plugins
  load <plugin>    Load plugin(s)

EOF
		return 1
	}
	local command="$1" 
	shift
	$0::$command "$@"
}
_omz::plugin::disable () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin> [...]" >&2
		return 1
	fi
	local -a dis_plugins
	for plugin in "$@"
	do
		if [[ ${plugins[(Ie)$plugin]} -eq 0 ]]
		then
			_omz::log warn "plugin '$plugin' is not enabled."
			continue
		fi
		dis_plugins+=("$plugin") 
	done
	if [[ ${#dis_plugins} -eq 0 ]]
	then
		return 1
	fi
	local awk_subst_plugins="  gsub(/[ \t]+(${(j:|:)dis_plugins})[ \t]+/, \" \") # with spaces before or after
  gsub(/[ \t]+(${(j:|:)dis_plugins})$/, \"\")       # with spaces before and EOL
  gsub(/^(${(j:|:)dis_plugins})[ \t]+/, \"\")       # with BOL and spaces after

  gsub(/\((${(j:|:)dis_plugins})[ \t]+/, \"(\")     # with parenthesis before and spaces after
  gsub(/[ \t]+(${(j:|:)dis_plugins})\)/, \")\")     # with spaces before or parenthesis after
  gsub(/\((${(j:|:)dis_plugins})\)/, \"()\")        # with only parentheses

  gsub(/^(${(j:|:)dis_plugins})\)/, \")\")          # with BOL and closing parenthesis
  gsub(/\((${(j:|:)dis_plugins})$/, \"(\")          # with opening parenthesis and EOL
" 
	local awk_script="
# if plugins=() is in oneline form, substitute disabled plugins and go to next line
/^[ \t]*plugins=\([^#]+\).*\$/ {
  $awk_subst_plugins
  print \$0
  next
}

# if plugins=() is in multiline form, enable multi flag and disable plugins if they're there
/^[ \t]*plugins=\(/ {
  multi=1
  $awk_subst_plugins
  print \$0
  next
}

# if multi flag is enabled and we find a valid closing parenthesis, remove plugins and disable multi flag
multi == 1 && /^[^#]*\)/ {
  multi=0
  $awk_subst_plugins
  print \$0
  next
}

multi == 1 && length(\$0) > 0 {
  $awk_subst_plugins
  if (length(\$0) > 0) print \$0
  next
}

{ print \$0 }
" 
	local zdot="${ZDOTDIR:-$HOME}" 
	local zshrc="${${:-"${zdot}/.zshrc"}:A}" 
	awk "$awk_script" "$zshrc" > "$zdot/.zshrc.new" && command cp -f "$zshrc" "$zdot/.zshrc.bck" && command mv -f "$zdot/.zshrc.new" "$zshrc"
	[[ $? -eq 0 ]] || {
		local ret=$? 
		_omz::log error "error disabling plugins."
		return $ret
	}
	if ! command zsh -n "$zdot/.zshrc"
	then
		_omz::log error "broken syntax in '"${zdot/#$HOME/\~}/.zshrc"'. Rolling back changes..."
		command mv -f "$zdot/.zshrc.bck" "$zshrc"
		return 1
	fi
	_omz::log info "plugins disabled: ${(j:, :)dis_plugins}."
	[[ ! -o interactive ]] || _omz::reload
}
_omz::plugin::enable () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin> [...]" >&2
		return 1
	fi
	local -a add_plugins
	for plugin in "$@"
	do
		if [[ ${plugins[(Ie)$plugin]} -ne 0 ]]
		then
			_omz::log warn "plugin '$plugin' is already enabled."
			continue
		fi
		add_plugins+=("$plugin") 
	done
	if [[ ${#add_plugins} -eq 0 ]]
	then
		return 1
	fi
	local awk_script="
# if plugins=() is in oneline form, substitute ) with new plugins and go to the next line
/^[ \t]*plugins=\([^#]+\).*\$/ {
  sub(/\)/, \" $add_plugins&\")
  print \$0
  next
}

# if plugins=() is in multiline form, enable multi flag and indent by default with 2 spaces
/^[ \t]*plugins=\(/ {
  multi=1
  indent=\"  \"
  print \$0
  next
}

# if multi flag is enabled and we find a valid closing parenthesis,
# add new plugins with proper indent and disable multi flag
multi == 1 && /^[^#]*\)/ {
  multi=0
  split(\"$add_plugins\",p,\" \")
  for (i in p) {
    print indent p[i]
  }
  print \$0
  next
}

# if multi flag is enabled and we didnt find a closing parenthesis,
# get the indentation level to match when adding plugins
multi == 1 && /^[^#]*/ {
  indent=\"\"
  for (i = 1; i <= length(\$0); i++) {
    char=substr(\$0, i, 1)
    if (char == \" \" || char == \"\t\") {
      indent = indent char
    } else {
      break
    }
  }
}

{ print \$0 }
" 
	local zdot="${ZDOTDIR:-$HOME}" 
	local zshrc="${${:-"${zdot}/.zshrc"}:A}" 
	awk "$awk_script" "$zshrc" > "$zdot/.zshrc.new" && command cp -f "$zshrc" "$zdot/.zshrc.bck" && command mv -f "$zdot/.zshrc.new" "$zshrc"
	[[ $? -eq 0 ]] || {
		local ret=$? 
		_omz::log error "error enabling plugins."
		return $ret
	}
	if ! command zsh -n "$zdot/.zshrc"
	then
		_omz::log error "broken syntax in '"${zdot/#$HOME/\~}/.zshrc"'. Rolling back changes..."
		command mv -f "$zdot/.zshrc.bck" "$zshrc"
		return 1
	fi
	_omz::log info "plugins enabled: ${(j:, :)add_plugins}."
	[[ ! -o interactive ]] || _omz::reload
}
_omz::plugin::info () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin>" >&2
		return 1
	fi
	local readme
	for readme in "$ZSH_CUSTOM/plugins/$1/README.md" "$ZSH/plugins/$1/README.md"
	do
		if [[ -f "$readme" ]]
		then
			if [[ ! -t 1 ]]
			then
				cat "$readme"
				return $?
			fi
			case 1 in
				(${+commands[glow]}) glow -p "$readme" ;;
				(${+commands[bat]}) bat -l md --style plain "$readme" ;;
				(${+commands[less]}) less "$readme" ;;
				(*) cat "$readme" ;;
			esac
			return $?
		fi
	done
	if [[ -d "$ZSH_CUSTOM/plugins/$1" || -d "$ZSH/plugins/$1" ]]
	then
		_omz::log error "the '$1' plugin doesn't have a README file"
	else
		_omz::log error "'$1' plugin not found"
	fi
	return 1
}
_omz::plugin::list () {
	local -a custom_plugins builtin_plugins
	if [[ "$1" == "--enabled" ]]
	then
		local plugin
		for plugin in "${plugins[@]}"
		do
			if [[ -d "${ZSH_CUSTOM}/plugins/${plugin}" ]]
			then
				custom_plugins+=("${plugin}") 
			elif [[ -d "${ZSH}/plugins/${plugin}" ]]
			then
				builtin_plugins+=("${plugin}") 
			fi
		done
	else
		custom_plugins=("$ZSH_CUSTOM"/plugins/*(-/N:t)) 
		builtin_plugins=("$ZSH"/plugins/*(-/N:t)) 
	fi
	if [[ ! -t 1 ]]
	then
		print -l ${(q-)custom_plugins} ${(q-)builtin_plugins}
		return
	fi
	if (( ${#custom_plugins} ))
	then
		print -P "%U%BCustom plugins%b%u:"
		print -lac ${(q-)custom_plugins}
	fi
	if (( ${#builtin_plugins} ))
	then
		(( ${#custom_plugins} )) && echo
		print -P "%U%BBuilt-in plugins%b%u:"
		print -lac ${(q-)builtin_plugins}
	fi
}
_omz::plugin::load () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <plugin> [...]" >&2
		return 1
	fi
	local plugin base has_completion=0 
	for plugin in "$@"
	do
		if [[ -d "$ZSH_CUSTOM/plugins/$plugin" ]]
		then
			base="$ZSH_CUSTOM/plugins/$plugin" 
		elif [[ -d "$ZSH/plugins/$plugin" ]]
		then
			base="$ZSH/plugins/$plugin" 
		else
			_omz::log warn "plugin '$plugin' not found"
			continue
		fi
		if [[ ! -f "$base/_$plugin" && ! -f "$base/$plugin.plugin.zsh" ]]
		then
			_omz::log warn "'$plugin' is not a valid plugin"
			continue
		elif (( ! ${fpath[(Ie)$base]} ))
		then
			fpath=("$base" $fpath) 
		fi
		local -a comp_files
		comp_files=($base/_*(N)) 
		has_completion=$(( $#comp_files > 0 )) 
		if [[ -f "$base/$plugin.plugin.zsh" ]]
		then
			source "$base/$plugin.plugin.zsh"
		fi
	done
	if (( has_completion ))
	then
		compinit -D -d "$_comp_dumpfile"
	fi
}
_omz::pr () {
	(( $# > 0 && $+functions[$0::$1] )) || {
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} <command> [options]

Available commands:

  clean                       Delete all PR branches (ohmyzsh/pull-*)
  test <PR_number_or_URL>     Fetch PR #NUMBER and rebase against master

EOF
		return 1
	}
	local command="$1" 
	shift
	$0::$command "$@"
}
_omz::pr::clean () {
	(
		set -e
		builtin cd -q "$ZSH"
		local fmt branches
		fmt="%(color:bold blue)%(align:18,right)%(refname:short)%(end)%(color:reset) %(color:dim bold red)%(objectname:short)%(color:reset) %(color:yellow)%(contents:subject)" 
		branches="$(command git for-each-ref --sort=-committerdate --color --format="$fmt" "refs/heads/ohmyzsh/pull-*")" 
		if [[ -z "$branches" ]]
		then
			_omz::log info "there are no Pull Request branches to remove."
			return
		fi
		echo "$branches\n"
		_omz::confirm "do you want remove these Pull Request branches? [Y/n] "
		[[ "$REPLY" != [yY$'\n'] ]] && return
		_omz::log info "removing all Oh My Zsh Pull Request branches..."
		command git branch --list 'ohmyzsh/pull-*' | while read branch
		do
			command git branch -D "$branch"
		done
	)
}
_omz::pr::test () {
	if [[ "$1" = https://* ]]
	then
		1="${1:t}" 
	fi
	if ! [[ -n "$1" && "$1" =~ ^[[:digit:]]+$ ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <PR_NUMBER_or_URL>" >&2
		return 1
	fi
	local branch
	branch=$(builtin cd -q "$ZSH"; git symbolic-ref --short HEAD)  || {
		_omz::log error "error when getting the current git branch. Aborting..."
		return 1
	}
	(
		set -e
		builtin cd -q "$ZSH"
		command git remote -v | while read remote url _
		do
			case "$url" in
				(https://github.com/ohmyzsh/ohmyzsh(|.git)) found=1 
					break ;;
				(git@github.com:ohmyzsh/ohmyzsh(|.git)) found=1 
					break ;;
			esac
		done
		(( $found )) || {
			_omz::log error "could not find the ohmyzsh git remote. Aborting..."
			return 1
		}
		_omz::log info "checking if PR #$1 has the 'testers needed' label..."
		local pr_json label label_id="MDU6TGFiZWw4NzY1NTkwNA==" 
		pr_json=$(
      curl -fsSL \
        -H "Accept: application/vnd.github+json" \
        -H "X-GitHub-Api-Version: 2022-11-28" \
        "https://api.github.com/repos/ohmyzsh/ohmyzsh/pulls/$1"
    ) 
		if [[ $? -gt 0 || -z "$pr_json" ]]
		then
			_omz::log error "error when trying to fetch PR #$1 from GitHub."
			return 1
		fi
		if (( $+commands[jq] ))
		then
			label="$(command jq ".labels.[] | select(.node_id == \"$label_id\")" <<< "$pr_json")" 
		else
			label="$(command grep "\"$label_id\"" <<< "$pr_json" 2>/dev/null)" 
		fi
		if [[ -z "$label" ]]
		then
			_omz::log warn "PR #$1 does not have the 'testers needed' label. This means that the PR"
			_omz::log warn "has not been reviewed by a maintainer and may contain malicious code."
			_omz::log prompt "Do you want to continue testing it? [yes/N] "
			builtin read -r
			if [[ "${REPLY:l}" != yes ]]
			then
				_omz::log error "PR test canceled. Please ask a maintainer to review and label the PR."
				return 1
			else
				_omz::log warn "Continuing to check out and test PR #$1. Be careful!"
			fi
		fi
		_omz::log info "fetching PR #$1 to ohmyzsh/pull-$1..."
		command git fetch -f "$remote" refs/pull/$1/head:ohmyzsh/pull-$1 || {
			_omz::log error "error when trying to fetch PR #$1."
			return 1
		}
		_omz::log info "rebasing PR #$1..."
		local ret gpgsign
		{
			gpgsign=$(command git config --local commit.gpgsign 2>/dev/null)  || ret=$? 
			[[ $ret -ne 129 ]] || gpgsign=$(command git config commit.gpgsign 2>/dev/null) 
			command git config commit.gpgsign false
			command git rebase master ohmyzsh/pull-$1 || {
				command git rebase --abort &> /dev/null
				_omz::log warn "could not rebase PR #$1 on top of master."
				_omz::log warn "you might not see the latest stable changes."
				_omz::log info "run \`zsh\` to test the changes."
				return 1
			}
		} always {
			case "$gpgsign" in
				("") command git config --unset commit.gpgsign ;;
				(*) command git config commit.gpgsign "$gpgsign" ;;
			esac
		}
		_omz::log info "fetch of PR #${1} successful."
	)
	[[ $? -eq 0 ]] || return 1
	_omz::log info "running \`zsh\` to test the changes. Run \`exit\` to go back."
	command zsh -l
	_omz::confirm "do you want to go back to the previous branch? [Y/n] "
	[[ "$REPLY" != [yY$'\n'] ]] && return
	(
		set -e
		builtin cd -q "$ZSH"
		command git checkout "$branch" -- || {
			_omz::log error "could not go back to the previous branch ('$branch')."
			return 1
		}
	)
}
_omz::reload () {
	command rm -f $_comp_dumpfile $ZSH_COMPDUMP
	local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}" 
	[[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
}
_omz::shop () {
	local shop_url="https://commitgoods.com/collections/oh-my-zsh" 
	_omz::log info "Opening Oh My Zsh shop in your browser..."
	_omz::log info "$shop_url"
	open_command "$shop_url"
}
_omz::theme () {
	(( $# > 0 && $+functions[$0::$1] )) || {
		cat >&2 <<EOF
Usage: ${(j: :)${(s.::.)0#_}} <command> [options]

Available commands:

  list            List all available Oh My Zsh themes
  set <theme>     Set a theme in your .zshrc file
  use <theme>     Load a theme

EOF
		return 1
	}
	local command="$1" 
	shift
	$0::$command "$@"
}
_omz::theme::list () {
	local -a custom_themes builtin_themes
	custom_themes=("$ZSH_CUSTOM"/**/*.zsh-theme(-.N:r:gs:"$ZSH_CUSTOM"/themes/:::gs:"$ZSH_CUSTOM"/:::)) 
	builtin_themes=("$ZSH"/themes/*.zsh-theme(-.N:t:r)) 
	if [[ ! -t 1 ]]
	then
		print -l ${(q-)custom_themes} ${(q-)builtin_themes}
		return
	fi
	if [[ -n "$ZSH_THEME" ]]
	then
		print -Pn "%U%BCurrent theme%b%u: "
		[[ $ZSH_THEME = random ]] && echo "$RANDOM_THEME (via random)" || echo "$ZSH_THEME"
		echo
	fi
	if (( ${#custom_themes} ))
	then
		print -P "%U%BCustom themes%b%u:"
		print -lac ${(q-)custom_themes}
		echo
	fi
	print -P "%U%BBuilt-in themes%b%u:"
	print -lac ${(q-)builtin_themes}
}
_omz::theme::set () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <theme>" >&2
		return 1
	fi
	if [[ ! -f "$ZSH_CUSTOM/$1.zsh-theme" ]] && [[ ! -f "$ZSH_CUSTOM/themes/$1.zsh-theme" ]] && [[ ! -f "$ZSH/themes/$1.zsh-theme" ]]
	then
		_omz::log error "%B$1%b theme not found"
		return 1
	fi
	local awk_script='
!set && /^[ \t]*ZSH_THEME=[^#]+.*$/ {
  set=1
  sub(/^[ \t]*ZSH_THEME=[^#]+.*$/, "ZSH_THEME=\"'$1'\" # set by `omz`")
  print $0
  next
}

{ print $0 }

END {
  # If no ZSH_THEME= line was found, return an error
  if (!set) exit 1
}
' 
	local zdot="${ZDOTDIR:-$HOME}" 
	local zshrc="${${:-"${zdot}/.zshrc"}:A}" 
	awk "$awk_script" "$zshrc" > "$zdot/.zshrc.new" || {
		cat <<EOF
ZSH_THEME="$1" # set by \`omz\`

EOF
		cat "$zdot/.zshrc"
	} > "$zdot/.zshrc.new" && command cp -f "$zshrc" "$zdot/.zshrc.bck" && command mv -f "$zdot/.zshrc.new" "$zshrc"
	[[ $? -eq 0 ]] || {
		local ret=$? 
		_omz::log error "error setting theme."
		return $ret
	}
	if ! command zsh -n "$zdot/.zshrc"
	then
		_omz::log error "broken syntax in '"${zdot/#$HOME/\~}/.zshrc"'. Rolling back changes..."
		command mv -f "$zdot/.zshrc.bck" "$zshrc"
		return 1
	fi
	_omz::log info "'$1' theme set correctly."
	[[ ! -o interactive ]] || _omz::reload
}
_omz::theme::use () {
	if [[ -z "$1" ]]
	then
		echo "Usage: ${(j: :)${(s.::.)0#_}} <theme>" >&2
		return 1
	fi
	if [[ -f "$ZSH_CUSTOM/$1.zsh-theme" ]]
	then
		source "$ZSH_CUSTOM/$1.zsh-theme"
	elif [[ -f "$ZSH_CUSTOM/themes/$1.zsh-theme" ]]
	then
		source "$ZSH_CUSTOM/themes/$1.zsh-theme"
	elif [[ -f "$ZSH/themes/$1.zsh-theme" ]]
	then
		source "$ZSH/themes/$1.zsh-theme"
	else
		_omz::log error "%B$1%b theme not found"
		return 1
	fi
	ZSH_THEME="$1" 
	[[ $1 = random ]] || unset RANDOM_THEME
}
_omz::update () {
	(( $+commands[git] )) || {
		_omz::log error "git is not installed. Aborting..."
		return 1
	}
	[[ "$1" != --unattended ]] || {
		_omz::log error "the \`\e[2m--unattended\e[0m\` flag is no longer supported, use the \`\e[2mupgrade.sh\e[0m\` script instead."
		_omz::log error "for more information see https://github.com/ohmyzsh/ohmyzsh/wiki/FAQ#how-do-i-update-oh-my-zsh"
		return 1
	}
	local last_commit=$(builtin cd -q "$ZSH"; git rev-parse HEAD 2>/dev/null) 
	[[ $? -eq 0 ]] || {
		_omz::log error "\`$ZSH\` is not a git directory. Aborting..."
		return 1
	}
	zstyle -s ':omz:update' verbose verbose_mode || verbose_mode=default 
	ZSH="$ZSH" command zsh -f "$ZSH/tools/upgrade.sh" -i -v $verbose_mode || return $?
	zmodload zsh/datetime
	echo "LAST_EPOCH=$(( EPOCHSECONDS / 60 / 60 / 24 ))" >| "${ZSH_CACHE_DIR}/.zsh-update"
	command rm -rf "$ZSH/log/update.lock"
	if [[ "$(builtin cd -q "$ZSH"; git rev-parse HEAD)" != "$last_commit" ]]
	then
		local zsh="${ZSH_ARGZERO:-${functrace[-1]%:*}}" 
		[[ "$zsh" = -* || -o login ]] && exec -l "${zsh#-}" || exec "$zsh"
	fi
}
_omz::version () {
	(
		builtin cd -q "$ZSH"
		local version
		version=$(command git describe --tags HEAD 2>/dev/null)  || version=$(command git symbolic-ref --quiet --short HEAD 2>/dev/null)  || version=$(command git name-rev --no-undefined --name-only --exclude="remotes/*" HEAD 2>/dev/null)  || version="<detached>" 
		local commit=$(command git rev-parse --short HEAD 2>/dev/null) 
		printf "%s (%s)\n" "$version" "$commit"
	)
}
_omz_async_callback () {
	emulate -L zsh
	local fd=$1 
	local err=$2 
	if [[ -z "$err" || "$err" == "hup" ]]
	then
		local handler="${(k)_OMZ_ASYNC_FDS[(r)$fd]}" 
		local old_output="${_OMZ_ASYNC_OUTPUT[$handler]}" 
		IFS= read -r -u $fd -d '' "_OMZ_ASYNC_OUTPUT[$handler]"
		if [[ "$old_output" != "${_OMZ_ASYNC_OUTPUT[$handler]}" ]]
		then
			zle .reset-prompt
			zle -R
		fi
		exec {fd}<&-
	fi
	zle -F "$fd"
	_OMZ_ASYNC_FDS[$handler]=-1 
	_OMZ_ASYNC_PIDS[$handler]=-1 
}
_omz_async_request () {
	setopt localoptions noksharrays unset
	local -i ret=$? 
	typeset -gA _OMZ_ASYNC_FDS _OMZ_ASYNC_PIDS _OMZ_ASYNC_OUTPUT
	local handler
	for handler in ${_omz_async_functions}
	do
		(( ${+functions[$handler]} )) || continue
		local fd=${_OMZ_ASYNC_FDS[$handler]:--1} 
		local pid=${_OMZ_ASYNC_PIDS[$handler]:--1} 
		if (( fd != -1 && pid != -1 )) && {
				true <&$fd
			} 2> /dev/null
		then
			exec {fd}<&-
			zle -F $fd
			if [[ -o MONITOR ]]
			then
				kill -TERM -$pid 2> /dev/null
			else
				kill -TERM $pid 2> /dev/null
			fi
		fi
		_OMZ_ASYNC_FDS[$handler]=-1 
		_OMZ_ASYNC_PIDS[$handler]=-1 
		exec {fd}< <(
      # Tell parent process our PID
      builtin echo ${sysparams[pid]}
      # Set exit code for the handler if used
      () { return $ret }
      # Run the async function handler
      $handler
    )
		_OMZ_ASYNC_FDS[$handler]=$fd 
		is-at-least 5.8 || command true
		read -u $fd "_OMZ_ASYNC_PIDS[$handler]"
		zle -F "$fd" _omz_async_callback
	done
}
_omz_diag_dump_check_core_commands () {
	builtin echo "Core command check:"
	local redefined name builtins externals reserved_words
	redefined=() 
	reserved_words=(do done esac then elif else fi for case if while function repeat time until select coproc nocorrect foreach end '!' '[[' '{' '}') 
	builtins=(alias autoload bg bindkey break builtin bye cd chdir command comparguments compcall compctl compdescribe compfiles compgroups compquote comptags comptry compvalues continue dirs disable disown echo echotc echoti emulate enable eval exec exit false fc fg functions getln getopts hash jobs kill let limit log logout noglob popd print printf pushd pushln pwd r read rehash return sched set setopt shift source suspend test times trap true ttyctl type ulimit umask unalias unfunction unhash unlimit unset unsetopt vared wait whence where which zcompile zle zmodload zparseopts zregexparse zstyle) 
	if is-at-least 5.1
	then
		reserved_word+=(declare export integer float local readonly typeset) 
	else
		builtins+=(declare export integer float local readonly typeset) 
	fi
	builtins_fatal=(builtin command local) 
	externals=(zsh) 
	for name in $reserved_words
	do
		if [[ $(builtin whence -w $name) != "$name: reserved" ]]
		then
			builtin echo "reserved word '$name' has been redefined"
			builtin which $name
			redefined+=$name 
		fi
	done
	for name in $builtins
	do
		if [[ $(builtin whence -w $name) != "$name: builtin" ]]
		then
			builtin echo "builtin '$name' has been redefined"
			builtin which $name
			redefined+=$name 
		fi
	done
	for name in $externals
	do
		if [[ $(builtin whence -w $name) != "$name: command" ]]
		then
			builtin echo "command '$name' has been redefined"
			builtin which $name
			redefined+=$name 
		fi
	done
	if [[ -n "$redefined" ]]
	then
		builtin echo "SOME CORE COMMANDS HAVE BEEN REDEFINED: $redefined"
	else
		builtin echo "All core commands are defined normally"
	fi
}
_omz_diag_dump_echo_file_w_header () {
	local file=$1 
	if [[ -f $file || -h $file ]]
	then
		builtin echo "========== $file =========="
		if [[ -h $file ]]
		then
			builtin echo "==========    ( => ${file:A} )   =========="
		fi
		command cat $file
		builtin echo "========== end $file =========="
		builtin echo
	elif [[ -d $file ]]
	then
		builtin echo "File '$file' is a directory"
	elif [[ ! -e $file ]]
	then
		builtin echo "File '$file' does not exist"
	else
		command ls -lad "$file"
	fi
}
_omz_diag_dump_one_big_text () {
	local program programs progfile md5
	builtin echo oh-my-zsh diagnostic dump
	builtin echo
	builtin echo $outfile
	builtin echo
	command date
	command uname -a
	builtin echo OSTYPE=$OSTYPE
	builtin echo ZSH_VERSION=$ZSH_VERSION
	builtin echo User: $USERNAME
	builtin echo umask: $(umask)
	builtin echo
	_omz_diag_dump_os_specific_version
	builtin echo
	programs=(sh zsh ksh bash sed cat grep ls find git posh) 
	local progfile="" extra_str="" sha_str="" 
	for program in $programs
	do
		extra_str="" sha_str="" 
		progfile=$(builtin which $program) 
		if [[ $? == 0 ]]
		then
			if [[ -e $progfile ]]
			then
				if builtin whence shasum &> /dev/null
				then
					sha_str=($(command shasum $progfile)) 
					sha_str=$sha_str[1] 
					extra_str+=" SHA $sha_str" 
				fi
				if [[ -h "$progfile" ]]
				then
					extra_str+=" ( -> ${progfile:A} )" 
				fi
			fi
			builtin printf '%-9s %-20s %s\n' "$program is" "$progfile" "$extra_str"
		else
			builtin echo "$program: not found"
		fi
	done
	builtin echo
	builtin echo Command Versions:
	builtin echo "zsh: $(zsh --version)"
	builtin echo "this zsh session: $ZSH_VERSION"
	builtin echo "bash: $(bash --version | command grep bash)"
	builtin echo "git: $(git --version)"
	builtin echo "grep: $(grep --version)"
	builtin echo
	_omz_diag_dump_check_core_commands || return 1
	builtin echo
	builtin echo Process state:
	builtin echo pwd: $PWD
	if builtin whence pstree &> /dev/null
	then
		builtin echo Process tree for this shell:
		pstree -p $$
	else
		ps -fT
	fi
	builtin set | command grep -a '^\(ZSH\|plugins\|TERM\|LC_\|LANG\|precmd\|chpwd\|preexec\|FPATH\|TTY\|DISPLAY\|PATH\)\|OMZ'
	builtin echo
	builtin echo Exported:
	builtin echo $(builtin export | command sed 's/=.*//')
	builtin echo
	builtin echo Locale:
	command locale
	builtin echo
	builtin echo Zsh configuration:
	builtin echo setopt: $(builtin setopt)
	builtin echo
	builtin echo zstyle:
	builtin zstyle
	builtin echo
	builtin echo 'compaudit output:'
	compaudit
	builtin echo
	builtin echo '$fpath directories:'
	command ls -lad $fpath
	builtin echo
	builtin echo oh-my-zsh installation:
	command ls -ld ~/.z*
	command ls -ld ~/.oh*
	builtin echo
	builtin echo oh-my-zsh git state:
	(
		builtin cd $ZSH && builtin echo "HEAD: $(git rev-parse HEAD)" && git remote -v && git status | command grep "[^[:space:]]"
	)
	if [[ $verbose -ge 1 ]]
	then
		(
			builtin cd $ZSH && git reflog --date=default | command grep pull
		)
	fi
	builtin echo
	if [[ -e $ZSH_CUSTOM ]]
	then
		local custom_dir=$ZSH_CUSTOM 
		if [[ -h $custom_dir ]]
		then
			custom_dir=$(builtin cd $custom_dir && pwd -P) 
		fi
		builtin echo "oh-my-zsh custom dir:"
		builtin echo "   $ZSH_CUSTOM ($custom_dir)"
		(
			builtin cd ${custom_dir:h} && command find ${custom_dir:t} -name .git -prune -o -print
		)
		builtin echo
	fi
	if [[ $verbose -ge 1 ]]
	then
		builtin echo "bindkey:"
		builtin bindkey
		builtin echo
		builtin echo "infocmp:"
		command infocmp -L
		builtin echo
	fi
	local zdotdir=${ZDOTDIR:-$HOME} 
	builtin echo "Zsh configuration files:"
	local cfgfile cfgfiles
	cfgfiles=(/etc/zshenv /etc/zprofile /etc/zshrc /etc/zlogin /etc/zlogout $zdotdir/.zshenv $zdotdir/.zprofile $zdotdir/.zshrc $zdotdir/.zlogin $zdotdir/.zlogout ~/.zsh.pre-oh-my-zsh /etc/bashrc /etc/profile ~/.bashrc ~/.profile ~/.bash_profile ~/.bash_logout) 
	command ls -lad $cfgfiles 2>&1
	builtin echo
	if [[ $verbose -ge 1 ]]
	then
		for cfgfile in $cfgfiles
		do
			_omz_diag_dump_echo_file_w_header $cfgfile
		done
	fi
	builtin echo
	builtin echo "Zsh compdump files:"
	local dumpfile dumpfiles
	command ls -lad $zdotdir/.zcompdump*
	dumpfiles=($zdotdir/.zcompdump*(N)) 
	if [[ $verbose -ge 2 ]]
	then
		for dumpfile in $dumpfiles
		do
			_omz_diag_dump_echo_file_w_header $dumpfile
		done
	fi
}
_omz_diag_dump_os_specific_version () {
	local osname osver version_file version_files
	case "$OSTYPE" in
		(darwin*) osname=$(command sw_vers -productName) 
			osver=$(command sw_vers -productVersion) 
			builtin echo "OS Version: $osname $osver build $(sw_vers -buildVersion)" ;;
		(cygwin) command systeminfo | command head -n 4 | command tail -n 2 ;;
	esac
	if builtin which lsb_release > /dev/null
	then
		builtin echo "OS Release: $(command lsb_release -s -d)"
	fi
	version_files=(/etc/*-release(N) /etc/*-version(N) /etc/*_version(N)) 
	for version_file in $version_files
	do
		builtin echo "$version_file:"
		command cat "$version_file"
		builtin echo
	done
}
_omz_git_prompt_info () {
	if ! __git_prompt_git rev-parse --git-dir &> /dev/null || [[ "$(__git_prompt_git config --get oh-my-zsh.hide-info 2>/dev/null)" == 1 ]]
	then
		return 0
	fi
	local ref
	ref=$(__git_prompt_git symbolic-ref --short HEAD 2> /dev/null)  || ref=$(__git_prompt_git describe --tags --exact-match HEAD 2> /dev/null)  || ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return 0
	local upstream
	if (( ${+ZSH_THEME_GIT_SHOW_UPSTREAM} ))
	then
		upstream=$(__git_prompt_git rev-parse --abbrev-ref --symbolic-full-name "@{upstream}" 2>/dev/null)  && upstream=" -> ${upstream}" 
	fi
	echo "${ZSH_THEME_GIT_PROMPT_PREFIX}${ref//\%/%%}${upstream//\%/%%}$(parse_git_dirty)${ZSH_THEME_GIT_PROMPT_SUFFIX}"
}
_omz_git_prompt_status () {
	[[ "$(__git_prompt_git config --get oh-my-zsh.hide-status 2>/dev/null)" = 1 ]] && return
	local -A prefix_constant_map
	prefix_constant_map=('\?\? ' 'UNTRACKED' 'A  ' 'ADDED' 'M  ' 'MODIFIED' 'MM ' 'MODIFIED' ' M ' 'MODIFIED' 'AM ' 'MODIFIED' ' T ' 'MODIFIED' 'R  ' 'RENAMED' ' D ' 'DELETED' 'D  ' 'DELETED' 'UU ' 'UNMERGED' 'ahead' 'AHEAD' 'behind' 'BEHIND' 'diverged' 'DIVERGED' 'stashed' 'STASHED') 
	local -A constant_prompt_map
	constant_prompt_map=('UNTRACKED' "$ZSH_THEME_GIT_PROMPT_UNTRACKED" 'ADDED' "$ZSH_THEME_GIT_PROMPT_ADDED" 'MODIFIED' "$ZSH_THEME_GIT_PROMPT_MODIFIED" 'RENAMED' "$ZSH_THEME_GIT_PROMPT_RENAMED" 'DELETED' "$ZSH_THEME_GIT_PROMPT_DELETED" 'UNMERGED' "$ZSH_THEME_GIT_PROMPT_UNMERGED" 'AHEAD' "$ZSH_THEME_GIT_PROMPT_AHEAD" 'BEHIND' "$ZSH_THEME_GIT_PROMPT_BEHIND" 'DIVERGED' "$ZSH_THEME_GIT_PROMPT_DIVERGED" 'STASHED' "$ZSH_THEME_GIT_PROMPT_STASHED") 
	local status_constants
	status_constants=(UNTRACKED ADDED MODIFIED RENAMED DELETED STASHED UNMERGED AHEAD BEHIND DIVERGED) 
	local status_text
	status_text="$(__git_prompt_git status --porcelain -b 2> /dev/null)" 
	if [[ $? -eq 128 ]]
	then
		return 1
	fi
	local -A statuses_seen
	if __git_prompt_git rev-parse --verify refs/stash &> /dev/null
	then
		statuses_seen[STASHED]=1 
	fi
	local status_lines
	status_lines=("${(@f)${status_text}}") 
	if [[ "$status_lines[1]" =~ "^## [^ ]+ \[(.*)\]" ]]
	then
		local branch_statuses
		branch_statuses=("${(@s/,/)match}") 
		for branch_status in $branch_statuses
		do
			if [[ ! $branch_status =~ "(behind|diverged|ahead) ([0-9]+)?" ]]
			then
				continue
			fi
			local last_parsed_status=$prefix_constant_map[$match[1]] 
			statuses_seen[$last_parsed_status]=$match[2] 
		done
	fi
	for status_prefix in "${(@k)prefix_constant_map}"
	do
		local status_constant="${prefix_constant_map[$status_prefix]}" 
		local status_regex=$'(^|\n)'"$status_prefix" 
		if [[ "$status_text" =~ $status_regex ]]
		then
			statuses_seen[$status_constant]=1 
		fi
	done
	local status_prompt
	for status_constant in $status_constants
	do
		if (( ${+statuses_seen[$status_constant]} ))
		then
			local next_display=$constant_prompt_map[$status_constant] 
			status_prompt="$next_display$status_prompt" 
		fi
	done
	echo $status_prompt
}
_omz_register_handler () {
	setopt localoptions noksharrays unset
	typeset -ga _omz_async_functions
	if [[ -z "$1" ]] || (( ! ${+functions[$1]} )) || (( ${_omz_async_functions[(Ie)$1]} ))
	then
		return
	fi
	_omz_async_functions+=("$1") 
	if (( ! ${precmd_functions[(Ie)_omz_async_request]} )) && (( ${+functions[_omz_async_request]}))
	then
		autoload -Uz add-zsh-hook
		add-zsh-hook precmd _omz_async_request
	fi
}
_omz_source () {
	local context filepath="$1" 
	case "$filepath" in
		(lib/*) context="lib:${filepath:t:r}"  ;;
		(plugins/*) context="plugins:${filepath:h:t}"  ;;
	esac
	local disable_aliases=0 
	zstyle -T ":omz:${context}" aliases || disable_aliases=1 
	local -A aliases_pre galiases_pre
	if (( disable_aliases ))
	then
		aliases_pre=("${(@kv)aliases}") 
		galiases_pre=("${(@kv)galiases}") 
	fi
	if [[ -f "$ZSH_CUSTOM/$filepath" ]]
	then
		source "$ZSH_CUSTOM/$filepath"
	elif [[ -f "$ZSH/$filepath" ]]
	then
		source "$ZSH/$filepath"
	fi
	if (( disable_aliases ))
	then
		if (( #aliases_pre ))
		then
			aliases=("${(@kv)aliases_pre}") 
		else
			(( #aliases )) && unalias "${(@k)aliases}"
		fi
		if (( #galiases_pre ))
		then
			galiases=("${(@kv)galiases_pre}") 
		else
			(( #galiases )) && unalias "${(@k)galiases}"
		fi
	fi
}
_oomctl () {
	# undefined
	builtin autoload -XUz
}
_opencode () {
	# undefined
	builtin autoload -XUz
}
_openstack () {
	# undefined
	builtin autoload -XUz
}
_opkg () {
	# undefined
	builtin autoload -XUz
}
_options () {
	# undefined
	builtin autoload -XUz
}
_options_set () {
	# undefined
	builtin autoload -XUz
}
_options_unset () {
	# undefined
	builtin autoload -XUz
}
_opustools () {
	# undefined
	builtin autoload -XUz
}
_other_accounts () {
	# undefined
	builtin autoload -XUz
}
_p11-kit () {
	# undefined
	builtin autoload -XUz
}
_pack () {
	# undefined
	builtin autoload -XUz
}
_pacman () {
	# undefined
	builtin autoload -XUz
}
_pandoc () {
	# undefined
	builtin autoload -XUz
}
_parameter () {
	# undefined
	builtin autoload -XUz
}
_parameters () {
	# undefined
	builtin autoload -XUz
}
_paste () {
	# undefined
	builtin autoload -XUz
}
_patch () {
	# undefined
	builtin autoload -XUz
}
_patchutils () {
	# undefined
	builtin autoload -XUz
}
_path_commands () {
	# undefined
	builtin autoload -XUz
}
_path_files () {
	# undefined
	builtin autoload -XUz
}
_pax () {
	# undefined
	builtin autoload -XUz
}
_pbm () {
	# undefined
	builtin autoload -XUz
}
_pdf () {
	# undefined
	builtin autoload -XUz
}
_pdftk () {
	# undefined
	builtin autoload -XUz
}
_perf () {
	# undefined
	builtin autoload -XUz
}
_perforce () {
	# undefined
	builtin autoload -XUz
}
_perl () {
	# undefined
	builtin autoload -XUz
}
_perl_basepods () {
	# undefined
	builtin autoload -XUz
}
_perl_modules () {
	# undefined
	builtin autoload -XUz
}
_perldoc () {
	# undefined
	builtin autoload -XUz
}
_pgids () {
	# undefined
	builtin autoload -XUz
}
_pgrep () {
	# undefined
	builtin autoload -XUz
}
_php () {
	# undefined
	builtin autoload -XUz
}
_pick_variant () {
	# undefined
	builtin autoload -XUz
}
_picocom () {
	# undefined
	builtin autoload -XUz
}
_pidof () {
	# undefined
	builtin autoload -XUz
}
_pids () {
	# undefined
	builtin autoload -XUz
}
_pine () {
	# undefined
	builtin autoload -XUz
}
_ping () {
	# undefined
	builtin autoload -XUz
}
_pip () {
	# undefined
	builtin autoload -XUz
}
_pkg-config () {
	# undefined
	builtin autoload -XUz
}
_pkg_instance () {
	# undefined
	builtin autoload -XUz
}
_pkgadd () {
	# undefined
	builtin autoload -XUz
}
_pkginfo () {
	# undefined
	builtin autoload -XUz
}
_pkgrm () {
	# undefined
	builtin autoload -XUz
}
_playerctl () {
	# undefined
	builtin autoload -XUz
}
_pmap () {
	# undefined
	builtin autoload -XUz
}
_pon () {
	# undefined
	builtin autoload -XUz
}
_ports () {
	# undefined
	builtin autoload -XUz
}
_postfix () {
	# undefined
	builtin autoload -XUz
}
_postgresql () {
	# undefined
	builtin autoload -XUz
}
_postscript () {
	# undefined
	builtin autoload -XUz
}
_powerprofilesctl () {
	# undefined
	builtin autoload -XUz
}
_pr () {
	# undefined
	builtin autoload -XUz
}
_precommand () {
	# undefined
	builtin autoload -XUz
}
_prefix () {
	# undefined
	builtin autoload -XUz
}
_print () {
	# undefined
	builtin autoload -XUz
}
_printenv () {
	# undefined
	builtin autoload -XUz
}
_printers () {
	# undefined
	builtin autoload -XUz
}
_process_names () {
	# undefined
	builtin autoload -XUz
}
_prompt () {
	# undefined
	builtin autoload -XUz
}
_prove () {
	# undefined
	builtin autoload -XUz
}
_ps () {
	# undefined
	builtin autoload -XUz
}
_ps1234 () {
	# undefined
	builtin autoload -XUz
}
_pspdf () {
	# undefined
	builtin autoload -XUz
}
_psutils () {
	# undefined
	builtin autoload -XUz
}
_ptx () {
	# undefined
	builtin autoload -XUz
}
_pulseaudio () {
	# undefined
	builtin autoload -XUz
}
_pump () {
	# undefined
	builtin autoload -XUz
}
_pv () {
	# undefined
	builtin autoload -XUz
}
_pwgen () {
	# undefined
	builtin autoload -XUz
}
_pydoc () {
	# undefined
	builtin autoload -XUz
}
_python () {
	# undefined
	builtin autoload -XUz
}
_python_modules () {
	# undefined
	builtin autoload -XUz
}
_qdbus () {
	# undefined
	builtin autoload -XUz
}
_qemu () {
	# undefined
	builtin autoload -XUz
}
_qiv () {
	# undefined
	builtin autoload -XUz
}
_qpdf () {
	# undefined
	builtin autoload -XUz
}
_quilt () {
	# undefined
	builtin autoload -XUz
}
_rake () {
	# undefined
	builtin autoload -XUz
}
_ranlib () {
	# undefined
	builtin autoload -XUz
}
_rar () {
	# undefined
	builtin autoload -XUz
}
_rclone () {
	# undefined
	builtin autoload -XUz
}
_rcs () {
	# undefined
	builtin autoload -XUz
}
_rdesktop () {
	# undefined
	builtin autoload -XUz
}
_read () {
	# undefined
	builtin autoload -XUz
}
_read_comp () {
	# undefined
	builtin autoload -XUz
}
_readelf () {
	# undefined
	builtin autoload -XUz
}
_readlink () {
	# undefined
	builtin autoload -XUz
}
_redirect () {
	# undefined
	builtin autoload -XUz
}
_regex_arguments () {
	# undefined
	builtin autoload -XUz
}
_regex_words () {
	# undefined
	builtin autoload -XUz
}
_remote_files () {
	# undefined
	builtin autoload -XUz
}
_renice () {
	# undefined
	builtin autoload -XUz
}
_requested () {
	# undefined
	builtin autoload -XUz
}
_resolvectl () {
	# undefined
	builtin autoload -XUz
}
_retrieve_cache () {
	# undefined
	builtin autoload -XUz
}
_rg () {
	# undefined
	builtin autoload -XUz
}
_ri () {
	# undefined
	builtin autoload -XUz
}
_rlogin () {
	# undefined
	builtin autoload -XUz
}
_rm () {
	# undefined
	builtin autoload -XUz
}
_rmdir () {
	# undefined
	builtin autoload -XUz
}
_rmmod () {
	# undefined
	builtin autoload -XUz
}
_route () {
	# undefined
	builtin autoload -XUz
}
_rrdtool () {
	# undefined
	builtin autoload -XUz
}
_rsync () {
	# undefined
	builtin autoload -XUz
}
_rubber () {
	# undefined
	builtin autoload -XUz
}
_ruby () {
	# undefined
	builtin autoload -XUz
}
_run-help () {
	# undefined
	builtin autoload -XUz
}
_run0 () {
	# undefined
	builtin autoload -XUz
}
_runit () {
	# undefined
	builtin autoload -XUz
}
_samba () {
	# undefined
	builtin autoload -XUz
}
_satty () {
	# undefined
	builtin autoload -XUz
}
_sccs () {
	# undefined
	builtin autoload -XUz
}
_sched () {
	# undefined
	builtin autoload -XUz
}
_schedtool () {
	# undefined
	builtin autoload -XUz
}
_scons () {
	# undefined
	builtin autoload -XUz
}
_screen () {
	# undefined
	builtin autoload -XUz
}
_script () {
	# undefined
	builtin autoload -XUz
}
_sd_bus_address () {
	# undefined
	builtin autoload -XUz
}
_sd_hosts_or_user_at_host () {
	# undefined
	builtin autoload -XUz
}
_sd_machines () {
	# undefined
	builtin autoload -XUz
}
_sd_outputmodes () {
	# undefined
	builtin autoload -XUz
}
_sd_unit_files () {
	# undefined
	builtin autoload -XUz
}
_seafile () {
	# undefined
	builtin autoload -XUz
}
_sed () {
	# undefined
	builtin autoload -XUz
}
_selinux_contexts () {
	# undefined
	builtin autoload -XUz
}
_selinux_roles () {
	# undefined
	builtin autoload -XUz
}
_selinux_types () {
	# undefined
	builtin autoload -XUz
}
_selinux_users () {
	# undefined
	builtin autoload -XUz
}
_sensors () {
	# undefined
	builtin autoload -XUz
}
_sensors-detect () {
	# undefined
	builtin autoload -XUz
}
_sep_parts () {
	# undefined
	builtin autoload -XUz
}
_seq () {
	# undefined
	builtin autoload -XUz
}
_sequence () {
	# undefined
	builtin autoload -XUz
}
_service () {
	# undefined
	builtin autoload -XUz
}
_services () {
	# undefined
	builtin autoload -XUz
}
_set () {
	# undefined
	builtin autoload -XUz
}
_set_command () {
	# undefined
	builtin autoload -XUz
}
_setfacl () {
	# undefined
	builtin autoload -XUz
}
_setopt () {
	# undefined
	builtin autoload -XUz
}
_setpriv () {
	# undefined
	builtin autoload -XUz
}
_setsid () {
	# undefined
	builtin autoload -XUz
}
_setup () {
	# undefined
	builtin autoload -XUz
}
_setxkbmap () {
	# undefined
	builtin autoload -XUz
}
_sh () {
	# undefined
	builtin autoload -XUz
}
_shasum () {
	# undefined
	builtin autoload -XUz
}
_showmount () {
	# undefined
	builtin autoload -XUz
}
_shred () {
	# undefined
	builtin autoload -XUz
}
_shtab () {
	# undefined
	builtin autoload -XUz
}
_shuf () {
	# undefined
	builtin autoload -XUz
}
_shutdown () {
	# undefined
	builtin autoload -XUz
}
_signals () {
	# undefined
	builtin autoload -XUz
}
_sisu () {
	# undefined
	builtin autoload -XUz
}
_slabtop () {
	# undefined
	builtin autoload -XUz
}
_slrn () {
	# undefined
	builtin autoload -XUz
}
_smartmontools () {
	# undefined
	builtin autoload -XUz
}
_snapper () {
	# undefined
	builtin autoload -XUz
}
_socket () {
	# undefined
	builtin autoload -XUz
}
_sort () {
	# undefined
	builtin autoload -XUz
}
_source () {
	# undefined
	builtin autoload -XUz
}
_spamassassin () {
	# undefined
	builtin autoload -XUz
}
_split () {
	# undefined
	builtin autoload -XUz
}
_sqlite () {
	# undefined
	builtin autoload -XUz
}
_sqsh () {
	# undefined
	builtin autoload -XUz
}
_ss () {
	# undefined
	builtin autoload -XUz
}
_ssh () {
	# undefined
	builtin autoload -XUz
}
_ssh_hosts () {
	# undefined
	builtin autoload -XUz
}
_sshfs () {
	# undefined
	builtin autoload -XUz
}
_starship () {
	# undefined
	builtin autoload -XUz
}
_stat () {
	# undefined
	builtin autoload -XUz
}
_stdbuf () {
	# undefined
	builtin autoload -XUz
}
_stgit () {
	# undefined
	builtin autoload -XUz
}
_store_cache () {
	# undefined
	builtin autoload -XUz
}
_stow () {
	# undefined
	builtin autoload -XUz
}
_strace () {
	# undefined
	builtin autoload -XUz
}
_strftime () {
	# undefined
	builtin autoload -XUz
}
_strings () {
	# undefined
	builtin autoload -XUz
}
_strip () {
	# undefined
	builtin autoload -XUz
}
_stty () {
	# undefined
	builtin autoload -XUz
}
_su () {
	# undefined
	builtin autoload -XUz
}
_sub_commands () {
	# undefined
	builtin autoload -XUz
}
_sublimetext () {
	# undefined
	builtin autoload -XUz
}
_subscript () {
	# undefined
	builtin autoload -XUz
}
_subversion () {
	# undefined
	builtin autoload -XUz
}
_sudo () {
	# undefined
	builtin autoload -XUz
}
_suffix_alias_files () {
	# undefined
	builtin autoload -XUz
}
_surfraw () {
	# undefined
	builtin autoload -XUz
}
_swaks () {
	# undefined
	builtin autoload -XUz
}
_swanctl () {
	# undefined
	builtin autoload -XUz
}
_swift () {
	# undefined
	builtin autoload -XUz
}
_sys_calls () {
	# undefined
	builtin autoload -XUz
}
_sysctl () {
	# undefined
	builtin autoload -XUz
}
_sysstat () {
	# undefined
	builtin autoload -XUz
}
_systemctl () {
	# undefined
	builtin autoload -XUz
}
_systemd () {
	# undefined
	builtin autoload -XUz
}
_systemd-analyze () {
	# undefined
	builtin autoload -XUz
}
_systemd-delta () {
	# undefined
	builtin autoload -XUz
}
_systemd-hwdb () {
	# undefined
	builtin autoload -XUz
}
_systemd-id128 () {
	# undefined
	builtin autoload -XUz
}
_systemd-inhibit () {
	# undefined
	builtin autoload -XUz
}
_systemd-nspawn () {
	# undefined
	builtin autoload -XUz
}
_systemd-path () {
	# undefined
	builtin autoload -XUz
}
_systemd-run () {
	# undefined
	builtin autoload -XUz
}
_systemd-tmpfiles () {
	# undefined
	builtin autoload -XUz
}
_tac () {
	# undefined
	builtin autoload -XUz
}
_tags () {
	# undefined
	builtin autoload -XUz
}
_tail () {
	# undefined
	builtin autoload -XUz
}
_tailscale () {
	# undefined
	builtin autoload -XUz
}
_tar () {
	# undefined
	builtin autoload -XUz
}
_tar_archive () {
	# undefined
	builtin autoload -XUz
}
_tardy () {
	# undefined
	builtin autoload -XUz
}
_tcpdump () {
	# undefined
	builtin autoload -XUz
}
_tcpsys () {
	# undefined
	builtin autoload -XUz
}
_tcptraceroute () {
	# undefined
	builtin autoload -XUz
}
_tee () {
	# undefined
	builtin autoload -XUz
}
_telnet () {
	# undefined
	builtin autoload -XUz
}
_terminals () {
	# undefined
	builtin autoload -XUz
}
_tex () {
	# undefined
	builtin autoload -XUz
}
_texi () {
	# undefined
	builtin autoload -XUz
}
_texinfo () {
	# undefined
	builtin autoload -XUz
}
_tidy () {
	# undefined
	builtin autoload -XUz
}
_tiff () {
	# undefined
	builtin autoload -XUz
}
_tilde () {
	# undefined
	builtin autoload -XUz
}
_tilde_files () {
	# undefined
	builtin autoload -XUz
}
_time_zone () {
	# undefined
	builtin autoload -XUz
}
_timedatectl () {
	# undefined
	builtin autoload -XUz
}
_timeout () {
	# undefined
	builtin autoload -XUz
}
_tin () {
	# undefined
	builtin autoload -XUz
}
_tla () {
	# undefined
	builtin autoload -XUz
}
_tldr () {
	# undefined
	builtin autoload -XUz
}
_tload () {
	# undefined
	builtin autoload -XUz
}
_tmux () {
	# undefined
	builtin autoload -XUz
}
_todo.sh () {
	# undefined
	builtin autoload -XUz
}
_toilet () {
	# undefined
	builtin autoload -XUz
}
_top () {
	# undefined
	builtin autoload -XUz
}
_topgit () {
	# undefined
	builtin autoload -XUz
}
_totd () {
	# undefined
	builtin autoload -XUz
}
_touch () {
	# undefined
	builtin autoload -XUz
}
_tpb () {
	# undefined
	builtin autoload -XUz
}
_tput () {
	# undefined
	builtin autoload -XUz
}
_tr () {
	# undefined
	builtin autoload -XUz
}
_tracepath () {
	# undefined
	builtin autoload -XUz
}
_transmission () {
	# undefined
	builtin autoload -XUz
}
_trap () {
	# undefined
	builtin autoload -XUz
}
_tree () {
	# undefined
	builtin autoload -XUz
}
_tree-sitter () {
	# undefined
	builtin autoload -XUz
}
_truncate () {
	# undefined
	builtin autoload -XUz
}
_truss () {
	# undefined
	builtin autoload -XUz
}
_trust () {
	# undefined
	builtin autoload -XUz
}
_tty () {
	# undefined
	builtin autoload -XUz
}
_ttyctl () {
	# undefined
	builtin autoload -XUz
}
_ttys () {
	# undefined
	builtin autoload -XUz
}
_tune2fs () {
	# undefined
	builtin autoload -XUz
}
_twidge () {
	# undefined
	builtin autoload -XUz
}
_twisted () {
	# undefined
	builtin autoload -XUz
}
_typeset () {
	# undefined
	builtin autoload -XUz
}
_udevadm () {
	# undefined
	builtin autoload -XUz
}
_udisks2 () {
	# undefined
	builtin autoload -XUz
}
_ulimit () {
	# undefined
	builtin autoload -XUz
}
_uml () {
	# undefined
	builtin autoload -XUz
}
_umountable () {
	# undefined
	builtin autoload -XUz
}
_unace () {
	# undefined
	builtin autoload -XUz
}
_uname () {
	# undefined
	builtin autoload -XUz
}
_unexpand () {
	# undefined
	builtin autoload -XUz
}
_unhash () {
	# undefined
	builtin autoload -XUz
}
_uniq () {
	# undefined
	builtin autoload -XUz
}
_unison () {
	# undefined
	builtin autoload -XUz
}
_units () {
	# undefined
	builtin autoload -XUz
}
_unshare () {
	# undefined
	builtin autoload -XUz
}
_upower () {
	# undefined
	builtin autoload -XUz
}
_uptime () {
	# undefined
	builtin autoload -XUz
}
_urls () {
	# undefined
	builtin autoload -XUz
}
_urxvt () {
	# undefined
	builtin autoload -XUz
}
_user_admin () {
	# undefined
	builtin autoload -XUz
}
_user_at_host () {
	# undefined
	builtin autoload -XUz
}
_user_expand () {
	# undefined
	builtin autoload -XUz
}
_user_math_func () {
	# undefined
	builtin autoload -XUz
}
_userdbctl () {
	# undefined
	builtin autoload -XUz
}
_users () {
	# undefined
	builtin autoload -XUz
}
_users_on () {
	# undefined
	builtin autoload -XUz
}
_valgrind () {
	# undefined
	builtin autoload -XUz
}
_value () {
	# undefined
	builtin autoload -XUz
}
_values () {
	# undefined
	builtin autoload -XUz
}
_vared () {
	# undefined
	builtin autoload -XUz
}
_varlinkctl () {
	# undefined
	builtin autoload -XUz
}
_vars () {
	# undefined
	builtin autoload -XUz
}
_vcs_info () {
	# undefined
	builtin autoload -XUz
}
_vcs_info_hooks () {
	# undefined
	builtin autoload -XUz
}
_vi () {
	# undefined
	builtin autoload -XUz
}
_vim () {
	# undefined
	builtin autoload -XUz
}
_visudo () {
	# undefined
	builtin autoload -XUz
}
_vmstat () {
	# undefined
	builtin autoload -XUz
}
_vnc () {
	# undefined
	builtin autoload -XUz
}
_vorbis () {
	# undefined
	builtin autoload -XUz
}
_vpnc () {
	# undefined
	builtin autoload -XUz
}
_vserver () {
	# undefined
	builtin autoload -XUz
}
_w () {
	# undefined
	builtin autoload -XUz
}
_w3m () {
	# undefined
	builtin autoload -XUz
}
_wait () {
	# undefined
	builtin autoload -XUz
}
_wakeup_capable_devices () {
	# undefined
	builtin autoload -XUz
}
_wanted () {
	# undefined
	builtin autoload -XUz
}
_watch () {
	# undefined
	builtin autoload -XUz
}
_wc () {
	# undefined
	builtin autoload -XUz
}
_webbrowser () {
	# undefined
	builtin autoload -XUz
}
_wget () {
	# undefined
	builtin autoload -XUz
}
_whereis () {
	# undefined
	builtin autoload -XUz
}
_which () {
	# undefined
	builtin autoload -XUz
}
_who () {
	# undefined
	builtin autoload -XUz
}
_whois () {
	# undefined
	builtin autoload -XUz
}
_widgets () {
	# undefined
	builtin autoload -XUz
}
_wiggle () {
	# undefined
	builtin autoload -XUz
}
_wipefs () {
	# undefined
	builtin autoload -XUz
}
_wl-copy () {
	# undefined
	builtin autoload -XUz
}
_wl-paste () {
	# undefined
	builtin autoload -XUz
}
_wpa_cli () {
	# undefined
	builtin autoload -XUz
}
_wpctl () {
	# undefined
	builtin autoload -XUz
}
_x_arguments () {
	# undefined
	builtin autoload -XUz
}
_x_borderwidth () {
	# undefined
	builtin autoload -XUz
}
_x_color () {
	# undefined
	builtin autoload -XUz
}
_x_colormapid () {
	# undefined
	builtin autoload -XUz
}
_x_cursor () {
	# undefined
	builtin autoload -XUz
}
_x_display () {
	# undefined
	builtin autoload -XUz
}
_x_extension () {
	# undefined
	builtin autoload -XUz
}
_x_font () {
	# undefined
	builtin autoload -XUz
}
_x_geometry () {
	# undefined
	builtin autoload -XUz
}
_x_keysym () {
	# undefined
	builtin autoload -XUz
}
_x_locale () {
	# undefined
	builtin autoload -XUz
}
_x_modifier () {
	# undefined
	builtin autoload -XUz
}
_x_name () {
	# undefined
	builtin autoload -XUz
}
_x_resource () {
	# undefined
	builtin autoload -XUz
}
_x_selection_timeout () {
	# undefined
	builtin autoload -XUz
}
_x_title () {
	# undefined
	builtin autoload -XUz
}
_x_utils () {
	# undefined
	builtin autoload -XUz
}
_x_visual () {
	# undefined
	builtin autoload -XUz
}
_x_window () {
	# undefined
	builtin autoload -XUz
}
_xargs () {
	# undefined
	builtin autoload -XUz
}
_xauth () {
	# undefined
	builtin autoload -XUz
}
_xautolock () {
	# undefined
	builtin autoload -XUz
}
_xclip () {
	# undefined
	builtin autoload -XUz
}
_xdvi () {
	# undefined
	builtin autoload -XUz
}
_xfig () {
	# undefined
	builtin autoload -XUz
}
_xft_fonts () {
	# undefined
	builtin autoload -XUz
}
_xinput () {
	# undefined
	builtin autoload -XUz
}
_xloadimage () {
	# undefined
	builtin autoload -XUz
}
_xmlsoft () {
	# undefined
	builtin autoload -XUz
}
_xmlstarlet () {
	# undefined
	builtin autoload -XUz
}
_xmms2 () {
	# undefined
	builtin autoload -XUz
}
_xmodmap () {
	# undefined
	builtin autoload -XUz
}
_xournal () {
	# undefined
	builtin autoload -XUz
}
_xpdf () {
	# undefined
	builtin autoload -XUz
}
_xrandr () {
	# undefined
	builtin autoload -XUz
}
_xscreensaver () {
	# undefined
	builtin autoload -XUz
}
_xset () {
	# undefined
	builtin autoload -XUz
}
_xt_arguments () {
	# undefined
	builtin autoload -XUz
}
_xt_session_id () {
	# undefined
	builtin autoload -XUz
}
_xterm () {
	# undefined
	builtin autoload -XUz
}
_xv () {
	# undefined
	builtin autoload -XUz
}
_xwit () {
	# undefined
	builtin autoload -XUz
}
_xxd () {
	# undefined
	builtin autoload -XUz
}
_xz () {
	# undefined
	builtin autoload -XUz
}
_yafc () {
	# undefined
	builtin autoload -XUz
}
_yay () {
	# undefined
	builtin autoload -XUz
}
_yodl () {
	# undefined
	builtin autoload -XUz
}
_yp () {
	# undefined
	builtin autoload -XUz
}
_yt-dlp () {
	# undefined
	builtin autoload -XUz
}
_zargs () {
	# undefined
	builtin autoload -XUz
}
_zattr () {
	# undefined
	builtin autoload -XUz
}
_zcalc () {
	# undefined
	builtin autoload -XUz
}
_zcalc_line () {
	# undefined
	builtin autoload -XUz
}
_zcat () {
	# undefined
	builtin autoload -XUz
}
_zcompile () {
	# undefined
	builtin autoload -XUz
}
_zdump () {
	# undefined
	builtin autoload -XUz
}
_zeal () {
	# undefined
	builtin autoload -XUz
}
_zed () {
	# undefined
	builtin autoload -XUz
}
_zfs () {
	# undefined
	builtin autoload -XUz
}
_zfs_dataset () {
	# undefined
	builtin autoload -XUz
}
_zfs_pool () {
	# undefined
	builtin autoload -XUz
}
_zftp () {
	# undefined
	builtin autoload -XUz
}
_zip () {
	# undefined
	builtin autoload -XUz
}
_zle () {
	# undefined
	builtin autoload -XUz
}
_zmodload () {
	# undefined
	builtin autoload -XUz
}
_zmv () {
	# undefined
	builtin autoload -XUz
}
_zoxide () {
	# undefined
	builtin autoload -XUz
}
_zparseopts () {
	# undefined
	builtin autoload -XUz
}
_zpty () {
	# undefined
	builtin autoload -XUz
}
_zsh () {
	# undefined
	builtin autoload -XUz
}
_zsh-mime-handler () {
	# undefined
	builtin autoload -XUz
}
_zsh_autosuggest_accept () {
	local -i retval max_cursor_pos=$#BUFFER 
	if [[ "$KEYMAP" = "vicmd" ]]
	then
		max_cursor_pos=$((max_cursor_pos - 1)) 
	fi
	if (( $CURSOR != $max_cursor_pos || !$#POSTDISPLAY ))
	then
		_zsh_autosuggest_invoke_original_widget $@
		return
	fi
	BUFFER="$BUFFER$POSTDISPLAY" 
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget $@
	retval=$? 
	if [[ "$KEYMAP" = "vicmd" ]]
	then
		CURSOR=$(($#BUFFER - 1)) 
	else
		CURSOR=$#BUFFER 
	fi
	return $retval
}
_zsh_autosuggest_async_request () {
	zmodload zsh/system 2> /dev/null
	typeset -g _ZSH_AUTOSUGGEST_ASYNC_FD _ZSH_AUTOSUGGEST_CHILD_PID
	if [[ -n "$_ZSH_AUTOSUGGEST_ASYNC_FD" ]] && {
			true <&$_ZSH_AUTOSUGGEST_ASYNC_FD
		} 2> /dev/null
	then
		builtin exec {_ZSH_AUTOSUGGEST_ASYNC_FD}<&-
		zle -F $_ZSH_AUTOSUGGEST_ASYNC_FD
		if [[ -n "$_ZSH_AUTOSUGGEST_CHILD_PID" ]]
		then
			if [[ -o MONITOR ]]
			then
				kill -TERM -$_ZSH_AUTOSUGGEST_CHILD_PID 2> /dev/null
			else
				kill -TERM $_ZSH_AUTOSUGGEST_CHILD_PID 2> /dev/null
			fi
		fi
	fi
	builtin exec {_ZSH_AUTOSUGGEST_ASYNC_FD}< <(
		# Tell parent process our pid
		echo $sysparams[pid]

		# Fetch and print the suggestion
		local suggestion
		_zsh_autosuggest_fetch_suggestion "$1"
		echo -nE "$suggestion"
	)
	autoload -Uz is-at-least
	is-at-least 5.8 || command true
	read _ZSH_AUTOSUGGEST_CHILD_PID <&$_ZSH_AUTOSUGGEST_ASYNC_FD
	zle -F "$_ZSH_AUTOSUGGEST_ASYNC_FD" _zsh_autosuggest_async_response
}
_zsh_autosuggest_async_response () {
	emulate -L zsh
	local suggestion
	if [[ -z "$2" || "$2" == "hup" ]]
	then
		IFS='' read -rd '' -u $1 suggestion
		zle autosuggest-suggest -- "$suggestion"
		builtin exec {1}<&-
	fi
	zle -F "$1"
	_ZSH_AUTOSUGGEST_ASYNC_FD= 
}
_zsh_autosuggest_bind_widget () {
	typeset -gA _ZSH_AUTOSUGGEST_BIND_COUNTS
	local widget=$1 
	local autosuggest_action=$2 
	local prefix=$ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX 
	local -i bind_count
	case $widgets[$widget] in
		(user:_zsh_autosuggest_(bound|orig)_*) bind_count=$((_ZSH_AUTOSUGGEST_BIND_COUNTS[$widget]))  ;;
		(user:*) _zsh_autosuggest_incr_bind_count $widget
			zle -N $prefix$bind_count-$widget ${widgets[$widget]#*:} ;;
		(builtin) _zsh_autosuggest_incr_bind_count $widget
			eval "_zsh_autosuggest_orig_${(q)widget}() { zle .${(q)widget} }"
			zle -N $prefix$bind_count-$widget _zsh_autosuggest_orig_$widget ;;
		(completion:*) _zsh_autosuggest_incr_bind_count $widget
			eval "zle -C $prefix$bind_count-${(q)widget} ${${(s.:.)widgets[$widget]}[2,3]}" ;;
	esac
	eval "_zsh_autosuggest_bound_${bind_count}_${(q)widget}() {
		_zsh_autosuggest_widget_$autosuggest_action $prefix$bind_count-${(q)widget} \$@
	}"
	zle -N -- $widget _zsh_autosuggest_bound_${bind_count}_$widget
}
_zsh_autosuggest_bind_widgets () {
	emulate -L zsh
	local widget
	local ignore_widgets
	ignore_widgets=(.\* _\* ${_ZSH_AUTOSUGGEST_BUILTIN_ACTIONS/#/autosuggest-} $ZSH_AUTOSUGGEST_ORIGINAL_WIDGET_PREFIX\* $ZSH_AUTOSUGGEST_IGNORE_WIDGETS) 
	for widget in ${${(f)"$(builtin zle -la)"}:#${(j:|:)~ignore_widgets}}
	do
		if [[ -n ${ZSH_AUTOSUGGEST_CLEAR_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget clear
		elif [[ -n ${ZSH_AUTOSUGGEST_ACCEPT_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget accept
		elif [[ -n ${ZSH_AUTOSUGGEST_EXECUTE_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget execute
		elif [[ -n ${ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS[(r)$widget]} ]]
		then
			_zsh_autosuggest_bind_widget $widget partial_accept
		else
			_zsh_autosuggest_bind_widget $widget modify
		fi
	done
}
_zsh_autosuggest_capture_completion_async () {
	_zsh_autosuggest_capture_setup
	zmodload zsh/parameter 2> /dev/null || return
	autoload +X _complete
	functions[_original_complete]=$functions[_complete] 
	_complete () {
		unset 'compstate[vared]'
		_original_complete "$@"
	}
	vared 1
}
_zsh_autosuggest_capture_completion_sync () {
	_zsh_autosuggest_capture_setup
	zle autosuggest-capture-completion
}
_zsh_autosuggest_capture_completion_widget () {
	local -a +h comppostfuncs
	comppostfuncs=(_zsh_autosuggest_capture_postcompletion) 
	CURSOR=$#BUFFER 
	zle -- ${(k)widgets[(r)completion:.complete-word:_main_complete]}
	if is-at-least 5.0.3
	then
		stty -onlcr -ocrnl -F /dev/tty
	fi
	echo -nE - $'\0'$BUFFER$'\0'
}
_zsh_autosuggest_capture_postcompletion () {
	compstate[insert]=1 
	unset 'compstate[list]'
}
_zsh_autosuggest_capture_setup () {
	if ! is-at-least 5.4
	then
		zshexit () {
			kill -KILL $$ 2>&- || command kill -KILL $$
			sleep 1
		}
	fi
	zstyle ':completion:*' matcher-list ''
	zstyle ':completion:*' path-completion false
	zstyle ':completion:*' max-errors 0 not-numeric
	bindkey '^I' autosuggest-capture-completion
}
_zsh_autosuggest_clear () {
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget $@
}
_zsh_autosuggest_disable () {
	typeset -g _ZSH_AUTOSUGGEST_DISABLED
	_zsh_autosuggest_clear
}
_zsh_autosuggest_enable () {
	unset _ZSH_AUTOSUGGEST_DISABLED
	if (( $#BUFFER ))
	then
		_zsh_autosuggest_fetch
	fi
}
_zsh_autosuggest_escape_command () {
	setopt localoptions EXTENDED_GLOB
	echo -E "${1//(#m)[\"\'\\()\[\]|*?~]/\\$MATCH}"
}
_zsh_autosuggest_execute () {
	BUFFER="$BUFFER$POSTDISPLAY" 
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget "accept-line"
}
_zsh_autosuggest_fetch () {
	if (( ${+ZSH_AUTOSUGGEST_USE_ASYNC} ))
	then
		_zsh_autosuggest_async_request "$BUFFER"
	else
		local suggestion
		_zsh_autosuggest_fetch_suggestion "$BUFFER"
		_zsh_autosuggest_suggest "$suggestion"
	fi
}
_zsh_autosuggest_fetch_suggestion () {
	typeset -g suggestion
	local -a strategies
	local strategy
	strategies=(${=ZSH_AUTOSUGGEST_STRATEGY}) 
	for strategy in $strategies
	do
		_zsh_autosuggest_strategy_$strategy "$1"
		[[ "$suggestion" != "$1"* ]] && unset suggestion
		[[ -n "$suggestion" ]] && break
	done
}
_zsh_autosuggest_highlight_apply () {
	typeset -g _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	if (( $#POSTDISPLAY ))
	then
		typeset -g _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT="$#BUFFER $(($#BUFFER + $#POSTDISPLAY)) $ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE" 
		region_highlight+=("$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT") 
	else
		unset _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	fi
}
_zsh_autosuggest_highlight_reset () {
	typeset -g _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	if [[ -n "$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT" ]]
	then
		region_highlight=("${(@)region_highlight:#$_ZSH_AUTOSUGGEST_LAST_HIGHLIGHT}") 
		unset _ZSH_AUTOSUGGEST_LAST_HIGHLIGHT
	fi
}
_zsh_autosuggest_incr_bind_count () {
	typeset -gi bind_count=$((_ZSH_AUTOSUGGEST_BIND_COUNTS[$1]+1)) 
	_ZSH_AUTOSUGGEST_BIND_COUNTS[$1]=$bind_count 
}
_zsh_autosuggest_invoke_original_widget () {
	(( $# )) || return 0
	local original_widget_name="$1" 
	shift
	if (( ${+widgets[$original_widget_name]} ))
	then
		zle $original_widget_name -- $@
	fi
}
_zsh_autosuggest_modify () {
	local -i retval
	local -i KEYS_QUEUED_COUNT
	local orig_buffer="$BUFFER" 
	local orig_postdisplay="$POSTDISPLAY" 
	POSTDISPLAY= 
	_zsh_autosuggest_invoke_original_widget $@
	retval=$? 
	emulate -L zsh
	if (( $PENDING > 0 || $KEYS_QUEUED_COUNT > 0 ))
	then
		POSTDISPLAY="$orig_postdisplay" 
		return $retval
	fi
	if [[ "$BUFFER" = "$orig_buffer"* && "$orig_postdisplay" = "${BUFFER:$#orig_buffer}"* ]]
	then
		POSTDISPLAY="${orig_postdisplay:$(($#BUFFER - $#orig_buffer))}" 
		return $retval
	fi
	if (( ${+_ZSH_AUTOSUGGEST_DISABLED} ))
	then
		return $?
	fi
	if (( $#BUFFER > 0 ))
	then
		if [[ -z "$ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE" ]] || (( $#BUFFER <= $ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE ))
		then
			_zsh_autosuggest_fetch
		fi
	fi
	return $retval
}
_zsh_autosuggest_partial_accept () {
	local -i retval cursor_loc
	local original_buffer="$BUFFER" 
	BUFFER="$BUFFER$POSTDISPLAY" 
	_zsh_autosuggest_invoke_original_widget $@
	retval=$? 
	cursor_loc=$CURSOR 
	if [[ "$KEYMAP" = "vicmd" ]]
	then
		cursor_loc=$((cursor_loc + 1)) 
	fi
	if (( $cursor_loc > $#original_buffer ))
	then
		POSTDISPLAY="${BUFFER[$(($cursor_loc + 1)),$#BUFFER]}" 
		BUFFER="${BUFFER[1,$cursor_loc]}" 
	else
		BUFFER="$original_buffer" 
	fi
	return $retval
}
_zsh_autosuggest_start () {
	if (( ${+ZSH_AUTOSUGGEST_MANUAL_REBIND} ))
	then
		add-zsh-hook -d precmd _zsh_autosuggest_start
	fi
	_zsh_autosuggest_bind_widgets
}
_zsh_autosuggest_strategy_completion () {
	emulate -L zsh
	setopt EXTENDED_GLOB
	typeset -g suggestion
	local line REPLY
	whence compdef > /dev/null || return
	zmodload zsh/zpty 2> /dev/null || return
	[[ -n "$ZSH_AUTOSUGGEST_COMPLETION_IGNORE" ]] && [[ "$1" == $~ZSH_AUTOSUGGEST_COMPLETION_IGNORE ]] && return
	if zle
	then
		zpty $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME _zsh_autosuggest_capture_completion_sync
	else
		zpty $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME _zsh_autosuggest_capture_completion_async "\$1"
		zpty -w $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME $'\t'
	fi
	{
		zpty -r $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME line '*'$'\0''*'$'\0'
		suggestion="${${(@0)line}[2]}" 
	} always {
		zpty -d $ZSH_AUTOSUGGEST_COMPLETIONS_PTY_NAME
	}
}
_zsh_autosuggest_strategy_history () {
	emulate -L zsh
	setopt EXTENDED_GLOB
	local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}" 
	local pattern="$prefix*" 
	if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]
	then
		pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)" 
	fi
	typeset -g suggestion="${history[(r)$pattern]}" 
}
_zsh_autosuggest_strategy_match_prev_cmd () {
	emulate -L zsh
	setopt EXTENDED_GLOB
	local prefix="${1//(#m)[\\*?[\]<>()|^~#]/\\$MATCH}" 
	local pattern="$prefix*" 
	if [[ -n $ZSH_AUTOSUGGEST_HISTORY_IGNORE ]]
	then
		pattern="($pattern)~($ZSH_AUTOSUGGEST_HISTORY_IGNORE)" 
	fi
	local history_match_keys
	history_match_keys=(${(k)history[(R)$~pattern]}) 
	local histkey="${history_match_keys[1]}" 
	local prev_cmd="$(_zsh_autosuggest_escape_command "${history[$((HISTCMD-1))]}")" 
	for key in "${(@)history_match_keys[1,200]}"
	do
		[[ $key -gt 1 ]] || break
		if [[ "${history[$((key - 1))]}" == "$prev_cmd" ]]
		then
			histkey="$key" 
			break
		fi
	done
	typeset -g suggestion="$history[$histkey]" 
}
_zsh_autosuggest_suggest () {
	emulate -L zsh
	local suggestion="$1" 
	if [[ -n "$suggestion" ]] && (( $#BUFFER ))
	then
		POSTDISPLAY="${suggestion#$BUFFER}" 
	else
		POSTDISPLAY= 
	fi
}
_zsh_autosuggest_toggle () {
	if (( ${+_ZSH_AUTOSUGGEST_DISABLED} ))
	then
		_zsh_autosuggest_enable
	else
		_zsh_autosuggest_disable
	fi
}
_zsh_autosuggest_widget_accept () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_accept $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_clear () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_clear $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_disable () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_disable $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_enable () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_enable $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_execute () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_execute $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_fetch () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_fetch $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_modify () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_modify $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_partial_accept () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_partial_accept $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_suggest () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_suggest $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_autosuggest_widget_toggle () {
	local -i retval
	_zsh_autosuggest_highlight_reset
	_zsh_autosuggest_toggle $@
	retval=$? 
	_zsh_autosuggest_highlight_apply
	zle -R
	return $retval
}
_zsh_highlight () {
	local ret=$? 
	typeset -r ret
	(( ${+region_highlight[@]} )) || {
		echo 'zsh-syntax-highlighting: error: $region_highlight is not defined' >&2
		echo 'zsh-syntax-highlighting: (Check whether zsh-syntax-highlighting was installed according to the instructions.)' >&2
		return $ret
	}
	(( ${+zsh_highlight__memo_feature} )) || {
		region_highlight+=(" 0 0 fg=red, memo=zsh-syntax-highlighting") 
		case ${region_highlight[-1]} in
			("0 0 fg=red") integer -gr zsh_highlight__memo_feature=0  ;;
			("0 0 fg=red memo=zsh-syntax-highlighting") integer -gr zsh_highlight__memo_feature=1  ;;
			(" 0 0 fg=red, memo=zsh-syntax-highlighting")  ;&
			(*) if is-at-least 5.9
				then
					integer -gr zsh_highlight__memo_feature=1 
				else
					integer -gr zsh_highlight__memo_feature=0 
				fi ;;
		esac
		region_highlight[-1]=() 
	}
	if (( zsh_highlight__memo_feature ))
	then
		region_highlight=("${(@)region_highlight:#*memo=zsh-syntax-highlighting*}") 
	else
		region_highlight=() 
	fi
	if [[ $WIDGET == zle-isearch-update ]] && {
			$zsh_highlight__pat_static_bug || ! (( $+ISEARCHMATCH_ACTIVE ))
		}
	then
		return $ret
	fi
	local -A zsyh_user_options
	if zmodload -e zsh/parameter
	then
		zsyh_user_options=("${(kv)options[@]}") 
	else
		local canonical_options onoff option raw_options
		raw_options=(${(f)"$(emulate -R zsh; set -o)"}) 
		canonical_options=(${${${(M)raw_options:#*off}%% *}#no} ${${(M)raw_options:#*on}%% *}) 
		for option in "${canonical_options[@]}"
		do
			[[ -o $option ]]
			case $? in
				(0) zsyh_user_options+=($option on)  ;;
				(1) zsyh_user_options+=($option off)  ;;
				(*) echo "zsh-syntax-highlighting: warning: '[[ -o $option ]]' returned $?" ;;
			esac
		done
	fi
	typeset -r zsyh_user_options
	emulate -L zsh
	setopt localoptions warncreateglobal nobashrematch
	local REPLY
	[[ -n ${ZSH_HIGHLIGHT_MAXLENGTH:-} ]] && [[ $#BUFFER -gt $ZSH_HIGHLIGHT_MAXLENGTH ]] && return $ret
	(( KEYS_QUEUED_COUNT > 0 )) && return $ret
	(( PENDING > 0 )) && return $ret
	{
		local cache_place
		local -a region_highlight_copy
		local highlighter
		for highlighter in $ZSH_HIGHLIGHT_HIGHLIGHTERS
		do
			cache_place="_zsh_highlight__highlighter_${highlighter}_cache" 
			typeset -ga ${cache_place}
			if ! type "_zsh_highlight_highlighter_${highlighter}_predicate" >&/dev/null
			then
				echo "zsh-syntax-highlighting: warning: disabling the ${(qq)highlighter} highlighter as it has not been loaded" >&2
				ZSH_HIGHLIGHT_HIGHLIGHTERS=(${ZSH_HIGHLIGHT_HIGHLIGHTERS:#${highlighter}}) 
			elif "_zsh_highlight_highlighter_${highlighter}_predicate"
			then
				region_highlight_copy=("${region_highlight[@]}") 
				region_highlight=() 
				{
					"_zsh_highlight_highlighter_${highlighter}_paint"
				} always {
					: ${(AP)cache_place::="${region_highlight[@]}"}
				}
				region_highlight=("${region_highlight_copy[@]}") 
			fi
			region_highlight+=("${(@P)cache_place}") 
		done
		() {
			(( REGION_ACTIVE )) || return
			integer min max
			if (( MARK > CURSOR ))
			then
				min=$CURSOR max=$MARK 
			else
				min=$MARK max=$CURSOR 
			fi
			if (( REGION_ACTIVE == 1 ))
			then
				[[ $KEYMAP = vicmd ]] && (( max++ ))
			elif (( REGION_ACTIVE == 2 ))
			then
				local needle=$'\n' 
				(( min = ${BUFFER[(Ib:min:)$needle]} ))
				(( max = ${BUFFER[(ib:max:)$needle]} - 1 ))
			fi
			_zsh_highlight_apply_zle_highlight region standout "$min" "$max"
		}
		(( $+YANK_ACTIVE )) && (( YANK_ACTIVE )) && _zsh_highlight_apply_zle_highlight paste standout "$YANK_START" "$YANK_END"
		(( $+ISEARCHMATCH_ACTIVE )) && (( ISEARCHMATCH_ACTIVE )) && _zsh_highlight_apply_zle_highlight isearch underline "$ISEARCHMATCH_START" "$ISEARCHMATCH_END"
		(( $+SUFFIX_ACTIVE )) && (( SUFFIX_ACTIVE )) && _zsh_highlight_apply_zle_highlight suffix bold "$SUFFIX_START" "$SUFFIX_END"
		return $ret
	} always {
		typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER="$BUFFER" 
		typeset -gi _ZSH_HIGHLIGHT_PRIOR_CURSOR=$CURSOR 
	}
}
_zsh_highlight__function_callable_p () {
	if _zsh_highlight__is_function_p "$1" && ! _zsh_highlight__function_is_autoload_stub_p "$1"
	then
		return 0
	else
		(
			autoload -U +X -- "$1" 2> /dev/null
		)
		return $?
	fi
}
_zsh_highlight__function_is_autoload_stub_p () {
	if zmodload -e zsh/parameter
	then
		[[ "$functions[$1]" == *"builtin autoload -X"* ]]
	else
		[[ "${${(@f)"$(which -- "$1")"}[2]}" == $'\t'$histchars[3]' undefined' ]]
	fi
}
_zsh_highlight__is_function_p () {
	if zmodload -e zsh/parameter
	then
		(( ${+functions[$1]} ))
	else
		[[ $(type -wa -- "$1") == *'function'* ]]
	fi
}
_zsh_highlight__zle-line-finish () {
	() {
		local -h -r WIDGET=zle-line-finish 
		_zsh_highlight
	}
}
_zsh_highlight__zle-line-pre-redraw () {
	true && _zsh_highlight "$@"
}
_zsh_highlight_add_highlight () {
	local -i start end
	local highlight
	start=$1 
	end=$2 
	shift 2
	for highlight
	do
		if (( $+ZSH_HIGHLIGHT_STYLES[$highlight] ))
		then
			region_highlight+=("$start $end $ZSH_HIGHLIGHT_STYLES[$highlight], memo=zsh-syntax-highlighting") 
			break
		fi
	done
}
_zsh_highlight_apply_zle_highlight () {
	local entry="$1" default="$2" 
	integer first="$3" second="$4" 
	local region="${zle_highlight[(r)${entry}:*]-}" 
	if [[ -z "$region" ]]
	then
		region=$default 
	else
		region="${region#${entry}:}" 
		if [[ -z "$region" ]] || [[ "$region" == none ]]
		then
			return
		fi
	fi
	integer start end
	if (( first < second ))
	then
		start=$first end=$second 
	else
		start=$second end=$first 
	fi
	region_highlight+=("$start $end $region, memo=zsh-syntax-highlighting") 
}
_zsh_highlight_bind_widgets () {
	
}
_zsh_highlight_brackets_match () {
	case $BUFFER[$1] in
		(\() [[ $BUFFER[$2] == \) ]] ;;
		(\[) [[ $BUFFER[$2] == \] ]] ;;
		(\{) [[ $BUFFER[$2] == \} ]] ;;
		(*) false ;;
	esac
}
_zsh_highlight_buffer_modified () {
	[[ "${_ZSH_HIGHLIGHT_PRIOR_BUFFER:-}" != "$BUFFER" ]]
}
_zsh_highlight_call_widget () {
	builtin zle "$@" && _zsh_highlight
}
_zsh_highlight_cursor_moved () {
	[[ -n $CURSOR ]] && [[ -n ${_ZSH_HIGHLIGHT_PRIOR_CURSOR-} ]] && (($_ZSH_HIGHLIGHT_PRIOR_CURSOR != $CURSOR))
}
_zsh_highlight_highlighter_brackets_paint () {
	local char style
	local -i bracket_color_size=${#ZSH_HIGHLIGHT_STYLES[(I)bracket-level-*]} buflen=${#BUFFER} level=0 matchingpos pos 
	local -A levelpos lastoflevel matching
	pos=0 
	for char in ${(s..)BUFFER}
	do
		(( ++pos ))
		case $char in
			(["([{"]) levelpos[$pos]=$((++level)) 
				lastoflevel[$level]=$pos  ;;
			([")]}"]) if (( level > 0 ))
				then
					matchingpos=$lastoflevel[$level] 
					levelpos[$pos]=$((level--)) 
					if _zsh_highlight_brackets_match $matchingpos $pos
					then
						matching[$matchingpos]=$pos 
						matching[$pos]=$matchingpos 
					fi
				else
					levelpos[$pos]=-1 
				fi ;;
		esac
	done
	for pos in ${(k)levelpos}
	do
		if (( $+matching[$pos] ))
		then
			if (( bracket_color_size ))
			then
				_zsh_highlight_add_highlight $((pos - 1)) $pos bracket-level-$(( (levelpos[$pos] - 1) % bracket_color_size + 1 ))
			fi
		else
			_zsh_highlight_add_highlight $((pos - 1)) $pos bracket-error
		fi
	done
	if [[ $WIDGET != zle-line-finish ]]
	then
		pos=$((CURSOR + 1)) 
		if (( $+levelpos[$pos] )) && (( $+matching[$pos] ))
		then
			local -i otherpos=$matching[$pos] 
			_zsh_highlight_add_highlight $((otherpos - 1)) $otherpos cursor-matchingbracket
		fi
	fi
}
_zsh_highlight_highlighter_brackets_predicate () {
	[[ $WIDGET == zle-line-finish ]] || _zsh_highlight_cursor_moved || _zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_cursor_paint () {
	[[ $WIDGET == zle-line-finish ]] && return
	_zsh_highlight_add_highlight $CURSOR $(( $CURSOR + 1 )) cursor
}
_zsh_highlight_highlighter_cursor_predicate () {
	[[ $WIDGET == zle-line-finish ]] || _zsh_highlight_cursor_moved
}
_zsh_highlight_highlighter_line_paint () {
	_zsh_highlight_add_highlight 0 $#BUFFER line
}
_zsh_highlight_highlighter_line_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_main_paint () {
	setopt localoptions extendedglob
	if [[ $CONTEXT == (select|vared) ]]
	then
		return
	fi
	typeset -a ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR
	typeset -a ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW
	local -a options_to_set reply
	local REPLY
	local flags_with_argument
	local flags_sans_argument
	local flags_solo
	local -A precommand_options
	precommand_options=('-' '' 'builtin' '' 'command' :pvV 'exec' a:cl 'noglob' '' 'doas' aCu:Lns 'nice' n: 'pkexec' '' 'sudo' Cgprtu:AEHPSbilns:eKkVv 'stdbuf' ioe: 'eatmydata' '' 'catchsegv' '' 'nohup' '' 'setsid' :wc 'env' u:i 'ionice' cn:t:pPu 'strace' IbeaosXPpEuOS:ACdfhikqrtTvVxyDc 'proxychains' f:q 'torsocks' idq:upaP 'torify' idq:upaP 'ssh-agent' aEPt:csDd:k 'tabbed' gnprtTuU:cdfhs:v 'chronic' :ev 'ifne' :n 'grc' :se 'cpulimit' elp:ivz 'ktrace' fgpt:aBCcdiT) 
	if [[ $zsyh_user_options[ignorebraces] == on || ${zsyh_user_options[ignoreclosebraces]:-off} == on ]]
	then
		local right_brace_is_recognised_everywhere=false 
	else
		local right_brace_is_recognised_everywhere=true 
	fi
	if [[ $zsyh_user_options[pathdirs] == on ]]
	then
		options_to_set+=(PATH_DIRS) 
	fi
	ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR=('|' '||' ';' '&' '&&' $'\n' '|&' '&!' '&|') 
	ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW=($'\x7b' $'\x28' '()' 'while' 'until' 'if' 'then' 'elif' 'else' 'do' 'time' 'coproc' '!') 
	if (( $+X_ZSH_HIGHLIGHT_DIRS_BLACKLIST ))
	then
		print 'zsh-syntax-highlighting: X_ZSH_HIGHLIGHT_DIRS_BLACKLIST is deprecated. Please use ZSH_HIGHLIGHT_DIRS_BLACKLIST.' >&2
		ZSH_HIGHLIGHT_DIRS_BLACKLIST=($X_ZSH_HIGHLIGHT_DIRS_BLACKLIST) 
		unset X_ZSH_HIGHLIGHT_DIRS_BLACKLIST
	fi
	_zsh_highlight_main_highlighter_highlight_list -$#PREBUFFER '' 1 "$PREBUFFER$BUFFER"
	local start end_ style
	for start end_ style in $reply
	do
		(( start >= end_ )) && {
			print -r -- "zsh-syntax-highlighting: BUG: _zsh_highlight_highlighter_main_paint: start($start) >= end($end_)" >&2
			return
		}
		(( end_ <= 0 )) && continue
		(( start < 0 )) && start=0 
		_zsh_highlight_main_calculate_fallback $style
		_zsh_highlight_add_highlight $start $end_ $reply
	done
}
_zsh_highlight_highlighter_main_predicate () {
	[[ $WIDGET == zle-line-finish ]] || _zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_pattern_paint () {
	setopt localoptions extendedglob
	local pattern
	for pattern in ${(k)ZSH_HIGHLIGHT_PATTERNS}
	do
		_zsh_highlight_pattern_highlighter_loop "$BUFFER" "$pattern"
	done
}
_zsh_highlight_highlighter_pattern_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_regexp_paint () {
	setopt localoptions extendedglob
	local pattern
	for pattern in ${(k)ZSH_HIGHLIGHT_REGEXP}
	do
		_zsh_highlight_regexp_highlighter_loop "$BUFFER" "$pattern"
	done
}
_zsh_highlight_highlighter_regexp_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_highlighter_root_paint () {
	if (( EUID == 0 ))
	then
		_zsh_highlight_add_highlight 0 $#BUFFER root
	fi
}
_zsh_highlight_highlighter_root_predicate () {
	_zsh_highlight_buffer_modified
}
_zsh_highlight_load_highlighters () {
	setopt localoptions noksharrays bareglobqual
	[[ -d "$1" ]] || {
		print -r -- "zsh-syntax-highlighting: highlighters directory ${(qq)1} not found." >&2
		return 1
	}
	local highlighter highlighter_dir
	for highlighter_dir in $1/*/(/)
	do
		highlighter="${highlighter_dir:t}" 
		[[ -f "$highlighter_dir${highlighter}-highlighter.zsh" ]] && . "$highlighter_dir${highlighter}-highlighter.zsh"
		if type "_zsh_highlight_highlighter_${highlighter}_paint" &> /dev/null && type "_zsh_highlight_highlighter_${highlighter}_predicate" &> /dev/null
		then
			
		elif type "_zsh_highlight_${highlighter}_highlighter" &> /dev/null && type "_zsh_highlight_${highlighter}_highlighter_predicate" &> /dev/null
		then
			if false
			then
				print -r -- "zsh-syntax-highlighting: warning: ${(qq)highlighter} highlighter uses deprecated entry point names; please ask its maintainer to update it: https://github.com/zsh-users/zsh-syntax-highlighting/issues/329" >&2
			fi
			eval "_zsh_highlight_highlighter_${(q)highlighter}_paint() { _zsh_highlight_${(q)highlighter}_highlighter \"\$@\" }"
			eval "_zsh_highlight_highlighter_${(q)highlighter}_predicate() { _zsh_highlight_${(q)highlighter}_highlighter_predicate \"\$@\" }"
		else
			print -r -- "zsh-syntax-highlighting: ${(qq)highlighter} highlighter should define both required functions '_zsh_highlight_highlighter_${highlighter}_paint' and '_zsh_highlight_highlighter_${highlighter}_predicate' in ${(qq):-"$highlighter_dir${highlighter}-highlighter.zsh"}." >&2
		fi
	done
}
_zsh_highlight_main__is_global_alias () {
	if zmodload -e zsh/parameter
	then
		(( ${+galiases[$arg]} ))
	elif [[ $arg == '='* ]]
	then
		return 1
	else
		alias -L -g -- "$1" > /dev/null
	fi
}
_zsh_highlight_main__is_redirection () {
	[[ ${1#[0-9]} == (\<|\<\>|(\>|\>\>)(|\|)|\<\<(|-)|\<\<\<|\<\&|\&\<|(\>|\>\>)\&(|\|)|\&(\>|\>\>)(|\||\!)) ]]
}
_zsh_highlight_main__is_runnable () {
	if _zsh_highlight_main__type "$1"
	then
		[[ $REPLY != none ]]
	else
		return 2
	fi
}
_zsh_highlight_main__precmd_hook () {
	setopt localoptions
	if eval '[[ -o warnnestedvar ]]' 2> /dev/null
	then
		unsetopt warnnestedvar
	fi
	_zsh_highlight_main__command_type_cache=() 
}
_zsh_highlight_main__resolve_alias () {
	if zmodload -e zsh/parameter
	then
		REPLY=${aliases[$arg]} 
	else
		REPLY="${"$(alias -- $arg)"#*=}" 
	fi
}
_zsh_highlight_main__stack_pop () {
	if [[ $braces_stack[1] == $1 ]]
	then
		braces_stack=${braces_stack:1} 
		if (( $+2 ))
		then
			style=$2 
		fi
		return 0
	else
		style=unknown-token 
		return 1
	fi
}
_zsh_highlight_main__type () {
	integer -r aliases_allowed=${2-1} 
	integer may_cache=1 
	if (( $+_zsh_highlight_main__command_type_cache ))
	then
		REPLY=$_zsh_highlight_main__command_type_cache[(e)$1] 
		if [[ -n "$REPLY" ]]
		then
			return
		fi
	fi
	if (( $#options_to_set ))
	then
		setopt localoptions $options_to_set
	fi
	unset REPLY
	if zmodload -e zsh/parameter
	then
		if (( $+aliases[(e)$1] ))
		then
			may_cache=0 
		fi
		if (( ${+galiases[(e)$1]} )) && (( aliases_allowed ))
		then
			REPLY='global alias' 
		elif (( $+aliases[(e)$1] )) && (( aliases_allowed ))
		then
			REPLY=alias 
		elif [[ $1 == *.* && -n ${1%.*} ]] && (( $+saliases[(e)${1##*.}] ))
		then
			REPLY='suffix alias' 
		elif (( $reswords[(Ie)$1] ))
		then
			REPLY=reserved 
		elif (( $+functions[(e)$1] ))
		then
			REPLY=function 
		elif (( $+builtins[(e)$1] ))
		then
			REPLY=builtin 
		elif (( $+commands[(e)$1] ))
		then
			REPLY=command 
		elif {
				[[ $1 != */* ]] || is-at-least 5.3
			} && ! (
				builtin type -w -- "$1"
			) > /dev/null 2>&1
		then
			REPLY=none 
		fi
	fi
	if ! (( $+REPLY ))
	then
		REPLY="${$(:; (( aliases_allowed )) || unalias -- "$1" 2>/dev/null; LC_ALL=C builtin type -w -- "$1" 2>/dev/null)##*: }" 
		if [[ $REPLY == 'alias' ]]
		then
			may_cache=0 
		fi
	fi
	if (( may_cache )) && (( $+_zsh_highlight_main__command_type_cache ))
	then
		_zsh_highlight_main__command_type_cache[(e)$1]=$REPLY 
	fi
	[[ -n $REPLY ]]
	return $?
}
_zsh_highlight_main_add_many_region_highlights () {
	for 1 2 3
	do
		_zsh_highlight_main_add_region_highlight $1 $2 $3
	done
}
_zsh_highlight_main_add_region_highlight () {
	integer start=$1 end=$2 
	shift 2
	if (( $#in_alias ))
	then
		[[ $1 == unknown-token ]] && alias_style=unknown-token 
		return
	fi
	if (( in_param ))
	then
		if [[ $1 == unknown-token ]]
		then
			param_style=unknown-token 
		fi
		if [[ -n $param_style ]]
		then
			return
		fi
		param_style=$1 
		return
	fi
	(( start += buf_offset ))
	(( end += buf_offset ))
	list_highlights+=($start $end $1) 
}
_zsh_highlight_main_calculate_fallback () {
	local -A fallback_of
	fallback_of=(alias arg0 suffix-alias arg0 global-alias dollar-double-quoted-argument builtin arg0 function arg0 command arg0 precommand arg0 hashed-command arg0 autodirectory arg0 arg0_\* arg0 path_prefix path path_pathseparator path path_prefix_pathseparator path_prefix single-quoted-argument{-unclosed,} double-quoted-argument{-unclosed,} dollar-quoted-argument{-unclosed,} back-quoted-argument{-unclosed,} command-substitution{-quoted,,-unquoted,} command-substitution-delimiter{-quoted,,-unquoted,} command-substitution{-delimiter,} process-substitution{-delimiter,} back-quoted-argument{-delimiter,}) 
	local needle=$1 value 
	reply=($1) 
	while [[ -n ${value::=$fallback_of[(k)$needle]} ]]
	do
		unset "fallback_of[$needle]"
		reply+=($value) 
		needle=$value 
	done
}
_zsh_highlight_main_highlighter__try_expand_parameter () {
	local arg="$1" 
	unset reply
	{
		{
			local -a match mbegin mend
			local MATCH
			integer MBEGIN MEND
			local parameter_name
			local -a words
			if [[ $arg[1] != '$' ]]
			then
				return 1
			fi
			if [[ ${arg[2]} == '{' ]] && [[ ${arg[-1]} == '}' ]]
			then
				parameter_name=${${arg:2}%?} 
			else
				parameter_name=${arg:1} 
			fi
			if [[ $res == none ]] && [[ ${parameter_name} =~ ^${~parameter_name_pattern}$ ]] && [[ ${(tP)MATCH} != *special* ]]
			then
				case ${(tP)MATCH} in
					(*array*|*assoc*) words=(${(P)MATCH})  ;;
					("") words=()  ;;
					(*) if [[ $zsyh_user_options[shwordsplit] == on ]]
						then
							words=(${(P)=MATCH}) 
						else
							words=(${(P)MATCH}) 
						fi ;;
				esac
				reply=("${words[@]}") 
			else
				return 1
			fi
		}
	}
}
_zsh_highlight_main_highlighter_check_assign () {
	setopt localoptions extended_glob
	[[ $arg == [[:alpha:]_][[:alnum:]_]#(|\[*\])(|[+])=* ]] || [[ $arg == [0-9]##(|[+])=* ]]
}
_zsh_highlight_main_highlighter_check_path () {
	_zsh_highlight_main_highlighter_expand_path "$1"
	local expanded_path="$REPLY" tmp_path 
	integer in_command_position=$2 
	if [[ $zsyh_user_options[autocd] == on ]]
	then
		integer autocd=1 
	else
		integer autocd=0 
	fi
	if (( in_command_position ))
	then
		REPLY=arg0 
	else
		REPLY=path 
	fi
	if [[ ${1[1]} == '=' && $1 == ??* && ${1[2]} != $'\x28' && $zsyh_user_options[equals] == 'on' && $expanded_path[1] != '/' ]]
	then
		REPLY=unknown-token 
		return 0
	fi
	[[ -z $expanded_path ]] && return 1
	if [[ $expanded_path[1] == / ]]
	then
		tmp_path=$expanded_path 
	else
		tmp_path=$PWD/$expanded_path 
	fi
	tmp_path=$tmp_path:a 
	while [[ $tmp_path != / ]]
	do
		[[ -n ${(M)ZSH_HIGHLIGHT_DIRS_BLACKLIST:#$tmp_path} ]] && return 1
		tmp_path=$tmp_path:h 
	done
	if (( in_command_position ))
	then
		if [[ -x $expanded_path ]]
		then
			if (( autocd ))
			then
				if [[ -d $expanded_path ]]
				then
					REPLY=autodirectory 
				fi
				return 0
			elif [[ ! -d $expanded_path ]]
			then
				return 0
			fi
		fi
	else
		if [[ -L $expanded_path || -e $expanded_path ]]
		then
			return 0
		fi
	fi
	if [[ $expanded_path != /* ]] && (( autocd || ! in_command_position ))
	then
		local cdpath_dir
		for cdpath_dir in $cdpath
		do
			if [[ -d "$cdpath_dir/$expanded_path" && -x "$cdpath_dir/$expanded_path" ]]
			then
				if (( in_command_position && autocd ))
				then
					REPLY=autodirectory 
				fi
				return 0
			fi
		done
	fi
	[[ ! -d ${expanded_path:h} ]] && return 1
	if (( has_end && (len == end_pos) )) && (( ! $#in_alias )) && [[ $WIDGET != zle-line-finish ]]
	then
		local -a tmp
		if (( in_command_position ))
		then
			tmp=(${expanded_path}*(N-*,N-/)) 
		else
			tmp=(${expanded_path}*(N)) 
		fi
		(( ${+tmp[1]} )) && REPLY=path_prefix  && return 0
	fi
	return 1
}
_zsh_highlight_main_highlighter_expand_path () {
	(( $# == 1 )) || print -r -- "zsh-syntax-highlighting: BUG: _zsh_highlight_main_highlighter_expand_path: called without argument" >&2
	setopt localoptions nonomatch
	unset REPLY
	: ${REPLY:=${(Q)${~1}}}
}
_zsh_highlight_main_highlighter_highlight_argument () {
	local base_style=default i=$1 option_eligible=${2:-1} path_eligible=1 ret start style 
	local -a highlights
	local -a match mbegin mend
	local MATCH
	integer MBEGIN MEND
	case "$arg[i]" in
		('%') if [[ $arg[i+1] == '?' ]]
			then
				(( i += 2 ))
			fi ;;
		('-') if (( option_eligible ))
			then
				if [[ $arg[i+1] == - ]]
				then
					base_style=double-hyphen-option 
				else
					base_style=single-hyphen-option 
				fi
				path_eligible=0 
			fi ;;
		('=') if [[ $arg[i+1] == $'\x28' ]]
			then
				(( i += 2 ))
				_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
				ret=$? 
				(( i += REPLY ))
				highlights+=($(( start_pos + $1 - 1 )) $(( start_pos + i )) process-substitution $(( start_pos + $1 - 1 )) $(( start_pos + $1 + 1 )) process-substitution-delimiter $reply) 
				if (( ret == 0 ))
				then
					highlights+=($(( start_pos + i - 1 )) $(( start_pos + i )) process-substitution-delimiter) 
				fi
			fi ;;
	esac
	(( --i ))
	while (( ++i <= $#arg ))
	do
		i=${arg[(ib.i.)[\\\'\"\`\$\<\>\*\?]]} 
		case "$arg[$i]" in
			("") break ;;
			("\\") (( i += 1 ))
				continue ;;
			("'") _zsh_highlight_main_highlighter_highlight_single_quote $i
				(( i = REPLY ))
				highlights+=($reply)  ;;
			('"') _zsh_highlight_main_highlighter_highlight_double_quote $i
				(( i = REPLY ))
				highlights+=($reply)  ;;
			('`') _zsh_highlight_main_highlighter_highlight_backtick $i
				(( i = REPLY ))
				highlights+=($reply)  ;;
			('$') if [[ $arg[i+1] != "'" ]]
				then
					path_eligible=0 
				fi
				if [[ $arg[i+1] == "'" ]]
				then
					_zsh_highlight_main_highlighter_highlight_dollar_quote $i
					(( i = REPLY ))
					highlights+=($reply) 
					continue
				elif [[ $arg[i+1] == $'\x28' ]]
				then
					if [[ $arg[i+2] == $'\x28' ]] && _zsh_highlight_main_highlighter_highlight_arithmetic $i
					then
						(( i = REPLY ))
						highlights+=($reply) 
						continue
					fi
					start=$i 
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
					ret=$? 
					(( i += REPLY ))
					highlights+=($(( start_pos + start - 1)) $(( start_pos + i )) command-substitution-unquoted $(( start_pos + start - 1)) $(( start_pos + start + 1)) command-substitution-delimiter-unquoted $reply) 
					if (( ret == 0 ))
					then
						highlights+=($(( start_pos + i - 1)) $(( start_pos + i )) command-substitution-delimiter-unquoted) 
					fi
					continue
				fi
				while [[ $arg[i+1] == [=~#+'^'] ]]
				do
					(( i += 1 ))
				done
				if [[ $arg[i+1] == [*@#?$!-] ]]
				then
					(( i += 1 ))
				fi ;;
			([\<\>]) if [[ $arg[i+1] == $'\x28' ]]
				then
					start=$i 
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
					ret=$? 
					(( i += REPLY ))
					highlights+=($(( start_pos + start - 1)) $(( start_pos + i )) process-substitution $(( start_pos + start - 1)) $(( start_pos + start + 1 )) process-substitution-delimiter $reply) 
					if (( ret == 0 ))
					then
						highlights+=($(( start_pos + i - 1)) $(( start_pos + i )) process-substitution-delimiter) 
					fi
					continue
				fi ;|
			(*) if $highlight_glob && [[ $zsyh_user_options[multios] == on || $in_redirection -eq 0 ]] && [[ ${arg[$i]} =~ ^[*?] || ${arg:$i-1} =~ ^\<[0-9]*-[0-9]*\> ]]
				then
					highlights+=($(( start_pos + i - 1 )) $(( start_pos + i + $#MATCH - 1)) globbing) 
					(( i += $#MATCH - 1 ))
					path_eligible=0 
				else
					continue
				fi ;;
		esac
	done
	if (( path_eligible ))
	then
		if (( in_redirection )) && [[ $last_arg == *['<>']['&'] && $arg[$1,-1] == (<0->|p|-) ]]
		then
			if [[ $arg[$1,-1] == (p|-) ]]
			then
				base_style=redirection 
			else
				base_style=numeric-fd 
			fi
		elif _zsh_highlight_main_highlighter_check_path $arg[$1,-1] 0
		then
			base_style=$REPLY 
			_zsh_highlight_main_highlighter_highlight_path_separators $base_style
			highlights+=($reply) 
		fi
	fi
	highlights=($(( start_pos + $1 - 1 )) $end_pos $base_style $highlights) 
	_zsh_highlight_main_add_many_region_highlights $highlights
}
_zsh_highlight_main_highlighter_highlight_arithmetic () {
	local -a saved_reply
	local style
	integer i j k paren_depth ret
	reply=() 
	for ((i = $1 + 3 ; i <= end_pos - start_pos ; i += 1 )) do
		(( j = i + start_pos - 1 ))
		(( k = j + 1 ))
		case "$arg[$i]" in
			([\'\"\\@{}]) style=unknown-token  ;;
			('(') (( paren_depth++ ))
				continue ;;
			(')') if (( paren_depth ))
				then
					(( paren_depth-- ))
					continue
				fi
				[[ $arg[i+1] == ')' ]] && {
					(( i++ ))
					break
				}
				(( has_end && (len == k) )) && break
				return 1 ;;
			('`') saved_reply=($reply) 
				_zsh_highlight_main_highlighter_highlight_backtick $i
				(( i = REPLY ))
				reply=($saved_reply $reply) 
				continue ;;
			('$') if [[ $arg[i+1] == $'\x28' ]]
				then
					saved_reply=($reply) 
					if [[ $arg[i+2] == $'\x28' ]] && _zsh_highlight_main_highlighter_highlight_arithmetic $i
					then
						(( i = REPLY ))
						reply=($saved_reply $reply) 
						continue
					fi
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,end_pos]
					ret=$? 
					(( i += REPLY ))
					reply=($saved_reply $j $(( start_pos + i )) command-substitution-quoted $j $(( j + 2 )) command-substitution-delimiter-quoted $reply) 
					if (( ret == 0 ))
					then
						reply+=($(( start_pos + i - 1 )) $(( start_pos + i )) command-substitution-delimiter) 
					fi
					continue
				else
					continue
				fi ;;
			($histchars[1]) if [[ $arg[i+1] != ('='|$'\x28'|$'\x7b'|[[:blank:]]) ]]
				then
					style=history-expansion 
				else
					continue
				fi ;;
			(*) continue ;;
		esac
		reply+=($j $k $style) 
	done
	if [[ $arg[i] != ')' ]]
	then
		(( i-- ))
	fi
	style=arithmetic-expansion 
	reply=($(( start_pos + $1 - 1)) $(( start_pos + i )) arithmetic-expansion $reply) 
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_backtick () {
	local buf highlight style=back-quoted-argument-unclosed style_end 
	local -i arg1=$1 end_ i=$1 last offset=0 start subshell_has_end=0 
	local -a highlight_zone highlights offsets
	reply=() 
	last=$(( arg1 + 1 )) 
	while i=$arg[(ib:i+1:)[\\\\\`]] 
	do
		if (( i > $#arg ))
		then
			buf=$buf$arg[last,i] 
			offsets[i-arg1-offset]='' 
			(( i-- ))
			subshell_has_end=$(( has_end && (start_pos + i == len) )) 
			break
		fi
		if [[ $arg[i] == '\' ]]
		then
			(( i++ ))
			if [[ $arg[i] == ('$'|'`'|'\') ]]
			then
				buf=$buf$arg[last,i-2] 
				(( offset++ ))
				offsets[i-arg1-offset]=$offset 
			else
				buf=$buf$arg[last,i-1] 
			fi
		else
			style=back-quoted-argument 
			style_end=back-quoted-argument-delimiter 
			buf=$buf$arg[last,i-1] 
			offsets[i-arg1-offset]='' 
			break
		fi
		last=$i 
	done
	_zsh_highlight_main_highlighter_highlight_list 0 '' $subshell_has_end $buf
	for start end_ highlight in $reply
	do
		start=$(( start_pos + arg1 + start + offsets[(Rb:start:)?*] )) 
		end_=$(( start_pos + arg1 + end_ + offsets[(Rb:end_:)?*] )) 
		highlights+=($start $end_ $highlight) 
		if [[ $highlight == back-quoted-argument-unclosed && $style == back-quoted-argument ]]
		then
			style_end=unknown-token 
		fi
	done
	reply=($(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style $(( start_pos + arg1 - 1 )) $(( start_pos + arg1 )) back-quoted-argument-delimiter $highlights) 
	if (( $#style_end ))
	then
		reply+=($(( start_pos + i - 1)) $(( start_pos + i )) $style_end) 
	fi
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_dollar_quote () {
	local -a match mbegin mend
	local MATCH
	integer MBEGIN MEND
	local i j k style
	local AA
	integer c
	reply=() 
	for ((i = $1 + 2 ; i <= $#arg ; i += 1 )) do
		(( j = i + start_pos - 1 ))
		(( k = j + 1 ))
		case "$arg[$i]" in
			("'") break ;;
			("\\") style=back-dollar-quoted-argument 
				for ((c = i + 1 ; c <= $#arg ; c += 1 )) do
					[[ "$arg[$c]" != ([0-9xXuUa-fA-F]) ]] && break
				done
				AA=$arg[$i+1,$c-1] 
				if [[ "$AA" =~ "^(x|X)[0-9a-fA-F]{1,2}" || "$AA" =~ "^[0-7]{1,3}" || "$AA" =~ "^u[0-9a-fA-F]{1,4}" || "$AA" =~ "^U[0-9a-fA-F]{1,8}" ]]
				then
					(( k += $#MATCH ))
					(( i += $#MATCH ))
				else
					if (( $#arg > $i+1 )) && [[ $arg[$i+1] == [xXuU] ]]
					then
						style=unknown-token 
					fi
					(( k += 1 ))
					(( i += 1 ))
				fi ;;
			(*) continue ;;
		esac
		reply+=($j $k $style) 
	done
	if [[ $arg[i] == "'" ]]
	then
		style=dollar-quoted-argument 
	else
		(( i-- ))
		style=dollar-quoted-argument-unclosed 
	fi
	reply=($(( start_pos + $1 - 1 )) $(( start_pos + i )) $style $reply) 
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_double_quote () {
	local -a breaks match mbegin mend saved_reply
	local MATCH
	integer last_break=$(( start_pos + $1 - 1 )) MBEGIN MEND 
	local i j k ret style
	reply=() 
	for ((i = $1 + 1 ; i <= $#arg ; i += 1 )) do
		(( j = i + start_pos - 1 ))
		(( k = j + 1 ))
		case "$arg[$i]" in
			('"') break ;;
			('`') saved_reply=($reply) 
				_zsh_highlight_main_highlighter_highlight_backtick $i
				(( i = REPLY ))
				reply=($saved_reply $reply) 
				continue ;;
			('$') style=dollar-double-quoted-argument 
				if [[ ${arg:$i} =~ ^([A-Za-z_][A-Za-z0-9_]*|[0-9]+) ]]
				then
					(( k += $#MATCH ))
					(( i += $#MATCH ))
				elif [[ ${arg:$i} =~ ^[{]([A-Za-z_][A-Za-z0-9_]*|[0-9]+)[}] ]]
				then
					(( k += $#MATCH ))
					(( i += $#MATCH ))
				elif [[ $arg[i+1] == '$' ]]
				then
					(( k += 1 ))
					(( i += 1 ))
				elif [[ $arg[i+1] == [-#*@?] ]]
				then
					(( k += 1 ))
					(( i += 1 ))
				elif [[ $arg[i+1] == $'\x28' ]]
				then
					saved_reply=($reply) 
					if [[ $arg[i+2] == $'\x28' ]] && _zsh_highlight_main_highlighter_highlight_arithmetic $i
					then
						(( i = REPLY ))
						reply=($saved_reply $reply) 
						continue
					fi
					breaks+=($last_break $(( start_pos + i - 1 ))) 
					(( i += 2 ))
					_zsh_highlight_main_highlighter_highlight_list $(( start_pos + i - 1 )) S $has_end $arg[i,-1]
					ret=$? 
					(( i += REPLY ))
					last_break=$(( start_pos + i )) 
					reply=($saved_reply $j $(( start_pos + i )) command-substitution-quoted $j $(( j + 2 )) command-substitution-delimiter-quoted $reply) 
					if (( ret == 0 ))
					then
						reply+=($(( start_pos + i - 1 )) $(( start_pos + i )) command-substitution-delimiter-quoted) 
					fi
					continue
				else
					continue
				fi ;;
			("\\") style=back-double-quoted-argument 
				if [[ \\\`\"\$${histchars[1]} == *$arg[$i+1]* ]]
				then
					(( k += 1 ))
					(( i += 1 ))
				else
					continue
				fi ;;
			($histchars[1]) if [[ $arg[i+1] != ('='|$'\x28'|$'\x7b'|[[:blank:]]) ]]
				then
					style=history-expansion 
				else
					continue
				fi ;;
			(*) continue ;;
		esac
		reply+=($j $k $style) 
	done
	if [[ $arg[i] == '"' ]]
	then
		style=double-quoted-argument 
	else
		(( i-- ))
		style=double-quoted-argument-unclosed 
	fi
	(( last_break != start_pos + i )) && breaks+=($last_break $(( start_pos + i ))) 
	saved_reply=($reply) 
	reply=() 
	for 1 2 in $breaks
	do
		(( $1 != $2 )) && reply+=($1 $2 $style) 
	done
	reply+=($saved_reply) 
	REPLY=$i 
}
_zsh_highlight_main_highlighter_highlight_list () {
	integer start_pos end_pos=0 buf_offset=$1 has_end=$3 
	local alias_style param_style last_arg arg buf=$4 highlight_glob=true saw_assignment=false style 
	local in_array_assignment=false 
	integer in_param=0 len=$#buf 
	local -a in_alias match mbegin mend list_highlights
	local -A seen_alias
	readonly parameter_name_pattern='([A-Za-z_][A-Za-z0-9_]*|[0-9]+)' 
	list_highlights=() 
	local braces_stack=$2 
	local this_word next_word=':start::start_of_pipeline:' 
	integer in_redirection
	local proc_buf="$buf" 
	local -a args
	if [[ $zsyh_user_options[interactivecomments] == on ]]
	then
		args=(${(zZ+c+)buf}) 
	else
		args=(${(z)buf}) 
	fi
	if [[ $braces_stack == 'S' ]] && (( $+args[3] && ! $+args[4] )) && [[ $args[3] == $'\x29' ]] && [[ $args[1] == *'<'* ]] && _zsh_highlight_main__is_redirection $args[1]
	then
		highlight_glob=false 
	fi
	while (( $#args ))
	do
		last_arg=$arg 
		arg=$args[1] 
		shift args
		if (( $#in_alias ))
		then
			(( in_alias[1]-- ))
			in_alias=($in_alias[$in_alias[(i)<1->],-1]) 
			if (( $#in_alias == 0 ))
			then
				seen_alias=() 
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos $alias_style
			else
				() {
					local alias_name
					for alias_name in ${(k)seen_alias[(R)<$#in_alias->]}
					do
						seen_alias=("${(@kv)seen_alias[(I)^$alias_name]}") 
					done
				}
			fi
		fi
		if (( in_param ))
		then
			(( in_param-- ))
			if (( in_param == 0 ))
			then
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos $param_style
				param_style="" 
			fi
		fi
		if (( in_redirection == 0 ))
		then
			this_word=$next_word 
			next_word=':regular:' 
		elif (( !in_param ))
		then
			(( --in_redirection ))
		fi
		style=unknown-token 
		if [[ $this_word == *':start:'* ]]
		then
			in_array_assignment=false 
			if [[ $arg == 'noglob' ]]
			then
				highlight_glob=false 
			fi
		fi
		if (( $#in_alias == 0 && in_param == 0 ))
		then
			[[ "$proc_buf" = (#b)(#s)(''([ $'\t']|[\\]$'\n')#)(?|)* ]]
			integer offset="${#match[1]}" 
			(( start_pos = end_pos + offset ))
			(( end_pos = start_pos + $#arg ))
			[[ $arg == ';' && ${match[3]} == $'\n' ]] && arg=$'\n' 
			proc_buf="${proc_buf[offset + $#arg + 1,len]}" 
		fi
		if [[ $zsyh_user_options[interactivecomments] == on && $arg[1] == $histchars[3] ]]
		then
			if [[ $this_word == *(':regular:'|':start:')* ]]
			then
				style=comment 
			else
				style=unknown-token 
			fi
			_zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
			in_redirection=1 
			continue
		fi
		if [[ $this_word == *':start:'* ]] && ! (( in_redirection ))
		then
			_zsh_highlight_main__type "$arg" "$(( ! ${+seen_alias[$arg]} ))"
			local res="$REPLY" 
			if [[ $res == "alias" ]]
			then
				if [[ $arg == ?*=* ]]
				then
					_zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
					continue
				fi
				seen_alias[$arg]=$#in_alias 
				_zsh_highlight_main__resolve_alias $arg
				local -a alias_args
				if [[ $zsyh_user_options[interactivecomments] == on ]]
				then
					alias_args=(${(zZ+c+)REPLY}) 
				else
					alias_args=(${(z)REPLY}) 
				fi
				args=($alias_args $args) 
				if (( $#in_alias == 0 ))
				then
					alias_style=alias 
				else
					(( in_alias[1]-- ))
				fi
				in_alias=($(($#alias_args + 1)) $in_alias) 
				(( in_redirection++ ))
				continue
			else
				_zsh_highlight_main_highlighter_expand_path $arg
				_zsh_highlight_main__type "$REPLY" 0
				res="$REPLY" 
			fi
		fi
		if _zsh_highlight_main__is_redirection $arg
		then
			if (( in_redirection == 1 ))
			then
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos unknown-token
			else
				in_redirection=2 
				_zsh_highlight_main_add_region_highlight $start_pos $end_pos redirection
			fi
			continue
		elif [[ $arg == '{'${~parameter_name_pattern}'}' ]] && _zsh_highlight_main__is_redirection $args[1]
		then
			in_redirection=3 
			_zsh_highlight_main_add_region_highlight $start_pos $end_pos named-fd
			continue
		fi
		if (( ! in_param )) && _zsh_highlight_main_highlighter__try_expand_parameter "$arg"
		then
			() {
				local -a words
				words=("${reply[@]}") 
				if (( $#words == 0 )) && (( ! in_redirection ))
				then
					(( ++in_redirection ))
					_zsh_highlight_main_add_region_highlight $start_pos $end_pos comment
					continue
				else
					(( in_param = 1 + $#words ))
					args=($words $args) 
					arg=$args[1] 
					_zsh_highlight_main__type "$arg" 0
					res=$REPLY 
				fi
			}
		fi
		if (( ! in_redirection ))
		then
			if [[ $this_word == *':sudo_opt:'* ]]
			then
				if [[ -n $flags_with_argument ]] && {
						if [[ -n $flags_sans_argument ]]
						then
							[[ $arg == '-'[$flags_sans_argument]#[$flags_with_argument] ]]
						else
							[[ $arg == '-'[$flags_with_argument] ]]
						fi
					}
				then
					this_word=${this_word//:start:/} 
					next_word=':sudo_arg:' 
				elif [[ -n $flags_with_argument ]] && {
						if [[ -n $flags_sans_argument ]]
						then
							[[ $arg == '-'[$flags_sans_argument]#[$flags_with_argument]* ]]
						else
							[[ $arg == '-'[$flags_with_argument]* ]]
						fi
					}
				then
					this_word=${this_word//:start:/} 
					next_word+=':start:' 
					next_word+=':sudo_opt:' 
				elif [[ -n $flags_sans_argument ]] && [[ $arg == '-'[$flags_sans_argument]# ]]
				then
					this_word=':sudo_opt:' 
					next_word+=':start:' 
					next_word+=':sudo_opt:' 
				elif [[ -n $flags_solo ]] && {
						if [[ -n $flags_sans_argument ]]
						then
							[[ $arg == '-'[$flags_sans_argument]#[$flags_solo]* ]]
						else
							[[ $arg == '-'[$flags_solo]* ]]
						fi
					}
				then
					this_word=':sudo_opt:' 
					next_word=':regular:' 
				elif [[ $arg == '-'* ]]
				then
					this_word=':sudo_opt:' 
					next_word+=':start:' 
					next_word+=':sudo_opt:' 
				else
					this_word=${this_word//:sudo_opt:/} 
				fi
			elif [[ $this_word == *':sudo_arg:'* ]]
			then
				next_word+=':sudo_opt:' 
				next_word+=':start:' 
			fi
		fi
		if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_COMMANDSEPARATOR:#"$arg"} ]] && [[ $braces_stack != *T* || $arg != ('||'|'&&') ]]
		then
			if _zsh_highlight_main__stack_pop T || _zsh_highlight_main__stack_pop Q
			then
				style=unknown-token 
			elif $in_array_assignment
			then
				case $arg in
					($'\n') style=commandseparator  ;;
					(';') style=unknown-token  ;;
					(*) style=unknown-token  ;;
				esac
			elif [[ $this_word == *':regular:'* ]]
			then
				style=commandseparator 
			elif [[ $this_word == *':start:'* ]] && [[ $arg == $'\n' ]]
			then
				style=commandseparator 
			elif [[ $this_word == *':start:'* ]] && [[ $arg == ';' ]] && (( $#in_alias ))
			then
				style=commandseparator 
			else
				style=unknown-token 
			fi
			if [[ $arg == $'\n' ]] && $in_array_assignment
			then
				next_word=':regular:' 
			elif [[ $arg == ';' ]] && $in_array_assignment
			then
				next_word=':regular:' 
			else
				next_word=':start:' 
				highlight_glob=true 
				saw_assignment=false 
				() {
					local alias_name
					for alias_name in ${(k)seen_alias[(R)<$#in_alias->]}
					do
						seen_alias=("${(@kv)seen_alias[(I)^$alias_name]}") 
					done
				}
				if [[ $arg != '|' && $arg != '|&' ]]
				then
					next_word+=':start_of_pipeline:' 
				fi
			fi
		elif ! (( in_redirection)) && [[ $this_word == *':always:'* && $arg == 'always' ]]
		then
			style=reserved-word 
			highlight_glob=true 
			saw_assignment=false 
			next_word=':start::start_of_pipeline:' 
		elif ! (( in_redirection)) && [[ $this_word == *':start:'* ]]
		then
			if (( ${+precommand_options[$arg]} )) && _zsh_highlight_main__is_runnable $arg
			then
				style=precommand 
				() {
					set -- "${(@s.:.)precommand_options[$arg]}"
					flags_with_argument=$1 
					flags_sans_argument=$2 
					flags_solo=$3 
				}
				next_word=${next_word//:regular:/} 
				next_word+=':sudo_opt:' 
				next_word+=':start:' 
				if [[ $arg == 'exec' || $arg == 'env' ]]
				then
					next_word+=':regular:' 
				fi
			else
				case $res in
					(reserved) style=reserved-word 
						case $arg in
							(time|nocorrect) next_word=${next_word//:regular:/} 
								next_word+=':start:'  ;;
							($'\x7b') braces_stack='Y'"$braces_stack"  ;;
							($'\x7d') _zsh_highlight_main__stack_pop 'Y' reserved-word
								if [[ $style == reserved-word ]]
								then
									next_word+=':always:' 
								fi ;;
							($'\x5b\x5b') braces_stack='T'"$braces_stack"  ;;
							('do') braces_stack='D'"$braces_stack"  ;;
							('done') _zsh_highlight_main__stack_pop 'D' reserved-word ;;
							('if') braces_stack=':?'"$braces_stack"  ;;
							('then') _zsh_highlight_main__stack_pop ':' reserved-word ;;
							('elif') if [[ ${braces_stack[1]} == '?' ]]
								then
									braces_stack=':'"$braces_stack" 
								else
									style=unknown-token 
								fi ;;
							('else') if [[ ${braces_stack[1]} == '?' ]]
								then
									:
								else
									style=unknown-token 
								fi ;;
							('fi') _zsh_highlight_main__stack_pop '?' ;;
							('foreach') braces_stack='$'"$braces_stack"  ;;
							('end') _zsh_highlight_main__stack_pop '$' reserved-word ;;
							('repeat') in_redirection=2 
								this_word=':start::regular:'  ;;
							('!') if [[ $this_word != *':start_of_pipeline:'* ]]
								then
									style=unknown-token 
								else
									
								fi ;;
						esac
						if $saw_assignment && [[ $style != unknown-token ]]
						then
							style=unknown-token 
						fi ;;
					('suffix alias') style=suffix-alias  ;;
					('global alias') style=global-alias  ;;
					(alias) : ;;
					(builtin) style=builtin 
						[[ $arg == $'\x5b' ]] && braces_stack='Q'"$braces_stack"  ;;
					(function) style=function  ;;
					(command) style=command  ;;
					(hashed) style=hashed-command  ;;
					(none) if (( ! in_param )) && _zsh_highlight_main_highlighter_check_assign
						then
							_zsh_highlight_main_add_region_highlight $start_pos $end_pos assign
							local i=$(( arg[(i)=] + 1 )) 
							saw_assignment=true 
							if [[ $arg[i] == '(' ]]
							then
								in_array_assignment=true 
								_zsh_highlight_main_add_region_highlight start_pos+i-1 start_pos+i reserved-word
							else
								next_word+=':start:' 
								if (( i <= $#arg ))
								then
									() {
										local highlight_glob=false 
										[[ $zsyh_user_options[globassign] == on ]] && highlight_glob=true 
										_zsh_highlight_main_highlighter_highlight_argument $i
									}
								fi
							fi
							continue
						elif (( ! in_param )) && [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 ))
						then
							style=history-expansion 
						elif (( ! in_param )) && [[ $arg[0,1] == $histchars[2,2] ]]
						then
							style=history-expansion 
						elif (( ! in_param )) && ! $saw_assignment && [[ $arg[1,2] == '((' ]]
						then
							_zsh_highlight_main_add_region_highlight $start_pos $((start_pos + 2)) reserved-word
							if [[ $arg[-2,-1] == '))' ]]
							then
								_zsh_highlight_main_add_region_highlight $((end_pos - 2)) $end_pos reserved-word
							fi
							continue
						elif (( ! in_param )) && [[ $arg == '()' ]]
						then
							style=reserved-word 
						elif (( ! in_param )) && ! $saw_assignment && [[ $arg == $'\x28' ]]
						then
							style=reserved-word 
							braces_stack='R'"$braces_stack" 
						elif (( ! in_param )) && [[ $arg == $'\x29' ]]
						then
							if _zsh_highlight_main__stack_pop 'S'
							then
								REPLY=$start_pos 
								reply=($list_highlights) 
								return 0
							fi
							_zsh_highlight_main__stack_pop 'R' reserved-word
						else
							if _zsh_highlight_main_highlighter_check_path $arg 1
							then
								style=$REPLY 
							else
								style=unknown-token 
							fi
						fi ;;
					(*) _zsh_highlight_main_add_region_highlight $start_pos $end_pos arg0_$res
						continue ;;
				esac
			fi
			if [[ -n ${(M)ZSH_HIGHLIGHT_TOKENS_CONTROL_FLOW:#"$arg"} ]]
			then
				next_word=':start::start_of_pipeline:' 
			fi
		elif _zsh_highlight_main__is_global_alias "$arg"
		then
			style=global-alias 
		else
			case $arg in
				($'\x29') if $in_array_assignment
					then
						_zsh_highlight_main_add_region_highlight $start_pos $end_pos assign
						_zsh_highlight_main_add_region_highlight $start_pos $end_pos reserved-word
						in_array_assignment=false 
						next_word+=':start:' 
						continue
					elif (( in_redirection ))
					then
						style=unknown-token 
					else
						if _zsh_highlight_main__stack_pop 'S'
						then
							REPLY=$start_pos 
							reply=($list_highlights) 
							return 0
						fi
						_zsh_highlight_main__stack_pop 'R' reserved-word
					fi ;;
				($'\x28\x29') if (( in_redirection )) || $in_array_assignment
					then
						style=unknown-token 
					else
						if [[ $zsyh_user_options[multifuncdef] == on ]] || false
						then
							next_word+=':start::start_of_pipeline:' 
						fi
						style=reserved-word 
					fi ;;
				(*) if false
					then
						
					elif [[ $arg = $'\x7d' ]] && $right_brace_is_recognised_everywhere
					then
						if (( in_redirection )) || $in_array_assignment
						then
							style=unknown-token 
						else
							_zsh_highlight_main__stack_pop 'Y' reserved-word
							if [[ $style == reserved-word ]]
							then
								next_word+=':always:' 
							fi
						fi
					elif [[ $arg[0,1] = $histchars[0,1] ]] && (( $#arg[0,2] == 2 ))
					then
						style=history-expansion 
					elif [[ $arg == $'\x5d\x5d' ]] && _zsh_highlight_main__stack_pop 'T' reserved-word
					then
						:
					elif [[ $arg == $'\x5d' ]] && _zsh_highlight_main__stack_pop 'Q' builtin
					then
						:
					else
						_zsh_highlight_main_highlighter_highlight_argument 1 $(( 1 != in_redirection ))
						continue
					fi ;;
			esac
		fi
		_zsh_highlight_main_add_region_highlight $start_pos $end_pos $style
	done
	(( $#in_alias )) && in_alias=() _zsh_highlight_main_add_region_highlight $start_pos $end_pos $alias_style
	(( in_param == 1 )) && in_param=0 _zsh_highlight_main_add_region_highlight $start_pos $end_pos $param_style
	[[ "$proc_buf" = (#b)(#s)(([[:space:]]|\\$'\n')#) ]]
	REPLY=$(( end_pos + ${#match[1]} - 1 )) 
	reply=($list_highlights) 
	return $(( $#braces_stack > 0 ))
}
_zsh_highlight_main_highlighter_highlight_path_separators () {
	local pos style_pathsep
	style_pathsep=$1_pathseparator 
	reply=() 
	[[ -z "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" || "$ZSH_HIGHLIGHT_STYLES[$1]" == "$ZSH_HIGHLIGHT_STYLES[$style_pathsep]" ]] && return 0
	for ((pos = start_pos; $pos <= end_pos; pos++ )) do
		if [[ $BUFFER[pos] == / ]]
		then
			reply+=($((pos - 1)) $pos $style_pathsep) 
		fi
	done
}
_zsh_highlight_main_highlighter_highlight_single_quote () {
	local arg1=$1 i q=\' style 
	i=$arg[(ib:arg1+1:)$q] 
	reply=() 
	if [[ $zsyh_user_options[rcquotes] == on ]]
	then
		while [[ $arg[i+1] == "'" ]]
		do
			reply+=($(( start_pos + i - 1 )) $(( start_pos + i + 1 )) rc-quote) 
			(( i++ ))
			i=$arg[(ib:i+1:)$q] 
		done
	fi
	if [[ $arg[i] == "'" ]]
	then
		style=single-quoted-argument 
	else
		(( i-- ))
		style=single-quoted-argument-unclosed 
	fi
	reply=($(( start_pos + arg1 - 1 )) $(( start_pos + i )) $style $reply) 
	REPLY=$i 
}
_zsh_highlight_pattern_highlighter_loop () {
	local buf="$1" pat="$2" 
	local -a match mbegin mend
	local MATCH
	integer MBEGIN MEND
	if [[ "$buf" == (#b)(*)(${~pat})* ]]
	then
		region_highlight+=("$((mbegin[2] - 1)) $mend[2] $ZSH_HIGHLIGHT_PATTERNS[$pat], memo=zsh-syntax-highlighting") 
		"$0" "$match[1]" "$pat"
		return $?
	fi
}
_zsh_highlight_preexec_hook () {
	typeset -g _ZSH_HIGHLIGHT_PRIOR_BUFFER= 
	typeset -gi _ZSH_HIGHLIGHT_PRIOR_CURSOR= 
}
_zsh_highlight_regexp_highlighter_loop () {
	local buf="$1" pat="$2" 
	integer OFFSET=0 
	local MATCH
	integer MBEGIN MEND
	local -a match mbegin mend
	while true
	do
		[[ "$buf" =~ "$pat" ]] || return
		region_highlight+=("$((MBEGIN - 1 + OFFSET)) $((MEND + OFFSET)) $ZSH_HIGHLIGHT_REGEXP[$pat], memo=zsh-syntax-highlighting") 
		buf="$buf[$(($MEND+1)),-1]" 
		OFFSET=$((MEND+OFFSET)) 
	done
}
_zsocket () {
	# undefined
	builtin autoload -XUz
}
_zstyle () {
	# undefined
	builtin autoload -XUz
}
_ztodo () {
	# undefined
	builtin autoload -XUz
}
add-zle-hook-widget () {
	# undefined
	builtin autoload -XU
}
add-zsh-hook () {
	emulate -L zsh
	local -a hooktypes
	hooktypes=(chpwd precmd preexec periodic zshaddhistory zshexit zsh_directory_name) 
	local usage="Usage: add-zsh-hook hook function\nValid hooks are:\n  $hooktypes" 
	local opt
	local -a autoopts
	integer del list help
	while getopts "dDhLUzk" opt
	do
		case $opt in
			(d) del=1  ;;
			(D) del=2  ;;
			(h) help=1  ;;
			(L) list=1  ;;
			([Uzk]) autoopts+=(-$opt)  ;;
			(*) return 1 ;;
		esac
	done
	shift $(( OPTIND - 1 ))
	if (( list ))
	then
		typeset -mp "(${1:-${(@j:|:)hooktypes}})_functions"
		return $?
	elif (( help || $# != 2 || ${hooktypes[(I)$1]} == 0 ))
	then
		print -u$(( 2 - help )) $usage
		return $(( 1 - help ))
	fi
	local hook="${1}_functions" 
	local fn="$2" 
	if (( del ))
	then
		if (( ${(P)+hook} ))
		then
			if (( del == 2 ))
			then
				set -A $hook ${(P)hook:#${~fn}}
			else
				set -A $hook ${(P)hook:#$fn}
			fi
			if (( ! ${(P)#hook} ))
			then
				unset $hook
			fi
		fi
	else
		if (( ${(P)+hook} ))
		then
			if (( ${${(P)hook}[(I)$fn]} == 0 ))
			then
				typeset -ga $hook
				set -A $hook ${(P)hook} $fn
			fi
		else
			typeset -ga $hook
			set -A $hook $fn
		fi
		autoload $autoopts -- $fn
	fi
}
alias_value () {
	(( $+aliases[$1] )) && echo $aliases[$1]
}
azure_prompt_info () {
	return 1
}
bashcompinit () {
	# undefined
	builtin autoload -XUz
}
bracketed-paste-magic () {
	# undefined
	builtin autoload -XUz
}
bzr_prompt_info () {
	local bzr_branch
	bzr_branch=$(bzr nick 2>/dev/null)  || return
	if [[ -n "$bzr_branch" ]]
	then
		local bzr_dirty="" 
		if [[ -n $(bzr status 2>/dev/null) ]]
		then
			bzr_dirty=" %{$fg[red]%}*%{$reset_color%}" 
		fi
		printf "%s%s%s%s" "$ZSH_THEME_SCM_PROMPT_PREFIX" "bzr::${bzr_branch##*:}" "$bzr_dirty" "$ZSH_THEME_GIT_PROMPT_SUFFIX"
	fi
}
chruby_prompt_info () {
	return 1
}
clipcopy () {
	unfunction clipcopy clippaste
	detect-clipboard || true
	"$0" "$@"
}
clippaste () {
	unfunction clipcopy clippaste
	detect-clipboard || true
	"$0" "$@"
}
colors () {
	emulate -L zsh
	typeset -Ag color colour
	color=(00 none 01 bold 02 faint 22 normal 03 italic 23 no-italic 04 underline 24 no-underline 05 blink 25 no-blink 07 reverse 27 no-reverse 08 conceal 28 no-conceal 30 black 40 bg-black 31 red 41 bg-red 32 green 42 bg-green 33 yellow 43 bg-yellow 34 blue 44 bg-blue 35 magenta 45 bg-magenta 36 cyan 46 bg-cyan 37 white 47 bg-white 39 default 49 bg-default) 
	local k
	for k in ${(k)color}
	do
		color[${color[$k]}]=$k 
	done
	for k in ${color[(I)3?]}
	do
		color[fg-${color[$k]}]=$k 
	done
	for k in grey gray
	do
		color[$k]=${color[black]} 
		color[fg-$k]=${color[$k]} 
		color[bg-$k]=${color[bg-black]} 
	done
	colour=(${(kv)color}) 
	local lc=$'\e[' rc=m 
	typeset -Hg reset_color bold_color
	reset_color="$lc${color[none]}$rc" 
	bold_color="$lc${color[bold]}$rc" 
	typeset -AHg fg fg_bold fg_no_bold
	for k in ${(k)color[(I)fg-*]}
	do
		fg[${k#fg-}]="$lc${color[$k]}$rc" 
		fg_bold[${k#fg-}]="$lc${color[bold]};${color[$k]}$rc" 
		fg_no_bold[${k#fg-}]="$lc${color[normal]};${color[$k]}$rc" 
	done
	typeset -AHg bg bg_bold bg_no_bold
	for k in ${(k)color[(I)bg-*]}
	do
		bg[${k#bg-}]="$lc${color[$k]}$rc" 
		bg_bold[${k#bg-}]="$lc${color[bold]};${color[$k]}$rc" 
		bg_no_bold[${k#bg-}]="$lc${color[normal]};${color[$k]}$rc" 
	done
}
compaudit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/functions/Completion
}
compdef () {
	local opt autol type func delete eval new i ret=0 cmd svc 
	local -a match mbegin mend
	emulate -L zsh
	setopt extendedglob
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	while getopts "anpPkKde" opt
	do
		case "$opt" in
			(a) autol=yes  ;;
			(n) new=yes  ;;
			([pPkK]) if [[ -n "$type" ]]
				then
					print -u2 "$0: type already set to $type"
					return 1
				fi
				if [[ "$opt" = p ]]
				then
					type=pattern 
				elif [[ "$opt" = P ]]
				then
					type=postpattern 
				elif [[ "$opt" = K ]]
				then
					type=widgetkey 
				else
					type=key 
				fi ;;
			(d) delete=yes  ;;
			(e) eval=yes  ;;
		esac
	done
	shift OPTIND-1
	if (( ! $# ))
	then
		print -u2 "$0: I need arguments"
		return 1
	fi
	if [[ -z "$delete" ]]
	then
		if [[ -z "$eval" ]] && [[ "$1" = *\=* ]]
		then
			while (( $# ))
			do
				if [[ "$1" = *\=* ]]
				then
					cmd="${1%%\=*}" 
					svc="${1#*\=}" 
					func="$_comps[${_services[(r)$svc]:-$svc}]" 
					[[ -n ${_services[$svc]} ]] && svc=${_services[$svc]} 
					[[ -z "$func" ]] && func="${${_patcomps[(K)$svc][1]}:-${_postpatcomps[(K)$svc][1]}}" 
					if [[ -n "$func" ]]
					then
						_comps[$cmd]="$func" 
						_services[$cmd]="$svc" 
					else
						print -u2 "$0: unknown command or service: $svc"
						ret=1 
					fi
				else
					print -u2 "$0: invalid argument: $1"
					ret=1 
				fi
				shift
			done
			return ret
		fi
		func="$1" 
		[[ -n "$autol" ]] && autoload -rUz "$func"
		shift
		case "$type" in
			(widgetkey) while [[ -n $1 ]]
				do
					if [[ $# -lt 3 ]]
					then
						print -u2 "$0: compdef -K requires <widget> <comp-widget> <key>"
						return 1
					fi
					[[ $1 = _* ]] || 1="_$1" 
					[[ $2 = .* ]] || 2=".$2" 
					[[ $2 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$1" "$2" "$func"
					if [[ -n $new ]]
					then
						bindkey "$3" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] && bindkey "$3" "$1"
					else
						bindkey "$3" "$1"
					fi
					shift 3
				done ;;
			(key) if [[ $# -lt 2 ]]
				then
					print -u2 "$0: missing keys"
					return 1
				fi
				if [[ $1 = .* ]]
				then
					[[ $1 = .menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" "$1" "$func"
				else
					[[ $1 = menu-select ]] && zmodload -i zsh/complist
					zle -C "$func" ".$1" "$func"
				fi
				shift
				for i
				do
					if [[ -n $new ]]
					then
						bindkey "$i" | IFS=$' \t' read -A opt
						[[ $opt[-1] = undefined-key ]] || continue
					fi
					bindkey "$i" "$func"
				done ;;
			(*) while (( $# ))
				do
					if [[ "$1" = -N ]]
					then
						type=normal 
					elif [[ "$1" = -p ]]
					then
						type=pattern 
					elif [[ "$1" = -P ]]
					then
						type=postpattern 
					else
						case "$type" in
							(pattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_patcomps[$match[1]]="=$match[2]=$func" 
								else
									_patcomps[$1]="$func" 
								fi ;;
							(postpattern) if [[ $1 = (#b)(*)=(*) ]]
								then
									_postpatcomps[$match[1]]="=$match[2]=$func" 
								else
									_postpatcomps[$1]="$func" 
								fi ;;
							(*) if [[ "$1" = *\=* ]]
								then
									cmd="${1%%\=*}" 
									svc=yes 
								else
									cmd="$1" 
									svc= 
								fi
								if [[ -z "$new" || -z "${_comps[$1]}" ]]
								then
									_comps[$cmd]="$func" 
									[[ -n "$svc" ]] && _services[$cmd]="${1#*\=}" 
								fi ;;
						esac
					fi
					shift
				done ;;
		esac
	else
		case "$type" in
			(pattern) unset "_patcomps[$^@]" ;;
			(postpattern) unset "_postpatcomps[$^@]" ;;
			(key) print -u2 "$0: cannot restore key bindings"
				return 1 ;;
			(*) unset "_comps[$^@]" ;;
		esac
	fi
}
compdump () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/functions/Completion
}
compgen () {
	local opts prefix suffix job OPTARG OPTIND ret=1 
	local -a name res results jids
	local -A shortopts
	emulate -L sh
	setopt kshglob noshglob braceexpand nokshautoload
	shortopts=(a alias b builtin c command d directory e export f file g group j job k keyword u user v variable) 
	while getopts "o:A:G:C:F:P:S:W:X:abcdefgjkuv" name
	do
		case $name in
			([abcdefgjkuv]) OPTARG="${shortopts[$name]}"  ;&
			(A) case $OPTARG in
					(alias) results+=("${(k)aliases[@]}")  ;;
					(arrayvar) results+=("${(k@)parameters[(R)array*]}")  ;;
					(binding) results+=("${(k)widgets[@]}")  ;;
					(builtin) results+=("${(k)builtins[@]}" "${(k)dis_builtins[@]}")  ;;
					(command) results+=("${(k)commands[@]}" "${(k)aliases[@]}" "${(k)builtins[@]}" "${(k)functions[@]}" "${(k)reswords[@]}")  ;;
					(directory) setopt bareglobqual
						results+=(${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N-/)) 
						setopt nobareglobqual ;;
					(disabled) results+=("${(k)dis_builtins[@]}")  ;;
					(enabled) results+=("${(k)builtins[@]}")  ;;
					(export) results+=("${(k)parameters[(R)*export*]}")  ;;
					(file) setopt bareglobqual
						results+=(${IPREFIX}${PREFIX}*${SUFFIX}${ISUFFIX}(N)) 
						setopt nobareglobqual ;;
					(function) results+=("${(k)functions[@]}")  ;;
					(group) emulate zsh
						_groups -U -O res
						emulate sh
						setopt kshglob noshglob braceexpand
						results+=("${res[@]}")  ;;
					(hostname) emulate zsh
						_hosts -U -O res
						emulate sh
						setopt kshglob noshglob braceexpand
						results+=("${res[@]}")  ;;
					(job) results+=("${savejobtexts[@]%% *}")  ;;
					(keyword) results+=("${(k)reswords[@]}")  ;;
					(running) jids=("${(@k)savejobstates[(R)running*]}") 
						for job in "${jids[@]}"
						do
							results+=(${savejobtexts[$job]%% *}) 
						done ;;
					(stopped) jids=("${(@k)savejobstates[(R)suspended*]}") 
						for job in "${jids[@]}"
						do
							results+=(${savejobtexts[$job]%% *}) 
						done ;;
					(setopt | shopt) results+=("${(k)options[@]}")  ;;
					(signal) results+=("SIG${^signals[@]}")  ;;
					(user) results+=("${(k)userdirs[@]}")  ;;
					(variable) results+=("${(k)parameters[@]}")  ;;
					(helptopic)  ;;
				esac ;;
			(F) COMPREPLY=() 
				local -a args
				args=("${words[0]}" "${@[-1]}" "${words[CURRENT-2]}") 
				() {
					typeset -h words
					$OPTARG "${args[@]}"
				}
				results+=("${COMPREPLY[@]}")  ;;
			(G) setopt nullglob
				results+=(${~OPTARG}) 
				unsetopt nullglob ;;
			(W) results+=(${(Q)~=OPTARG})  ;;
			(C) results+=($(eval $OPTARG))  ;;
			(P) prefix="$OPTARG"  ;;
			(S) suffix="$OPTARG"  ;;
			(X) if [[ ${OPTARG[0]} = '!' ]]
				then
					results=("${(M)results[@]:#${OPTARG#?}}") 
				else
					results=("${results[@]:#$OPTARG}") 
				fi ;;
		esac
	done
	print -l -r -- "$prefix${^results[@]}$suffix"
}
compinit () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/functions/Completion
}
compinstall () {
	# undefined
	builtin autoload -XUz /usr/share/zsh/functions/Completion
}
complete () {
	emulate -L zsh
	local args void cmd print remove
	args=("$@") 
	zparseopts -D -a void o: A: G: W: C: F: P: S: X: a b c d e f g j k u v p=print r=remove
	if [[ -n $print ]]
	then
		printf 'complete %2$s %1$s\n' "${(@kv)_comps[(R)_bash*]#* }"
	elif [[ -n $remove ]]
	then
		for cmd
		do
			unset "_comps[$cmd]"
		done
	else
		compdef _bash_complete\ ${(j. .)${(q)args[1,-1-$#]}} "$@"
	fi
}
compress () {
	tar -czf "${1%/}.tar.gz" "${1%/}"
}
conda_prompt_info () {
	return 1
}
cursor () {
	~/Applications/Cursor.AppImage "$@" > /dev/null 2>&1 &
	disown
}
d () {
	if [[ -n $1 ]]
	then
		dirs "$@"
	else
		dirs -v | head -n 10
	fi
}
default () {
	(( $+parameters[$1] )) && return 0
	typeset -g "$1"="$2" && return 3
}
detect-clipboard () {
	emulate -L zsh
	if [[ "${OSTYPE}" == darwin* ]] && (( ${+commands[pbcopy]} )) && (( ${+commands[pbpaste]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | pbcopy
		}
		clippaste () {
			pbpaste
		}
	elif [[ "${OSTYPE}" == (cygwin|msys)* ]]
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" > /dev/clipboard
		}
		clippaste () {
			cat /dev/clipboard
		}
	elif (( $+commands[clip.exe] )) && (( $+commands[powershell.exe] ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | clip.exe
		}
		clippaste () {
			powershell.exe -noprofile -command Get-Clipboard
		}
	elif [ -n "${WAYLAND_DISPLAY:-}" ] && (( ${+commands[wl-copy]} )) && (( ${+commands[wl-paste]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | wl-copy &> /dev/null &|
		}
		clippaste () {
			wl-paste --no-newline
		}
	elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xsel]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | xsel --clipboard --input
		}
		clippaste () {
			xsel --clipboard --output
		}
	elif [ -n "${DISPLAY:-}" ] && (( ${+commands[xclip]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | xclip -selection clipboard -in &> /dev/null &|
		}
		clippaste () {
			xclip -out -selection clipboard
		}
	elif (( ${+commands[lemonade]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | lemonade copy
		}
		clippaste () {
			lemonade paste
		}
	elif (( ${+commands[doitclient]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | doitclient wclip
		}
		clippaste () {
			doitclient wclip -r
		}
	elif (( ${+commands[win32yank]} ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | win32yank -i
		}
		clippaste () {
			win32yank -o
		}
	elif [[ $OSTYPE == linux-android* ]] && (( $+commands[termux-clipboard-set] ))
	then
		clipcopy () {
			cat "${1:-/dev/stdin}" | termux-clipboard-set
		}
		clippaste () {
			termux-clipboard-get
		}
	elif [ -n "${TMUX:-}" ] && (( ${+commands[tmux]} ))
	then
		clipcopy () {
			tmux load-buffer -w "${1:--}"
		}
		clippaste () {
			tmux save-buffer -
		}
	else
		_retry_clipboard_detection_or_fail () {
			local clipcmd="${1}" 
			shift
			if detect-clipboard
			then
				"${clipcmd}" "$@"
			else
				print "${clipcmd}: Platform $OSTYPE not supported or xclip/xsel not installed" >&2
				return 1
			fi
		}
		clipcopy () {
			_retry_clipboard_detection_or_fail clipcopy "$@"
		}
		clippaste () {
			_retry_clipboard_detection_or_fail clippaste "$@"
		}
		return 1
	fi
}
diff () {
	command diff --color "$@"
}
down-line-or-beginning-search () {
	# undefined
	builtin autoload -XU
}
edit-command-line () {
	# undefined
	builtin autoload -XU
}
env_default () {
	[[ ${parameters[$1]} = *-export* ]] && return 0
	export "$1=$2" && return 3
}
format-drive () {
	if [ $# -ne 2 ]
	then
		echo "Usage: format-drive <device> <name>"
		echo "Example: format-drive /dev/sda 'My Stuff'"
		echo -e "\nAvailable drives:"
		lsblk -d -o NAME -n | awk '{print "/dev/"$1}'
	else
		echo "WARNING: This will completely erase all data on $1 and label it '$2'."
		read -rp "Are you sure you want to continue? (y/N): " confirm
		if [[ "$confirm" =~ ^[Yy]$ ]]
		then
			sudo wipefs -a "$1"
			sudo dd if=/dev/zero of="$1" bs=1M count=100 status=progress
			sudo parted -s "$1" mklabel gpt
			sudo parted -s "$1" mkpart primary ext4 1MiB 100%
			sudo mkfs.ext4 -L "$2" "$([[ $1 == *"nvme"* ]] && echo "${1}p1" || echo "${1}1")"
			sudo chmod -R 777 "/run/media/$USER/$2"
			echo "Drive $1 formatted and labeled '$2'."
		fi
	fi
}
gawklibpath_append () {
	[ -z "$AWKLIBPATH" ] && AWKLIBPATH=`gawk 'BEGIN {print ENVIRON["AWKLIBPATH"]}'` 
	export AWKLIBPATH="$AWKLIBPATH:$*" 
}
gawklibpath_default () {
	unset AWKLIBPATH
	export AWKLIBPATH=`gawk 'BEGIN {print ENVIRON["AWKLIBPATH"]}'` 
}
gawklibpath_prepend () {
	[ -z "$AWKLIBPATH" ] && AWKLIBPATH=`gawk 'BEGIN {print ENVIRON["AWKLIBPATH"]}'` 
	export AWKLIBPATH="$*:$AWKLIBPATH" 
}
gawkpath_append () {
	[ -z "$AWKPATH" ] && AWKPATH=`gawk 'BEGIN {print ENVIRON["AWKPATH"]}'` 
	export AWKPATH="$AWKPATH:$*" 
}
gawkpath_default () {
	unset AWKPATH
	export AWKPATH=`gawk 'BEGIN {print ENVIRON["AWKPATH"]}'` 
}
gawkpath_prepend () {
	[ -z "$AWKPATH" ] && AWKPATH=`gawk 'BEGIN {print ENVIRON["AWKPATH"]}'` 
	export AWKPATH="$*:$AWKPATH" 
}
gbda () {
	git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|$(git_develop_branch))\s*$)" | command xargs git branch --delete 2> /dev/null
}
gbds () {
	local default_branch=$(git_main_branch) 
	(( ! $? )) || default_branch=$(git_develop_branch) 
	git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch
	do
		local merge_base=$(git merge-base $default_branch $branch) 
		if [[ $(git cherry $default_branch $(git commit-tree $(git rev-parse $branch\^{tree}) -p $merge_base -m _)) = -* ]]
		then
			git branch -D $branch
		fi
	done
}
gccd () {
	setopt localoptions extendedglob
	local repo="${${@[(r)(ssh://*|git://*|ftp(s)#://*|http(s)#://*|*@*)(.git/#)#]}:-$_}" 
	command git clone --recurse-submodules "$@" || return
	[[ -d "$_" ]] && cd "$_" || cd "${${repo:t}%.git/#}"
}
gdnolock () {
	git diff "$@" ":(exclude)package-lock.json" ":(exclude)*.lock"
}
gdv () {
	git diff -w "$@" | view -
}
ggf () {
	local b
	[[ $# != 1 ]] && b="$(git_current_branch)" 
	git push --force origin "${b:-$1}"
}
ggfl () {
	local b
	[[ $# != 1 ]] && b="$(git_current_branch)" 
	git push --force-with-lease origin "${b:-$1}"
}
ggl () {
	if [[ $# != 0 ]] && [[ $# != 1 ]]
	then
		git pull origin "${*}"
	else
		local b
		[[ $# == 0 ]] && b="$(git_current_branch)" 
		git pull origin "${b:-$1}"
	fi
}
ggp () {
	if [[ $# != 0 ]] && [[ $# != 1 ]]
	then
		git push origin "${*}"
	else
		local b
		[[ $# == 0 ]] && b="$(git_current_branch)" 
		git push origin "${b:-$1}"
	fi
}
ggpnp () {
	if [[ $# == 0 ]]
	then
		ggl && ggp
	else
		ggl "${*}" && ggp "${*}"
	fi
}
ggu () {
	local b
	[[ $# != 1 ]] && b="$(git_current_branch)" 
	git pull --rebase origin "${b:-$1}"
}
git_commits_ahead () {
	if __git_prompt_git rev-parse --git-dir &> /dev/null
	then
		local commits="$(__git_prompt_git rev-list --count @{upstream}..HEAD 2>/dev/null)" 
		if [[ -n "$commits" && "$commits" != 0 ]]
		then
			echo "$ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX$commits$ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX"
		fi
	fi
}
git_commits_behind () {
	if __git_prompt_git rev-parse --git-dir &> /dev/null
	then
		local commits="$(__git_prompt_git rev-list --count HEAD..@{upstream} 2>/dev/null)" 
		if [[ -n "$commits" && "$commits" != 0 ]]
		then
			echo "$ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX$commits$ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX"
		fi
	fi
}
git_current_branch () {
	local ref
	ref=$(__git_prompt_git symbolic-ref --quiet HEAD 2> /dev/null) 
	local ret=$? 
	if [[ $ret != 0 ]]
	then
		[[ $ret == 128 ]] && return
		ref=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  || return
	fi
	echo ${ref#refs/heads/}
}
git_current_user_email () {
	__git_prompt_git config user.email 2> /dev/null
}
git_current_user_name () {
	__git_prompt_git config user.name 2> /dev/null
}
git_develop_branch () {
	command git rev-parse --git-dir &> /dev/null || return
	local branch
	for branch in dev devel develop development
	do
		if command git show-ref -q --verify refs/heads/$branch
		then
			echo $branch
			return 0
		fi
	done
	echo develop
	return 1
}
git_main_branch () {
	command git rev-parse --git-dir &> /dev/null || return
	local remote ref
	for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}
	do
		if command git show-ref -q --verify $ref
		then
			echo ${ref:t}
			return 0
		fi
	done
	for remote in origin upstream
	do
		ref=$(command git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null) 
		if [[ $ref == $remote/* ]]
		then
			echo ${ref#"$remote/"}
			return 0
		fi
	done
	echo master
	return 1
}
git_previous_branch () {
	local ref
	ref=$(__git_prompt_git rev-parse --quiet --symbolic-full-name @{-1} 2> /dev/null) 
	local ret=$? 
	if [[ $ret != 0 ]] || [[ -z $ref ]]
	then
		return
	fi
	echo ${ref#refs/heads/}
}
git_prompt_ahead () {
	if [[ -n "$(__git_prompt_git rev-list origin/$(git_current_branch)..HEAD 2> /dev/null)" ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_AHEAD"
	fi
}
git_prompt_behind () {
	if [[ -n "$(__git_prompt_git rev-list HEAD..origin/$(git_current_branch) 2> /dev/null)" ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_BEHIND"
	fi
}
git_prompt_info () {
	if [[ -n "${_OMZ_ASYNC_OUTPUT[_omz_git_prompt_info]}" ]]
	then
		echo -n "${_OMZ_ASYNC_OUTPUT[_omz_git_prompt_info]}"
	fi
}
git_prompt_long_sha () {
	local SHA
	SHA=$(__git_prompt_git rev-parse HEAD 2> /dev/null)  && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}
git_prompt_remote () {
	if [[ -n "$(__git_prompt_git show-ref origin/$(git_current_branch) 2> /dev/null)" ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_REMOTE_EXISTS"
	else
		echo "$ZSH_THEME_GIT_PROMPT_REMOTE_MISSING"
	fi
}
git_prompt_short_sha () {
	local SHA
	SHA=$(__git_prompt_git rev-parse --short HEAD 2> /dev/null)  && echo "$ZSH_THEME_GIT_PROMPT_SHA_BEFORE$SHA$ZSH_THEME_GIT_PROMPT_SHA_AFTER"
}
git_prompt_status () {
	if [[ -n "${_OMZ_ASYNC_OUTPUT[_omz_git_prompt_status]}" ]]
	then
		echo -n "${_OMZ_ASYNC_OUTPUT[_omz_git_prompt_status]}"
	fi
}
git_remote_status () {
	local remote ahead behind git_remote_status git_remote_status_detailed
	remote=${$(__git_prompt_git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/} 
	if [[ -n ${remote} ]]
	then
		ahead=$(__git_prompt_git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l) 
		behind=$(__git_prompt_git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l) 
		if [[ $ahead -eq 0 ]] && [[ $behind -eq 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_EQUAL_REMOTE" 
		elif [[ $ahead -gt 0 ]] && [[ $behind -eq 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE" 
			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$((ahead))%{$reset_color%}" 
		elif [[ $behind -gt 0 ]] && [[ $ahead -eq 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE" 
			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$((behind))%{$reset_color%}" 
		elif [[ $ahead -gt 0 ]] && [[ $behind -gt 0 ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE" 
			git_remote_status_detailed="$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$((ahead))%{$reset_color%}$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE_COLOR$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$((behind))%{$reset_color%}" 
		fi
		if [[ -n $ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_DETAILED ]]
		then
			git_remote_status="$ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_PREFIX${remote//\%/%%}$git_remote_status_detailed$ZSH_THEME_GIT_PROMPT_REMOTE_STATUS_SUFFIX" 
		fi
		echo $git_remote_status
	fi
}
git_repo_name () {
	local repo_path
	if repo_path="$(__git_prompt_git rev-parse --show-toplevel 2>/dev/null)"  && [[ -n "$repo_path" ]]
	then
		echo ${repo_path:t}
	fi
}
grename () {
	if [[ -z "$1" || -z "$2" ]]
	then
		echo "Usage: $0 old_branch new_branch"
		return 1
	fi
	git branch -m "$1" "$2"
	if git push origin :"$1"
	then
		git push --set-upstream origin "$2"
	fi
}
gunwipall () {
	local _commit=$(git log --grep='--wip--' --invert-grep --max-count=1 --format=format:%H) 
	if [[ "$_commit" != "$(git rev-parse HEAD)" ]]
	then
		git reset $_commit || return 1
	fi
}
handle_completion_insecurities () {
	local -aU insecure_dirs
	insecure_dirs=(${(f@):-"$(compaudit 2>/dev/null)"}) 
	[[ -z "${insecure_dirs}" ]] && return
	print "[oh-my-zsh] Insecure completion-dependent directories detected:"
	ls -ld "${(@)insecure_dirs}"
	cat <<EOD

[oh-my-zsh] For safety, we will not load completions from these directories until
[oh-my-zsh] you fix their permissions and ownership and restart zsh.
[oh-my-zsh] See the above list for directories with group or other writability.

[oh-my-zsh] To fix your permissions you can do so by disabling
[oh-my-zsh] the write permission of "group" and "others" and making sure that the
[oh-my-zsh] owner of these directories is either root or your current user.
[oh-my-zsh] The following command may help:
[oh-my-zsh]     compaudit | xargs chmod g-w,o-w

[oh-my-zsh] If the above didn't help or you want to skip the verification of
[oh-my-zsh] insecure directories you can set the variable ZSH_DISABLE_COMPFIX to
[oh-my-zsh] "true" before oh-my-zsh is sourced in your zshrc file.

EOD
}
hg_prompt_info () {
	return 1
}
img2jpg () {
	magick $1 -quality 95 -strip ${1%.*}.jpg
}
img2jpg-small () {
	magick $1 -resize 1080x\> -quality 95 -strip ${1%.*}.jpg
}
img2png () {
	magick "$1" -strip -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all "${1%.*}.png"
}
is-at-least () {
	emulate -L zsh
	local IFS=".-" min_cnt=0 ver_cnt=0 part min_ver version order 
	min_ver=(${=1}) 
	version=(${=2:-$ZSH_VERSION} 0) 
	while (( $min_cnt <= ${#min_ver} ))
	do
		while [[ "$part" != <-> ]]
		do
			(( ++ver_cnt > ${#version} )) && return 0
			if [[ ${version[ver_cnt]} = *[0-9][^0-9]* ]]
			then
				order=(${version[ver_cnt]} ${min_ver[ver_cnt]}) 
				if [[ ${version[ver_cnt]} = <->* ]]
				then
					[[ $order != ${${(On)order}} ]] && return 1
				else
					[[ $order != ${${(O)order}} ]] && return 1
				fi
				[[ $order[1] != $order[2] ]] && return 0
			fi
			part=${version[ver_cnt]##*[^0-9]} 
		done
		while true
		do
			(( ++min_cnt > ${#min_ver} )) && return 0
			[[ ${min_ver[min_cnt]} = <-> ]] && break
		done
		(( part > min_ver[min_cnt] )) && return 0
		(( part < min_ver[min_cnt] )) && return 1
		part='' 
	done
}
is_plugin () {
	local base_dir=$1 
	local name=$2 
	builtin test -f $base_dir/plugins/$name/$name.plugin.zsh || builtin test -f $base_dir/plugins/$name/_$name
}
is_theme () {
	local base_dir=$1 
	local name=$2 
	builtin test -f $base_dir/$name.zsh-theme
}
iso2sd () {
	if [ $# -ne 2 ]
	then
		echo "Usage: iso2sd <input_file> <output_device>"
		echo "Example: iso2sd ~/Downloads/ubuntu-25.04-desktop-amd64.iso /dev/sda"
		echo -e "\nAvailable SD cards:"
		lsblk -d -o NAME | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv} -E '^sd[a-z]' | awk '{print "/dev/"$1}'
	else
		sudo dd bs=4M status=progress oflag=sync if="$1" of="$2"
		sudo eject $2
	fi
}
jenv_prompt_info () {
	return 1
}
mkcd () {
	mkdir -p $@ && cd ${@:$#}
}
n () {
	if [ "$#" -eq 0 ]
	then
		nvim .
	else
		nvim "$@"
	fi
}
nvm () {
	if [ "$#" -lt 1 ]
	then
		nvm --help
		return
	fi
	local DEFAULT_IFS
	DEFAULT_IFS=" $(nvm_echo t | command tr t \\t)
" 
	if [ "${-#*e}" != "$-" ]
	then
		set +e
		local EXIT_CODE
		IFS="${DEFAULT_IFS}" nvm "$@"
		EXIT_CODE="$?" 
		set -e
		return "$EXIT_CODE"
	elif [ "${-#*a}" != "$-" ]
	then
		set +a
		local EXIT_CODE
		IFS="${DEFAULT_IFS}" nvm "$@"
		EXIT_CODE="$?" 
		set -a
		return "$EXIT_CODE"
	elif [ -n "${BASH-}" ] && [ "${-#*E}" != "$-" ]
	then
		set +E
		local EXIT_CODE
		IFS="${DEFAULT_IFS}" nvm "$@"
		EXIT_CODE="$?" 
		set -E
		return "$EXIT_CODE"
	elif [ "${IFS}" != "${DEFAULT_IFS}" ]
	then
		IFS="${DEFAULT_IFS}" nvm "$@"
		return "$?"
	fi
	local i
	for i in "$@"
	do
		case $i in
			(--) break ;;
			('-h' | 'help' | '--help') NVM_NO_COLORS="" 
				for j in "$@"
				do
					if [ "${j}" = '--no-colors' ]
					then
						NVM_NO_COLORS="${j}" 
						break
					fi
				done
				local NVM_IOJS_PREFIX
				NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
				local NVM_NODE_PREFIX
				NVM_NODE_PREFIX="$(nvm_node_prefix)" 
				NVM_VERSION="$(nvm --version)" 
				nvm_echo
				nvm_echo "Node Version Manager (v${NVM_VERSION})"
				nvm_echo
				nvm_echo 'Note: <version> refers to any version-like string nvm understands. This includes:'
				nvm_echo '  - full or partial version numbers, starting with an optional "v" (0.10, v0.1.2, v1)'
				nvm_echo "  - default (built-in) aliases: ${NVM_NODE_PREFIX}, stable, unstable, ${NVM_IOJS_PREFIX}, system"
				nvm_echo '  - custom aliases you define with `nvm alias foo`'
				nvm_echo
				nvm_echo ' Any options that produce colorized output should respect the `--no-colors` option.'
				nvm_echo
				nvm_echo 'Usage:'
				nvm_echo '  nvm --help                                  Show this message'
				nvm_echo '    --no-colors                               Suppress colored output'
				nvm_echo '  nvm --version                               Print out the installed version of nvm'
				nvm_echo '  nvm install [<version>]                     Download and install a <version>. Uses .nvmrc if available and version is omitted.'
				nvm_echo '   The following optional arguments, if provided, must appear directly after `nvm install`:'
				nvm_echo '    -s                                        Skip binary download, install from source only.'
				nvm_echo '    -b                                        Skip source download, install from binary only.'
				nvm_echo '    --reinstall-packages-from=<version>       When installing, reinstall packages installed in <node|iojs|node version number>'
				nvm_echo '    --lts                                     When installing, only select from LTS (long-term support) versions'
				nvm_echo '    --lts=<LTS name>                          When installing, only select from versions for a specific LTS line'
				nvm_echo '    --skip-default-packages                   When installing, skip the default-packages file if it exists'
				nvm_echo '    --latest-npm                              After installing, attempt to upgrade to the latest working npm on the given node version'
				nvm_echo '    --no-progress                             Disable the progress bar on any downloads'
				nvm_echo '    --alias=<name>                            After installing, set the alias specified to the version specified. (same as: nvm alias <name> <version>)'
				nvm_echo '    --default                                 After installing, set default alias to the version specified. (same as: nvm alias default <version>)'
				nvm_echo '    --save                                    After installing, write the specified version to .nvmrc'
				nvm_echo '  nvm uninstall <version>                     Uninstall a version'
				nvm_echo '  nvm uninstall --lts                         Uninstall using automatic LTS (long-term support) alias `lts/*`, if available.'
				nvm_echo '  nvm uninstall --lts=<LTS name>              Uninstall using automatic alias for provided LTS line, if available.'
				nvm_echo '  nvm use [<version>]                         Modify PATH to use <version>. Uses .nvmrc if available and version is omitted.'
				nvm_echo '   The following optional arguments, if provided, must appear directly after `nvm use`:'
				nvm_echo '    --silent                                  Silences stdout/stderr output'
				nvm_echo '    --lts                                     Uses automatic LTS (long-term support) alias `lts/*`, if available.'
				nvm_echo '    --lts=<LTS name>                          Uses automatic alias for provided LTS line, if available.'
				nvm_echo '    --save                                    Writes the specified version to .nvmrc.'
				nvm_echo '  nvm exec [<version>] [<command>]            Run <command> on <version>. Uses .nvmrc if available and version is omitted.'
				nvm_echo '   The following optional arguments, if provided, must appear directly after `nvm exec`:'
				nvm_echo '    --silent                                  Silences stdout/stderr output'
				nvm_echo '    --lts                                     Uses automatic LTS (long-term support) alias `lts/*`, if available.'
				nvm_echo '    --lts=<LTS name>                          Uses automatic alias for provided LTS line, if available.'
				nvm_echo '  nvm run [<version>] [<args>]                Run `node` on <version> with <args> as arguments. Uses .nvmrc if available and version is omitted.'
				nvm_echo '   The following optional arguments, if provided, must appear directly after `nvm run`:'
				nvm_echo '    --silent                                  Silences stdout/stderr output'
				nvm_echo '    --lts                                     Uses automatic LTS (long-term support) alias `lts/*`, if available.'
				nvm_echo '    --lts=<LTS name>                          Uses automatic alias for provided LTS line, if available.'
				nvm_echo '  nvm current                                 Display currently activated version of Node'
				nvm_echo '  nvm ls [<version>]                          List installed versions, matching a given <version> if provided'
				nvm_echo '    --no-colors                               Suppress colored output'
				nvm_echo '    --no-alias                                Suppress `nvm alias` output'
				nvm_echo '  nvm ls-remote [<version>]                   List remote versions available for install, matching a given <version> if provided'
				nvm_echo '    --lts                                     When listing, only show LTS (long-term support) versions'
				nvm_echo '    --lts=<LTS name>                          When listing, only show versions for a specific LTS line'
				nvm_echo '    --no-colors                               Suppress colored output'
				nvm_echo '  nvm version <version>                       Resolve the given description to a single local version'
				nvm_echo '  nvm version-remote <version>                Resolve the given description to a single remote version'
				nvm_echo '    --lts                                     When listing, only select from LTS (long-term support) versions'
				nvm_echo '    --lts=<LTS name>                          When listing, only select from versions for a specific LTS line'
				nvm_echo '  nvm deactivate                              Undo effects of `nvm` on current shell'
				nvm_echo '    --silent                                  Silences stdout/stderr output'
				nvm_echo '  nvm alias [<pattern>]                       Show all aliases beginning with <pattern>'
				nvm_echo '    --no-colors                               Suppress colored output'
				nvm_echo '  nvm alias <name> <version>                  Set an alias named <name> pointing to <version>'
				nvm_echo '  nvm unalias <name>                          Deletes the alias named <name>'
				nvm_echo '  nvm install-latest-npm                      Attempt to upgrade to the latest working `npm` on the current node version'
				nvm_echo '  nvm reinstall-packages <version>            Reinstall global `npm` packages contained in <version> to current version'
				nvm_echo '  nvm unload                                  Unload `nvm` from shell'
				nvm_echo '  nvm which [current | <version>]             Display path to installed node version. Uses .nvmrc if available and version is omitted.'
				nvm_echo '    --silent                                  Silences stdout/stderr output when a version is omitted'
				nvm_echo '  nvm cache dir                               Display path to the cache directory for nvm'
				nvm_echo '  nvm cache clear                             Empty cache directory for nvm'
				nvm_echo '  nvm set-colors [<color codes>]              Set five text colors using format "yMeBg". Available when supported.'
				nvm_echo '                                               Initial colors are:'
				nvm_echo_with_colors "                                                  $(nvm_wrap_with_color_code 'b' 'b')$(nvm_wrap_with_color_code 'y' 'y')$(nvm_wrap_with_color_code 'g' 'g')$(nvm_wrap_with_color_code 'r' 'r')$(nvm_wrap_with_color_code 'e' 'e')"
				nvm_echo '                                               Color codes:'
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'r' 'r')/$(nvm_wrap_with_color_code 'R' 'R') = $(nvm_wrap_with_color_code 'r' 'red') / $(nvm_wrap_with_color_code 'R' 'bold red')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'g' 'g')/$(nvm_wrap_with_color_code 'G' 'G') = $(nvm_wrap_with_color_code 'g' 'green') / $(nvm_wrap_with_color_code 'G' 'bold green')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'b' 'b')/$(nvm_wrap_with_color_code 'B' 'B') = $(nvm_wrap_with_color_code 'b' 'blue') / $(nvm_wrap_with_color_code 'B' 'bold blue')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'c' 'c')/$(nvm_wrap_with_color_code 'C' 'C') = $(nvm_wrap_with_color_code 'c' 'cyan') / $(nvm_wrap_with_color_code 'C' 'bold cyan')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'm' 'm')/$(nvm_wrap_with_color_code 'M' 'M') = $(nvm_wrap_with_color_code 'm' 'magenta') / $(nvm_wrap_with_color_code 'M' 'bold magenta')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'y' 'y')/$(nvm_wrap_with_color_code 'Y' 'Y') = $(nvm_wrap_with_color_code 'y' 'yellow') / $(nvm_wrap_with_color_code 'Y' 'bold yellow')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'k' 'k')/$(nvm_wrap_with_color_code 'K' 'K') = $(nvm_wrap_with_color_code 'k' 'black') / $(nvm_wrap_with_color_code 'K' 'bold black')"
				nvm_echo_with_colors "                                                $(nvm_wrap_with_color_code 'e' 'e')/$(nvm_wrap_with_color_code 'W' 'W') = $(nvm_wrap_with_color_code 'e' 'light grey') / $(nvm_wrap_with_color_code 'W' 'white')"
				nvm_echo 'Example:'
				nvm_echo '  nvm install 8.0.0                     Install a specific version number'
				nvm_echo '  nvm use 8.0                           Use the latest available 8.0.x release'
				nvm_echo '  nvm run 6.10.3 app.js                 Run app.js using node 6.10.3'
				nvm_echo '  nvm exec 4.8.3 node app.js            Run `node app.js` with the PATH pointing to node 4.8.3'
				nvm_echo '  nvm alias default 8.1.0               Set default node version on a shell'
				nvm_echo '  nvm alias default node                Always default to the latest available node version on a shell'
				nvm_echo
				nvm_echo '  nvm install node                      Install the latest available version'
				nvm_echo '  nvm use node                          Use the latest version'
				nvm_echo '  nvm install --lts                     Install the latest LTS version'
				nvm_echo '  nvm use --lts                         Use the latest LTS version'
				nvm_echo
				nvm_echo '  nvm set-colors cgYmW                  Set text colors to cyan, green, bold yellow, magenta, and white'
				nvm_echo
				nvm_echo 'Note:'
				nvm_echo '  to remove, delete, or uninstall nvm - just remove the `$NVM_DIR` folder (usually `~/.nvm`)'
				nvm_echo
				return 0 ;;
		esac
	done
	local COMMAND
	COMMAND="${1-}" 
	shift
	local VERSION
	local ADDITIONAL_PARAMETERS
	case $COMMAND in
		("cache") case "${1-}" in
				(dir) nvm_cache_dir ;;
				(clear) local DIR
					DIR="$(nvm_cache_dir)" 
					if command rm -rf "${DIR}" && command mkdir -p "${DIR}"
					then
						nvm_echo 'nvm cache cleared.'
					else
						nvm_err "Unable to clear nvm cache: ${DIR}"
						return 1
					fi ;;
				(*) nvm --help >&2
					return 127 ;;
			esac ;;
		("debug") local OS_VERSION
			nvm_is_zsh && setopt local_options shwordsplit
			nvm_err "nvm --version: v$(nvm --version)"
			if [ -n "${TERM_PROGRAM-}" ]
			then
				nvm_err "\$TERM_PROGRAM: ${TERM_PROGRAM}"
			fi
			nvm_err "\$SHELL: ${SHELL}"
			nvm_err "\$SHLVL: ${SHLVL-}"
			nvm_err "whoami: '$(whoami)'"
			nvm_err "\${HOME}: ${HOME}"
			nvm_err "\${NVM_DIR}: '$(nvm_sanitize_path "${NVM_DIR}")'"
			nvm_err "\${PATH}: $(nvm_sanitize_path "${PATH}")"
			nvm_err "\$PREFIX: '$(nvm_sanitize_path "${PREFIX}")'"
			nvm_err "\${NPM_CONFIG_PREFIX}: '$(nvm_sanitize_path "${NPM_CONFIG_PREFIX}")'"
			nvm_err "\$NVM_NODEJS_ORG_MIRROR: '${NVM_NODEJS_ORG_MIRROR}'"
			nvm_err "\$NVM_IOJS_ORG_MIRROR: '${NVM_IOJS_ORG_MIRROR}'"
			nvm_err "shell version: '$(${SHELL} --version | command head -n 1)'"
			nvm_err "uname -a: '$(command uname -a | command awk '{$2=""; print}' | command xargs)'"
			nvm_err "checksum binary: '$(nvm_get_checksum_binary 2>/dev/null)'"
			if [ "$(nvm_get_os)" = "darwin" ] && nvm_has sw_vers
			then
				OS_VERSION="$(sw_vers | command awk '{print $2}' | command xargs)" 
			elif [ -r "/etc/issue" ]
			then
				OS_VERSION="$(command head -n 1 /etc/issue | command sed 's/\\.//g')" 
				if [ -z "${OS_VERSION}" ] && [ -r "/etc/os-release" ]
				then
					OS_VERSION="$(. /etc/os-release && echo "${NAME}" "${VERSION}")" 
				fi
			fi
			if [ -n "${OS_VERSION}" ]
			then
				nvm_err "OS version: ${OS_VERSION}"
			fi
			if nvm_has "awk"
			then
				nvm_err "awk: $(nvm_command_info awk), $({ command awk --version 2>/dev/null || command awk -W version; } \
          | command head -n 1)"
			else
				nvm_err "awk: not found"
			fi
			if nvm_has "curl"
			then
				nvm_err "curl: $(nvm_command_info curl), $(command curl -V | command head -n 1)"
			else
				nvm_err "curl: not found"
			fi
			if nvm_has "wget"
			then
				nvm_err "wget: $(nvm_command_info wget), $(command wget -V | command head -n 1)"
			else
				nvm_err "wget: not found"
			fi
			local TEST_TOOLS ADD_TEST_TOOLS
			TEST_TOOLS="git grep" 
			ADD_TEST_TOOLS="sed cut basename rm mkdir xargs" 
			if [ "darwin" != "$(nvm_get_os)" ] && [ "freebsd" != "$(nvm_get_os)" ]
			then
				TEST_TOOLS="${TEST_TOOLS} ${ADD_TEST_TOOLS}" 
			else
				for tool in ${ADD_TEST_TOOLS}
				do
					if nvm_has "${tool}"
					then
						nvm_err "${tool}: $(nvm_command_info "${tool}")"
					else
						nvm_err "${tool}: not found"
					fi
				done
			fi
			for tool in ${TEST_TOOLS}
			do
				local NVM_TOOL_VERSION
				if nvm_has "${tool}"
				then
					if command ls -l "$(nvm_command_info "${tool}" | command awk '{print $1}')" | command grep -q busybox
					then
						NVM_TOOL_VERSION="$(command "${tool}" --help 2>&1 | command head -n 1)" 
					else
						NVM_TOOL_VERSION="$(command "${tool}" --version 2>&1 | command head -n 1)" 
					fi
					nvm_err "${tool}: $(nvm_command_info "${tool}"), ${NVM_TOOL_VERSION}"
				else
					nvm_err "${tool}: not found"
				fi
				unset NVM_TOOL_VERSION
			done
			unset TEST_TOOLS ADD_TEST_TOOLS
			local NVM_DEBUG_OUTPUT
			for NVM_DEBUG_COMMAND in 'nvm current' 'which node' 'which iojs' 'which npm' 'npm config get prefix' 'npm root -g'
			do
				NVM_DEBUG_OUTPUT="$(${NVM_DEBUG_COMMAND} 2>&1)" 
				nvm_err "${NVM_DEBUG_COMMAND}: $(nvm_sanitize_path "${NVM_DEBUG_OUTPUT}")"
			done
			return 42 ;;
		("install" | "i") local version_not_provided
			version_not_provided=0 
			local NVM_OS
			NVM_OS="$(nvm_get_os)" 
			if ! nvm_has "curl" && ! nvm_has "wget"
			then
				nvm_err 'nvm needs curl or wget to proceed.'
				return 1
			fi
			if [ $# -lt 1 ]
			then
				version_not_provided=1 
			fi
			local nobinary
			local nosource
			local noprogress
			nobinary=0 
			noprogress=0 
			nosource=0 
			local LTS
			local ALIAS
			local NVM_UPGRADE_NPM
			NVM_UPGRADE_NPM=0 
			local NVM_WRITE_TO_NVMRC
			NVM_WRITE_TO_NVMRC=0 
			local PROVIDED_REINSTALL_PACKAGES_FROM
			local REINSTALL_PACKAGES_FROM
			local SKIP_DEFAULT_PACKAGES
			while [ $# -ne 0 ]
			do
				case "$1" in
					(---*) nvm_err 'arguments with `---` are not supported - this is likely a typo'
						return 55 ;;
					(-s) shift
						nobinary=1 
						if [ $nosource -eq 1 ]
						then
							nvm err '-s and -b cannot be set together since they would skip install from both binary and source'
							return 6
						fi ;;
					(-b) shift
						nosource=1 
						if [ $nobinary -eq 1 ]
						then
							nvm err '-s and -b cannot be set together since they would skip install from both binary and source'
							return 6
						fi ;;
					(-j) shift
						nvm_get_make_jobs "$1"
						shift ;;
					(--no-progress) noprogress=1 
						shift ;;
					(--lts) LTS='*' 
						shift ;;
					(--lts=*) LTS="${1##--lts=}" 
						shift ;;
					(--latest-npm) NVM_UPGRADE_NPM=1 
						shift ;;
					(--default) if [ -n "${ALIAS-}" ]
						then
							nvm_err '--default and --alias are mutually exclusive, and may not be provided more than once'
							return 6
						fi
						ALIAS='default' 
						shift ;;
					(--alias=*) if [ -n "${ALIAS-}" ]
						then
							nvm_err '--default and --alias are mutually exclusive, and may not be provided more than once'
							return 6
						fi
						ALIAS="${1##--alias=}" 
						shift ;;
					(--reinstall-packages-from=*) if [ -n "${PROVIDED_REINSTALL_PACKAGES_FROM-}" ]
						then
							nvm_err '--reinstall-packages-from may not be provided more than once'
							return 6
						fi
						PROVIDED_REINSTALL_PACKAGES_FROM="$(nvm_echo "$1" | command cut -c 27-)" 
						if [ -z "${PROVIDED_REINSTALL_PACKAGES_FROM}" ]
						then
							nvm_err 'If --reinstall-packages-from is provided, it must point to an installed version of node.'
							return 6
						fi
						REINSTALL_PACKAGES_FROM="$(nvm_version "${PROVIDED_REINSTALL_PACKAGES_FROM}")"  || :
						shift ;;
					(--copy-packages-from=*) if [ -n "${PROVIDED_REINSTALL_PACKAGES_FROM-}" ]
						then
							nvm_err '--reinstall-packages-from may not be provided more than once, or combined with `--copy-packages-from`'
							return 6
						fi
						PROVIDED_REINSTALL_PACKAGES_FROM="$(nvm_echo "$1" | command cut -c 22-)" 
						if [ -z "${PROVIDED_REINSTALL_PACKAGES_FROM}" ]
						then
							nvm_err 'If --copy-packages-from is provided, it must point to an installed version of node.'
							return 6
						fi
						REINSTALL_PACKAGES_FROM="$(nvm_version "${PROVIDED_REINSTALL_PACKAGES_FROM}")"  || :
						shift ;;
					(--reinstall-packages-from | --copy-packages-from) nvm_err "If ${1} is provided, it must point to an installed version of node using \`=\`."
						return 6 ;;
					(--skip-default-packages) SKIP_DEFAULT_PACKAGES=true 
						shift ;;
					(--save | -w) if [ $NVM_WRITE_TO_NVMRC -eq 1 ]
						then
							nvm_err '--save and -w may only be provided once'
							return 6
						fi
						NVM_WRITE_TO_NVMRC=1 
						shift ;;
					(*) break ;;
				esac
			done
			local provided_version
			provided_version="${1-}" 
			if [ -z "${provided_version}" ]
			then
				if [ "_${LTS-}" = '_*' ]
				then
					nvm_echo 'Installing latest LTS version.'
					if [ $# -gt 0 ]
					then
						shift
					fi
				elif [ "_${LTS-}" != '_' ]
				then
					nvm_echo "Installing with latest version of LTS line: ${LTS}"
					if [ $# -gt 0 ]
					then
						shift
					fi
				else
					nvm_rc_version
					if [ $version_not_provided -eq 1 ] && [ -z "${NVM_RC_VERSION}" ]
					then
						unset NVM_RC_VERSION
						nvm --help >&2
						return 127
					fi
					provided_version="${NVM_RC_VERSION}" 
					unset NVM_RC_VERSION
				fi
			elif [ $# -gt 0 ]
			then
				shift
			fi
			case "${provided_version}" in
				('lts/*') LTS='*' 
					provided_version=''  ;;
				(lts/*) LTS="${provided_version##lts/}" 
					provided_version=''  ;;
			esac
			local EXIT_CODE
			VERSION="$(NVM_VERSION_ONLY=true NVM_LTS="${LTS-}" nvm_remote_version "${provided_version}")" 
			EXIT_CODE="$?" 
			if [ "${VERSION}" = 'N/A' ] || [ $EXIT_CODE -ne 0 ]
			then
				local LTS_MSG
				local REMOTE_CMD
				if [ "${LTS-}" = '*' ]
				then
					LTS_MSG='(with LTS filter) ' 
					REMOTE_CMD='nvm ls-remote --lts' 
				elif [ -n "${LTS-}" ]
				then
					LTS_MSG="(with LTS filter '${LTS}') " 
					REMOTE_CMD="nvm ls-remote --lts=${LTS}" 
					if [ -z "${provided_version}" ]
					then
						nvm_err "Version with LTS filter '${LTS}' not found - try \`${REMOTE_CMD}\` to browse available versions."
						return 3
					fi
				else
					REMOTE_CMD='nvm ls-remote' 
				fi
				nvm_err "Version '${provided_version}' ${LTS_MSG-}not found - try \`${REMOTE_CMD}\` to browse available versions."
				return 3
			fi
			ADDITIONAL_PARAMETERS='' 
			while [ $# -ne 0 ]
			do
				case "$1" in
					(--reinstall-packages-from=*) if [ -n "${PROVIDED_REINSTALL_PACKAGES_FROM-}" ]
						then
							nvm_err '--reinstall-packages-from may not be provided more than once'
							return 6
						fi
						PROVIDED_REINSTALL_PACKAGES_FROM="$(nvm_echo "$1" | command cut -c 27-)" 
						if [ -z "${PROVIDED_REINSTALL_PACKAGES_FROM}" ]
						then
							nvm_err 'If --reinstall-packages-from is provided, it must point to an installed version of node.'
							return 6
						fi
						REINSTALL_PACKAGES_FROM="$(nvm_version "${PROVIDED_REINSTALL_PACKAGES_FROM}")"  || : ;;
					(--copy-packages-from=*) if [ -n "${PROVIDED_REINSTALL_PACKAGES_FROM-}" ]
						then
							nvm_err '--reinstall-packages-from may not be provided more than once, or combined with `--copy-packages-from`'
							return 6
						fi
						PROVIDED_REINSTALL_PACKAGES_FROM="$(nvm_echo "$1" | command cut -c 22-)" 
						if [ -z "${PROVIDED_REINSTALL_PACKAGES_FROM}" ]
						then
							nvm_err 'If --copy-packages-from is provided, it must point to an installed version of node.'
							return 6
						fi
						REINSTALL_PACKAGES_FROM="$(nvm_version "${PROVIDED_REINSTALL_PACKAGES_FROM}")"  || : ;;
					(--reinstall-packages-from | --copy-packages-from) nvm_err "If ${1} is provided, it must point to an installed version of node using \`=\`."
						return 6 ;;
					(--skip-default-packages) SKIP_DEFAULT_PACKAGES=true  ;;
					(*) ADDITIONAL_PARAMETERS="${ADDITIONAL_PARAMETERS} $1"  ;;
				esac
				shift
			done
			if [ -n "${PROVIDED_REINSTALL_PACKAGES_FROM-}" ] && [ "$(nvm_ensure_version_prefix "${PROVIDED_REINSTALL_PACKAGES_FROM}")" = "${VERSION}" ]
			then
				nvm_err "You can't reinstall global packages from the same version of node you're installing."
				return 4
			elif [ "${REINSTALL_PACKAGES_FROM-}" = 'N/A' ]
			then
				nvm_err "If --reinstall-packages-from is provided, it must point to an installed version of node."
				return 5
			fi
			local FLAVOR
			if nvm_is_iojs_version "${VERSION}"
			then
				FLAVOR="$(nvm_iojs_prefix)" 
			else
				FLAVOR="$(nvm_node_prefix)" 
			fi
			EXIT_CODE=0 
			if nvm_is_version_installed "${VERSION}"
			then
				nvm_err "${VERSION} is already installed."
				nvm use "${VERSION}"
				EXIT_CODE=$? 
				if [ $EXIT_CODE -eq 0 ]
				then
					if [ "${NVM_UPGRADE_NPM}" = 1 ]
					then
						nvm install-latest-npm
						EXIT_CODE=$? 
					fi
					if [ $EXIT_CODE -ne 0 ] && [ -z "${SKIP_DEFAULT_PACKAGES-}" ]
					then
						nvm_install_default_packages
					fi
					if [ $EXIT_CODE -ne 0 ] && [ -n "${REINSTALL_PACKAGES_FROM-}" ] && [ "_${REINSTALL_PACKAGES_FROM}" != "_N/A" ]
					then
						nvm reinstall-packages "${REINSTALL_PACKAGES_FROM}"
						EXIT_CODE=$? 
					fi
				fi
				if [ -n "${LTS-}" ]
				then
					LTS="$(echo "${LTS}" | tr '[:upper:]' '[:lower:]')" 
					nvm_ensure_default_set "lts/${LTS}"
				else
					nvm_ensure_default_set "${provided_version}"
				fi
				if [ $NVM_WRITE_TO_NVMRC -eq 1 ]
				then
					nvm_write_nvmrc "${VERSION}"
					EXIT_CODE=$? 
				fi
				if [ $EXIT_CODE -ne 0 ] && [ -n "${ALIAS-}" ]
				then
					nvm alias "${ALIAS}" "${provided_version}"
					EXIT_CODE=$? 
				fi
				return $EXIT_CODE
			fi
			if [ -n "${NVM_INSTALL_THIRD_PARTY_HOOK-}" ]
			then
				nvm_err '** $NVM_INSTALL_THIRD_PARTY_HOOK env var set; dispatching to third-party installation method **'
				local NVM_METHOD_PREFERENCE
				NVM_METHOD_PREFERENCE='binary' 
				if [ $nobinary -eq 1 ]
				then
					NVM_METHOD_PREFERENCE='source' 
				fi
				local VERSION_PATH
				VERSION_PATH="$(nvm_version_path "${VERSION}")" 
				"${NVM_INSTALL_THIRD_PARTY_HOOK}" "${VERSION}" "${FLAVOR}" std "${NVM_METHOD_PREFERENCE}" "${VERSION_PATH}" || {
					EXIT_CODE=$? 
					nvm_err '*** Third-party $NVM_INSTALL_THIRD_PARTY_HOOK env var failed to install! ***'
					return $EXIT_CODE
				}
				if ! nvm_is_version_installed "${VERSION}"
				then
					nvm_err '*** Third-party $NVM_INSTALL_THIRD_PARTY_HOOK env var claimed to succeed, but failed to install! ***'
					return 33
				fi
				EXIT_CODE=0 
			else
				if [ "_${NVM_OS}" = "_freebsd" ]
				then
					nobinary=1 
					nvm_err "Currently, there is no binary for FreeBSD"
				elif [ "_$NVM_OS" = "_openbsd" ]
				then
					nobinary=1 
					nvm_err "Currently, there is no binary for OpenBSD"
				elif [ "_${NVM_OS}" = "_sunos" ]
				then
					if ! nvm_has_solaris_binary "${VERSION}"
					then
						nobinary=1 
						nvm_err "Currently, there is no binary of version ${VERSION} for SunOS"
					fi
				fi
				if [ $nobinary -ne 1 ] && nvm_binary_available "${VERSION}"
				then
					NVM_NO_PROGRESS="${NVM_NO_PROGRESS:-${noprogress}}" nvm_install_binary "${FLAVOR}" std "${VERSION}" "${nosource}"
					EXIT_CODE=$? 
				else
					EXIT_CODE=-1 
					if [ $nosource -eq 1 ]
					then
						nvm_err "Binary download is not available for ${VERSION}"
						EXIT_CODE=3 
					fi
				fi
				if [ $EXIT_CODE -ne 0 ] && [ $nosource -ne 1 ]
				then
					if [ -z "${NVM_MAKE_JOBS-}" ]
					then
						nvm_get_make_jobs
					fi
					if [ "_${NVM_OS}" = "_win" ]
					then
						nvm_err 'Installing from source on non-WSL Windows is not supported'
						EXIT_CODE=87 
					else
						NVM_NO_PROGRESS="${NVM_NO_PROGRESS:-${noprogress}}" nvm_install_source "${FLAVOR}" std "${VERSION}" "${NVM_MAKE_JOBS}" "${ADDITIONAL_PARAMETERS}"
						EXIT_CODE=$? 
					fi
				fi
			fi
			if [ $EXIT_CODE -eq 0 ]
			then
				if nvm_use_if_needed "${VERSION}" && nvm_install_npm_if_needed "${VERSION}"
				then
					if [ -n "${LTS-}" ]
					then
						nvm_ensure_default_set "lts/${LTS}"
					else
						nvm_ensure_default_set "${provided_version}"
					fi
					if [ "${NVM_UPGRADE_NPM}" = 1 ]
					then
						nvm install-latest-npm
						EXIT_CODE=$? 
					fi
					if [ $EXIT_CODE -eq 0 ] && [ -z "${SKIP_DEFAULT_PACKAGES-}" ]
					then
						nvm_install_default_packages
					fi
					if [ $EXIT_CODE -eq 0 ] && [ -n "${REINSTALL_PACKAGES_FROM-}" ] && [ "_${REINSTALL_PACKAGES_FROM}" != "_N/A" ]
					then
						nvm reinstall-packages "${REINSTALL_PACKAGES_FROM}"
						EXIT_CODE=$? 
					fi
				else
					EXIT_CODE=$? 
				fi
			fi
			return $EXIT_CODE ;;
		("uninstall") if [ $# -ne 1 ]
			then
				nvm --help >&2
				return 127
			fi
			local PATTERN
			PATTERN="${1-}" 
			case "${PATTERN-}" in
				(--)  ;;
				(--lts | 'lts/*') VERSION="$(nvm_match_version "lts/*")"  ;;
				(lts/*) VERSION="$(nvm_match_version "lts/${PATTERN##lts/}")"  ;;
				(--lts=*) VERSION="$(nvm_match_version "lts/${PATTERN##--lts=}")"  ;;
				(*) VERSION="$(nvm_version "${PATTERN}")"  ;;
			esac
			if [ "_${VERSION}" = "_$(nvm_ls_current)" ]
			then
				if nvm_is_iojs_version "${VERSION}"
				then
					nvm_err "nvm: Cannot uninstall currently-active io.js version, ${VERSION} (inferred from ${PATTERN})."
				else
					nvm_err "nvm: Cannot uninstall currently-active node version, ${VERSION} (inferred from ${PATTERN})."
				fi
				return 1
			fi
			if ! nvm_is_version_installed "${VERSION}"
			then
				nvm_err "${VERSION} version is not installed..."
				return
			fi
			local SLUG_BINARY
			local SLUG_SOURCE
			if nvm_is_iojs_version "${VERSION}"
			then
				SLUG_BINARY="$(nvm_get_download_slug iojs binary std "${VERSION}")" 
				SLUG_SOURCE="$(nvm_get_download_slug iojs source std "${VERSION}")" 
			else
				SLUG_BINARY="$(nvm_get_download_slug node binary std "${VERSION}")" 
				SLUG_SOURCE="$(nvm_get_download_slug node source std "${VERSION}")" 
			fi
			local NVM_SUCCESS_MSG
			if nvm_is_iojs_version "${VERSION}"
			then
				NVM_SUCCESS_MSG="Uninstalled io.js $(nvm_strip_iojs_prefix "${VERSION}")" 
			else
				NVM_SUCCESS_MSG="Uninstalled node ${VERSION}" 
			fi
			local VERSION_PATH
			VERSION_PATH="$(nvm_version_path "${VERSION}")" 
			if ! nvm_check_file_permissions "${VERSION_PATH}"
			then
				nvm_err 'Cannot uninstall, incorrect permissions on installation folder.'
				nvm_err 'This is usually caused by running `npm install -g` as root. Run the following commands as root to fix the permissions and then try again.'
				nvm_err
				nvm_err "  chown -R $(whoami) \"$(nvm_sanitize_path "${VERSION_PATH}")\""
				nvm_err "  chmod -R u+w \"$(nvm_sanitize_path "${VERSION_PATH}")\""
				return 1
			fi
			local CACHE_DIR
			CACHE_DIR="$(nvm_cache_dir)" 
			command rm -rf "${CACHE_DIR}/bin/${SLUG_BINARY}/files" "${CACHE_DIR}/src/${SLUG_SOURCE}/files" "${VERSION_PATH}" 2> /dev/null
			nvm_echo "${NVM_SUCCESS_MSG}"
			for ALIAS in $(nvm_grep -l "${VERSION}" "$(nvm_alias_path)/*" 2>/dev/null)
			do
				nvm unalias "$(command basename "${ALIAS}")"
			done ;;
		("deactivate") local NVM_SILENT
			while [ $# -ne 0 ]
			do
				case "${1}" in
					(--silent) NVM_SILENT=1  ;;
					(--)  ;;
				esac
				shift
			done
			local NEWPATH
			NEWPATH="$(nvm_strip_path "${PATH}" "/bin")" 
			if [ "_${PATH}" = "_${NEWPATH}" ]
			then
				if [ "${NVM_SILENT:-0}" -ne 1 ]
				then
					nvm_err "Could not find ${NVM_DIR}/*/bin in \${PATH}"
				fi
			else
				export PATH="${NEWPATH}" 
				\hash -r
				if [ "${NVM_SILENT:-0}" -ne 1 ]
				then
					nvm_echo "${NVM_DIR}/*/bin removed from \${PATH}"
				fi
			fi
			if [ -n "${MANPATH-}" ]
			then
				NEWPATH="$(nvm_strip_path "${MANPATH}" "/share/man")" 
				if [ "_${MANPATH}" = "_${NEWPATH}" ]
				then
					if [ "${NVM_SILENT:-0}" -ne 1 ]
					then
						nvm_err "Could not find ${NVM_DIR}/*/share/man in \${MANPATH}"
					fi
				else
					export MANPATH="${NEWPATH}" 
					if [ "${NVM_SILENT:-0}" -ne 1 ]
					then
						nvm_echo "${NVM_DIR}/*/share/man removed from \${MANPATH}"
					fi
				fi
			fi
			if [ -n "${NODE_PATH-}" ]
			then
				NEWPATH="$(nvm_strip_path "${NODE_PATH}" "/lib/node_modules")" 
				if [ "_${NODE_PATH}" != "_${NEWPATH}" ]
				then
					export NODE_PATH="${NEWPATH}" 
					if [ "${NVM_SILENT:-0}" -ne 1 ]
					then
						nvm_echo "${NVM_DIR}/*/lib/node_modules removed from \${NODE_PATH}"
					fi
				fi
			fi
			unset NVM_BIN
			unset NVM_INC ;;
		("use") local PROVIDED_VERSION
			local NVM_SILENT
			local NVM_SILENT_ARG
			local NVM_DELETE_PREFIX
			NVM_DELETE_PREFIX=0 
			local NVM_LTS
			local IS_VERSION_FROM_NVMRC
			IS_VERSION_FROM_NVMRC=0 
			local NVM_WRITE_TO_NVMRC
			NVM_WRITE_TO_NVMRC=0 
			while [ $# -ne 0 ]
			do
				case "$1" in
					(--silent) NVM_SILENT=1 
						NVM_SILENT_ARG='--silent'  ;;
					(--delete-prefix) NVM_DELETE_PREFIX=1  ;;
					(--)  ;;
					(--lts) NVM_LTS='*'  ;;
					(--lts=*) NVM_LTS="${1##--lts=}"  ;;
					(--save | -w) if [ $NVM_WRITE_TO_NVMRC -eq 1 ]
						then
							nvm_err '--save and -w may only be provided once'
							return 6
						fi
						NVM_WRITE_TO_NVMRC=1  ;;
					(--*)  ;;
					(*) if [ -n "${1-}" ]
						then
							PROVIDED_VERSION="$1" 
						fi ;;
				esac
				shift
			done
			if [ -n "${NVM_LTS-}" ]
			then
				VERSION="$(nvm_match_version "lts/${NVM_LTS:-*}")" 
			elif [ -z "${PROVIDED_VERSION-}" ]
			then
				NVM_SILENT="${NVM_SILENT:-0}" nvm_rc_version
				if [ -n "${NVM_RC_VERSION-}" ]
				then
					PROVIDED_VERSION="${NVM_RC_VERSION}" 
					IS_VERSION_FROM_NVMRC=1 
					VERSION="$(nvm_version "${PROVIDED_VERSION}")" 
				fi
				unset NVM_RC_VERSION
				if [ -z "${VERSION}" ]
				then
					nvm_err 'Please see `nvm --help` or https://github.com/nvm-sh/nvm#nvmrc for more information.'
					return 127
				fi
			else
				VERSION="$(nvm_match_version "${PROVIDED_VERSION}")" 
			fi
			if [ -z "${VERSION}" ]
			then
				nvm --help >&2
				return 127
			fi
			if [ $NVM_WRITE_TO_NVMRC -eq 1 ]
			then
				nvm_write_nvmrc "${VERSION}"
			fi
			if [ "_${VERSION}" = '_system' ]
			then
				if nvm_has_system_node && nvm deactivate "${NVM_SILENT_ARG-}" > /dev/null 2>&1
				then
					if [ "${NVM_SILENT:-0}" -ne 1 ]
					then
						nvm_echo "Now using system version of node: $(node -v 2>/dev/null)$(nvm_print_npm_version)"
					fi
					return
				elif nvm_has_system_iojs && nvm deactivate "${NVM_SILENT_ARG-}" > /dev/null 2>&1
				then
					if [ "${NVM_SILENT:-0}" -ne 1 ]
					then
						nvm_echo "Now using system version of io.js: $(iojs --version 2>/dev/null)$(nvm_print_npm_version)"
					fi
					return
				elif [ "${NVM_SILENT:-0}" -ne 1 ]
				then
					nvm_err 'System version of node not found.'
				fi
				return 127
			elif [ "_${VERSION}" = '_∞' ]
			then
				if [ "${NVM_SILENT:-0}" -ne 1 ]
				then
					nvm_err "The alias \"${PROVIDED_VERSION}\" leads to an infinite loop. Aborting."
				fi
				return 8
			fi
			if [ "${VERSION}" = 'N/A' ]
			then
				if [ "${NVM_SILENT:-0}" -ne 1 ]
				then
					nvm_ensure_version_installed "${PROVIDED_VERSION}" "${IS_VERSION_FROM_NVMRC}"
				fi
				return 3
			elif ! nvm_ensure_version_installed "${VERSION}" "${IS_VERSION_FROM_NVMRC}"
			then
				return $?
			fi
			local NVM_VERSION_DIR
			NVM_VERSION_DIR="$(nvm_version_path "${VERSION}")" 
			PATH="$(nvm_change_path "${PATH}" "/bin" "${NVM_VERSION_DIR}")" 
			if nvm_has manpath
			then
				if [ -z "${MANPATH-}" ]
				then
					local MANPATH
					MANPATH=$(manpath) 
				fi
				MANPATH="$(nvm_change_path "${MANPATH}" "/share/man" "${NVM_VERSION_DIR}")" 
				export MANPATH
			fi
			export PATH
			\hash -r
			export NVM_BIN="${NVM_VERSION_DIR}/bin" 
			export NVM_INC="${NVM_VERSION_DIR}/include/node" 
			if [ "${NVM_SYMLINK_CURRENT-}" = true ]
			then
				command rm -f "${NVM_DIR}/current" && ln -s "${NVM_VERSION_DIR}" "${NVM_DIR}/current"
			fi
			local NVM_USE_OUTPUT
			NVM_USE_OUTPUT='' 
			if [ "${NVM_SILENT:-0}" -ne 1 ]
			then
				if nvm_is_iojs_version "${VERSION}"
				then
					NVM_USE_OUTPUT="Now using io.js $(nvm_strip_iojs_prefix "${VERSION}")$(nvm_print_npm_version)" 
				else
					NVM_USE_OUTPUT="Now using node ${VERSION}$(nvm_print_npm_version)" 
				fi
			fi
			if [ "_${VERSION}" != "_system" ]
			then
				local NVM_USE_CMD
				NVM_USE_CMD="nvm use --delete-prefix" 
				if [ -n "${PROVIDED_VERSION}" ]
				then
					NVM_USE_CMD="${NVM_USE_CMD} ${VERSION}" 
				fi
				if [ "${NVM_SILENT:-0}" -eq 1 ]
				then
					NVM_USE_CMD="${NVM_USE_CMD} --silent" 
				fi
				if ! nvm_die_on_prefix "${NVM_DELETE_PREFIX}" "${NVM_USE_CMD}" "${NVM_VERSION_DIR}"
				then
					return 11
				fi
			fi
			if [ -n "${NVM_USE_OUTPUT-}" ] && [ "${NVM_SILENT:-0}" -ne 1 ]
			then
				nvm_echo "${NVM_USE_OUTPUT}"
			fi ;;
		("run") local provided_version
			local has_checked_nvmrc
			has_checked_nvmrc=0 
			local IS_VERSION_FROM_NVMRC
			IS_VERSION_FROM_NVMRC=0 
			local NVM_SILENT
			local NVM_SILENT_ARG
			local NVM_LTS
			while [ $# -gt 0 ]
			do
				case "$1" in
					(--silent) NVM_SILENT=1 
						NVM_SILENT_ARG='--silent' 
						shift ;;
					(--lts) NVM_LTS='*' 
						shift ;;
					(--lts=*) NVM_LTS="${1##--lts=}" 
						shift ;;
					(*) if [ -n "$1" ]
						then
							break
						else
							shift
						fi ;;
				esac
			done
			if [ $# -lt 1 ] && [ -z "${NVM_LTS-}" ]
			then
				NVM_SILENT="${NVM_SILENT:-0}" nvm_rc_version && has_checked_nvmrc=1 
				if [ -n "${NVM_RC_VERSION-}" ]
				then
					VERSION="$(nvm_version "${NVM_RC_VERSION-}")"  || :
				fi
				unset NVM_RC_VERSION
				if [ "${VERSION:-N/A}" = 'N/A' ]
				then
					nvm --help >&2
					return 127
				fi
			fi
			if [ -z "${NVM_LTS-}" ]
			then
				provided_version="$1" 
				if [ -n "${provided_version}" ]
				then
					VERSION="$(nvm_version "${provided_version}")"  || :
					if [ "_${VERSION:-N/A}" = '_N/A' ] && ! nvm_is_valid_version "${provided_version}"
					then
						provided_version='' 
						if [ $has_checked_nvmrc -ne 1 ]
						then
							NVM_SILENT="${NVM_SILENT:-0}" nvm_rc_version && has_checked_nvmrc=1 
						fi
						provided_version="${NVM_RC_VERSION}" 
						IS_VERSION_FROM_NVMRC=1 
						VERSION="$(nvm_version "${NVM_RC_VERSION}")"  || :
						unset NVM_RC_VERSION
					else
						shift
					fi
				fi
			fi
			local NVM_IOJS
			if nvm_is_iojs_version "${VERSION}"
			then
				NVM_IOJS=true 
			fi
			local EXIT_CODE
			nvm_is_zsh && setopt local_options shwordsplit
			local LTS_ARG
			if [ -n "${NVM_LTS-}" ]
			then
				LTS_ARG="--lts=${NVM_LTS-}" 
				VERSION='' 
			fi
			if [ "_${VERSION}" = "_N/A" ]
			then
				nvm_ensure_version_installed "${provided_version}" "${IS_VERSION_FROM_NVMRC}"
			elif [ "${NVM_IOJS}" = true ]
			then
				nvm exec "${NVM_SILENT_ARG-}" "${LTS_ARG-}" "${VERSION}" iojs "$@"
			else
				nvm exec "${NVM_SILENT_ARG-}" "${LTS_ARG-}" "${VERSION}" node "$@"
			fi
			EXIT_CODE="$?" 
			return $EXIT_CODE ;;
		("exec") local NVM_SILENT
			local NVM_LTS
			while [ $# -gt 0 ]
			do
				case "$1" in
					(--silent) NVM_SILENT=1 
						shift ;;
					(--lts) NVM_LTS='*' 
						shift ;;
					(--lts=*) NVM_LTS="${1##--lts=}" 
						shift ;;
					(--) break ;;
					(--*) nvm_err "Unsupported option \"$1\"."
						return 55 ;;
					(*) if [ -n "$1" ]
						then
							break
						else
							shift
						fi ;;
				esac
			done
			local provided_version
			provided_version="$1" 
			if [ "${NVM_LTS-}" != '' ]
			then
				provided_version="lts/${NVM_LTS:-*}" 
				VERSION="${provided_version}" 
			elif [ -n "${provided_version}" ]
			then
				VERSION="$(nvm_version "${provided_version}")"  || :
				if [ "_${VERSION}" = '_N/A' ] && ! nvm_is_valid_version "${provided_version}"
				then
					NVM_SILENT="${NVM_SILENT:-0}" nvm_rc_version && has_checked_nvmrc=1 
					provided_version="${NVM_RC_VERSION}" 
					unset NVM_RC_VERSION
					VERSION="$(nvm_version "${provided_version}")"  || :
				else
					shift
				fi
			fi
			nvm_ensure_version_installed "${provided_version}"
			EXIT_CODE=$? 
			if [ "${EXIT_CODE}" != "0" ]
			then
				return $EXIT_CODE
			fi
			if [ "${NVM_SILENT:-0}" -ne 1 ]
			then
				if [ "${NVM_LTS-}" = '*' ]
				then
					nvm_echo "Running node latest LTS -> $(nvm_version "${VERSION}")$(nvm use --silent "${VERSION}" && nvm_print_npm_version)"
				elif [ -n "${NVM_LTS-}" ]
				then
					nvm_echo "Running node LTS \"${NVM_LTS-}\" -> $(nvm_version "${VERSION}")$(nvm use --silent "${VERSION}" && nvm_print_npm_version)"
				elif nvm_is_iojs_version "${VERSION}"
				then
					nvm_echo "Running io.js $(nvm_strip_iojs_prefix "${VERSION}")$(nvm use --silent "${VERSION}" && nvm_print_npm_version)"
				else
					nvm_echo "Running node ${VERSION}$(nvm use --silent "${VERSION}" && nvm_print_npm_version)"
				fi
			fi
			NODE_VERSION="${VERSION}" "${NVM_DIR}/nvm-exec" "$@" ;;
		("ls" | "list") local PATTERN
			local NVM_NO_COLORS
			local NVM_NO_ALIAS
			while [ $# -gt 0 ]
			do
				case "${1}" in
					(--)  ;;
					(--no-colors) NVM_NO_COLORS="${1}"  ;;
					(--no-alias) NVM_NO_ALIAS="${1}"  ;;
					(--*) nvm_err "Unsupported option \"${1}\"."
						return 55 ;;
					(*) PATTERN="${PATTERN:-$1}"  ;;
				esac
				shift
			done
			if [ -n "${PATTERN-}" ] && [ -n "${NVM_NO_ALIAS-}" ]
			then
				nvm_err '`--no-alias` is not supported when a pattern is provided.'
				return 55
			fi
			local NVM_LS_OUTPUT
			local NVM_LS_EXIT_CODE
			NVM_LS_OUTPUT=$(nvm_ls "${PATTERN-}") 
			NVM_LS_EXIT_CODE=$? 
			NVM_NO_COLORS="${NVM_NO_COLORS-}" nvm_print_versions "${NVM_LS_OUTPUT}"
			if [ -z "${NVM_NO_ALIAS-}" ] && [ -z "${PATTERN-}" ]
			then
				if [ -n "${NVM_NO_COLORS-}" ]
				then
					nvm alias --no-colors
				else
					nvm alias
				fi
			fi
			return $NVM_LS_EXIT_CODE ;;
		("ls-remote" | "list-remote") local NVM_LTS
			local PATTERN
			local NVM_NO_COLORS
			while [ $# -gt 0 ]
			do
				case "${1-}" in
					(--)  ;;
					(--lts) NVM_LTS='*'  ;;
					(--lts=*) NVM_LTS="${1##--lts=}"  ;;
					(--no-colors) NVM_NO_COLORS="${1}"  ;;
					(--*) nvm_err "Unsupported option \"${1}\"."
						return 55 ;;
					(*) if [ -z "${PATTERN-}" ]
						then
							PATTERN="${1-}" 
							if [ -z "${NVM_LTS-}" ]
							then
								case "${PATTERN}" in
									('lts/*') NVM_LTS='*' 
										PATTERN=''  ;;
									(lts/*) NVM_LTS="${PATTERN##lts/}" 
										PATTERN=''  ;;
								esac
							fi
						fi ;;
				esac
				shift
			done
			local NVM_OUTPUT
			local EXIT_CODE
			NVM_OUTPUT="$(NVM_LTS="${NVM_LTS-}" nvm_remote_versions "${PATTERN}" &&:)" 
			EXIT_CODE=$? 
			if [ -n "${NVM_OUTPUT}" ]
			then
				NVM_NO_COLORS="${NVM_NO_COLORS-}" nvm_print_versions "${NVM_OUTPUT}"
				return $EXIT_CODE
			fi
			NVM_NO_COLORS="${NVM_NO_COLORS-}" nvm_print_versions "N/A"
			return 3 ;;
		("current") nvm_version current ;;
		("which") local NVM_SILENT
			local provided_version
			while [ $# -ne 0 ]
			do
				case "${1}" in
					(--silent) NVM_SILENT=1  ;;
					(--)  ;;
					(*) provided_version="${1-}"  ;;
				esac
				shift
			done
			if [ -z "${provided_version-}" ]
			then
				NVM_SILENT="${NVM_SILENT:-0}" nvm_rc_version
				if [ -n "${NVM_RC_VERSION}" ]
				then
					provided_version="${NVM_RC_VERSION}" 
					VERSION=$(nvm_version "${NVM_RC_VERSION}")  || :
				fi
				unset NVM_RC_VERSION
			elif [ "${provided_version}" != 'system' ]
			then
				VERSION="$(nvm_version "${provided_version}")"  || :
			else
				VERSION="${provided_version-}" 
			fi
			if [ -z "${VERSION}" ]
			then
				nvm --help >&2
				return 127
			fi
			if [ "_${VERSION}" = '_system' ]
			then
				if nvm_has_system_iojs > /dev/null 2>&1 || nvm_has_system_node > /dev/null 2>&1
				then
					local NVM_BIN
					NVM_BIN="$(nvm use system >/dev/null 2>&1 && command which node)" 
					if [ -n "${NVM_BIN}" ]
					then
						nvm_echo "${NVM_BIN}"
						return
					fi
					return 1
				fi
				nvm_err 'System version of node not found.'
				return 127
			elif [ "${VERSION}" = '∞' ]
			then
				nvm_err "The alias \"${2}\" leads to an infinite loop. Aborting."
				return 8
			fi
			nvm_ensure_version_installed "${provided_version}"
			EXIT_CODE=$? 
			if [ "${EXIT_CODE}" != "0" ]
			then
				return $EXIT_CODE
			fi
			local NVM_VERSION_DIR
			NVM_VERSION_DIR="$(nvm_version_path "${VERSION}")" 
			nvm_echo "${NVM_VERSION_DIR}/bin/node" ;;
		("alias") local NVM_ALIAS_DIR
			NVM_ALIAS_DIR="$(nvm_alias_path)" 
			local NVM_CURRENT
			NVM_CURRENT="$(nvm_ls_current)" 
			command mkdir -p "${NVM_ALIAS_DIR}/lts"
			local ALIAS
			local TARGET
			local NVM_NO_COLORS
			ALIAS='--' 
			TARGET='--' 
			while [ $# -gt 0 ]
			do
				case "${1-}" in
					(--)  ;;
					(--no-colors) NVM_NO_COLORS="${1}"  ;;
					(--*) nvm_err "Unsupported option \"${1}\"."
						return 55 ;;
					(*) if [ "${ALIAS}" = '--' ]
						then
							ALIAS="${1-}" 
						elif [ "${TARGET}" = '--' ]
						then
							TARGET="${1-}" 
						fi ;;
				esac
				shift
			done
			if [ -z "${TARGET}" ]
			then
				nvm unalias "${ALIAS}"
				return $?
			elif echo "${ALIAS}" | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv} -q "#"
			then
				nvm_err 'Aliases with a comment delimiter (#) are not supported.'
				return 1
			elif [ "${TARGET}" != '--' ]
			then
				if [ "${ALIAS#*\/}" != "${ALIAS}" ]
				then
					nvm_err 'Aliases in subdirectories are not supported.'
					return 1
				fi
				VERSION="$(nvm_version "${TARGET}")"  || :
				if [ "${VERSION}" = 'N/A' ]
				then
					nvm_err "! WARNING: Version '${TARGET}' does not exist."
				fi
				nvm_make_alias "${ALIAS}" "${TARGET}"
				NVM_NO_COLORS="${NVM_NO_COLORS-}" NVM_CURRENT="${NVM_CURRENT-}" DEFAULT=false nvm_print_formatted_alias "${ALIAS}" "${TARGET}" "${VERSION}"
			else
				if [ "${ALIAS-}" = '--' ]
				then
					unset ALIAS
				fi
				nvm_list_aliases "${ALIAS-}"
			fi ;;
		("unalias") local NVM_ALIAS_DIR
			NVM_ALIAS_DIR="$(nvm_alias_path)" 
			command mkdir -p "${NVM_ALIAS_DIR}"
			if [ $# -ne 1 ]
			then
				nvm --help >&2
				return 127
			fi
			if [ "${1#*\/}" != "${1-}" ]
			then
				nvm_err 'Aliases in subdirectories are not supported.'
				return 1
			fi
			local NVM_IOJS_PREFIX
			local NVM_NODE_PREFIX
			NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
			NVM_NODE_PREFIX="$(nvm_node_prefix)" 
			local NVM_ALIAS_EXISTS
			NVM_ALIAS_EXISTS=0 
			if [ -f "${NVM_ALIAS_DIR}/${1-}" ]
			then
				NVM_ALIAS_EXISTS=1 
			fi
			if [ $NVM_ALIAS_EXISTS -eq 0 ]
			then
				case "$1" in
					("stable" | "unstable" | "${NVM_IOJS_PREFIX}" | "${NVM_NODE_PREFIX}" | "system") nvm_err "${1-} is a default (built-in) alias and cannot be deleted."
						return 1 ;;
				esac
				nvm_err "Alias ${1-} doesn't exist!"
				return
			fi
			local NVM_ALIAS_ORIGINAL
			NVM_ALIAS_ORIGINAL="$(nvm_alias "${1}")" 
			command rm -f "${NVM_ALIAS_DIR}/${1}"
			nvm_echo "Deleted alias ${1} - restore it with \`nvm alias \"${1}\" \"${NVM_ALIAS_ORIGINAL}\"\`" ;;
		("install-latest-npm") if [ $# -ne 0 ]
			then
				nvm --help >&2
				return 127
			fi
			nvm_install_latest_npm ;;
		("reinstall-packages" | "copy-packages") if [ $# -ne 1 ]
			then
				nvm --help >&2
				return 127
			fi
			local PROVIDED_VERSION
			PROVIDED_VERSION="${1-}" 
			if [ "${PROVIDED_VERSION}" = "$(nvm_ls_current)" ] || [ "$(nvm_version "${PROVIDED_VERSION}" ||:)" = "$(nvm_ls_current)" ]
			then
				nvm_err 'Can not reinstall packages from the current version of node.'
				return 2
			fi
			local VERSION
			if [ "_${PROVIDED_VERSION}" = "_system" ]
			then
				if ! nvm_has_system_node && ! nvm_has_system_iojs
				then
					nvm_err 'No system version of node or io.js detected.'
					return 3
				fi
				VERSION="system" 
			else
				VERSION="$(nvm_version "${PROVIDED_VERSION}")"  || :
			fi
			local NPMLIST
			NPMLIST="$(nvm_npm_global_modules "${VERSION}")" 
			local INSTALLS
			local LINKS
			INSTALLS="${NPMLIST%% //// *}" 
			LINKS="${NPMLIST##* //// }" 
			nvm_echo "Reinstalling global packages from ${VERSION}..."
			if [ -n "${INSTALLS}" ]
			then
				nvm_echo "${INSTALLS}" | command xargs npm install -g --quiet
			else
				nvm_echo "No installed global packages found..."
			fi
			nvm_echo "Linking global packages from ${VERSION}..."
			if [ -n "${LINKS}" ]
			then
				(
					set -f
					IFS='
' 
					for LINK in ${LINKS}
					do
						set +f
						unset IFS
						if [ -n "${LINK}" ]
						then
							case "${LINK}" in
								('/'*) (
										nvm_cd "${LINK}" && npm link
									) ;;
								(*) (
										nvm_cd "$(npm root -g)/../${LINK}" && npm link
									) ;;
							esac
						fi
					done
				)
			else
				nvm_echo "No linked global packages found..."
			fi ;;
		("clear-cache") command rm -f "${NVM_DIR}/v*" "$(nvm_version_dir)" 2> /dev/null
			nvm_echo 'nvm cache cleared.' ;;
		("version") nvm_version "${1}" ;;
		("version-remote") local NVM_LTS
			local PATTERN
			while [ $# -gt 0 ]
			do
				case "${1-}" in
					(--)  ;;
					(--lts) NVM_LTS='*'  ;;
					(--lts=*) NVM_LTS="${1##--lts=}"  ;;
					(--*) nvm_err "Unsupported option \"${1}\"."
						return 55 ;;
					(*) PATTERN="${PATTERN:-${1}}"  ;;
				esac
				shift
			done
			case "${PATTERN-}" in
				('lts/*') NVM_LTS='*' 
					unset PATTERN ;;
				(lts/*) NVM_LTS="${PATTERN##lts/}" 
					unset PATTERN ;;
			esac
			NVM_VERSION_ONLY=true NVM_LTS="${NVM_LTS-}" nvm_remote_version "${PATTERN:-node}" ;;
		("--version" | "-v") nvm_echo '0.40.3' ;;
		("unload") nvm deactivate > /dev/null 2>&1
			unset -f nvm nvm_iojs_prefix nvm_node_prefix nvm_add_iojs_prefix nvm_strip_iojs_prefix nvm_is_iojs_version nvm_is_alias nvm_has_non_aliased nvm_ls_remote nvm_ls_remote_iojs nvm_ls_remote_index_tab nvm_ls nvm_remote_version nvm_remote_versions nvm_install_binary nvm_install_source nvm_clang_version nvm_get_mirror nvm_get_download_slug nvm_download_artifact nvm_install_npm_if_needed nvm_use_if_needed nvm_check_file_permissions nvm_print_versions nvm_compute_checksum nvm_get_checksum_binary nvm_get_checksum_alg nvm_get_checksum nvm_compare_checksum nvm_version nvm_rc_version nvm_match_version nvm_ensure_default_set nvm_get_arch nvm_get_os nvm_print_implicit_alias nvm_validate_implicit_alias nvm_resolve_alias nvm_ls_current nvm_alias nvm_binary_available nvm_change_path nvm_strip_path nvm_num_version_groups nvm_format_version nvm_ensure_version_prefix nvm_normalize_version nvm_is_valid_version nvm_normalize_lts nvm_ensure_version_installed nvm_cache_dir nvm_version_path nvm_alias_path nvm_version_dir nvm_find_nvmrc nvm_find_up nvm_find_project_dir nvm_tree_contains_path nvm_version_greater nvm_version_greater_than_or_equal_to nvm_print_npm_version nvm_install_latest_npm nvm_npm_global_modules nvm_has_system_node nvm_has_system_iojs nvm_download nvm_get_latest nvm_has nvm_install_default_packages nvm_get_default_packages nvm_curl_use_compression nvm_curl_version nvm_auto nvm_supports_xz nvm_echo nvm_err nvm_grep nvm_cd nvm_die_on_prefix nvm_get_make_jobs nvm_get_minor_version nvm_has_solaris_binary nvm_is_merged_node_version nvm_is_natural_num nvm_is_version_installed nvm_list_aliases nvm_make_alias nvm_print_alias_path nvm_print_default_alias nvm_print_formatted_alias nvm_resolve_local_alias nvm_sanitize_path nvm_has_colors nvm_process_parameters nvm_node_version_has_solaris_binary nvm_iojs_version_has_solaris_binary nvm_curl_libz_support nvm_command_info nvm_is_zsh nvm_stdout_is_terminal nvm_npmrc_bad_news_bears nvm_sanitize_auth_header nvm_get_colors nvm_set_colors nvm_print_color_code nvm_wrap_with_color_code nvm_format_help_message_colors nvm_echo_with_colors nvm_err_with_colors nvm_get_artifact_compression nvm_install_binary_extract nvm_extract_tarball nvm_process_nvmrc nvm_nvmrc_invalid_msg nvm_write_nvmrc > /dev/null 2>&1
			unset NVM_RC_VERSION NVM_NODEJS_ORG_MIRROR NVM_IOJS_ORG_MIRROR NVM_DIR NVM_CD_FLAGS NVM_BIN NVM_INC NVM_MAKE_JOBS NVM_COLORS INSTALLED_COLOR SYSTEM_COLOR CURRENT_COLOR NOT_INSTALLED_COLOR DEFAULT_COLOR LTS_COLOR > /dev/null 2>&1 ;;
		("set-colors") local EXIT_CODE
			nvm_set_colors "${1-}"
			EXIT_CODE=$? 
			if [ "$EXIT_CODE" -eq 17 ]
			then
				nvm --help >&2
				nvm_echo
				nvm_err_with_colors "\033[1;37mPlease pass in five \033[1;31mvalid color codes\033[1;37m. Choose from: rRgGbBcCyYmMkKeW\033[0m"
			fi ;;
		(*) nvm --help >&2
			return 127 ;;
	esac
}
nvm_add_iojs_prefix () {
	nvm_echo "$(nvm_iojs_prefix)-$(nvm_ensure_version_prefix "$(nvm_strip_iojs_prefix "${1-}")")"
}
nvm_alias () {
	local ALIAS
	ALIAS="${1-}" 
	if [ -z "${ALIAS}" ]
	then
		nvm_err 'An alias is required.'
		return 1
	fi
	if ! ALIAS="$(nvm_normalize_lts "${ALIAS}")" 
	then
		return $?
	fi
	if [ -z "${ALIAS}" ]
	then
		return 2
	fi
	local NVM_ALIAS_PATH
	NVM_ALIAS_PATH="$(nvm_alias_path)/${ALIAS}" 
	if [ ! -f "${NVM_ALIAS_PATH}" ]
	then
		nvm_err 'Alias does not exist.'
		return 2
	fi
	command awk 'NF' "${NVM_ALIAS_PATH}"
}
nvm_alias_path () {
	nvm_echo "$(nvm_version_dir old)/alias"
}
nvm_auto () {
	local NVM_MODE
	NVM_MODE="${1-}" 
	case "${NVM_MODE}" in
		(none) return 0 ;;
		(use) local VERSION
			local NVM_CURRENT
			NVM_CURRENT="$(nvm_ls_current)" 
			if [ "_${NVM_CURRENT}" = '_none' ] || [ "_${NVM_CURRENT}" = '_system' ]
			then
				VERSION="$(nvm_resolve_local_alias default 2>/dev/null || nvm_echo)" 
				if [ -n "${VERSION}" ]
				then
					if [ "_${VERSION}" != '_N/A' ] && nvm_is_valid_version "${VERSION}"
					then
						nvm use --silent "${VERSION}" > /dev/null
					else
						return 0
					fi
				elif nvm_rc_version > /dev/null 2>&1
				then
					nvm use --silent > /dev/null
				fi
			else
				nvm use --silent "${NVM_CURRENT}" > /dev/null
			fi ;;
		(install) local VERSION
			VERSION="$(nvm_alias default 2>/dev/null || nvm_echo)" 
			if [ -n "${VERSION}" ] && [ "_${VERSION}" != '_N/A' ] && nvm_is_valid_version "${VERSION}"
			then
				nvm install "${VERSION}" > /dev/null
			elif nvm_rc_version > /dev/null 2>&1
			then
				nvm install > /dev/null
			else
				return 0
			fi ;;
		(*) nvm_err 'Invalid auto mode supplied.'
			return 1 ;;
	esac
}
nvm_binary_available () {
	nvm_version_greater_than_or_equal_to "$(nvm_strip_iojs_prefix "${1-}")" v0.8.6
}
nvm_cache_dir () {
	nvm_echo "${NVM_DIR}/.cache"
}
nvm_cd () {
	\cd "$@"
}
nvm_change_path () {
	if [ -z "${1-}" ]
	then
		nvm_echo "${3-}${2-}"
	elif ! nvm_echo "${1-}" | nvm_grep -q "${NVM_DIR}/[^/]*${2-}" && ! nvm_echo "${1-}" | nvm_grep -q "${NVM_DIR}/versions/[^/]*/[^/]*${2-}"
	then
		nvm_echo "${3-}${2-}:${1-}"
	elif nvm_echo "${1-}" | nvm_grep -Eq "(^|:)(/usr(/local)?)?${2-}:.*${NVM_DIR}/[^/]*${2-}" || nvm_echo "${1-}" | nvm_grep -Eq "(^|:)(/usr(/local)?)?${2-}:.*${NVM_DIR}/versions/[^/]*/[^/]*${2-}"
	then
		nvm_echo "${3-}${2-}:${1-}"
	else
		nvm_echo "${1-}" | command sed -e "s#${NVM_DIR}/[^/]*${2-}[^:]*#${3-}${2-}#" -e "s#${NVM_DIR}/versions/[^/]*/[^/]*${2-}[^:]*#${3-}${2-}#"
	fi
}
nvm_check_file_permissions () {
	nvm_is_zsh && setopt local_options nonomatch
	for FILE in "$1"/* "$1"/.[!.]* "$1"/..?*
	do
		if [ -d "$FILE" ]
		then
			if [ -n "${NVM_DEBUG-}" ]
			then
				nvm_err "${FILE}"
			fi
			if [ ! -L "${FILE}" ] && ! nvm_check_file_permissions "${FILE}"
			then
				return 2
			fi
		elif [ -e "$FILE" ] && [ ! -w "$FILE" ] && [ ! -O "$FILE" ]
		then
			nvm_err "file is not writable or self-owned: $(nvm_sanitize_path "$FILE")"
			return 1
		fi
	done
	return 0
}
nvm_clang_version () {
	clang --version | command awk '{ if ($2 == "version") print $3; else if ($3 == "version") print $4 }' | command sed 's/-.*$//g'
}
nvm_command_info () {
	local COMMAND
	local INFO
	COMMAND="${1}" 
	if type "${COMMAND}" | nvm_grep -q hashed
	then
		INFO="$(type "${COMMAND}" | command sed -E 's/\(|\)//g' | command awk '{print $4}')" 
	elif type "${COMMAND}" | nvm_grep -q aliased
	then
		INFO="$(which "${COMMAND}") ($(type "${COMMAND}" | command awk '{ $1=$2=$3=$4="" ;print }' | command sed -e 's/^\ *//g' -Ee "s/\`|'//g"))" 
	elif type "${COMMAND}" | nvm_grep -q "^${COMMAND} is an alias for"
	then
		INFO="$(which "${COMMAND}") ($(type "${COMMAND}" | command awk '{ $1=$2=$3=$4=$5="" ;print }' | command sed 's/^\ *//g'))" 
	elif type "${COMMAND}" | nvm_grep -q "^${COMMAND} is /"
	then
		INFO="$(type "${COMMAND}" | command awk '{print $3}')" 
	else
		INFO="$(type "${COMMAND}")" 
	fi
	nvm_echo "${INFO}"
}
nvm_compare_checksum () {
	local FILE
	FILE="${1-}" 
	if [ -z "${FILE}" ]
	then
		nvm_err 'Provided file to checksum is empty.'
		return 4
	elif ! [ -f "${FILE}" ]
	then
		nvm_err 'Provided file to checksum does not exist.'
		return 3
	fi
	local COMPUTED_SUM
	COMPUTED_SUM="$(nvm_compute_checksum "${FILE}")" 
	local CHECKSUM
	CHECKSUM="${2-}" 
	if [ -z "${CHECKSUM}" ]
	then
		nvm_err 'Provided checksum to compare to is empty.'
		return 2
	fi
	if [ -z "${COMPUTED_SUM}" ]
	then
		nvm_err "Computed checksum of '${FILE}' is empty."
		nvm_err 'WARNING: Continuing *without checksum verification*'
		return
	elif [ "${COMPUTED_SUM}" != "${CHECKSUM}" ] && [ "${COMPUTED_SUM}" != "\\${CHECKSUM}" ]
	then
		nvm_err "Checksums do not match: '${COMPUTED_SUM}' found, '${CHECKSUM}' expected."
		return 1
	fi
	nvm_err 'Checksums matched!'
}
nvm_compute_checksum () {
	local FILE
	FILE="${1-}" 
	if [ -z "${FILE}" ]
	then
		nvm_err 'Provided file to checksum is empty.'
		return 2
	elif ! [ -f "${FILE}" ]
	then
		nvm_err 'Provided file to checksum does not exist.'
		return 1
	fi
	if nvm_has_non_aliased "sha256sum"
	then
		nvm_err 'Computing checksum with sha256sum'
		command sha256sum "${FILE}" | command awk '{print $1}'
	elif nvm_has_non_aliased "shasum"
	then
		nvm_err 'Computing checksum with shasum -a 256'
		command shasum -a 256 "${FILE}" | command awk '{print $1}'
	elif nvm_has_non_aliased "sha256"
	then
		nvm_err 'Computing checksum with sha256 -q'
		command sha256 -q "${FILE}" | command awk '{print $1}'
	elif nvm_has_non_aliased "gsha256sum"
	then
		nvm_err 'Computing checksum with gsha256sum'
		command gsha256sum "${FILE}" | command awk '{print $1}'
	elif nvm_has_non_aliased "openssl"
	then
		nvm_err 'Computing checksum with openssl dgst -sha256'
		command openssl dgst -sha256 "${FILE}" | command awk '{print $NF}'
	elif nvm_has_non_aliased "bssl"
	then
		nvm_err 'Computing checksum with bssl sha256sum'
		command bssl sha256sum "${FILE}" | command awk '{print $1}'
	elif nvm_has_non_aliased "sha1sum"
	then
		nvm_err 'Computing checksum with sha1sum'
		command sha1sum "${FILE}" | command awk '{print $1}'
	elif nvm_has_non_aliased "sha1"
	then
		nvm_err 'Computing checksum with sha1 -q'
		command sha1 -q "${FILE}"
	fi
}
nvm_curl_libz_support () {
	curl -V 2> /dev/null | nvm_grep "^Features:" | nvm_grep -q "libz"
}
nvm_curl_use_compression () {
	nvm_curl_libz_support && nvm_version_greater_than_or_equal_to "$(nvm_curl_version)" 7.21.0
}
nvm_curl_version () {
	curl -V | command awk '{ if ($1 == "curl") print $2 }' | command sed 's/-.*$//g'
}
nvm_die_on_prefix () {
	local NVM_DELETE_PREFIX
	NVM_DELETE_PREFIX="${1-}" 
	case "${NVM_DELETE_PREFIX}" in
		(0 | 1)  ;;
		(*) nvm_err 'First argument "delete the prefix" must be zero or one'
			return 1 ;;
	esac
	local NVM_COMMAND
	NVM_COMMAND="${2-}" 
	local NVM_VERSION_DIR
	NVM_VERSION_DIR="${3-}" 
	if [ -z "${NVM_COMMAND}" ] || [ -z "${NVM_VERSION_DIR}" ]
	then
		nvm_err 'Second argument "nvm command", and third argument "nvm version dir", must both be nonempty'
		return 2
	fi
	if [ -n "${PREFIX-}" ] && [ "$(nvm_version_path "$(node -v)")" != "${PREFIX}" ]
	then
		nvm deactivate > /dev/null 2>&1
		nvm_err "nvm is not compatible with the \"PREFIX\" environment variable: currently set to \"${PREFIX}\""
		nvm_err 'Run `unset PREFIX` to unset it.'
		return 3
	fi
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	local NVM_NPM_CONFIG_x_PREFIX_ENV
	NVM_NPM_CONFIG_x_PREFIX_ENV="$(command awk 'BEGIN { for (name in ENVIRON) if (toupper(name) == "NPM_CONFIG_PREFIX") { print name; break } }')" 
	if [ -n "${NVM_NPM_CONFIG_x_PREFIX_ENV-}" ]
	then
		local NVM_CONFIG_VALUE
		eval "NVM_CONFIG_VALUE=\"\$${NVM_NPM_CONFIG_x_PREFIX_ENV}\""
		if [ -n "${NVM_CONFIG_VALUE-}" ] && [ "_${NVM_OS}" = "_win" ]
		then
			NVM_CONFIG_VALUE="$(cd "$NVM_CONFIG_VALUE" 2>/dev/null && pwd)" 
		fi
		if [ -n "${NVM_CONFIG_VALUE-}" ] && ! nvm_tree_contains_path "${NVM_DIR}" "${NVM_CONFIG_VALUE}"
		then
			nvm deactivate > /dev/null 2>&1
			nvm_err "nvm is not compatible with the \"${NVM_NPM_CONFIG_x_PREFIX_ENV}\" environment variable: currently set to \"${NVM_CONFIG_VALUE}\""
			nvm_err "Run \`unset ${NVM_NPM_CONFIG_x_PREFIX_ENV}\` to unset it."
			return 4
		fi
	fi
	local NVM_NPM_BUILTIN_NPMRC
	NVM_NPM_BUILTIN_NPMRC="${NVM_VERSION_DIR}/lib/node_modules/npm/npmrc" 
	if nvm_npmrc_bad_news_bears "${NVM_NPM_BUILTIN_NPMRC}"
	then
		if [ "_${NVM_DELETE_PREFIX}" = "_1" ]
		then
			npm config --loglevel=warn delete prefix --userconfig="${NVM_NPM_BUILTIN_NPMRC}"
			npm config --loglevel=warn delete globalconfig --userconfig="${NVM_NPM_BUILTIN_NPMRC}"
		else
			nvm_err "Your builtin npmrc file ($(nvm_sanitize_path "${NVM_NPM_BUILTIN_NPMRC}"))"
			nvm_err 'has a `globalconfig` and/or a `prefix` setting, which are incompatible with nvm.'
			nvm_err "Run \`${NVM_COMMAND}\` to unset it."
			return 10
		fi
	fi
	local NVM_NPM_GLOBAL_NPMRC
	NVM_NPM_GLOBAL_NPMRC="${NVM_VERSION_DIR}/etc/npmrc" 
	if nvm_npmrc_bad_news_bears "${NVM_NPM_GLOBAL_NPMRC}"
	then
		if [ "_${NVM_DELETE_PREFIX}" = "_1" ]
		then
			npm config --global --loglevel=warn delete prefix
			npm config --global --loglevel=warn delete globalconfig
		else
			nvm_err "Your global npmrc file ($(nvm_sanitize_path "${NVM_NPM_GLOBAL_NPMRC}"))"
			nvm_err 'has a `globalconfig` and/or a `prefix` setting, which are incompatible with nvm.'
			nvm_err "Run \`${NVM_COMMAND}\` to unset it."
			return 10
		fi
	fi
	local NVM_NPM_USER_NPMRC
	NVM_NPM_USER_NPMRC="${HOME}/.npmrc" 
	if nvm_npmrc_bad_news_bears "${NVM_NPM_USER_NPMRC}"
	then
		if [ "_${NVM_DELETE_PREFIX}" = "_1" ]
		then
			npm config --loglevel=warn delete prefix --userconfig="${NVM_NPM_USER_NPMRC}"
			npm config --loglevel=warn delete globalconfig --userconfig="${NVM_NPM_USER_NPMRC}"
		else
			nvm_err "Your user’s .npmrc file ($(nvm_sanitize_path "${NVM_NPM_USER_NPMRC}"))"
			nvm_err 'has a `globalconfig` and/or a `prefix` setting, which are incompatible with nvm.'
			nvm_err "Run \`${NVM_COMMAND}\` to unset it."
			return 10
		fi
	fi
	local NVM_NPM_PROJECT_NPMRC
	NVM_NPM_PROJECT_NPMRC="$(nvm_find_project_dir)/.npmrc" 
	if nvm_npmrc_bad_news_bears "${NVM_NPM_PROJECT_NPMRC}"
	then
		if [ "_${NVM_DELETE_PREFIX}" = "_1" ]
		then
			npm config --loglevel=warn delete prefix
			npm config --loglevel=warn delete globalconfig
		else
			nvm_err "Your project npmrc file ($(nvm_sanitize_path "${NVM_NPM_PROJECT_NPMRC}"))"
			nvm_err 'has a `globalconfig` and/or a `prefix` setting, which are incompatible with nvm.'
			nvm_err "Run \`${NVM_COMMAND}\` to unset it."
			return 10
		fi
	fi
}
nvm_download () {
	if nvm_has "curl"
	then
		local CURL_COMPRESSED_FLAG="" 
		local CURL_HEADER_FLAG="" 
		if [ -n "${NVM_AUTH_HEADER:-}" ]
		then
			sanitized_header=$(nvm_sanitize_auth_header "${NVM_AUTH_HEADER}") 
			CURL_HEADER_FLAG="--header \"Authorization: ${sanitized_header}\"" 
		fi
		if nvm_curl_use_compression
		then
			CURL_COMPRESSED_FLAG="--compressed" 
		fi
		local NVM_DOWNLOAD_ARGS
		NVM_DOWNLOAD_ARGS='' 
		for arg in "$@"
		do
			NVM_DOWNLOAD_ARGS="${NVM_DOWNLOAD_ARGS} \"$arg\"" 
		done
		eval "curl -q --fail ${CURL_COMPRESSED_FLAG:-} ${CURL_HEADER_FLAG:-} ${NVM_DOWNLOAD_ARGS}"
	elif nvm_has "wget"
	then
		ARGS=$(nvm_echo "$@" | command sed "
      s/--progress-bar /--progress=bar /
      s/--compressed //
      s/--fail //
      s/-L //
      s/-I /--server-response /
      s/-s /-q /
      s/-sS /-nv /
      s/-o /-O /
      s/-C - /-c /
    ") 
		if [ -n "${NVM_AUTH_HEADER:-}" ]
		then
			ARGS="${ARGS} --header \"${NVM_AUTH_HEADER}\"" 
		fi
		eval wget $ARGS
	fi
}
nvm_download_artifact () {
	local FLAVOR
	case "${1-}" in
		(node | iojs) FLAVOR="${1}"  ;;
		(*) nvm_err 'supported flavors: node, iojs'
			return 1 ;;
	esac
	local KIND
	case "${2-}" in
		(binary | source) KIND="${2}"  ;;
		(*) nvm_err 'supported kinds: binary, source'
			return 1 ;;
	esac
	local TYPE
	TYPE="${3-}" 
	local MIRROR
	MIRROR="$(nvm_get_mirror "${FLAVOR}" "${TYPE}")" 
	if [ -z "${MIRROR}" ]
	then
		return 2
	fi
	local VERSION
	VERSION="${4}" 
	if [ -z "${VERSION}" ]
	then
		nvm_err 'A version number is required.'
		return 3
	fi
	if [ "${KIND}" = 'binary' ] && ! nvm_binary_available "${VERSION}"
	then
		nvm_err "No precompiled binary available for ${VERSION}."
		return
	fi
	local SLUG
	SLUG="$(nvm_get_download_slug "${FLAVOR}" "${KIND}" "${VERSION}")" 
	local COMPRESSION
	COMPRESSION="$(nvm_get_artifact_compression "${VERSION}")" 
	local CHECKSUM
	CHECKSUM="$(nvm_get_checksum "${FLAVOR}" "${TYPE}" "${VERSION}" "${SLUG}" "${COMPRESSION}")" 
	local tmpdir
	if [ "${KIND}" = 'binary' ]
	then
		tmpdir="$(nvm_cache_dir)/bin/${SLUG}" 
	else
		tmpdir="$(nvm_cache_dir)/src/${SLUG}" 
	fi
	command mkdir -p "${tmpdir}/files" || (
		nvm_err "creating directory ${tmpdir}/files failed"
		return 3
	)
	local TARBALL
	TARBALL="${tmpdir}/${SLUG}.${COMPRESSION}" 
	local TARBALL_URL
	if nvm_version_greater_than_or_equal_to "${VERSION}" 0.1.14
	then
		TARBALL_URL="${MIRROR}/${VERSION}/${SLUG}.${COMPRESSION}" 
	else
		TARBALL_URL="${MIRROR}/${SLUG}.${COMPRESSION}" 
	fi
	if [ -r "${TARBALL}" ]
	then
		nvm_err "Local cache found: $(nvm_sanitize_path "${TARBALL}")"
		if nvm_compare_checksum "${TARBALL}" "${CHECKSUM}" > /dev/null 2>&1
		then
			nvm_err "Checksums match! Using existing downloaded archive $(nvm_sanitize_path "${TARBALL}")"
			nvm_echo "${TARBALL}"
			return 0
		fi
		nvm_compare_checksum "${TARBALL}" "${CHECKSUM}"
		nvm_err "Checksum check failed!"
		nvm_err "Removing the broken local cache..."
		command rm -rf "${TARBALL}"
	fi
	nvm_err "Downloading ${TARBALL_URL}..."
	nvm_download -L -C - "${PROGRESS_BAR}" "${TARBALL_URL}" -o "${TARBALL}" || (
		command rm -rf "${TARBALL}" "${tmpdir}"
		nvm_err "download from ${TARBALL_URL} failed"
		return 4
	)
	if nvm_grep '404 Not Found' "${TARBALL}" > /dev/null
	then
		command rm -rf "${TARBALL}" "${tmpdir}"
		nvm_err "HTTP 404 at URL ${TARBALL_URL}"
		return 5
	fi
	nvm_compare_checksum "${TARBALL}" "${CHECKSUM}" || (
		command rm -rf "${tmpdir}/files"
		return 6
	)
	nvm_echo "${TARBALL}"
}
nvm_echo () {
	command printf %s\\n "$*" 2> /dev/null
}
nvm_echo_with_colors () {
	command printf %b\\n "$*" 2> /dev/null
}
nvm_ensure_default_set () {
	local VERSION
	VERSION="$1" 
	if [ -z "${VERSION}" ]
	then
		nvm_err 'nvm_ensure_default_set: a version is required'
		return 1
	elif nvm_alias default > /dev/null 2>&1
	then
		return 0
	fi
	local OUTPUT
	OUTPUT="$(nvm alias default "${VERSION}")" 
	local EXIT_CODE
	EXIT_CODE="$?" 
	nvm_echo "Creating default alias: ${OUTPUT}"
	return $EXIT_CODE
}
nvm_ensure_version_installed () {
	local PROVIDED_VERSION
	PROVIDED_VERSION="${1-}" 
	local IS_VERSION_FROM_NVMRC
	IS_VERSION_FROM_NVMRC="${2-}" 
	if [ "${PROVIDED_VERSION}" = 'system' ]
	then
		if nvm_has_system_iojs || nvm_has_system_node
		then
			return 0
		fi
		nvm_err "N/A: no system version of node/io.js is installed."
		return 1
	fi
	local LOCAL_VERSION
	local EXIT_CODE
	LOCAL_VERSION="$(nvm_version "${PROVIDED_VERSION}")" 
	EXIT_CODE="$?" 
	local NVM_VERSION_DIR
	if [ "${EXIT_CODE}" != "0" ] || ! nvm_is_version_installed "${LOCAL_VERSION}"
	then
		if VERSION="$(nvm_resolve_alias "${PROVIDED_VERSION}")" 
		then
			nvm_err "N/A: version \"${PROVIDED_VERSION} -> ${VERSION}\" is not yet installed."
		else
			local PREFIXED_VERSION
			PREFIXED_VERSION="$(nvm_ensure_version_prefix "${PROVIDED_VERSION}")" 
			nvm_err "N/A: version \"${PREFIXED_VERSION:-$PROVIDED_VERSION}\" is not yet installed."
		fi
		nvm_err ""
		if [ "${PROVIDED_VERSION}" = 'lts' ]
		then
			nvm_err '`lts` is not an alias - you may need to run `nvm install --lts` to install and `nvm use --lts` to use it.'
		elif [ "${IS_VERSION_FROM_NVMRC}" != '1' ]
		then
			nvm_err "You need to run \`nvm install ${PROVIDED_VERSION}\` to install and use it."
		else
			nvm_err 'You need to run `nvm install` to install and use the node version specified in `.nvmrc`.'
		fi
		return 1
	fi
}
nvm_ensure_version_prefix () {
	local NVM_VERSION
	NVM_VERSION="$(nvm_strip_iojs_prefix "${1-}" | command sed -e 's/^\([0-9]\)/v\1/g')" 
	if nvm_is_iojs_version "${1-}"
	then
		nvm_add_iojs_prefix "${NVM_VERSION}"
	else
		nvm_echo "${NVM_VERSION}"
	fi
}
nvm_err () {
	nvm_echo "$@" >&2
}
nvm_err_with_colors () {
	nvm_echo_with_colors "$@" >&2
}
nvm_extract_tarball () {
	if [ "$#" -ne 4 ]
	then
		nvm_err 'nvm_extract_tarball requires exactly 4 arguments'
		return 5
	fi
	local NVM_OS
	NVM_OS="${1-}" 
	local VERSION
	VERSION="${2-}" 
	local TARBALL
	TARBALL="${3-}" 
	local TMPDIR
	TMPDIR="${4-}" 
	local tar_compression_flag
	tar_compression_flag='z' 
	if nvm_supports_xz "${VERSION}"
	then
		tar_compression_flag='J' 
	fi
	local tar
	tar='tar' 
	if [ "${NVM_OS}" = 'aix' ]
	then
		tar='gtar' 
	fi
	if [ "${NVM_OS}" = 'openbsd' ]
	then
		if [ "${tar_compression_flag}" = 'J' ]
		then
			command xzcat "${TARBALL}" | "${tar}" -xf - -C "${TMPDIR}" -s '/[^\/]*\///' || return 1
		else
			command "${tar}" -x${tar_compression_flag}f "${TARBALL}" -C "${TMPDIR}" -s '/[^\/]*\///' || return 1
		fi
	else
		command "${tar}" -x${tar_compression_flag}f "${TARBALL}" -C "${TMPDIR}" --strip-components 1 || return 1
	fi
}
nvm_find_nvmrc () {
	local dir
	dir="$(nvm_find_up '.nvmrc')" 
	if [ -e "${dir}/.nvmrc" ]
	then
		nvm_echo "${dir}/.nvmrc"
	fi
}
nvm_find_project_dir () {
	local path_
	path_="${PWD}" 
	while [ "${path_}" != "" ] && [ "${path_}" != '.' ] && [ ! -f "${path_}/package.json" ] && [ ! -d "${path_}/node_modules" ]
	do
		path_=${path_%/*} 
	done
	nvm_echo "${path_}"
}
nvm_find_up () {
	local path_
	path_="${PWD}" 
	while [ "${path_}" != "" ] && [ "${path_}" != '.' ] && [ ! -f "${path_}/${1-}" ]
	do
		path_=${path_%/*} 
	done
	nvm_echo "${path_}"
}
nvm_format_version () {
	local VERSION
	VERSION="$(nvm_ensure_version_prefix "${1-}")" 
	local NUM_GROUPS
	NUM_GROUPS="$(nvm_num_version_groups "${VERSION}")" 
	if [ "${NUM_GROUPS}" -lt 3 ]
	then
		nvm_format_version "${VERSION%.}.0"
	else
		nvm_echo "${VERSION}" | command cut -f1-3 -d.
	fi
}
nvm_get_arch () {
	local HOST_ARCH
	local NVM_OS
	local EXIT_CODE
	local LONG_BIT
	NVM_OS="$(nvm_get_os)" 
	if [ "_${NVM_OS}" = "_sunos" ]
	then
		if HOST_ARCH=$(pkg_info -Q MACHINE_ARCH pkg_install) 
		then
			HOST_ARCH=$(nvm_echo "${HOST_ARCH}" | command tail -1) 
		else
			HOST_ARCH=$(isainfo -n) 
		fi
	elif [ "_${NVM_OS}" = "_aix" ]
	then
		HOST_ARCH=ppc64 
	else
		HOST_ARCH="$(command uname -m)" 
		LONG_BIT="$(getconf LONG_BIT 2>/dev/null)" 
	fi
	local NVM_ARCH
	case "${HOST_ARCH}" in
		(x86_64 | amd64) NVM_ARCH="x64"  ;;
		(i*86) NVM_ARCH="x86"  ;;
		(aarch64 | armv8l) NVM_ARCH="arm64"  ;;
		(*) NVM_ARCH="${HOST_ARCH}"  ;;
	esac
	if [ "_${LONG_BIT}" = "_32" ] && [ "${NVM_ARCH}" = "x64" ]
	then
		NVM_ARCH="x86" 
	fi
	if [ "$(uname)" = "Linux" ] && [ "${NVM_ARCH}" = arm64 ] && [ "$(command od -An -t x1 -j 4 -N 1 "/sbin/init" 2>/dev/null)" = ' 01' ]
	then
		NVM_ARCH=armv7l 
		HOST_ARCH=armv7l 
	fi
	if [ -f "/etc/alpine-release" ]
	then
		NVM_ARCH=x64-musl 
	fi
	nvm_echo "${NVM_ARCH}"
}
nvm_get_artifact_compression () {
	local VERSION
	VERSION="${1-}" 
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	local COMPRESSION
	COMPRESSION='tar.gz' 
	if [ "_${NVM_OS}" = '_win' ]
	then
		COMPRESSION='zip' 
	elif nvm_supports_xz "${VERSION}"
	then
		COMPRESSION='tar.xz' 
	fi
	nvm_echo "${COMPRESSION}"
}
nvm_get_checksum () {
	local FLAVOR
	case "${1-}" in
		(node | iojs) FLAVOR="${1}"  ;;
		(*) nvm_err 'supported flavors: node, iojs'
			return 2 ;;
	esac
	local MIRROR
	MIRROR="$(nvm_get_mirror "${FLAVOR}" "${2-}")" 
	if [ -z "${MIRROR}" ]
	then
		return 1
	fi
	local SHASUMS_URL
	if [ "$(nvm_get_checksum_alg)" = 'sha-256' ]
	then
		SHASUMS_URL="${MIRROR}/${3}/SHASUMS256.txt" 
	else
		SHASUMS_URL="${MIRROR}/${3}/SHASUMS.txt" 
	fi
	nvm_download -L -s "${SHASUMS_URL}" -o - | command awk "{ if (\"${4}.${5}\" == \$2) print \$1}"
}
nvm_get_checksum_alg () {
	local NVM_CHECKSUM_BIN
	NVM_CHECKSUM_BIN="$(nvm_get_checksum_binary 2>/dev/null)" 
	case "${NVM_CHECKSUM_BIN-}" in
		(sha256sum | shasum | sha256 | gsha256sum | openssl | bssl) nvm_echo 'sha-256' ;;
		(sha1sum | sha1) nvm_echo 'sha-1' ;;
		(*) nvm_get_checksum_binary
			return $? ;;
	esac
}
nvm_get_checksum_binary () {
	if nvm_has_non_aliased 'sha256sum'
	then
		nvm_echo 'sha256sum'
	elif nvm_has_non_aliased 'shasum'
	then
		nvm_echo 'shasum'
	elif nvm_has_non_aliased 'sha256'
	then
		nvm_echo 'sha256'
	elif nvm_has_non_aliased 'gsha256sum'
	then
		nvm_echo 'gsha256sum'
	elif nvm_has_non_aliased 'openssl'
	then
		nvm_echo 'openssl'
	elif nvm_has_non_aliased 'bssl'
	then
		nvm_echo 'bssl'
	elif nvm_has_non_aliased 'sha1sum'
	then
		nvm_echo 'sha1sum'
	elif nvm_has_non_aliased 'sha1'
	then
		nvm_echo 'sha1'
	else
		nvm_err 'Unaliased sha256sum, shasum, sha256, gsha256sum, openssl, or bssl not found.'
		nvm_err 'Unaliased sha1sum or sha1 not found.'
		return 1
	fi
}
nvm_get_colors () {
	local COLOR
	local SYS_COLOR
	local COLORS
	COLORS="${NVM_COLORS:-bygre}" 
	case $1 in
		(1) COLOR=$(nvm_print_color_code "$(echo "$COLORS" | awk '{ print substr($0, 1, 1); }')")  ;;
		(2) COLOR=$(nvm_print_color_code "$(echo "$COLORS" | awk '{ print substr($0, 2, 1); }')")  ;;
		(3) COLOR=$(nvm_print_color_code "$(echo "$COLORS" | awk '{ print substr($0, 3, 1); }')")  ;;
		(4) COLOR=$(nvm_print_color_code "$(echo "$COLORS" | awk '{ print substr($0, 4, 1); }')")  ;;
		(5) COLOR=$(nvm_print_color_code "$(echo "$COLORS" | awk '{ print substr($0, 5, 1); }')")  ;;
		(6) SYS_COLOR=$(nvm_print_color_code "$(echo "$COLORS" | awk '{ print substr($0, 2, 1); }')") 
			COLOR=$(nvm_echo "$SYS_COLOR" | command tr '0;' '1;')  ;;
		(*) nvm_err "Invalid color index, ${1-}"
			return 1 ;;
	esac
	nvm_echo "$COLOR"
}
nvm_get_default_packages () {
	local NVM_DEFAULT_PACKAGE_FILE
	NVM_DEFAULT_PACKAGE_FILE="${NVM_DIR}/default-packages" 
	if [ -f "${NVM_DEFAULT_PACKAGE_FILE}" ]
	then
		command awk -v filename="${NVM_DEFAULT_PACKAGE_FILE}" '
      /^[[:space:]]*#/ { next }                     # Skip lines that begin with #
      /^[[:space:]]*$/ { next }                     # Skip empty lines
      /[[:space:]]/ && !/^[[:space:]]*#/ {
        print "Only one package per line is allowed in `" filename "`. Please remove any lines with multiple space-separated values." > "/dev/stderr"
        err = 1
        exit 1
      }
      {
        if (NR > 1 && !prev_space) printf " "
        printf "%s", $0
        prev_space = 0
      }
    ' "${NVM_DEFAULT_PACKAGE_FILE}"
	fi
}
nvm_get_download_slug () {
	local FLAVOR
	case "${1-}" in
		(node | iojs) FLAVOR="${1}"  ;;
		(*) nvm_err 'supported flavors: node, iojs'
			return 1 ;;
	esac
	local KIND
	case "${2-}" in
		(binary | source) KIND="${2}"  ;;
		(*) nvm_err 'supported kinds: binary, source'
			return 2 ;;
	esac
	local VERSION
	VERSION="${3-}" 
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	local NVM_ARCH
	NVM_ARCH="$(nvm_get_arch)" 
	if ! nvm_is_merged_node_version "${VERSION}"
	then
		if [ "${NVM_ARCH}" = 'armv6l' ] || [ "${NVM_ARCH}" = 'armv7l' ]
		then
			NVM_ARCH="arm-pi" 
		fi
	fi
	if nvm_version_greater '14.17.0' "${VERSION}" || (
			nvm_version_greater_than_or_equal_to "${VERSION}" '15.0.0' && nvm_version_greater '16.0.0' "${VERSION}"
		)
	then
		if [ "_${NVM_OS}" = '_darwin' ] && [ "${NVM_ARCH}" = 'arm64' ]
		then
			NVM_ARCH=x64 
		fi
	fi
	if [ "${KIND}" = 'binary' ]
	then
		nvm_echo "${FLAVOR}-${VERSION}-${NVM_OS}-${NVM_ARCH}"
	elif [ "${KIND}" = 'source' ]
	then
		nvm_echo "${FLAVOR}-${VERSION}"
	fi
}
nvm_get_latest () {
	local NVM_LATEST_URL
	local CURL_COMPRESSED_FLAG
	if nvm_has "curl"
	then
		if nvm_curl_use_compression
		then
			CURL_COMPRESSED_FLAG="--compressed" 
		fi
		NVM_LATEST_URL="$(curl ${CURL_COMPRESSED_FLAG:-} -q -w "%{url_effective}\\n" -L -s -S https://latest.nvm.sh -o /dev/null)" 
	elif nvm_has "wget"
	then
		NVM_LATEST_URL="$(wget -q https://latest.nvm.sh --server-response -O /dev/null 2>&1 | command awk '/^  Location: /{DEST=$2} END{ print DEST }')" 
	else
		nvm_err 'nvm needs curl or wget to proceed.'
		return 1
	fi
	if [ -z "${NVM_LATEST_URL}" ]
	then
		nvm_err "https://latest.nvm.sh did not redirect to the latest release on GitHub"
		return 2
	fi
	nvm_echo "${NVM_LATEST_URL##*/}"
}
nvm_get_make_jobs () {
	if nvm_is_natural_num "${1-}"
	then
		NVM_MAKE_JOBS="$1" 
		nvm_echo "number of \`make\` jobs: ${NVM_MAKE_JOBS}"
		return
	elif [ -n "${1-}" ]
	then
		unset NVM_MAKE_JOBS
		nvm_err "$1 is invalid for number of \`make\` jobs, must be a natural number"
	fi
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	local NVM_CPU_CORES
	case "_${NVM_OS}" in
		("_linux") NVM_CPU_CORES="$(nvm_grep -c -E '^processor.+: [0-9]+' /proc/cpuinfo)"  ;;
		("_freebsd" | "_darwin" | "_openbsd") NVM_CPU_CORES="$(sysctl -n hw.ncpu)"  ;;
		("_sunos") NVM_CPU_CORES="$(psrinfo | wc -l)"  ;;
		("_aix") NVM_CPU_CORES="$(pmcycles -m | wc -l)"  ;;
	esac
	if ! nvm_is_natural_num "${NVM_CPU_CORES}"
	then
		nvm_err 'Can not determine how many core(s) are available, running in single-threaded mode.'
		nvm_err 'Please report an issue on GitHub to help us make nvm run faster on your computer!'
		NVM_MAKE_JOBS=1 
	else
		nvm_echo "Detected that you have ${NVM_CPU_CORES} CPU core(s)"
		if [ "${NVM_CPU_CORES}" -gt 2 ]
		then
			NVM_MAKE_JOBS=$((NVM_CPU_CORES - 1)) 
			nvm_echo "Running with ${NVM_MAKE_JOBS} threads to speed up the build"
		else
			NVM_MAKE_JOBS=1 
			nvm_echo 'Number of CPU core(s) less than or equal to 2, running in single-threaded mode'
		fi
	fi
}
nvm_get_minor_version () {
	local VERSION
	VERSION="$1" 
	if [ -z "${VERSION}" ]
	then
		nvm_err 'a version is required'
		return 1
	fi
	case "${VERSION}" in
		(v | .* | *..* | v*[!.0123456789]* | [!v]*[!.0123456789]* | [!v0123456789]* | v[!0123456789]*) nvm_err 'invalid version number'
			return 2 ;;
	esac
	local PREFIXED_VERSION
	PREFIXED_VERSION="$(nvm_format_version "${VERSION}")" 
	local MINOR
	MINOR="$(nvm_echo "${PREFIXED_VERSION}" | nvm_grep -e '^v' | command cut -c2- | command cut -d . -f 1,2)" 
	if [ -z "${MINOR}" ]
	then
		nvm_err 'invalid version number! (please report this)'
		return 3
	fi
	nvm_echo "${MINOR}"
}
nvm_get_mirror () {
	local NVM_MIRROR
	NVM_MIRROR='' 
	case "${1}-${2}" in
		(node-std) NVM_MIRROR="${NVM_NODEJS_ORG_MIRROR:-https://nodejs.org/dist}"  ;;
		(iojs-std) NVM_MIRROR="${NVM_IOJS_ORG_MIRROR:-https://iojs.org/dist}"  ;;
		(*) nvm_err 'unknown type of node.js or io.js release'
			return 1 ;;
	esac
	case "${NVM_MIRROR}" in
		(*\`* | *\\* | *\'* | *\(* | *' '*) nvm_err '$NVM_NODEJS_ORG_MIRROR and $NVM_IOJS_ORG_MIRROR may only contain a URL'
			return 2 ;;
	esac
	if ! nvm_echo "${NVM_MIRROR}" | command awk '{ $0 ~ "^https?://[a-zA-Z0-9./_-]+$" }'
	then
		nvm_err '$NVM_NODEJS_ORG_MIRROR and $NVM_IOJS_ORG_MIRROR may only contain a URL'
		return 2
	fi
	nvm_echo "${NVM_MIRROR}"
}
nvm_get_os () {
	local NVM_UNAME
	NVM_UNAME="$(command uname -a)" 
	local NVM_OS
	case "${NVM_UNAME}" in
		(Linux\ *) NVM_OS=linux  ;;
		(Darwin\ *) NVM_OS=darwin  ;;
		(SunOS\ *) NVM_OS=sunos  ;;
		(FreeBSD\ *) NVM_OS=freebsd  ;;
		(OpenBSD\ *) NVM_OS=openbsd  ;;
		(AIX\ *) NVM_OS=aix  ;;
		(CYGWIN* | MSYS* | MINGW*) NVM_OS=win  ;;
	esac
	nvm_echo "${NVM_OS-}"
}
nvm_grep () {
	GREP_OPTIONS='' command grep "$@"
}
nvm_has () {
	type "${1-}" > /dev/null 2>&1
}
nvm_has_colors () {
	local NVM_NUM_COLORS
	if nvm_has tput
	then
		NVM_NUM_COLORS="$(command tput -T "${TERM:-vt100}" colors)" 
	fi
	[ "${NVM_NUM_COLORS:--1}" -ge 8 ] && [ "${NVM_NO_COLORS-}" != '--no-colors' ]
}
nvm_has_non_aliased () {
	nvm_has "${1-}" && ! nvm_is_alias "${1-}"
}
nvm_has_solaris_binary () {
	local VERSION="${1-}" 
	if nvm_is_merged_node_version "${VERSION}"
	then
		return 0
	elif nvm_is_iojs_version "${VERSION}"
	then
		nvm_iojs_version_has_solaris_binary "${VERSION}"
	else
		nvm_node_version_has_solaris_binary "${VERSION}"
	fi
}
nvm_has_system_iojs () {
	[ "$(nvm deactivate >/dev/null 2>&1 && command -v iojs)" != '' ]
}
nvm_has_system_node () {
	[ "$(nvm deactivate >/dev/null 2>&1 && command -v node)" != '' ]
}
nvm_install_binary () {
	local FLAVOR
	case "${1-}" in
		(node | iojs) FLAVOR="${1}"  ;;
		(*) nvm_err 'supported flavors: node, iojs'
			return 4 ;;
	esac
	local TYPE
	TYPE="${2-}" 
	local PREFIXED_VERSION
	PREFIXED_VERSION="${3-}" 
	if [ -z "${PREFIXED_VERSION}" ]
	then
		nvm_err 'A version number is required.'
		return 3
	fi
	local nosource
	nosource="${4-}" 
	local VERSION
	VERSION="$(nvm_strip_iojs_prefix "${PREFIXED_VERSION}")" 
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	if [ -z "${NVM_OS}" ]
	then
		return 2
	fi
	local TARBALL
	local TMPDIR
	local PROGRESS_BAR
	local NODE_OR_IOJS
	if [ "${FLAVOR}" = 'node' ]
	then
		NODE_OR_IOJS="${FLAVOR}" 
	elif [ "${FLAVOR}" = 'iojs' ]
	then
		NODE_OR_IOJS="io.js" 
	fi
	if [ "${NVM_NO_PROGRESS-}" = "1" ]
	then
		PROGRESS_BAR="-sS" 
	else
		PROGRESS_BAR="--progress-bar" 
	fi
	nvm_echo "Downloading and installing ${NODE_OR_IOJS-} ${VERSION}..."
	TARBALL="$(PROGRESS_BAR="${PROGRESS_BAR}" nvm_download_artifact "${FLAVOR}" binary "${TYPE-}" "${VERSION}" | command tail -1)" 
	if [ -f "${TARBALL}" ]
	then
		TMPDIR="$(dirname "${TARBALL}")/files" 
	fi
	if nvm_install_binary_extract "${NVM_OS}" "${PREFIXED_VERSION}" "${VERSION}" "${TARBALL}" "${TMPDIR}"
	then
		if [ -n "${ALIAS-}" ]
		then
			nvm alias "${ALIAS}" "${provided_version}"
		fi
		return 0
	fi
	if [ "${nosource-}" = '1' ]
	then
		nvm_err 'Binary download failed. Download from source aborted.'
		return 0
	fi
	nvm_err 'Binary download failed, trying source.'
	if [ -n "${TMPDIR-}" ]
	then
		command rm -rf "${TMPDIR}"
	fi
	return 1
}
nvm_install_binary_extract () {
	if [ "$#" -ne 5 ]
	then
		nvm_err 'nvm_install_binary_extract needs 5 parameters'
		return 1
	fi
	local NVM_OS
	local PREFIXED_VERSION
	local VERSION
	local TARBALL
	local TMPDIR
	NVM_OS="${1}" 
	PREFIXED_VERSION="${2}" 
	VERSION="${3}" 
	TARBALL="${4}" 
	TMPDIR="${5}" 
	local VERSION_PATH
	[ -n "${TMPDIR-}" ] && command mkdir -p "${TMPDIR}" && VERSION_PATH="$(nvm_version_path "${PREFIXED_VERSION}")"  || return 1
	if [ "${NVM_OS}" = 'win' ]
	then
		VERSION_PATH="${VERSION_PATH}/bin" 
		command unzip -q "${TARBALL}" -d "${TMPDIR}" || return 1
	else
		nvm_extract_tarball "${NVM_OS}" "${VERSION}" "${TARBALL}" "${TMPDIR}"
	fi
	command mkdir -p "${VERSION_PATH}" || return 1
	if [ "${NVM_OS}" = 'win' ]
	then
		command mv "${TMPDIR}/"*/* "${VERSION_PATH}/" || return 1
		command chmod +x "${VERSION_PATH}"/node.exe || return 1
		command chmod +x "${VERSION_PATH}"/npm || return 1
		command chmod +x "${VERSION_PATH}"/npx 2> /dev/null
	else
		command mv "${TMPDIR}/"* "${VERSION_PATH}" || return 1
	fi
	command rm -rf "${TMPDIR}"
	return 0
}
nvm_install_default_packages () {
	local DEFAULT_PACKAGES
	DEFAULT_PACKAGES="$(nvm_get_default_packages)" 
	EXIT_CODE=$? 
	if [ $EXIT_CODE -ne 0 ] || [ -z "${DEFAULT_PACKAGES}" ]
	then
		return $EXIT_CODE
	fi
	nvm_echo "Installing default global packages from ${NVM_DIR}/default-packages..."
	nvm_echo "npm install -g --quiet ${DEFAULT_PACKAGES}"
	if ! nvm_echo "${DEFAULT_PACKAGES}" | command xargs npm install -g --quiet
	then
		nvm_err "Failed installing default packages. Please check if your default-packages file or a package in it has problems!"
		return 1
	fi
}
nvm_install_latest_npm () {
	nvm_echo 'Attempting to upgrade to the latest working version of npm...'
	local NODE_VERSION
	NODE_VERSION="$(nvm_strip_iojs_prefix "$(nvm_ls_current)")" 
	local NPM_VERSION
	NPM_VERSION="$(npm --version 2>/dev/null)" 
	if [ "${NODE_VERSION}" = 'system' ]
	then
		NODE_VERSION="$(node --version)" 
	elif [ "${NODE_VERSION}" = 'none' ]
	then
		nvm_echo "Detected node version ${NODE_VERSION}, npm version v${NPM_VERSION}"
		NODE_VERSION='' 
	fi
	if [ -z "${NODE_VERSION}" ]
	then
		nvm_err 'Unable to obtain node version.'
		return 1
	fi
	if [ -z "${NPM_VERSION}" ]
	then
		nvm_err 'Unable to obtain npm version.'
		return 2
	fi
	local NVM_NPM_CMD
	NVM_NPM_CMD='npm' 
	if [ "${NVM_DEBUG-}" = 1 ]
	then
		nvm_echo "Detected node version ${NODE_VERSION}, npm version v${NPM_VERSION}"
		NVM_NPM_CMD='nvm_echo npm' 
	fi
	local NVM_IS_0_6
	NVM_IS_0_6=0 
	if nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 0.6.0 && nvm_version_greater 0.7.0 "${NODE_VERSION}"
	then
		NVM_IS_0_6=1 
	fi
	local NVM_IS_0_9
	NVM_IS_0_9=0 
	if nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 0.9.0 && nvm_version_greater 0.10.0 "${NODE_VERSION}"
	then
		NVM_IS_0_9=1 
	fi
	if [ $NVM_IS_0_6 -eq 1 ]
	then
		nvm_echo '* `node` v0.6.x can only upgrade to `npm` v1.3.x'
		$NVM_NPM_CMD install -g npm@1.3
	elif [ $NVM_IS_0_9 -eq 0 ]
	then
		if nvm_version_greater_than_or_equal_to "${NPM_VERSION}" 1.0.0 && nvm_version_greater 2.0.0 "${NPM_VERSION}"
		then
			nvm_echo '* `npm` v1.x needs to first jump to `npm` v1.4.28 to be able to upgrade further'
			$NVM_NPM_CMD install -g npm@1.4.28
		elif nvm_version_greater_than_or_equal_to "${NPM_VERSION}" 2.0.0 && nvm_version_greater 3.0.0 "${NPM_VERSION}"
		then
			nvm_echo '* `npm` v2.x needs to first jump to the latest v2 to be able to upgrade further'
			$NVM_NPM_CMD install -g npm@2
		fi
	fi
	if [ $NVM_IS_0_9 -eq 1 ] || [ $NVM_IS_0_6 -eq 1 ]
	then
		nvm_echo '* node v0.6 and v0.9 are unable to upgrade further'
	elif nvm_version_greater 1.1.0 "${NODE_VERSION}"
	then
		nvm_echo '* `npm` v4.5.x is the last version that works on `node` versions < v1.1.0'
		$NVM_NPM_CMD install -g npm@4.5
	elif nvm_version_greater 4.0.0 "${NODE_VERSION}"
	then
		nvm_echo '* `npm` v5 and higher do not work on `node` versions below v4.0.0'
		$NVM_NPM_CMD install -g npm@4
	elif [ $NVM_IS_0_9 -eq 0 ] && [ $NVM_IS_0_6 -eq 0 ]
	then
		local NVM_IS_4_4_OR_BELOW
		NVM_IS_4_4_OR_BELOW=0 
		if nvm_version_greater 4.5.0 "${NODE_VERSION}"
		then
			NVM_IS_4_4_OR_BELOW=1 
		fi
		local NVM_IS_5_OR_ABOVE
		NVM_IS_5_OR_ABOVE=0 
		if [ $NVM_IS_4_4_OR_BELOW -eq 0 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 5.0.0
		then
			NVM_IS_5_OR_ABOVE=1 
		fi
		local NVM_IS_6_OR_ABOVE
		NVM_IS_6_OR_ABOVE=0 
		local NVM_IS_6_2_OR_ABOVE
		NVM_IS_6_2_OR_ABOVE=0 
		if [ $NVM_IS_5_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 6.0.0
		then
			NVM_IS_6_OR_ABOVE=1 
			if nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 6.2.0
			then
				NVM_IS_6_2_OR_ABOVE=1 
			fi
		fi
		local NVM_IS_9_OR_ABOVE
		NVM_IS_9_OR_ABOVE=0 
		local NVM_IS_9_3_OR_ABOVE
		NVM_IS_9_3_OR_ABOVE=0 
		if [ $NVM_IS_6_2_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 9.0.0
		then
			NVM_IS_9_OR_ABOVE=1 
			if nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 9.3.0
			then
				NVM_IS_9_3_OR_ABOVE=1 
			fi
		fi
		local NVM_IS_10_OR_ABOVE
		NVM_IS_10_OR_ABOVE=0 
		if [ $NVM_IS_9_3_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 10.0.0
		then
			NVM_IS_10_OR_ABOVE=1 
		fi
		local NVM_IS_12_LTS_OR_ABOVE
		NVM_IS_12_LTS_OR_ABOVE=0 
		if [ $NVM_IS_10_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 12.13.0
		then
			NVM_IS_12_LTS_OR_ABOVE=1 
		fi
		local NVM_IS_13_OR_ABOVE
		NVM_IS_13_OR_ABOVE=0 
		if [ $NVM_IS_12_LTS_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 13.0.0
		then
			NVM_IS_13_OR_ABOVE=1 
		fi
		local NVM_IS_14_LTS_OR_ABOVE
		NVM_IS_14_LTS_OR_ABOVE=0 
		if [ $NVM_IS_13_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 14.15.0
		then
			NVM_IS_14_LTS_OR_ABOVE=1 
		fi
		local NVM_IS_14_17_OR_ABOVE
		NVM_IS_14_17_OR_ABOVE=0 
		if [ $NVM_IS_14_LTS_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 14.17.0
		then
			NVM_IS_14_17_OR_ABOVE=1 
		fi
		local NVM_IS_15_OR_ABOVE
		NVM_IS_15_OR_ABOVE=0 
		if [ $NVM_IS_14_LTS_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 15.0.0
		then
			NVM_IS_15_OR_ABOVE=1 
		fi
		local NVM_IS_16_OR_ABOVE
		NVM_IS_16_OR_ABOVE=0 
		if [ $NVM_IS_15_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 16.0.0
		then
			NVM_IS_16_OR_ABOVE=1 
		fi
		local NVM_IS_16_LTS_OR_ABOVE
		NVM_IS_16_LTS_OR_ABOVE=0 
		if [ $NVM_IS_16_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 16.13.0
		then
			NVM_IS_16_LTS_OR_ABOVE=1 
		fi
		local NVM_IS_17_OR_ABOVE
		NVM_IS_17_OR_ABOVE=0 
		if [ $NVM_IS_16_LTS_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 17.0.0
		then
			NVM_IS_17_OR_ABOVE=1 
		fi
		local NVM_IS_18_OR_ABOVE
		NVM_IS_18_OR_ABOVE=0 
		if [ $NVM_IS_17_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 18.0.0
		then
			NVM_IS_18_OR_ABOVE=1 
		fi
		local NVM_IS_18_17_OR_ABOVE
		NVM_IS_18_17_OR_ABOVE=0 
		if [ $NVM_IS_18_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 18.17.0
		then
			NVM_IS_18_17_OR_ABOVE=1 
		fi
		local NVM_IS_19_OR_ABOVE
		NVM_IS_19_OR_ABOVE=0 
		if [ $NVM_IS_18_17_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 19.0.0
		then
			NVM_IS_19_OR_ABOVE=1 
		fi
		local NVM_IS_20_5_OR_ABOVE
		NVM_IS_20_5_OR_ABOVE=0 
		if [ $NVM_IS_19_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 20.5.0
		then
			NVM_IS_20_5_OR_ABOVE=1 
		fi
		local NVM_IS_20_17_OR_ABOVE
		NVM_IS_20_17_OR_ABOVE=0 
		if [ $NVM_IS_20_5_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 20.17.0
		then
			NVM_IS_20_17_OR_ABOVE=1 
		fi
		local NVM_IS_21_OR_ABOVE
		NVM_IS_21_OR_ABOVE=0 
		if [ $NVM_IS_20_17_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 21.0.0
		then
			NVM_IS_21_OR_ABOVE=1 
		fi
		local NVM_IS_22_9_OR_ABOVE
		NVM_IS_22_9_OR_ABOVE=0 
		if [ $NVM_IS_21_OR_ABOVE -eq 1 ] && nvm_version_greater_than_or_equal_to "${NODE_VERSION}" 22.9.0
		then
			NVM_IS_22_9_OR_ABOVE=1 
		fi
		if [ $NVM_IS_4_4_OR_BELOW -eq 1 ] || {
				[ $NVM_IS_5_OR_ABOVE -eq 1 ] && nvm_version_greater 5.10.0 "${NODE_VERSION}"
			}
		then
			nvm_echo '* `npm` `v5.3.x` is the last version that works on `node` 4.x versions below v4.4, or 5.x versions below v5.10, due to `Buffer.alloc`'
			$NVM_NPM_CMD install -g npm@5.3
		elif [ $NVM_IS_4_4_OR_BELOW -eq 0 ] && nvm_version_greater 4.7.0 "${NODE_VERSION}"
		then
			nvm_echo '* `npm` `v5.4.1` is the last version that works on `node` `v4.5` and `v4.6`'
			$NVM_NPM_CMD install -g npm@5.4.1
		elif [ $NVM_IS_6_OR_ABOVE -eq 0 ]
		then
			nvm_echo '* `npm` `v5.x` is the last version that works on `node` below `v6.0.0`'
			$NVM_NPM_CMD install -g npm@5
		elif {
				[ $NVM_IS_6_OR_ABOVE -eq 1 ] && [ $NVM_IS_6_2_OR_ABOVE -eq 0 ]
			} || {
				[ $NVM_IS_9_OR_ABOVE -eq 1 ] && [ $NVM_IS_9_3_OR_ABOVE -eq 0 ]
			}
		then
			nvm_echo '* `npm` `v6.9` is the last version that works on `node` `v6.0.x`, `v6.1.x`, `v9.0.x`, `v9.1.x`, or `v9.2.x`'
			$NVM_NPM_CMD install -g npm@6.9
		elif [ $NVM_IS_10_OR_ABOVE -eq 0 ]
		then
			if nvm_version_greater 4.4.4 "${NPM_VERSION}"
			then
				nvm_echo '* `npm` `v4.4.4` or later is required to install npm v6.14.18'
				$NVM_NPM_CMD install -g npm@4
			fi
			nvm_echo '* `npm` `v6.x` is the last version that works on `node` below `v10.0.0`'
			$NVM_NPM_CMD install -g npm@6
		elif [ $NVM_IS_12_LTS_OR_ABOVE -eq 0 ] || {
				[ $NVM_IS_13_OR_ABOVE -eq 1 ] && [ $NVM_IS_14_LTS_OR_ABOVE -eq 0 ]
			} || {
				[ $NVM_IS_15_OR_ABOVE -eq 1 ] && [ $NVM_IS_16_OR_ABOVE -eq 0 ]
			}
		then
			nvm_echo '* `npm` `v7.x` is the last version that works on `node` `v13`, `v15`, below `v12.13`, or `v14.0` - `v14.15`'
			$NVM_NPM_CMD install -g npm@7
		elif {
				[ $NVM_IS_12_LTS_OR_ABOVE -eq 1 ] && [ $NVM_IS_13_OR_ABOVE -eq 0 ]
			} || {
				[ $NVM_IS_14_LTS_OR_ABOVE -eq 1 ] && [ $NVM_IS_14_17_OR_ABOVE -eq 0 ]
			} || {
				[ $NVM_IS_16_OR_ABOVE -eq 1 ] && [ $NVM_IS_16_LTS_OR_ABOVE -eq 0 ]
			} || {
				[ $NVM_IS_17_OR_ABOVE -eq 1 ] && [ $NVM_IS_18_OR_ABOVE -eq 0 ]
			}
		then
			nvm_echo '* `npm` `v8.6` is the last version that works on `node` `v12`, `v14.13` - `v14.16`, or `v16.0` - `v16.12`'
			$NVM_NPM_CMD install -g npm@8.6
		elif [ $NVM_IS_18_17_OR_ABOVE -eq 0 ] || {
				[ $NVM_IS_19_OR_ABOVE -eq 1 ] && [ $NVM_IS_20_5_OR_ABOVE -eq 0 ]
			}
		then
			nvm_echo '* `npm` `v9.x` is the last version that works on `node` `< v18.17`, `v19`, or `v20.0` - `v20.4`'
			$NVM_NPM_CMD install -g npm@9
		elif [ $NVM_IS_20_17_OR_ABOVE -eq 0 ] || {
				[ $NVM_IS_21_OR_ABOVE -eq 1 ] && [ $NVM_IS_22_9_OR_ABOVE -eq 0 ]
			}
		then
			nvm_echo '* `npm` `v10.x` is the last version that works on `node` `< v20.17`, `v21`, or `v22.0` - `v22.8`'
			$NVM_NPM_CMD install -g npm@10
		else
			nvm_echo '* Installing latest `npm`; if this does not work on your node version, please report a bug!'
			$NVM_NPM_CMD install -g npm
		fi
	fi
	nvm_echo "* npm upgraded to: v$(npm --version 2>/dev/null)"
}
nvm_install_npm_if_needed () {
	local VERSION
	VERSION="$(nvm_ls_current)" 
	if ! nvm_has "npm"
	then
		nvm_echo 'Installing npm...'
		if nvm_version_greater 0.2.0 "${VERSION}"
		then
			nvm_err 'npm requires node v0.2.3 or higher'
		elif nvm_version_greater_than_or_equal_to "${VERSION}" 0.2.0
		then
			if nvm_version_greater 0.2.3 "${VERSION}"
			then
				nvm_err 'npm requires node v0.2.3 or higher'
			else
				nvm_download -L https://npmjs.org/install.sh -o - | clean=yes npm_install=0.2.19 sh
			fi
		else
			nvm_download -L https://npmjs.org/install.sh -o - | clean=yes sh
		fi
	fi
	return $?
}
nvm_install_source () {
	local FLAVOR
	case "${1-}" in
		(node | iojs) FLAVOR="${1}"  ;;
		(*) nvm_err 'supported flavors: node, iojs'
			return 4 ;;
	esac
	local TYPE
	TYPE="${2-}" 
	local PREFIXED_VERSION
	PREFIXED_VERSION="${3-}" 
	if [ -z "${PREFIXED_VERSION}" ]
	then
		nvm_err 'A version number is required.'
		return 3
	fi
	local VERSION
	VERSION="$(nvm_strip_iojs_prefix "${PREFIXED_VERSION}")" 
	local NVM_MAKE_JOBS
	NVM_MAKE_JOBS="${4-}" 
	local ADDITIONAL_PARAMETERS
	ADDITIONAL_PARAMETERS="${5-}" 
	local NVM_ARCH
	NVM_ARCH="$(nvm_get_arch)" 
	if [ "${NVM_ARCH}" = 'armv6l' ] || [ "${NVM_ARCH}" = 'armv7l' ]
	then
		if [ -n "${ADDITIONAL_PARAMETERS}" ]
		then
			ADDITIONAL_PARAMETERS="--without-snapshot ${ADDITIONAL_PARAMETERS}" 
		else
			ADDITIONAL_PARAMETERS='--without-snapshot' 
		fi
	fi
	if [ -n "${ADDITIONAL_PARAMETERS}" ]
	then
		nvm_echo "Additional options while compiling: ${ADDITIONAL_PARAMETERS}"
	fi
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	local make
	make='make' 
	local MAKE_CXX
	case "${NVM_OS}" in
		('freebsd' | 'openbsd') make='gmake' 
			MAKE_CXX="CC=${CC:-cc} CXX=${CXX:-c++}"  ;;
		('darwin') MAKE_CXX="CC=${CC:-cc} CXX=${CXX:-c++}"  ;;
		('aix') make='gmake'  ;;
	esac
	if nvm_has "clang++" && nvm_has "clang" && nvm_version_greater_than_or_equal_to "$(nvm_clang_version)" 3.5
	then
		if [ -z "${CC-}" ] || [ -z "${CXX-}" ]
		then
			nvm_echo "Clang v3.5+ detected! CC or CXX not specified, will use Clang as C/C++ compiler!"
			MAKE_CXX="CC=${CC:-cc} CXX=${CXX:-c++}" 
		fi
	fi
	local TARBALL
	local TMPDIR
	local VERSION_PATH
	if [ "${NVM_NO_PROGRESS-}" = "1" ]
	then
		PROGRESS_BAR="-sS" 
	else
		PROGRESS_BAR="--progress-bar" 
	fi
	nvm_is_zsh && setopt local_options shwordsplit
	TARBALL="$(PROGRESS_BAR="${PROGRESS_BAR}" nvm_download_artifact "${FLAVOR}" source "${TYPE}" "${VERSION}" | command tail -1)"  && [ -f "${TARBALL}" ] && TMPDIR="$(dirname "${TARBALL}")/files"  && if ! (
			command mkdir -p "${TMPDIR}" && nvm_extract_tarball "${NVM_OS}" "${VERSION}" "${TARBALL}" "${TMPDIR}" && VERSION_PATH="$(nvm_version_path "${PREFIXED_VERSION}")"  && nvm_cd "${TMPDIR}" && nvm_echo '$>'./configure --prefix="${VERSION_PATH}" $ADDITIONAL_PARAMETERS'<' && ./configure --prefix="${VERSION_PATH}" $ADDITIONAL_PARAMETERS && $make -j "${NVM_MAKE_JOBS}" ${MAKE_CXX-} && command rm -f "${VERSION_PATH}" 2> /dev/null && $make -j "${NVM_MAKE_JOBS}" ${MAKE_CXX-} install
		)
	then
		nvm_err "nvm: install ${VERSION} failed!"
		command rm -rf "${TMPDIR-}"
		return 1
	fi
}
nvm_iojs_prefix () {
	nvm_echo 'iojs'
}
nvm_iojs_version_has_solaris_binary () {
	local IOJS_VERSION
	IOJS_VERSION="$1" 
	local STRIPPED_IOJS_VERSION
	STRIPPED_IOJS_VERSION="$(nvm_strip_iojs_prefix "${IOJS_VERSION}")" 
	if [ "_${STRIPPED_IOJS_VERSION}" = "${IOJS_VERSION}" ]
	then
		return 1
	fi
	nvm_version_greater_than_or_equal_to "${STRIPPED_IOJS_VERSION}" v3.3.1
}
nvm_is_alias () {
	\alias "${1-}" > /dev/null 2>&1
}
nvm_is_iojs_version () {
	case "${1-}" in
		(iojs-*) return 0 ;;
	esac
	return 1
}
nvm_is_merged_node_version () {
	nvm_version_greater_than_or_equal_to "$1" v4.0.0
}
nvm_is_natural_num () {
	if [ -z "$1" ]
	then
		return 4
	fi
	case "$1" in
		(0) return 1 ;;
		(-*) return 3 ;;
		(*) [ "$1" -eq "$1" ] 2> /dev/null ;;
	esac
}
nvm_is_valid_version () {
	if nvm_validate_implicit_alias "${1-}" 2> /dev/null
	then
		return 0
	fi
	case "${1-}" in
		("$(nvm_iojs_prefix)" | "$(nvm_node_prefix)") return 0 ;;
		(*) local VERSION
			VERSION="$(nvm_strip_iojs_prefix "${1-}")" 
			nvm_version_greater_than_or_equal_to "${VERSION}" 0 ;;
	esac
}
nvm_is_version_installed () {
	if [ -z "${1-}" ]
	then
		return 1
	fi
	local NVM_NODE_BINARY
	NVM_NODE_BINARY='node' 
	if [ "_$(nvm_get_os)" = '_win' ]
	then
		NVM_NODE_BINARY='node.exe' 
	fi
	if [ -x "$(nvm_version_path "$1" 2>/dev/null)/bin/${NVM_NODE_BINARY}" ]
	then
		return 0
	fi
	return 1
}
nvm_is_zsh () {
	[ -n "${ZSH_VERSION-}" ]
}
nvm_list_aliases () {
	local ALIAS
	ALIAS="${1-}" 
	local NVM_CURRENT
	NVM_CURRENT="$(nvm_ls_current)" 
	local NVM_ALIAS_DIR
	NVM_ALIAS_DIR="$(nvm_alias_path)" 
	command mkdir -p "${NVM_ALIAS_DIR}/lts"
	if [ "${ALIAS}" != "${ALIAS#lts/}" ]
	then
		nvm_alias "${ALIAS}"
		return $?
	fi
	nvm_is_zsh && unsetopt local_options nomatch
	(
		local ALIAS_PATH
		for ALIAS_PATH in "${NVM_ALIAS_DIR}/${ALIAS}"*
		do
			NVM_NO_COLORS="${NVM_NO_COLORS-}" NVM_CURRENT="${NVM_CURRENT}" nvm_print_alias_path "${NVM_ALIAS_DIR}" "${ALIAS_PATH}" &
		done
		wait
	) | command sort
	(
		local ALIAS_NAME
		for ALIAS_NAME in "$(nvm_node_prefix)" "stable" "unstable" "$(nvm_iojs_prefix)"
		do
			{
				if [ ! -f "${NVM_ALIAS_DIR}/${ALIAS_NAME}" ] && {
						[ -z "${ALIAS}" ] || [ "${ALIAS_NAME}" = "${ALIAS}" ]
					}
				then
					NVM_NO_COLORS="${NVM_NO_COLORS-}" NVM_CURRENT="${NVM_CURRENT}" nvm_print_default_alias "${ALIAS_NAME}"
				fi
			} &
		done
		wait
	) | command sort
	(
		local LTS_ALIAS
		for ALIAS_PATH in "${NVM_ALIAS_DIR}/lts/${ALIAS}"*
		do
			{
				LTS_ALIAS="$(NVM_NO_COLORS="${NVM_NO_COLORS-}" NVM_LTS=true nvm_print_alias_path "${NVM_ALIAS_DIR}" "${ALIAS_PATH}")" 
				if [ -n "${LTS_ALIAS}" ]
				then
					nvm_echo "${LTS_ALIAS}"
				fi
			} &
		done
		wait
	) | command sort
	return
}
nvm_ls () {
	local PATTERN
	PATTERN="${1-}" 
	local VERSIONS
	VERSIONS='' 
	if [ "${PATTERN}" = 'current' ]
	then
		nvm_ls_current
		return
	fi
	local NVM_IOJS_PREFIX
	NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
	local NVM_NODE_PREFIX
	NVM_NODE_PREFIX="$(nvm_node_prefix)" 
	local NVM_VERSION_DIR_IOJS
	NVM_VERSION_DIR_IOJS="$(nvm_version_dir "${NVM_IOJS_PREFIX}")" 
	local NVM_VERSION_DIR_NEW
	NVM_VERSION_DIR_NEW="$(nvm_version_dir new)" 
	local NVM_VERSION_DIR_OLD
	NVM_VERSION_DIR_OLD="$(nvm_version_dir old)" 
	case "${PATTERN}" in
		("${NVM_IOJS_PREFIX}" | "${NVM_NODE_PREFIX}") PATTERN="${PATTERN}-"  ;;
		(*) if nvm_resolve_local_alias "${PATTERN}"
			then
				return
			fi
			PATTERN="$(nvm_ensure_version_prefix "${PATTERN}")"  ;;
	esac
	if [ "${PATTERN}" = 'N/A' ]
	then
		return
	fi
	local NVM_PATTERN_STARTS_WITH_V
	case $PATTERN in
		(v*) NVM_PATTERN_STARTS_WITH_V=true  ;;
		(*) NVM_PATTERN_STARTS_WITH_V=false  ;;
	esac
	if [ $NVM_PATTERN_STARTS_WITH_V = true ] && [ "_$(nvm_num_version_groups "${PATTERN}")" = "_3" ]
	then
		if nvm_is_version_installed "${PATTERN}"
		then
			VERSIONS="${PATTERN}" 
		elif nvm_is_version_installed "$(nvm_add_iojs_prefix "${PATTERN}")"
		then
			VERSIONS="$(nvm_add_iojs_prefix "${PATTERN}")" 
		fi
	else
		case "${PATTERN}" in
			("${NVM_IOJS_PREFIX}-" | "${NVM_NODE_PREFIX}-" | "system")  ;;
			(*) local NUM_VERSION_GROUPS
				NUM_VERSION_GROUPS="$(nvm_num_version_groups "${PATTERN}")" 
				if [ "${NUM_VERSION_GROUPS}" = "2" ] || [ "${NUM_VERSION_GROUPS}" = "1" ]
				then
					PATTERN="${PATTERN%.}." 
				fi ;;
		esac
		nvm_is_zsh && setopt local_options shwordsplit
		nvm_is_zsh && unsetopt local_options markdirs
		local NVM_DIRS_TO_SEARCH1
		NVM_DIRS_TO_SEARCH1='' 
		local NVM_DIRS_TO_SEARCH2
		NVM_DIRS_TO_SEARCH2='' 
		local NVM_DIRS_TO_SEARCH3
		NVM_DIRS_TO_SEARCH3='' 
		local NVM_ADD_SYSTEM
		NVM_ADD_SYSTEM=false 
		if nvm_is_iojs_version "${PATTERN}"
		then
			NVM_DIRS_TO_SEARCH1="${NVM_VERSION_DIR_IOJS}" 
			PATTERN="$(nvm_strip_iojs_prefix "${PATTERN}")" 
			if nvm_has_system_iojs
			then
				NVM_ADD_SYSTEM=true 
			fi
		elif [ "${PATTERN}" = "${NVM_NODE_PREFIX}-" ]
		then
			NVM_DIRS_TO_SEARCH1="${NVM_VERSION_DIR_OLD}" 
			NVM_DIRS_TO_SEARCH2="${NVM_VERSION_DIR_NEW}" 
			PATTERN='' 
			if nvm_has_system_node
			then
				NVM_ADD_SYSTEM=true 
			fi
		else
			NVM_DIRS_TO_SEARCH1="${NVM_VERSION_DIR_OLD}" 
			NVM_DIRS_TO_SEARCH2="${NVM_VERSION_DIR_NEW}" 
			NVM_DIRS_TO_SEARCH3="${NVM_VERSION_DIR_IOJS}" 
			if nvm_has_system_iojs || nvm_has_system_node
			then
				NVM_ADD_SYSTEM=true 
			fi
		fi
		if ! [ -d "${NVM_DIRS_TO_SEARCH1}" ] || ! (
				command ls -1qA "${NVM_DIRS_TO_SEARCH1}" | nvm_grep -q .
			)
		then
			NVM_DIRS_TO_SEARCH1='' 
		fi
		if ! [ -d "${NVM_DIRS_TO_SEARCH2}" ] || ! (
				command ls -1qA "${NVM_DIRS_TO_SEARCH2}" | nvm_grep -q .
			)
		then
			NVM_DIRS_TO_SEARCH2="${NVM_DIRS_TO_SEARCH1}" 
		fi
		if ! [ -d "${NVM_DIRS_TO_SEARCH3}" ] || ! (
				command ls -1qA "${NVM_DIRS_TO_SEARCH3}" | nvm_grep -q .
			)
		then
			NVM_DIRS_TO_SEARCH3="${NVM_DIRS_TO_SEARCH2}" 
		fi
		local SEARCH_PATTERN
		if [ -z "${PATTERN}" ]
		then
			PATTERN='v' 
			SEARCH_PATTERN='.*' 
		else
			SEARCH_PATTERN="$(nvm_echo "${PATTERN}" | command sed 's#\.#\\\.#g;')" 
		fi
		if [ -n "${NVM_DIRS_TO_SEARCH1}${NVM_DIRS_TO_SEARCH2}${NVM_DIRS_TO_SEARCH3}" ]
		then
			VERSIONS="$(command find "${NVM_DIRS_TO_SEARCH1}"/* "${NVM_DIRS_TO_SEARCH2}"/* "${NVM_DIRS_TO_SEARCH3}"/* -name . -o -type d -prune -o -path "${PATTERN}*" \
        | command sed -e "
            s#${NVM_VERSION_DIR_IOJS}/#versions/${NVM_IOJS_PREFIX}/#;
            s#^${NVM_DIR}/##;
            \\#^[^v]# d;
            \\#^versions\$# d;
            s#^versions/##;
            s#^v#${NVM_NODE_PREFIX}/v#;
            \\#${SEARCH_PATTERN}# !d;
          " \
          -e 's#^\([^/]\{1,\}\)/\(.*\)$#\2.\1#;' \
        | command sort -t. -u -k 1.2,1n -k 2,2n -k 3,3n \
        | command sed -e 's#\(.*\)\.\([^\.]\{1,\}\)$#\2-\1#;' \
                      -e "s#^${NVM_NODE_PREFIX}-##;" \
      )" 
		fi
	fi
	if [ "${NVM_ADD_SYSTEM-}" = true ]
	then
		case "${PATTERN}" in
			('' | v) VERSIONS="${VERSIONS}
system"  ;;
			(system) VERSIONS="system"  ;;
		esac
	fi
	if [ -z "${VERSIONS}" ]
	then
		nvm_echo 'N/A'
		return 3
	fi
	nvm_echo "${VERSIONS}"
}
nvm_ls_current () {
	local NVM_LS_CURRENT_NODE_PATH
	if ! NVM_LS_CURRENT_NODE_PATH="$(command which node 2>/dev/null)" 
	then
		nvm_echo 'none'
	elif nvm_tree_contains_path "$(nvm_version_dir iojs)" "${NVM_LS_CURRENT_NODE_PATH}"
	then
		nvm_add_iojs_prefix "$(iojs --version 2>/dev/null)"
	elif nvm_tree_contains_path "${NVM_DIR}" "${NVM_LS_CURRENT_NODE_PATH}"
	then
		local VERSION
		VERSION="$(node --version 2>/dev/null)" 
		if [ "${VERSION}" = "v0.6.21-pre" ]
		then
			nvm_echo 'v0.6.21'
		else
			nvm_echo "${VERSION:-none}"
		fi
	else
		nvm_echo 'system'
	fi
}
nvm_ls_remote () {
	local PATTERN
	PATTERN="${1-}" 
	if nvm_validate_implicit_alias "${PATTERN}" 2> /dev/null
	then
		local IMPLICIT
		IMPLICIT="$(nvm_print_implicit_alias remote "${PATTERN}")" 
		if [ -z "${IMPLICIT-}" ] || [ "${IMPLICIT}" = 'N/A' ]
		then
			nvm_echo "N/A"
			return 3
		fi
		PATTERN="$(NVM_LTS="${NVM_LTS-}" nvm_ls_remote "${IMPLICIT}" | command tail -1 | command awk '{ print $1 }')" 
	elif [ -n "${PATTERN}" ]
	then
		PATTERN="$(nvm_ensure_version_prefix "${PATTERN}")" 
	else
		PATTERN=".*" 
	fi
	NVM_LTS="${NVM_LTS-}" nvm_ls_remote_index_tab node std "${PATTERN}"
}
nvm_ls_remote_index_tab () {
	local LTS
	LTS="${NVM_LTS-}" 
	if [ "$#" -lt 3 ]
	then
		nvm_err 'not enough arguments'
		return 5
	fi
	local FLAVOR
	FLAVOR="${1-}" 
	local TYPE
	TYPE="${2-}" 
	local MIRROR
	MIRROR="$(nvm_get_mirror "${FLAVOR}" "${TYPE}")" 
	if [ -z "${MIRROR}" ]
	then
		return 3
	fi
	local PREFIX
	PREFIX='' 
	case "${FLAVOR}-${TYPE}" in
		(iojs-std) PREFIX="$(nvm_iojs_prefix)-"  ;;
		(node-std) PREFIX=''  ;;
		(iojs-*) nvm_err 'unknown type of io.js release'
			return 4 ;;
		(*) nvm_err 'unknown type of node.js release'
			return 4 ;;
	esac
	local SORT_COMMAND
	SORT_COMMAND='command sort' 
	case "${FLAVOR}" in
		(node) SORT_COMMAND='command sort -t. -u -k 1.2,1n -k 2,2n -k 3,3n'  ;;
	esac
	local PATTERN
	PATTERN="${3-}" 
	if [ "${PATTERN#"${PATTERN%?}"}" = '.' ]
	then
		PATTERN="${PATTERN%.}" 
	fi
	local VERSIONS
	if [ -n "${PATTERN}" ] && [ "${PATTERN}" != '*' ]
	then
		if [ "${FLAVOR}" = 'iojs' ]
		then
			PATTERN="$(nvm_ensure_version_prefix "$(nvm_strip_iojs_prefix "${PATTERN}")")" 
		else
			PATTERN="$(nvm_ensure_version_prefix "${PATTERN}")" 
		fi
	else
		unset PATTERN
	fi
	nvm_is_zsh && setopt local_options shwordsplit
	local VERSION_LIST
	VERSION_LIST="$(nvm_download -L -s "${MIRROR}/index.tab" -o - \
    | command sed "
        1d;
        s/^/${PREFIX}/;
      " \
  )" 
	local LTS_ALIAS
	local LTS_VERSION
	command mkdir -p "$(nvm_alias_path)/lts"
	{
		command awk '{
        if ($10 ~ /^\-?$/) { next }
        if ($10 && !a[tolower($10)]++) {
          if (alias) { print alias, version }
          alias_name = "lts/" tolower($10)
          if (!alias) { print "lts/*", alias_name }
          alias = alias_name
          version = $1
        }
      }
      END {
        if (alias) {
          print alias, version
        }
      }' | while read -r LTS_ALIAS_LINE
		do
			LTS_ALIAS="${LTS_ALIAS_LINE%% *}" 
			LTS_VERSION="${LTS_ALIAS_LINE#* }" 
			nvm_make_alias "${LTS_ALIAS}" "${LTS_VERSION}" > /dev/null 2>&1
		done
	} <<EOF
$VERSION_LIST
EOF
	if [ -n "${LTS-}" ]
	then
		if ! LTS="$(nvm_normalize_lts "lts/${LTS}")" 
		then
			return $?
		fi
		LTS="${LTS#lts/}" 
	fi
	VERSIONS="$( { command awk -v lts="${LTS-}" '{
        if (!$1) { next }
        if (lts && $10 ~ /^\-?$/) { next }
        if (lts && lts != "*" && tolower($10) !~ tolower(lts)) { next }
        if ($10 !~ /^\-?$/) {
          if ($10 && $10 != prev) {
            print $1, $10, "*"
          } else {
            print $1, $10
          }
        } else {
          print $1
        }
        prev=$10;
      }' \
    | nvm_grep -w "${PATTERN:-.*}" \
    | $SORT_COMMAND; } << EOF
$VERSION_LIST
EOF
)" 
	if [ -z "${VERSIONS}" ]
	then
		nvm_echo 'N/A'
		return 3
	fi
	nvm_echo "${VERSIONS}"
}
nvm_ls_remote_iojs () {
	NVM_LTS="${NVM_LTS-}" nvm_ls_remote_index_tab iojs std "${1-}"
}
nvm_make_alias () {
	local ALIAS
	ALIAS="${1-}" 
	if [ -z "${ALIAS}" ]
	then
		nvm_err "an alias name is required"
		return 1
	fi
	local VERSION
	VERSION="${2-}" 
	if [ -z "${VERSION}" ]
	then
		nvm_err "an alias target version is required"
		return 2
	fi
	nvm_echo "${VERSION}" | tee "$(nvm_alias_path)/${ALIAS}" > /dev/null
}
nvm_match_version () {
	local NVM_IOJS_PREFIX
	NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
	local PROVIDED_VERSION
	PROVIDED_VERSION="$1" 
	case "_${PROVIDED_VERSION}" in
		("_${NVM_IOJS_PREFIX}" | '_io.js') nvm_version "${NVM_IOJS_PREFIX}" ;;
		('_system') nvm_echo 'system' ;;
		(*) nvm_version "${PROVIDED_VERSION}" ;;
	esac
}
nvm_node_prefix () {
	nvm_echo 'node'
}
nvm_node_version_has_solaris_binary () {
	local NODE_VERSION
	NODE_VERSION="$1" 
	local STRIPPED_IOJS_VERSION
	STRIPPED_IOJS_VERSION="$(nvm_strip_iojs_prefix "${NODE_VERSION}")" 
	if [ "_${STRIPPED_IOJS_VERSION}" != "_${NODE_VERSION}" ]
	then
		return 1
	fi
	nvm_version_greater_than_or_equal_to "${NODE_VERSION}" v0.8.6 && ! nvm_version_greater_than_or_equal_to "${NODE_VERSION}" v1.0.0
}
nvm_normalize_lts () {
	local LTS
	LTS="${1-}" 
	case "${LTS}" in
		(lts/-[123456789] | lts/-[123456789][0123456789]*) local N
			N="$(echo "${LTS}" | cut -d '-' -f 2)" 
			N=$((N+1)) 
			if [ $? -ne 0 ]
			then
				nvm_echo "${LTS}"
				return 0
			fi
			local NVM_ALIAS_DIR
			NVM_ALIAS_DIR="$(nvm_alias_path)" 
			local RESULT
			RESULT="$(command ls "${NVM_ALIAS_DIR}/lts" | command tail -n "${N}" | command head -n 1)" 
			if [ "${RESULT}" != '*' ]
			then
				nvm_echo "lts/${RESULT}"
			else
				nvm_err 'That many LTS releases do not exist yet.'
				return 2
			fi ;;
		(*) if [ "${LTS}" != "$(echo "${LTS}" | command tr '[:upper:]' '[:lower:]')" ]
			then
				nvm_err 'LTS names must be lowercase'
				return 3
			fi
			nvm_echo "${LTS}" ;;
	esac
}
nvm_normalize_version () {
	command awk 'BEGIN {
    split(ARGV[1], a, /\./);
    printf "%d%06d%06d\n", a[1], a[2], a[3];
    exit;
  }' "${1#v}"
}
nvm_npm_global_modules () {
	local NPMLIST
	local VERSION
	VERSION="$1" 
	NPMLIST=$(nvm use "${VERSION}" >/dev/null && npm list -g --depth=0 2>/dev/null | command sed -e '1d' -e '/UNMET PEER DEPENDENCY/d') 
	local INSTALLS
	INSTALLS=$(nvm_echo "${NPMLIST}" | command sed -e '/ -> / d' -e '/\(empty\)/ d' -e 's/^.* \(.*@[^ ]*\).*/\1/' -e '/^npm@[^ ]*.*$/ d' -e '/^corepack@[^ ]*.*$/ d' | command xargs) 
	local LINKS
	LINKS="$(nvm_echo "${NPMLIST}" | command sed -n 's/.* -> \(.*\)/\1/ p')" 
	nvm_echo "${INSTALLS} //// ${LINKS}"
}
nvm_npmrc_bad_news_bears () {
	local NVM_NPMRC
	NVM_NPMRC="${1-}" 
	if [ -n "${NVM_NPMRC}" ] && [ -f "${NVM_NPMRC}" ] && nvm_grep -Ee '^(prefix|globalconfig) *=' < "${NVM_NPMRC}" > /dev/null
	then
		return 0
	fi
	return 1
}
nvm_num_version_groups () {
	local VERSION
	VERSION="${1-}" 
	VERSION="${VERSION#v}" 
	VERSION="${VERSION%.}" 
	if [ -z "${VERSION}" ]
	then
		nvm_echo "0"
		return
	fi
	local NVM_NUM_DOTS
	NVM_NUM_DOTS=$(nvm_echo "${VERSION}" | command sed -e 's/[^\.]//g') 
	local NVM_NUM_GROUPS
	NVM_NUM_GROUPS=".${NVM_NUM_DOTS}" 
	nvm_echo "${#NVM_NUM_GROUPS}"
}
nvm_nvmrc_invalid_msg () {
	local error_text
	error_text="invalid .nvmrc!
all non-commented content (anything after # is a comment) must be either:
  - a single bare nvm-recognized version-ish
  - or, multiple distinct key-value pairs, each key/value separated by a single equals sign (=)

additionally, a single bare nvm-recognized version-ish must be present (after stripping comments)." 
	local warn_text
	warn_text="non-commented content parsed:
${1}" 
	nvm_err "$(nvm_wrap_with_color_code 'r' "${error_text}")

$(nvm_wrap_with_color_code 'y' "${warn_text}")"
}
nvm_print_alias_path () {
	local NVM_ALIAS_DIR
	NVM_ALIAS_DIR="${1-}" 
	if [ -z "${NVM_ALIAS_DIR}" ]
	then
		nvm_err 'An alias dir is required.'
		return 1
	fi
	local ALIAS_PATH
	ALIAS_PATH="${2-}" 
	if [ -z "${ALIAS_PATH}" ]
	then
		nvm_err 'An alias path is required.'
		return 2
	fi
	local ALIAS
	ALIAS="${ALIAS_PATH##"${NVM_ALIAS_DIR}"\/}" 
	local DEST
	DEST="$(nvm_alias "${ALIAS}" 2>/dev/null)"  || :
	if [ -n "${DEST}" ]
	then
		NVM_NO_COLORS="${NVM_NO_COLORS-}" NVM_LTS="${NVM_LTS-}" DEFAULT=false nvm_print_formatted_alias "${ALIAS}" "${DEST}"
	fi
}
nvm_print_color_code () {
	case "${1-}" in
		('0') return 0 ;;
		('r') nvm_echo '0;31m' ;;
		('R') nvm_echo '1;31m' ;;
		('g') nvm_echo '0;32m' ;;
		('G') nvm_echo '1;32m' ;;
		('b') nvm_echo '0;34m' ;;
		('B') nvm_echo '1;34m' ;;
		('c') nvm_echo '0;36m' ;;
		('C') nvm_echo '1;36m' ;;
		('m') nvm_echo '0;35m' ;;
		('M') nvm_echo '1;35m' ;;
		('y') nvm_echo '0;33m' ;;
		('Y') nvm_echo '1;33m' ;;
		('k') nvm_echo '0;30m' ;;
		('K') nvm_echo '1;30m' ;;
		('e') nvm_echo '0;37m' ;;
		('W') nvm_echo '1;37m' ;;
		(*) nvm_err "Invalid color code: ${1-}"
			return 1 ;;
	esac
}
nvm_print_default_alias () {
	local ALIAS
	ALIAS="${1-}" 
	if [ -z "${ALIAS}" ]
	then
		nvm_err 'A default alias is required.'
		return 1
	fi
	local DEST
	DEST="$(nvm_print_implicit_alias local "${ALIAS}")" 
	if [ -n "${DEST}" ]
	then
		NVM_NO_COLORS="${NVM_NO_COLORS-}" DEFAULT=true nvm_print_formatted_alias "${ALIAS}" "${DEST}"
	fi
}
nvm_print_formatted_alias () {
	local ALIAS
	ALIAS="${1-}" 
	local DEST
	DEST="${2-}" 
	local VERSION
	VERSION="${3-}" 
	if [ -z "${VERSION}" ]
	then
		VERSION="$(nvm_version "${DEST}")"  || :
	fi
	local VERSION_FORMAT
	local ALIAS_FORMAT
	local DEST_FORMAT
	local INSTALLED_COLOR
	local SYSTEM_COLOR
	local CURRENT_COLOR
	local NOT_INSTALLED_COLOR
	local DEFAULT_COLOR
	local LTS_COLOR
	INSTALLED_COLOR=$(nvm_get_colors 1) 
	SYSTEM_COLOR=$(nvm_get_colors 2) 
	CURRENT_COLOR=$(nvm_get_colors 3) 
	NOT_INSTALLED_COLOR=$(nvm_get_colors 4) 
	DEFAULT_COLOR=$(nvm_get_colors 5) 
	LTS_COLOR=$(nvm_get_colors 6) 
	ALIAS_FORMAT='%s' 
	DEST_FORMAT='%s' 
	VERSION_FORMAT='%s' 
	local NEWLINE
	NEWLINE='\n' 
	if [ "_${DEFAULT}" = '_true' ]
	then
		NEWLINE=' (default)\n' 
	fi
	local ARROW
	ARROW='->' 
	if nvm_has_colors
	then
		ARROW='\033[0;90m->\033[0m' 
		if [ "_${DEFAULT}" = '_true' ]
		then
			NEWLINE=" \033[${DEFAULT_COLOR}(default)\033[0m\n" 
		fi
		if [ "_${VERSION}" = "_${NVM_CURRENT-}" ]
		then
			ALIAS_FORMAT="\033[${CURRENT_COLOR}%s\033[0m" 
			DEST_FORMAT="\033[${CURRENT_COLOR}%s\033[0m" 
			VERSION_FORMAT="\033[${CURRENT_COLOR}%s\033[0m" 
		elif nvm_is_version_installed "${VERSION}"
		then
			ALIAS_FORMAT="\033[${INSTALLED_COLOR}%s\033[0m" 
			DEST_FORMAT="\033[${INSTALLED_COLOR}%s\033[0m" 
			VERSION_FORMAT="\033[${INSTALLED_COLOR}%s\033[0m" 
		elif [ "${VERSION}" = '∞' ] || [ "${VERSION}" = 'N/A' ]
		then
			ALIAS_FORMAT="\033[${NOT_INSTALLED_COLOR}%s\033[0m" 
			DEST_FORMAT="\033[${NOT_INSTALLED_COLOR}%s\033[0m" 
			VERSION_FORMAT="\033[${NOT_INSTALLED_COLOR}%s\033[0m" 
		fi
		if [ "_${NVM_LTS-}" = '_true' ]
		then
			ALIAS_FORMAT="\033[${LTS_COLOR}%s\033[0m" 
		fi
		if [ "_${DEST%/*}" = "_lts" ]
		then
			DEST_FORMAT="\033[${LTS_COLOR}%s\033[0m" 
		fi
	elif [ "_${VERSION}" != '_∞' ] && [ "_${VERSION}" != '_N/A' ]
	then
		VERSION_FORMAT='%s *' 
	fi
	if [ "${DEST}" = "${VERSION}" ]
	then
		command printf -- "${ALIAS_FORMAT} ${ARROW} ${VERSION_FORMAT}${NEWLINE}" "${ALIAS}" "${DEST}"
	else
		command printf -- "${ALIAS_FORMAT} ${ARROW} ${DEST_FORMAT} (${ARROW} ${VERSION_FORMAT})${NEWLINE}" "${ALIAS}" "${DEST}" "${VERSION}"
	fi
}
nvm_print_implicit_alias () {
	if [ "_$1" != "_local" ] && [ "_$1" != "_remote" ]
	then
		nvm_err "nvm_print_implicit_alias must be specified with local or remote as the first argument."
		return 1
	fi
	local NVM_IMPLICIT
	NVM_IMPLICIT="$2" 
	if ! nvm_validate_implicit_alias "${NVM_IMPLICIT}"
	then
		return 2
	fi
	local NVM_IOJS_PREFIX
	NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
	local NVM_NODE_PREFIX
	NVM_NODE_PREFIX="$(nvm_node_prefix)" 
	local NVM_COMMAND
	local NVM_ADD_PREFIX_COMMAND
	local LAST_TWO
	case "${NVM_IMPLICIT}" in
		("${NVM_IOJS_PREFIX}") NVM_COMMAND="nvm_ls_remote_iojs" 
			NVM_ADD_PREFIX_COMMAND="nvm_add_iojs_prefix" 
			if [ "_$1" = "_local" ]
			then
				NVM_COMMAND="nvm_ls ${NVM_IMPLICIT}" 
			fi
			nvm_is_zsh && setopt local_options shwordsplit
			local NVM_IOJS_VERSION
			local EXIT_CODE
			NVM_IOJS_VERSION="$(${NVM_COMMAND})"  && :
			EXIT_CODE="$?" 
			if [ "_${EXIT_CODE}" = "_0" ]
			then
				NVM_IOJS_VERSION="$(nvm_echo "${NVM_IOJS_VERSION}" | command sed "s/^${NVM_IMPLICIT}-//" | nvm_grep -e '^v' | command cut -c2- | command cut -d . -f 1,2 | uniq | command tail -1)" 
			fi
			if [ "_$NVM_IOJS_VERSION" = "_N/A" ]
			then
				nvm_echo 'N/A'
			else
				${NVM_ADD_PREFIX_COMMAND} "${NVM_IOJS_VERSION}"
			fi
			return $EXIT_CODE ;;
		("${NVM_NODE_PREFIX}") nvm_echo 'stable'
			return ;;
		(*) NVM_COMMAND="nvm_ls_remote" 
			if [ "_$1" = "_local" ]
			then
				NVM_COMMAND="nvm_ls node" 
			fi
			nvm_is_zsh && setopt local_options shwordsplit
			LAST_TWO=$($NVM_COMMAND | nvm_grep -e '^v' | command cut -c2- | command cut -d . -f 1,2 | uniq)  ;;
	esac
	local MINOR
	local STABLE
	local UNSTABLE
	local MOD
	local NORMALIZED_VERSION
	nvm_is_zsh && setopt local_options shwordsplit
	for MINOR in $LAST_TWO
	do
		NORMALIZED_VERSION="$(nvm_normalize_version "$MINOR")" 
		if [ "_0${NORMALIZED_VERSION#?}" != "_$NORMALIZED_VERSION" ]
		then
			STABLE="$MINOR" 
		else
			MOD="$(awk 'BEGIN { print int(ARGV[1] / 1000000) % 2 ; exit(0) }' "${NORMALIZED_VERSION}")" 
			if [ "${MOD}" -eq 0 ]
			then
				STABLE="${MINOR}" 
			elif [ "${MOD}" -eq 1 ]
			then
				UNSTABLE="${MINOR}" 
			fi
		fi
	done
	if [ "_$2" = '_stable' ]
	then
		nvm_echo "${STABLE}"
	elif [ "_$2" = '_unstable' ]
	then
		nvm_echo "${UNSTABLE:-"N/A"}"
	fi
}
nvm_print_npm_version () {
	if nvm_has "npm"
	then
		local NPM_VERSION
		NPM_VERSION="$(npm --version 2>/dev/null)" 
		if [ -n "${NPM_VERSION}" ]
		then
			command printf " (npm v${NPM_VERSION})"
		fi
	fi
}
nvm_print_versions () {
	local NVM_CURRENT
	NVM_CURRENT=$(nvm_ls_current) 
	local INSTALLED_COLOR
	local SYSTEM_COLOR
	local CURRENT_COLOR
	local NOT_INSTALLED_COLOR
	local DEFAULT_COLOR
	local LTS_COLOR
	local NVM_HAS_COLORS
	NVM_HAS_COLORS=0 
	INSTALLED_COLOR=$(nvm_get_colors 1) 
	SYSTEM_COLOR=$(nvm_get_colors 2) 
	CURRENT_COLOR=$(nvm_get_colors 3) 
	NOT_INSTALLED_COLOR=$(nvm_get_colors 4) 
	DEFAULT_COLOR=$(nvm_get_colors 5) 
	LTS_COLOR=$(nvm_get_colors 6) 
	if nvm_has_colors
	then
		NVM_HAS_COLORS=1 
	fi
	command awk -v remote_versions="$(printf '%s' "${1-}" | tr '\n' '|')" -v installed_versions="$(nvm_ls | tr '\n' '|')" -v current="$NVM_CURRENT" -v installed_color="$INSTALLED_COLOR" -v system_color="$SYSTEM_COLOR" -v current_color="$CURRENT_COLOR" -v default_color="$DEFAULT_COLOR" -v old_lts_color="$DEFAULT_COLOR" -v has_colors="$NVM_HAS_COLORS" '
function alen(arr, i, len) { len=0; for(i in arr) len++; return len; }
BEGIN {
  fmt_installed = has_colors ? (installed_color ? "\033[" installed_color "%15s\033[0m" : "%15s") : "%15s *";
  fmt_system = has_colors ? (system_color ? "\033[" system_color "%15s\033[0m" : "%15s") : "%15s *";
  fmt_current = has_colors ? (current_color ? "\033[" current_color "->%13s\033[0m" : "%15s") : "->%13s *";

  latest_lts_color = current_color;
  sub(/0;/, "1;", latest_lts_color);

  fmt_latest_lts = has_colors && latest_lts_color ? ("\033[" latest_lts_color " (Latest LTS: %s)\033[0m") : " (Latest LTS: %s)";
  fmt_old_lts = has_colors && old_lts_color ? ("\033[" old_lts_color " (LTS: %s)\033[0m") : " (LTS: %s)";

  split(remote_versions, lines, "|");
  split(installed_versions, installed, "|");
  rows = alen(lines);

  for (n = 1; n <= rows; n++) {
    split(lines[n], fields, "[[:blank:]]+");
    cols = alen(fields);
    version = fields[1];
    is_installed = 0;

    for (i in installed) {
      if (version == installed[i]) {
        is_installed = 1;
        break;
      }
    }

    fmt_version = "%15s";
    if (version == current) {
      fmt_version = fmt_current;
    } else if (version == "system") {
      fmt_version = fmt_system;
    } else if (is_installed) {
      fmt_version = fmt_installed;
    }

    padding = (!has_colors && is_installed) ? "" : "  ";

    if (cols == 1) {
      formatted = sprintf(fmt_version, version);
    } else if (cols == 2) {
      formatted = sprintf((fmt_version padding fmt_old_lts), version, fields[2]);
    } else if (cols == 3 && fields[3] == "*") {
      formatted = sprintf((fmt_version padding fmt_latest_lts), version, fields[2]);
    }

    output[n] = formatted;
  }

  for (n = 1; n <= rows; n++) {
    print output[n]
  }

  exit
}'
}
nvm_process_nvmrc () {
	local NVMRC_PATH
	NVMRC_PATH="$1" 
	local lines
	lines=$(command sed 's/#.*//' "$NVMRC_PATH" | command sed 's/^[[:space:]]*//;s/[[:space:]]*$//' | nvm_grep -v '^$') 
	if [ -z "$lines" ]
	then
		nvm_nvmrc_invalid_msg "${lines}"
		return 1
	fi
	local keys
	keys='' 
	local values
	values='' 
	local unpaired_line
	unpaired_line='' 
	while IFS= read -r line
	do
		if [ -z "${line}" ]
		then
			continue
		elif [ -z "${line%%=*}" ]
		then
			if [ -n "${unpaired_line}" ]
			then
				nvm_nvmrc_invalid_msg "${lines}"
				return 1
			fi
			unpaired_line="${line}" 
		elif case "$line" in
				(*'='*) true ;;
				(*) false ;;
			esac
		then
			key="${line%%=*}" 
			value="${line#*=}" 
			key=$(nvm_echo "${key}" | command sed 's/^[[:space:]]*//;s/[[:space:]]*$//') 
			value=$(nvm_echo "${value}" | command sed 's/^[[:space:]]*//;s/[[:space:]]*$//') 
			if [ "${key}" = 'node' ]
			then
				nvm_nvmrc_invalid_msg "${lines}"
				return 1
			fi
			if nvm_echo "${keys}" | nvm_grep -q -E "(^| )${key}( |$)"
			then
				nvm_nvmrc_invalid_msg "${lines}"
				return 1
			fi
			keys="${keys} ${key}" 
			values="${values} ${value}" 
		else
			if [ -n "${unpaired_line}" ]
			then
				nvm_nvmrc_invalid_msg "${lines}"
				return 1
			fi
			unpaired_line="${line}" 
		fi
	done <<EOF
$lines
EOF
	if [ -z "${unpaired_line}" ]
	then
		nvm_nvmrc_invalid_msg "${lines}"
		return 1
	fi
	nvm_echo "${unpaired_line}"
}
nvm_process_parameters () {
	local NVM_AUTO_MODE
	NVM_AUTO_MODE='use' 
	while [ "$#" -ne 0 ]
	do
		case "$1" in
			(--install) NVM_AUTO_MODE='install'  ;;
			(--no-use) NVM_AUTO_MODE='none'  ;;
		esac
		shift
	done
	nvm_auto "${NVM_AUTO_MODE}"
}
nvm_prompt_info () {
	which nvm &> /dev/null || return
	local nvm_prompt=${$(nvm current)#v} 
	echo "${ZSH_THEME_NVM_PROMPT_PREFIX}${nvm_prompt:gs/%/%%}${ZSH_THEME_NVM_PROMPT_SUFFIX}"
}
nvm_rc_version () {
	export NVM_RC_VERSION='' 
	local NVMRC_PATH
	NVMRC_PATH="$(nvm_find_nvmrc)" 
	if [ ! -e "${NVMRC_PATH}" ]
	then
		if [ "${NVM_SILENT:-0}" -ne 1 ]
		then
			nvm_err "No .nvmrc file found"
		fi
		return 1
	fi
	if ! NVM_RC_VERSION="$(nvm_process_nvmrc "${NVMRC_PATH}")" 
	then
		return 1
	fi
	if [ -z "${NVM_RC_VERSION}" ]
	then
		if [ "${NVM_SILENT:-0}" -ne 1 ]
		then
			nvm_err "Warning: empty .nvmrc file found at \"${NVMRC_PATH}\""
		fi
		return 2
	fi
	if [ "${NVM_SILENT:-0}" -ne 1 ]
	then
		nvm_echo "Found '${NVMRC_PATH}' with version <${NVM_RC_VERSION}>"
	fi
}
nvm_remote_version () {
	local PATTERN
	PATTERN="${1-}" 
	local VERSION
	if nvm_validate_implicit_alias "${PATTERN}" 2> /dev/null
	then
		case "${PATTERN}" in
			("$(nvm_iojs_prefix)") VERSION="$(NVM_LTS="${NVM_LTS-}" nvm_ls_remote_iojs | command tail -1)"  && : ;;
			(*) VERSION="$(NVM_LTS="${NVM_LTS-}" nvm_ls_remote "${PATTERN}")"  && : ;;
		esac
	else
		VERSION="$(NVM_LTS="${NVM_LTS-}" nvm_remote_versions "${PATTERN}" | command tail -1)" 
	fi
	if [ -n "${NVM_VERSION_ONLY-}" ]
	then
		command awk 'BEGIN {
      n = split(ARGV[1], a);
      print a[1]
    }' "${VERSION}"
	else
		nvm_echo "${VERSION}"
	fi
	if [ "${VERSION}" = 'N/A' ]
	then
		return 3
	fi
}
nvm_remote_versions () {
	local NVM_IOJS_PREFIX
	NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
	local NVM_NODE_PREFIX
	NVM_NODE_PREFIX="$(nvm_node_prefix)" 
	local PATTERN
	PATTERN="${1-}" 
	local NVM_FLAVOR
	if [ -n "${NVM_LTS-}" ]
	then
		NVM_FLAVOR="${NVM_NODE_PREFIX}" 
	fi
	case "${PATTERN}" in
		("${NVM_IOJS_PREFIX}" | "io.js") NVM_FLAVOR="${NVM_IOJS_PREFIX}" 
			unset PATTERN ;;
		("${NVM_NODE_PREFIX}") NVM_FLAVOR="${NVM_NODE_PREFIX}" 
			unset PATTERN ;;
	esac
	if nvm_validate_implicit_alias "${PATTERN-}" 2> /dev/null
	then
		nvm_err 'Implicit aliases are not supported in nvm_remote_versions.'
		return 1
	fi
	local NVM_LS_REMOTE_EXIT_CODE
	NVM_LS_REMOTE_EXIT_CODE=0 
	local NVM_LS_REMOTE_PRE_MERGED_OUTPUT
	NVM_LS_REMOTE_PRE_MERGED_OUTPUT='' 
	local NVM_LS_REMOTE_POST_MERGED_OUTPUT
	NVM_LS_REMOTE_POST_MERGED_OUTPUT='' 
	if [ -z "${NVM_FLAVOR-}" ] || [ "${NVM_FLAVOR-}" = "${NVM_NODE_PREFIX}" ]
	then
		local NVM_LS_REMOTE_OUTPUT
		NVM_LS_REMOTE_OUTPUT="$(NVM_LTS="${NVM_LTS-}" nvm_ls_remote "${PATTERN-}") "  && :
		NVM_LS_REMOTE_EXIT_CODE=$? 
		NVM_LS_REMOTE_PRE_MERGED_OUTPUT="${NVM_LS_REMOTE_OUTPUT%%v4\.0\.0*}" 
		NVM_LS_REMOTE_POST_MERGED_OUTPUT="${NVM_LS_REMOTE_OUTPUT#"$NVM_LS_REMOTE_PRE_MERGED_OUTPUT"}" 
	fi
	local NVM_LS_REMOTE_IOJS_EXIT_CODE
	NVM_LS_REMOTE_IOJS_EXIT_CODE=0 
	local NVM_LS_REMOTE_IOJS_OUTPUT
	NVM_LS_REMOTE_IOJS_OUTPUT='' 
	if [ -z "${NVM_LTS-}" ] && {
			[ -z "${NVM_FLAVOR-}" ] || [ "${NVM_FLAVOR-}" = "${NVM_IOJS_PREFIX}" ]
		}
	then
		NVM_LS_REMOTE_IOJS_OUTPUT=$(nvm_ls_remote_iojs "${PATTERN-}")  && :
		NVM_LS_REMOTE_IOJS_EXIT_CODE=$? 
	fi
	VERSIONS="$(nvm_echo "${NVM_LS_REMOTE_PRE_MERGED_OUTPUT}
${NVM_LS_REMOTE_IOJS_OUTPUT}
${NVM_LS_REMOTE_POST_MERGED_OUTPUT}" | nvm_grep -v "N/A" | command sed '/^ *$/d')" 
	if [ -z "${VERSIONS}" ]
	then
		nvm_echo 'N/A'
		return 3
	fi
	nvm_echo "${VERSIONS}" | command sed 's/ *$//g'
	return $NVM_LS_REMOTE_EXIT_CODE || $NVM_LS_REMOTE_IOJS_EXIT_CODE
}
nvm_resolve_alias () {
	if [ -z "${1-}" ]
	then
		return 1
	fi
	local PATTERN
	PATTERN="${1-}" 
	local ALIAS
	ALIAS="${PATTERN}" 
	local ALIAS_TEMP
	local SEEN_ALIASES
	SEEN_ALIASES="${ALIAS}" 
	local NVM_ALIAS_INDEX
	NVM_ALIAS_INDEX=1 
	while true
	do
		ALIAS_TEMP="$( (nvm_alias "${ALIAS}" 2>/dev/null | command head -n "${NVM_ALIAS_INDEX}" | command tail -n 1) || nvm_echo)" 
		if [ -z "${ALIAS_TEMP}" ]
		then
			break
		fi
		if command printf "${SEEN_ALIASES}" | nvm_grep -q -e "^${ALIAS_TEMP}$"
		then
			ALIAS="∞" 
			break
		fi
		SEEN_ALIASES="${SEEN_ALIASES}\\n${ALIAS_TEMP}" 
		ALIAS="${ALIAS_TEMP}" 
	done
	if [ -n "${ALIAS}" ] && [ "_${ALIAS}" != "_${PATTERN}" ]
	then
		local NVM_IOJS_PREFIX
		NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
		local NVM_NODE_PREFIX
		NVM_NODE_PREFIX="$(nvm_node_prefix)" 
		case "${ALIAS}" in
			('∞' | "${NVM_IOJS_PREFIX}" | "${NVM_IOJS_PREFIX}-" | "${NVM_NODE_PREFIX}") nvm_echo "${ALIAS}" ;;
			(*) nvm_ensure_version_prefix "${ALIAS}" ;;
		esac
		return 0
	fi
	if nvm_validate_implicit_alias "${PATTERN}" 2> /dev/null
	then
		local IMPLICIT
		IMPLICIT="$(nvm_print_implicit_alias local "${PATTERN}" 2>/dev/null)" 
		if [ -n "${IMPLICIT}" ]
		then
			nvm_ensure_version_prefix "${IMPLICIT}"
		fi
	fi
	return 2
}
nvm_resolve_local_alias () {
	if [ -z "${1-}" ]
	then
		return 1
	fi
	local VERSION
	local EXIT_CODE
	VERSION="$(nvm_resolve_alias "${1-}")" 
	EXIT_CODE=$? 
	if [ -z "${VERSION}" ]
	then
		return $EXIT_CODE
	fi
	if [ "_${VERSION}" != '_∞' ]
	then
		nvm_version "${VERSION}"
	else
		nvm_echo "${VERSION}"
	fi
}
nvm_sanitize_auth_header () {
	nvm_echo "$1" | command sed 's/[^a-zA-Z0-9:;_. -]//g'
}
nvm_sanitize_path () {
	local SANITIZED_PATH
	SANITIZED_PATH="${1-}" 
	if [ "_${SANITIZED_PATH}" != "_${NVM_DIR}" ]
	then
		SANITIZED_PATH="$(nvm_echo "${SANITIZED_PATH}" | command sed -e "s#${NVM_DIR}#\${NVM_DIR}#g")" 
	fi
	if [ "_${SANITIZED_PATH}" != "_${HOME}" ]
	then
		SANITIZED_PATH="$(nvm_echo "${SANITIZED_PATH}" | command sed -e "s#${HOME}#\${HOME}#g")" 
	fi
	nvm_echo "${SANITIZED_PATH}"
}
nvm_set_colors () {
	if [ "${#1}" -eq 5 ] && nvm_echo "$1" | nvm_grep -E "^[rRgGbBcCyYmMkKeW]{1,}$" > /dev/null
	then
		local INSTALLED_COLOR
		local LTS_AND_SYSTEM_COLOR
		local CURRENT_COLOR
		local NOT_INSTALLED_COLOR
		local DEFAULT_COLOR
		INSTALLED_COLOR="$(echo "$1" | awk '{ print substr($0, 1, 1); }')" 
		LTS_AND_SYSTEM_COLOR="$(echo "$1" | awk '{ print substr($0, 2, 1); }')" 
		CURRENT_COLOR="$(echo "$1" | awk '{ print substr($0, 3, 1); }')" 
		NOT_INSTALLED_COLOR="$(echo "$1" | awk '{ print substr($0, 4, 1); }')" 
		DEFAULT_COLOR="$(echo "$1" | awk '{ print substr($0, 5, 1); }')" 
		if ! nvm_has_colors
		then
			nvm_echo "Setting colors to: ${INSTALLED_COLOR} ${LTS_AND_SYSTEM_COLOR} ${CURRENT_COLOR} ${NOT_INSTALLED_COLOR} ${DEFAULT_COLOR}"
			nvm_echo "WARNING: Colors may not display because they are not supported in this shell."
		else
			nvm_echo_with_colors "Setting colors to: $(nvm_wrap_with_color_code "${INSTALLED_COLOR}" "${INSTALLED_COLOR}")$(nvm_wrap_with_color_code "${LTS_AND_SYSTEM_COLOR}" "${LTS_AND_SYSTEM_COLOR}")$(nvm_wrap_with_color_code "${CURRENT_COLOR}" "${CURRENT_COLOR}")$(nvm_wrap_with_color_code "${NOT_INSTALLED_COLOR}" "${NOT_INSTALLED_COLOR}")$(nvm_wrap_with_color_code "${DEFAULT_COLOR}" "${DEFAULT_COLOR}")"
		fi
		export NVM_COLORS="$1" 
	else
		return 17
	fi
}
nvm_stdout_is_terminal () {
	[ -t 1 ]
}
nvm_strip_iojs_prefix () {
	local NVM_IOJS_PREFIX
	NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
	case "${1-}" in
		("${NVM_IOJS_PREFIX}") nvm_echo ;;
		(*) nvm_echo "${1#"${NVM_IOJS_PREFIX}"-}" ;;
	esac
}
nvm_strip_path () {
	if [ -z "${NVM_DIR-}" ]
	then
		nvm_err '${NVM_DIR} not set!'
		return 1
	fi
	command printf %s "${1-}" | command awk -v NVM_DIR="${NVM_DIR}" -v RS=: '
  index($0, NVM_DIR) == 1 {
    path = substr($0, length(NVM_DIR) + 1)
    if (path ~ "^(/versions/[^/]*)?/[^/]*'"${2-}"'.*$") { next }
  }
  # The final RT will contain a colon if the input has a trailing colon, or a null string otherwise
  { printf "%s%s", sep, $0; sep=RS } END { printf "%s", RT }'
}
nvm_supports_xz () {
	if [ -z "${1-}" ]
	then
		return 1
	fi
	local NVM_OS
	NVM_OS="$(nvm_get_os)" 
	if [ "_${NVM_OS}" = '_darwin' ]
	then
		local MACOS_VERSION
		MACOS_VERSION="$(sw_vers -productVersion)" 
		if nvm_version_greater "10.9.0" "${MACOS_VERSION}"
		then
			return 1
		fi
	elif [ "_${NVM_OS}" = '_freebsd' ]
	then
		if ! [ -e '/usr/lib/liblzma.so' ]
		then
			return 1
		fi
	else
		if ! command which xz > /dev/null 2>&1
		then
			return 1
		fi
	fi
	if nvm_is_merged_node_version "${1}"
	then
		return 0
	fi
	if nvm_version_greater_than_or_equal_to "${1}" "0.12.10" && nvm_version_greater "0.13.0" "${1}"
	then
		return 0
	fi
	if nvm_version_greater_than_or_equal_to "${1}" "0.10.42" && nvm_version_greater "0.11.0" "${1}"
	then
		return 0
	fi
	case "${NVM_OS}" in
		(darwin) nvm_version_greater_than_or_equal_to "${1}" "2.3.2" ;;
		(*) nvm_version_greater_than_or_equal_to "${1}" "1.0.0" ;;
	esac
	return $?
}
nvm_tree_contains_path () {
	local tree
	tree="${1-}" 
	local node_path
	node_path="${2-}" 
	if [ "@${tree}@" = "@@" ] || [ "@${node_path}@" = "@@" ]
	then
		nvm_err "both the tree and the node path are required"
		return 2
	fi
	local previous_pathdir
	previous_pathdir="${node_path}" 
	local pathdir
	pathdir=$(dirname "${previous_pathdir}") 
	while [ "${pathdir}" != '' ] && [ "${pathdir}" != '.' ] && [ "${pathdir}" != '/' ] && [ "${pathdir}" != "${tree}" ] && [ "${pathdir}" != "${previous_pathdir}" ]
	do
		previous_pathdir="${pathdir}" 
		pathdir=$(dirname "${previous_pathdir}") 
	done
	[ "${pathdir}" = "${tree}" ]
}
nvm_use_if_needed () {
	if [ "_${1-}" = "_$(nvm_ls_current)" ]
	then
		return
	fi
	nvm use "$@"
}
nvm_validate_implicit_alias () {
	local NVM_IOJS_PREFIX
	NVM_IOJS_PREFIX="$(nvm_iojs_prefix)" 
	local NVM_NODE_PREFIX
	NVM_NODE_PREFIX="$(nvm_node_prefix)" 
	case "$1" in
		("stable" | "unstable" | "${NVM_IOJS_PREFIX}" | "${NVM_NODE_PREFIX}") return ;;
		(*) nvm_err "Only implicit aliases 'stable', 'unstable', '${NVM_IOJS_PREFIX}', and '${NVM_NODE_PREFIX}' are supported."
			return 1 ;;
	esac
}
nvm_version () {
	local PATTERN
	PATTERN="${1-}" 
	local VERSION
	if [ -z "${PATTERN}" ]
	then
		PATTERN='current' 
	fi
	if [ "${PATTERN}" = "current" ]
	then
		nvm_ls_current
		return $?
	fi
	local NVM_NODE_PREFIX
	NVM_NODE_PREFIX="$(nvm_node_prefix)" 
	case "_${PATTERN}" in
		("_${NVM_NODE_PREFIX}" | "_${NVM_NODE_PREFIX}-") PATTERN="stable"  ;;
	esac
	VERSION="$(nvm_ls "${PATTERN}" | command tail -1)" 
	if [ -z "${VERSION}" ] || [ "_${VERSION}" = "_N/A" ]
	then
		nvm_echo "N/A"
		return 3
	fi
	nvm_echo "${VERSION}"
}
nvm_version_dir () {
	local NVM_WHICH_DIR
	NVM_WHICH_DIR="${1-}" 
	if [ -z "${NVM_WHICH_DIR}" ] || [ "${NVM_WHICH_DIR}" = "new" ]
	then
		nvm_echo "${NVM_DIR}/versions/node"
	elif [ "_${NVM_WHICH_DIR}" = "_iojs" ]
	then
		nvm_echo "${NVM_DIR}/versions/io.js"
	elif [ "_${NVM_WHICH_DIR}" = "_old" ]
	then
		nvm_echo "${NVM_DIR}"
	else
		nvm_err 'unknown version dir'
		return 3
	fi
}
nvm_version_greater () {
	command awk 'BEGIN {
    if (ARGV[1] == "" || ARGV[2] == "") exit(1)
    split(ARGV[1], a, /\./);
    split(ARGV[2], b, /\./);
    for (i=1; i<=3; i++) {
      if (a[i] && a[i] !~ /^[0-9]+$/) exit(2);
      if (b[i] && b[i] !~ /^[0-9]+$/) { exit(0); }
      if (a[i] < b[i]) exit(3);
      else if (a[i] > b[i]) exit(0);
    }
    exit(4)
  }' "${1#v}" "${2#v}"
}
nvm_version_greater_than_or_equal_to () {
	command awk 'BEGIN {
    if (ARGV[1] == "" || ARGV[2] == "") exit(1)
    split(ARGV[1], a, /\./);
    split(ARGV[2], b, /\./);
    for (i=1; i<=3; i++) {
      if (a[i] && a[i] !~ /^[0-9]+$/) exit(2);
      if (a[i] < b[i]) exit(3);
      else if (a[i] > b[i]) exit(0);
    }
    exit(0)
  }' "${1#v}" "${2#v}"
}
nvm_version_path () {
	local VERSION
	VERSION="${1-}" 
	if [ -z "${VERSION}" ]
	then
		nvm_err 'version is required'
		return 3
	elif nvm_is_iojs_version "${VERSION}"
	then
		nvm_echo "$(nvm_version_dir iojs)/$(nvm_strip_iojs_prefix "${VERSION}")"
	elif nvm_version_greater 0.12.0 "${VERSION}"
	then
		nvm_echo "$(nvm_version_dir old)/${VERSION}"
	else
		nvm_echo "$(nvm_version_dir new)/${VERSION}"
	fi
}
nvm_wrap_with_color_code () {
	local CODE
	CODE="$(nvm_print_color_code "${1}" 2>/dev/null ||:)" 
	local TEXT
	TEXT="${2-}" 
	if nvm_has_colors && [ -n "${CODE}" ]
	then
		nvm_echo_with_colors "\033[${CODE}${TEXT}\033[0m"
	else
		nvm_echo "${TEXT}"
	fi
}
nvm_write_nvmrc () {
	local VERSION_STRING
	VERSION_STRING=$(nvm_version "${1-}") 
	if [ "${VERSION_STRING}" = '∞' ] || [ "${VERSION_STRING}" = 'N/A' ]
	then
		return 1
	fi
	echo "${VERSION_STRING}" | tee "$PWD"/.nvmrc > /dev/null || {
		if [ "${NVM_SILENT:-0}" -ne 1 ]
		then
			nvm_err "Warning: Unable to write version number ($VERSION_STRING) to .nvmrc"
		fi
		return 3
	}
	if [ "${NVM_SILENT:-0}" -ne 1 ]
	then
		nvm_echo "Wrote version number ($VERSION_STRING) to .nvmrc"
	fi
}
omz () {
	setopt localoptions noksharrays
	[[ $# -gt 0 ]] || {
		_omz::help
		return 1
	}
	local command="$1" 
	shift
	(( ${+functions[_omz::$command]} )) || {
		_omz::help
		return 1
	}
	_omz::$command "$@"
}
omz_diagnostic_dump () {
	emulate -L zsh
	builtin echo "Generating diagnostic dump; please be patient..."
	local thisfcn=omz_diagnostic_dump 
	local -A opts
	local opt_verbose opt_noverbose opt_outfile
	local timestamp=$(date +%Y%m%d-%H%M%S) 
	local outfile=omz_diagdump_$timestamp.txt 
	builtin zparseopts -A opts -D -- "v+=opt_verbose" "V+=opt_noverbose"
	local verbose n_verbose=${#opt_verbose} n_noverbose=${#opt_noverbose} 
	(( verbose = 1 + n_verbose - n_noverbose ))
	if [[ ${#*} > 0 ]]
	then
		opt_outfile=$1 
	fi
	if [[ ${#*} > 1 ]]
	then
		builtin echo "$thisfcn: error: too many arguments" >&2
		return 1
	fi
	if [[ -n "$opt_outfile" ]]
	then
		outfile="$opt_outfile" 
	fi
	_omz_diag_dump_one_big_text &> "$outfile"
	if [[ $? != 0 ]]
	then
		builtin echo "$thisfcn: error while creating diagnostic dump; see $outfile for details"
	fi
	builtin echo
	builtin echo Diagnostic dump file created at: "$outfile"
	builtin echo
	builtin echo To share this with OMZ developers, post it as a gist on GitHub
	builtin echo at "https://gist.github.com" and share the link to the gist.
	builtin echo
	builtin echo "WARNING: This dump file contains all your zsh and omz configuration files,"
	builtin echo "so don't share it publicly if there's sensitive information in them."
	builtin echo
}
omz_history () {
	local clear list stamp REPLY
	zparseopts -E -D c=clear l=list f=stamp E=stamp i=stamp t:=stamp
	if [[ -n "$clear" ]]
	then
		print -nu2 "This action will irreversibly delete your command history. Are you sure? [y/N] "
		builtin read -E
		[[ "$REPLY" = [yY] ]] || return 0
		print -nu2 >| "$HISTFILE"
		fc -p "$HISTFILE"
		print -u2 History file deleted.
	elif [[ $# -eq 0 ]]
	then
		builtin fc "${stamp[@]}" -l 1
	else
		builtin fc "${stamp[@]}" -l "$@"
	fi
}
omz_termsupport_cwd () {
	setopt localoptions unset
	local URL_HOST URL_PATH
	URL_HOST="$(omz_urlencode -P $HOST)"  || return 1
	URL_PATH="$(omz_urlencode -P $PWD)"  || return 1
	[[ -z "$KONSOLE_PROFILE_NAME" && -z "$KONSOLE_DBUS_SESSION" ]] || URL_HOST="" 
	printf "\e]7;file://%s%s\e\\" "${URL_HOST}" "${URL_PATH}"
}
omz_termsupport_precmd () {
	[[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return 0
	title "$ZSH_THEME_TERM_TAB_TITLE_IDLE" "$ZSH_THEME_TERM_TITLE_IDLE"
}
omz_termsupport_preexec () {
	[[ "${DISABLE_AUTO_TITLE:-}" != true ]] || return 0
	emulate -L zsh
	setopt extended_glob
	local -a cmdargs
	cmdargs=("${(z)2}") 
	if [[ "${cmdargs[1]}" = fg ]]
	then
		local job_id jobspec="${cmdargs[2]#%}" 
		case "$jobspec" in
			(<->) job_id=${jobspec}  ;;
			("" | % | +) job_id=${(k)jobstates[(r)*:+:*]}  ;;
			(-) job_id=${(k)jobstates[(r)*:-:*]}  ;;
			([?]*) job_id=${(k)jobtexts[(r)*${(Q)jobspec}*]}  ;;
			(*) job_id=${(k)jobtexts[(r)${(Q)jobspec}*]}  ;;
		esac
		if [[ -n "${jobtexts[$job_id]}" ]]
		then
			1="${jobtexts[$job_id]}" 
			2="${jobtexts[$job_id]}" 
		fi
	fi
	local CMD="${1[(wr)^(*=*|sudo|ssh|mosh|rake|-*)]:gs/%/%%}" 
	local LINE="${2:gs/%/%%}" 
	title "$CMD" "%100>...>${LINE}%<<"
}
omz_urldecode () {
	emulate -L zsh
	local encoded_url=$1 
	local caller_encoding=$langinfo[CODESET] 
	local LC_ALL=C 
	export LC_ALL
	local tmp=${encoded_url:gs/+/ /} 
	tmp=${tmp:gs/\\/\\\\/} 
	tmp=${tmp:gs/%/\\x/} 
	local decoded="$(printf -- "$tmp")" 
	local -a safe_encodings
	safe_encodings=(UTF-8 utf8 US-ASCII) 
	if [[ -z ${safe_encodings[(r)$caller_encoding]} ]]
	then
		decoded=$(echo -E "$decoded" | iconv -f UTF-8 -t $caller_encoding) 
		if [[ $? != 0 ]]
		then
			echo "Error converting string from UTF-8 to $caller_encoding" >&2
			return 1
		fi
	fi
	echo -E "$decoded"
}
omz_urlencode () {
	emulate -L zsh
	setopt norematchpcre
	local -a opts
	zparseopts -D -E -a opts r m P
	local in_str="$@" 
	local url_str="" 
	local spaces_as_plus
	if [[ -z $opts[(r)-P] ]]
	then
		spaces_as_plus=1 
	fi
	local str="$in_str" 
	local encoding=$langinfo[CODESET] 
	local safe_encodings
	safe_encodings=(UTF-8 utf8 US-ASCII) 
	if [[ -z ${safe_encodings[(r)$encoding]} ]]
	then
		str=$(echo -E "$str" | iconv -f $encoding -t UTF-8) 
		if [[ $? != 0 ]]
		then
			echo "Error converting string from $encoding to UTF-8" >&2
			return 1
		fi
	fi
	local i byte ord LC_ALL=C 
	export LC_ALL
	local reserved=';/?:@&=+$,' 
	local mark='_.!~*''()-' 
	local dont_escape="[A-Za-z0-9" 
	if [[ -z $opts[(r)-r] ]]
	then
		dont_escape+=$reserved 
	fi
	if [[ -z $opts[(r)-m] ]]
	then
		dont_escape+=$mark 
	fi
	dont_escape+="]" 
	local url_str="" 
	for ((i = 1; i <= ${#str}; ++i )) do
		byte="$str[i]" 
		if [[ "$byte" =~ "$dont_escape" ]]
		then
			url_str+="$byte" 
		else
			if [[ "$byte" == " " && -n $spaces_as_plus ]]
			then
				url_str+="+" 
			elif [[ "$PREFIX" = *com.termux* ]]
			then
				url_str+="$byte" 
			else
				ord=$(( [##16] #byte )) 
				url_str+="%$ord" 
			fi
		fi
	done
	echo -E "$url_str"
}
open () {
	xdg-open "$@" > /dev/null 2>&1 &
}
open_command () {
	local open_cmd
	case "$OSTYPE" in
		(darwin*) open_cmd='open'  ;;
		(cygwin*) open_cmd='cygstart'  ;;
		(linux*) [[ "$(uname -r)" != *icrosoft* ]] && open_cmd='nohup xdg-open'  || {
				open_cmd='cmd.exe /c start ""' 
				[[ -e "$1" ]] && {
					1="$(wslpath -w "${1:a}")"  || return 1
				}
				[[ "$1" = (http|https)://* ]] && {
					1="$(echo "$1" | sed -E 's/([&|()<>^])/^\1/g')"  || return 1
				}
			} ;;
		(msys*) open_cmd='start ""'  ;;
		(*) echo "Platform $OSTYPE not supported"
			return 1 ;;
	esac
	if [[ -n "$BROWSER" && "$1" = (http|https)://* ]]
	then
		"$BROWSER" "$@"
		return
	fi
	${=open_cmd} "$@" &> /dev/null
}
parse_git_dirty () {
	local STATUS
	local -a FLAGS
	FLAGS=('--porcelain') 
	if [[ "$(__git_prompt_git config --get oh-my-zsh.hide-dirty)" != "1" ]]
	then
		if [[ "${DISABLE_UNTRACKED_FILES_DIRTY:-}" == "true" ]]
		then
			FLAGS+='--untracked-files=no' 
		fi
		case "${GIT_STATUS_IGNORE_SUBMODULES:-}" in
			(git)  ;;
			(*) FLAGS+="--ignore-submodules=${GIT_STATUS_IGNORE_SUBMODULES:-dirty}"  ;;
		esac
		STATUS=$(__git_prompt_git status ${FLAGS} 2> /dev/null | tail -n 1) 
	fi
	if [[ -n $STATUS ]]
	then
		echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
	else
		echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
	fi
}
pyenv_prompt_info () {
	return 1
}
rbenv_prompt_info () {
	return 1
}
regexp-replace () {
	argv=("$1" "$2" "$3") 
	4=0 
	[[ -o re_match_pcre ]] && 4=1 
	emulate -L zsh
	local MATCH MBEGIN MEND
	local -a match mbegin mend
	if (( $4 ))
	then
		zmodload zsh/pcre || return 2
		pcre_compile -- "$2" && pcre_study || return 2
		4=0 6= 
		local ZPCRE_OP
		while pcre_match -b -n $4 -- "${(P)1}"
		do
			5=${(e)3} 
			argv+=(${(s: :)ZPCRE_OP} "$5") 
			4=$((argv[-2] + (argv[-3] == argv[-2]))) 
		done
		(($# > 6)) || return
		set +o multibyte
		5= 6=1 
		for 2 3 4 in "$@[7,-1]"
		do
			5+=${(P)1[$6,$2]}$4 
			6=$(($3 + 1)) 
		done
		5+=${(P)1[$6,-1]} 
	else
		4=${(P)1} 
		while [[ -n $4 ]]
		do
			if [[ $4 =~ $2 ]]
			then
				5+=${4[1,MBEGIN-1]}${(e)3} 
				if ((MEND < MBEGIN))
				then
					((MEND++))
					5+=${4[1]} 
				fi
				4=${4[MEND+1,-1]} 
				6=1 
			else
				break
			fi
		done
		[[ -n $6 ]] || return
		5+=$4 
	fi
	eval $1=\$5
}
ruby_prompt_info () {
	echo "$(rvm_prompt_info || rbenv_prompt_info || chruby_prompt_info)"
}
rvm_prompt_info () {
	[ -f $HOME/.rvm/bin/rvm-prompt ] || return 1
	local rvm_prompt
	rvm_prompt=$($HOME/.rvm/bin/rvm-prompt ${=ZSH_THEME_RVM_PROMPT_OPTIONS} 2>/dev/null) 
	[[ -z "${rvm_prompt}" ]] && return 1
	echo "${ZSH_THEME_RUBY_PROMPT_PREFIX}${rvm_prompt:gs/%/%%}${ZSH_THEME_RUBY_PROMPT_SUFFIX}"
}
spectrum_bls () {
	setopt localoptions nopromptsubst
	local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris} 
	for code in {000..255}
	do
		print -P -- "$code: ${BG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
	done
}
spectrum_ls () {
	setopt localoptions nopromptsubst
	local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris} 
	for code in {000..255}
	do
		print -P -- "$code: ${FG[$code]}${ZSH_SPECTRUM_TEXT}%{$reset_color%}"
	done
}
start_onsched () {
	zd "$HOME/Work/OnSched/v3/app" || {
		echo "Failed to cd to app dir"
		return 1
	}
	docker compose --env-file .env.local up -d
	zd "$HOME/Work/OnSched/v3/api" || {
		echo "Failed to cd to api dir"
		return 1
	}
	docker compose --env-file .env up -d
	echo "All Onsched v3 services started!"
}
sv () {
	source venv/bin/activate && tmux set-environment VIRTUAL_ENV $VIRTUAL_ENV
}
svn_prompt_info () {
	return 1
}
take () {
	if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]
	then
		takeurl "$1"
	elif [[ $1 =~ ^(https?|ftp).*\.(zip)$ ]]
	then
		takezip "$1"
	elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]
	then
		takegit "$1"
	else
		takedir "$@"
	fi
}
takedir () {
	mkdir -p $@ && cd ${@:$#}
}
takegit () {
	git clone "$1"
	cd "$(basename ${1%%.git})"
}
takeurl () {
	local data thedir
	data="$(mktemp)" 
	curl -L "$1" > "$data"
	tar xf "$data"
	thedir="$(tar tf "$data" | head -n 1)" 
	rm "$data"
	cd "$thedir"
}
takezip () {
	local data thedir
	data="$(mktemp)" 
	curl -L "$1" > "$data"
	unzip "$data" -d "./"
	thedir="$(unzip -l "$data" | awk 'NR==4 {print $4}' | sed 's/\/.*//')" 
	rm "$data"
	cd "$thedir"
}
tf_prompt_info () {
	return 1
}
title () {
	setopt localoptions nopromptsubst
	[[ -n "${INSIDE_EMACS:-}" && "$INSIDE_EMACS" != vterm ]] && return
	: ${2=$1}
	case "$TERM" in
		(cygwin | xterm* | putty* | rxvt* | konsole* | ansi | mlterm* | alacritty* | st* | foot* | contour* | wezterm*) print -Pn "\e]2;${2:q}\a"
			print -Pn "\e]1;${1:q}\a" ;;
		(screen* | tmux*) print -Pn "\ek${1:q}\e\\" ;;
		(*) if [[ "$TERM_PROGRAM" == "iTerm.app" ]]
			then
				print -Pn "\e]2;${2:q}\a"
				print -Pn "\e]1;${1:q}\a"
			else
				if (( ${+terminfo[fsl]} && ${+terminfo[tsl]} ))
				then
					print -Pn "${terminfo[tsl]}$1${terminfo[fsl]}"
				fi
			fi ;;
	esac
}
transcode-video-1080p () {
	ffmpeg -i $1 -vf scale=1920:1080 -c:v libx264 -preset fast -crf 23 -c:a copy ${1%.*}-1080p.mp4
}
transcode-video-4K () {
	ffmpeg -i $1 -c:v libx265 -preset slow -crf 24 -c:a aac -b:a 192k ${1%.*}-optimized.mp4
}
try_alias_value () {
	alias_value "$1" || echo "$1"
}
uninstall_oh_my_zsh () {
	command env ZSH="$ZSH" sh "$ZSH/tools/uninstall.sh"
}
up-line-or-beginning-search () {
	# undefined
	builtin autoload -XU
}
upgrade_oh_my_zsh () {
	echo "${fg[yellow]}Note: \`$0\` is deprecated. Use \`omz update\` instead.$reset_color" >&2
	omz update
}
url-quote-magic () {
	# undefined
	builtin autoload -XUz
}
vi_mode_prompt_info () {
	return 1
}
virtualenv_prompt_info () {
	return 1
}
work_in_progress () {
	command git -c log.showSignature=false log -n 1 2> /dev/null | grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv} -q -- "--wip--" && echo "WIP!!"
}
zd () {
	if [ $# -eq 0 ]
	then
		builtin cd ~ && return
	elif [ -d "$1" ]
	then
		builtin cd "$1"
	else
		z "$@" && printf "\U000F17A9 " && pwd || echo "Error: Directory not found"
	fi
}
zle-keymap-select () {
	if [[ ${KEYMAP} == vicmd ]]
		[[ $1 = 'block' ]]
	then
		echo -ne '\e[1 q'
	elif [[ ${KEYMAP} == main ]]
		[[ ${KEYMAP} == viins ]]
		[[ ${KEYMAP} = '' ]]
		[[ $1 = 'beam' ]]
	then
		echo -ne '\e[5 q'
	fi
}
zle-line-finish () {
	echoti rmkx
}
zle-line-init () {
	echoti smkx
}
zrecompile () {
	setopt localoptions extendedglob noshwordsplit noksharrays
	local opt check quiet zwc files re file pre ret map tmp mesg pats
	tmp=() 
	while getopts ":tqp" opt
	do
		case $opt in
			(t) check=yes  ;;
			(q) quiet=yes  ;;
			(p) pats=yes  ;;
			(*) if [[ -n $pats ]]
				then
					tmp=($tmp $OPTARG) 
				else
					print -u2 zrecompile: bad option: -$OPTARG
					return 1
				fi ;;
		esac
	done
	shift OPTIND-${#tmp}-1
	if [[ -n $check ]]
	then
		ret=1 
	else
		ret=0 
	fi
	if [[ -n $pats ]]
	then
		local end num
		while (( $# ))
		do
			end=$argv[(i)--] 
			if [[ end -le $# ]]
			then
				files=($argv[1,end-1]) 
				shift end
			else
				files=($argv) 
				argv=() 
			fi
			tmp=() 
			map=() 
			OPTIND=1 
			while getopts :MR opt $files
			do
				case $opt in
					([MR]) map=(-$opt)  ;;
					(*) tmp=($tmp $files[OPTIND])  ;;
				esac
			done
			shift OPTIND-1 files
			(( $#files )) || continue
			files=($files[1] ${files[2,-1]:#*(.zwc|~)}) 
			(( $#files )) || continue
			zwc=${files[1]%.zwc}.zwc 
			shift 1 files
			(( $#files )) || files=(${zwc%.zwc}) 
			if [[ -f $zwc ]]
			then
				num=$(zcompile -t $zwc | wc -l) 
				if [[ num-1 -ne $#files ]]
				then
					re=yes 
				else
					re= 
					for file in $files
					do
						if [[ $file -nt $zwc ]]
						then
							re=yes 
							break
						fi
					done
				fi
			else
				re=yes 
			fi
			if [[ -n $re ]]
			then
				if [[ -n $check ]]
				then
					[[ -z $quiet ]] && print $zwc needs re-compilation
					ret=0 
				else
					[[ -z $quiet ]] && print -n "re-compiling ${zwc}: "
					if [[ -z "$quiet" ]] && {
							[[ ! -f $zwc ]] || mv -f $zwc ${zwc}.old
						} && zcompile $map $tmp $zwc $files
					then
						print succeeded
					elif ! {
							{
								[[ ! -f $zwc ]] || mv -f $zwc ${zwc}.old
							} && zcompile $map $tmp $zwc $files 2> /dev/null
						}
					then
						[[ -z $quiet ]] && print "re-compiling ${zwc}: failed"
						ret=1 
					fi
				fi
			fi
		done
		return ret
	fi
	if (( $# ))
	then
		argv=(${^argv}/*.zwc(ND) ${^argv}.zwc(ND) ${(M)argv:#*.zwc}) 
	else
		argv=(${^fpath}/*.zwc(ND) ${^fpath}.zwc(ND) ${(M)fpath:#*.zwc}) 
	fi
	argv=(${^argv%.zwc}.zwc) 
	for zwc
	do
		files=(${(f)"$(zcompile -t $zwc)"}) 
		if [[ $files[1] = *\(mapped\)* ]]
		then
			map=-M 
			mesg='succeeded (old saved)' 
		else
			map=-R 
			mesg=succeeded 
		fi
		if [[ $zwc = */* ]]
		then
			pre=${zwc%/*}/ 
		else
			pre= 
		fi
		if [[ $files[1] != *$ZSH_VERSION ]]
		then
			re=yes 
		else
			re= 
		fi
		files=(${pre}${^files[2,-1]:#/*} ${(M)files[2,-1]:#/*}) 
		[[ -z $re ]] && for file in $files
		do
			if [[ $file -nt $zwc ]]
			then
				re=yes 
				break
			fi
		done
		if [[ -n $re ]]
		then
			if [[ -n $check ]]
			then
				[[ -z $quiet ]] && print $zwc needs re-compilation
				ret=0 
			else
				[[ -z $quiet ]] && print -n "re-compiling ${zwc}: "
				tmp=(${^files}(N)) 
				if [[ $#tmp -ne $#files ]]
				then
					[[ -z $quiet ]] && print 'failed (missing files)'
					ret=1 
				else
					if [[ -z "$quiet" ]] && mv -f $zwc ${zwc}.old && zcompile $map $zwc $files
					then
						print $mesg
					elif ! {
							mv -f $zwc ${zwc}.old && zcompile $map $zwc $files 2> /dev/null
						}
					then
						[[ -z $quiet ]] && print "re-compiling ${zwc}: failed"
						ret=1 
					fi
				fi
			fi
		fi
	done
	return ret
}
zsh_stats () {
	fc -l 1 | awk '{ CMD[$2]++; count++; } END { for (a in CMD) print CMD[a] " " CMD[a]*100/count "% " a }' | grep -v "./" | sort -nr | head -n 20 | column -c3 -s " " -t | nl
}
zvm_append_eol () {
	ZVM_INSERT_MODE='A' 
	zle vi-end-of-line
	zvm_exit_visual_mode false
	zvm_select_vi_mode $ZVM_MODE_INSERT
	zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
}
zvm_backward_kill_line () {
	BUFFER=${BUFFER:$CURSOR:$#BUFFER} 
	CURSOR=0 
}
zvm_backward_kill_region () {
	local bpos=$CURSOR-1 epos=$CURSOR 
	for ((; bpos >= 0; bpos--)) do
		[[ "${BUFFER:$bpos:1}" == $'\n' ]] && break
		[[ "${BUFFER:$bpos:2}" =~ ^\ [^\ $'\n']$ ]] && break
	done
	bpos=$bpos+1 
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))} 
	BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
	CURSOR=$bpos 
	zvm_clipboard_copy_buffer
}
zvm_bindkey () {
	local keymap=$1 
	local keys=$2 
	local widget=$3 
	local params=$4 
	local key= 
	[[ -z $widget ]] && return
	if [[ -n ${ZVM_LAZY_KEYBINDINGS_LIST+x} && ${keymap} != viins ]]
	then
		keys=${keys//\"/\\\"} 
		keys=${keys//\`/\\\`} 
		ZVM_LAZY_KEYBINDINGS_LIST+=("${keymap} \"${keys}\" ${widget} \"${params}\"") 
		return
	fi
	if [[ $ZVM_READKEY_ENGINE == $ZVM_READKEY_ENGINE_NEX ]]
	then
		if [[ $#keys -gt 1 && "${keys:0:1}" == '^' ]]
		then
			key=${keys:0:2} 
		else
			key=${keys:0:1} 
			if [[ "$keymap" == "viins" ]]
			then
				bindkey -M isearch "${key}" self-insert
			fi
		fi
		bindkey -M $keymap "${key}" zvm_readkeys_handler
	fi
	if [[ -n $params ]]
	then
		local suffix=$(zvm_string_to_hex $params) 
		eval "$widget:$suffix() { $widget $params }"
		widget="$widget:$suffix" 
		zvm_define_widget $widget
	fi
	bindkey -M $keymap "${keys}" $widget
}
zvm_calc_selection () {
	local ret=($(zvm_selection)) 
	local bpos=${ret[1]} epos=${ret[2]} cpos= 
	cpos=$bpos 
	if [[ "${1:-$ZVM_MODE}" == $ZVM_MODE_VISUAL_LINE ]]
	then
		for ((bpos=$bpos-1; $bpos>0; bpos--)) do
			if [[ "${BUFFER:$bpos:1}" == $'\n' ]]
			then
				bpos=$((bpos+1)) 
				break
			fi
		done
		for ((epos=$epos-1; $epos<$#BUFFER; epos++)) do
			if [[ "${BUFFER:$epos:1}" == $'\n' ]]
			then
				break
			fi
		done
		if (( bpos < 0 ))
		then
			bpos=0 
		fi
		for ((cpos=$((CURSOR-1)); $cpos>=0; cpos--)) do
			[[ "${BUFFER:$cpos:1}" == $'\n' ]] && break
		done
		local indent=$((CURSOR-cpos-1)) 
		local hpos= 
		local rpos= 
		if (( $epos < $#BUFFER ))
		then
			hpos=$((epos+1)) 
			rpos=$bpos 
		else
			for ((hpos=$((bpos-2)); $hpos>0; hpos--)) do
				if [[ "${BUFFER:$hpos:1}" == $'\n' ]]
				then
					break
				fi
			done
			if (( $hpos < -1 ))
			then
				hpos=-1 
			fi
			hpos=$((hpos+1)) 
			rpos=$hpos 
		fi
		for ((cpos=$hpos; $cpos<$#BUFFER; cpos++)) do
			if [[ "${BUFFER:$cpos:1}" == $'\n' ]]
			then
				break
			fi
			if (( $hpos + $indent <= $cpos ))
			then
				break
			fi
		done
		cpos=$((rpos+cpos-hpos)) 
	fi
	echo $bpos $epos $cpos
}
zvm_change_surround () {
	local ret=($(zvm_parse_surround_keys)) 
	local action=${1:-${ret[1]}} 
	local surround=${2:-${ret[2]//$ZVM_ESCAPE_SPACE/ }} 
	local bpos=${3} epos=${4} 
	local is_appending=false 
	case $action in
		(S | y | a) is_appending=true  ;;
	esac
	if $is_appending
	then
		if [[ -z $bpos && -z $epos ]]
		then
			ret=($(zvm_selection)) 
			bpos=${ret[1]} epos=${ret[2]} 
		fi
	else
		ret=($(zvm_search_surround "$surround")) 
		(( ${#ret[@]} )) || return
		bpos=${ret[1]} epos=${ret[2]} 
		zvm_highlight custom $bpos $(($bpos+1))
		zvm_highlight custom $epos $(($epos+1))
	fi
	local key= 
	case $action in
		(c | r) zvm_enter_oppend_mode
			read -k 1 key
			zvm_exit_oppend_mode ;;
		(S | y | a) if [[ -z $surround ]]
			then
				zvm_enter_oppend_mode
				read -k 1 key
				zvm_exit_oppend_mode
			else
				key=$surround 
			fi
			if [[ $ZVM_MODE == $ZVM_MODE_VISUAL ]]
			then
				zle visual-mode
			fi ;;
	esac
	case "$key" in
		($'\e' | "${ZVM_VI_ESCAPE_BINDKEY//\^\[/$'\e'}") zvm_highlight clear
			return ;;
	esac
	ret=($(zvm_match_surround "$key")) 
	local bchar=${${ret[1]//$ZVM_ESCAPE_SPACE/ }:-$key} 
	local echar=${${ret[2]//$ZVM_ESCAPE_SPACE/ }:-$key} 
	local value=$($is_appending && echo 0 || echo 1 ) 
	local head=${BUFFER:0:$bpos} 
	local body=${BUFFER:$((bpos+value)):$((epos-(bpos+value)))} 
	local foot=${BUFFER:$((epos+value))} 
	BUFFER="${head}${bchar}${body}${echar}${foot}" 
	zvm_highlight clear
	case $action in
		(S | y | a) zvm_select_vi_mode $ZVM_MODE_NORMAL ;;
	esac
}
zvm_change_surround_text_object () {
	local ret=($(zvm_parse_surround_keys)) 
	local action=${1:-${ret[1]}} 
	local surround=${2:-${ret[2]//$ZVM_ESCAPE_SPACE/ }} 
	ret=($(zvm_search_surround "${surround}")) 
	if [[ ${#ret[@]} == 0 ]]
	then
		zvm_select_vi_mode $ZVM_MODE_NORMAL
		return
	fi
	local bpos=${ret[1]} 
	local epos=${ret[2]} 
	if [[ ${action:1:1} == 'i' ]]
	then
		((bpos++))
	else
		((epos++))
	fi
	CUTBUFFER=${BUFFER:$bpos:$(($epos-$bpos))} 
	case ${action:0:1} in
		(c) BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
			CURSOR=$bpos 
			zvm_select_vi_mode $ZVM_MODE_INSERT ;;
		(d) BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
			CURSOR=$bpos  ;;
	esac
}
zvm_clipboard_available () {
	zvm_clipboard_detect
	if [[ -n $ZVM_CLIPBOARD_COPY_CMD && -n $ZVM_CLIPBOARD_PASTE_CMD ]]
	then
		return 0
	fi
	return 1
}
zvm_clipboard_copy_buffer () {
	$ZVM_SYSTEM_CLIPBOARD_ENABLED || return
	zvm_clipboard_available || return
	print -rn -- "$CUTBUFFER" | eval "$ZVM_CLIPBOARD_COPY_CMD" > /dev/null 2>&1
}
zvm_clipboard_detect () {
	if [[ -n $ZVM_CLIPBOARD_COPY_CMD && -n $ZVM_CLIPBOARD_PASTE_CMD ]]
	then
		return
	fi
	if zvm_exist_command pbcopy && zvm_exist_command pbpaste
	then
		ZVM_CLIPBOARD_COPY_CMD='pbcopy' 
		ZVM_CLIPBOARD_PASTE_CMD='pbpaste' 
		return
	fi
	if zvm_exist_command wl-copy && zvm_exist_command wl-paste
	then
		ZVM_CLIPBOARD_COPY_CMD='wl-copy' 
		ZVM_CLIPBOARD_PASTE_CMD='wl-paste -n' 
		return
	fi
	if zvm_exist_command xclip
	then
		ZVM_CLIPBOARD_COPY_CMD='xclip -selection clipboard' 
		ZVM_CLIPBOARD_PASTE_CMD='xclip -selection clipboard -o' 
		return
	fi
	if zvm_exist_command xsel
	then
		ZVM_CLIPBOARD_COPY_CMD='xsel --clipboard -i' 
		ZVM_CLIPBOARD_PASTE_CMD='xsel --clipboard -o' 
		return
	fi
}
zvm_clipboard_get () {
	zvm_clipboard_available || return
	eval "$ZVM_CLIPBOARD_PASTE_CMD" 2> /dev/null
}
zvm_cursor_style () {
	local style=${(L)1} 
	local term=${2:-$ZVM_TERM} 
	case $term in
		(xterm* | rxvt* | screen* | tmux* | konsole* | alacritty* | st* | foot* | wezterm) case $style in
				($ZVM_CURSOR_BLOCK) style='\e[2 q'  ;;
				($ZVM_CURSOR_UNDERLINE) style='\e[4 q'  ;;
				($ZVM_CURSOR_BEAM) style='\e[6 q'  ;;
				($ZVM_CURSOR_BLINKING_BLOCK) style='\e[1 q'  ;;
				($ZVM_CURSOR_BLINKING_UNDERLINE) style='\e[3 q'  ;;
				($ZVM_CURSOR_BLINKING_BEAM) style='\e[5 q'  ;;
				($ZVM_CURSOR_USER_DEFAULT) style='\e[0 q'  ;;
			esac ;;
		(*) style='\e[0 q'  ;;
	esac
	if [[ $style == '\e[0 q' ]]
	then
		local old_style= 
		case $ZVM_MODE in
			($ZVM_MODE_INSERT) old_style=$ZVM_INSERT_MODE_CURSOR  ;;
			($ZVM_MODE_NORMAL) old_style=$ZVM_NORMAL_MODE_CURSOR  ;;
			($ZVM_MODE_VISUAL) old_style=$ZVM_VISUAL_MODE_CURSOR  ;;
			($ZVM_MODE_VISUAL_LINE) old_style=$ZVM_VISUAL_LINE_MODE_CURSOR  ;;
		esac
		if [[ $old_style =~ '\e\][0-9]+;.+\a' ]]
		then
			style=$style'\e\e]112\a' 
		fi
	fi
	echo $style
}
zvm_default_handler () {
	local keys=$(zvm_keys) 
	local extra_keys=$1 
	case $(zvm_escape_non_printed_characters "$keys") in
		('^[' | $ZVM_VI_INSERT_ESCAPE_BINDKEY) zvm_exit_insert_mode false
			zvm_reset_prompt
			ZVM_KEYS=${extra_keys} 
			return ;;
		([vV]'^[' | [vV]$ZVM_VI_VISUAL_ESCAPE_BINDKEY) zvm_exit_visual_mode false
			zvm_reset_prompt
			ZVM_KEYS=${extra_keys} 
			return ;;
	esac
	case "$KEYMAP" in
		(vicmd) case "$keys" in
				([vV]c) zvm_vi_change false ;;
				([vV]d) zvm_vi_delete false ;;
				([vV]y) zvm_vi_yank false ;;
				([vV]S) zvm_change_surround S ;;
				([cdyvV]*) while :
					do
						zvm_range_handler "${keys}${extra_keys}"
						case $? in
							($ZVM_RANGE_HANDLER_RET_OK) break ;;
							($ZVM_RANGE_HANDLER_RET_CONTINUE) keys='v' 
								extra_keys=  ;;
							($ZVM_RANGE_HANDLER_RET_PUSHBACK) zvm_exit_visual_mode false
								zvm_reset_prompt
								return ;;
							($ZVM_RANGE_HANDLER_RET_CANCEL) zvm_exit_visual_mode false
								zvm_reset_prompt
								break ;;
						esac
					done ;;
				(*) local i= 
					for ((i=0; i<$#keys; i++)) do
						zvm_navigation_handler ${keys:$i:1}
						zvm_highlight
					done ;;
			esac ;;
		(viins | main) if [[ "${keys:0:1}" =~ [a-zA-Z0-9\ ] ]]
			then
				zvm_self_insert "${keys:0:1}"
				zle redisplay
				ZVM_KEYS="${keys:1}${extra_keys}" 
				return
			elif [[ "${keys:0:1}" == $'\e' ]]
			then
				zvm_exit_insert_mode false
				ZVM_KEYS="${keys:1}${extra_keys}" 
				return
			fi ;;
		(visual)  ;;
	esac
	ZVM_KEYS= 
}
zvm_define_widget () {
	local widget=$1 
	local func=$2  || $1
	local result=($(zle -l -L "${widget}")) 
	if [[ ${#result[@]} == 4 ]]
	then
		local rawfunc=${result[4]} 
		local wrapper="zvm_${widget}-wrapper" 
		local rawcode=$(declare -f $func 2>/dev/null) 
		local called=false 
		[[ "$rawcode" == *"\$rawfunc"* ]] && {
			called=true 
		}
		eval "$wrapper() { zvm_widget_wrapper $rawfunc $func $called \"\$@\" }"
		func=$wrapper 
	fi
	zle -N $widget $func
}
zvm_enter_insert_mode () {
	local keys=${1:-$(zvm_keys)} 
	if [[ $keys == 'i' ]]
	then
		ZVM_INSERT_MODE='i' 
	elif [[ $keys == 'a' ]]
	then
		ZVM_INSERT_MODE='a' 
		if ! zvm_is_empty_line
		then
			CURSOR=$((CURSOR+1)) 
		fi
	fi
	zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
	zvm_select_vi_mode $ZVM_MODE_INSERT
}
zvm_enter_oppend_mode () {
	ZVM_OPPEND_MODE=true 
	${1:-true} && zvm_update_cursor
}
zvm_enter_visual_mode () {
	local mode= 
	local last_mode=$ZVM_MODE 
	local last_region= 
	case $last_mode in
		($ZVM_MODE_VISUAL | $ZVM_MODE_VISUAL_LINE) last_region=($MARK $CURSOR) 
			zvm_exit_visual_mode ;;
	esac
	case "${1:-$(zvm_keys)}" in
		(v) mode=$ZVM_MODE_VISUAL  ;;
		(V) mode=$ZVM_MODE_VISUAL_LINE  ;;
		(*) mode=$last_mode  ;;
	esac
	if [[ $last_mode == $mode ]]
	then
		return
	fi
	zvm_select_vi_mode $mode
	if [[ -n $last_region ]]
	then
		MARK=$last_region[1] 
		CURSOR=$last_region[2] 
		zle redisplay
	fi
}
zvm_escape_non_printed_characters () {
	local str= i= 
	for ((i=0; i<$#1; i++)) do
		local c=${1:$i:1} 
		if [[ "$c" < ' ' ]]
		then
			local ord=$(($(printf '%d' "'$c")+64)) 
			c=$(printf \\$(printf '%03o' $ord)) 
			str="${str}^${c}" 
		elif [[ "$c" == '' ]]
		then
			str="${str}^?" 
		elif [[ "$c" == ' ' ]]
		then
			str="${str}^@" 
		else
			str="${str}${c}" 
		fi
	done
	str=${str// /$ZVM_ESCAPE_SPACE} 
	str=${str//$'\n'/$ZVM_ESCAPE_NEWLINE} 
	echo -n $str
}
zvm_exchange_point_and_mark () {
	cursor=$MARK 
	MARK=$CURSOR CURSOR=$cursor 
	zvm_highlight
}
zvm_exec_commands () {
	local commands="zvm_${1}_commands" 
	commands=(${(P)commands}) 
	if zvm_exist_command "zvm_$1"
	then
		eval "zvm_$1" ${@:2}
	fi
	for cmd in $commands
	do
		if zvm_exist_command ${cmd}
		then
			cmd="$cmd ${@:2}" 
		fi
		eval $cmd
	done
}
zvm_exist_command () {
	command -v "$1" > /dev/null
}
zvm_exit_insert_mode () {
	ZVM_INSERT_MODE= 
	zvm_select_vi_mode $ZVM_MODE_NORMAL ${1:-true}
}
zvm_exit_oppend_mode () {
	ZVM_OPPEND_MODE=false 
	${1:-true} && zvm_update_cursor
}
zvm_exit_visual_mode () {
	case "$ZVM_MODE" in
		($ZVM_MODE_VISUAL) zle visual-mode ;;
		($ZVM_MODE_VISUAL_LINE) zle visual-line-mode ;;
	esac
	zvm_highlight clear
	zvm_select_vi_mode $ZVM_MODE_NORMAL ${1:-true}
}
zvm_find_and_move_cursor () {
	local char=$1 
	local count=${2:-1} 
	local forward=${3:-true} 
	local skip=${4:-false} 
	local cursor=$CURSOR 
	[[ -z $char ]] && return 1
	while :
	do
		if $forward
		then
			cursor=$((cursor+1)) 
			((cursor > $#BUFFER)) && break
		else
			cursor=$((cursor-1)) 
			((cursor < 0)) && break
		fi
		if [[ ${BUFFER[$cursor+1]} == $char ]]
		then
			count=$((count-1)) 
		fi
		((count == 0)) && break
	done
	[[ $count > 0 ]] && return 1
	if $skip
	then
		if $forward
		then
			cursor=$((cursor-1)) 
		else
			cursor=$((cursor+1)) 
		fi
	fi
	CURSOR=$cursor 
}
zvm_find_bindkey_widget () {
	local keymap=$1 
	local keys=$2 
	local prefix_mode=${3:-false} 
	retval=() 
	if $prefix_mode
	then
		local pos=0 
		local spos=3 
		local prefix_keys=$keys 
		if [[ -n $prefix_keys ]]
		then
			prefix_keys=${prefix_keys:0:-1} 
			if [[ ${prefix_keys: -1} == '\' ]]
			then
				prefix_keys=${prefix_keys:0:-1} 
			fi
		fi
		local result=$(bindkey -M ${keymap} -p "$prefix_keys")$'\n' 
		local i= 
		for ((i=$spos; i<$#result; i++)) do
			case "${result:$i:1}" in
				(' ') spos=$i 
					i=$i+1 
					continue ;;
				([$'\n'])  ;;
				(*) continue ;;
			esac
			if [[ "${result:$((pos+1)):$#keys}" == "$keys" ]]
			then
				local k=${result:$((pos+1)):$((spos-pos-2))} 
				k=${k// /$ZVM_ESCAPE_SPACE} 
				retval+=($k ${result:$((spos+1)):$((i-spos-1))}) 
			fi
			pos=$i+1 
			i=$i+3 
		done
	else
		local result=$(bindkey -M ${keymap} "$keys") 
		if [[ "${result: -14}" == ' undefined-key' ]]
		then
			return
		fi
		local i= 
		for ((i=$#result; i>=0; i--)) do
			[[ "${result:$i:1}" == ' ' ]] || continue
			local k=${result:1:$i-2} 
			k=${k// /$ZVM_ESCAPE_SPACE} 
			retval+=($k ${result:$i+1}) 
			break
		done
	fi
}
zvm_forward_kill_line () {
	BUFFER=${BUFFER:0:$CURSOR} 
}
zvm_highlight () {
	local opt=${1:-mode} 
	local region=() 
	local redraw=false 
	case "$opt" in
		(mode) case "$ZVM_MODE" in
				($ZVM_MODE_VISUAL | $ZVM_MODE_VISUAL_LINE) local ret=($(zvm_calc_selection)) 
					local bpos=$((ret[1])) epos=$((ret[2])) 
					local bg=$ZVM_VI_HIGHLIGHT_BACKGROUND 
					local fg=$ZVM_VI_HIGHLIGHT_FOREGROUND 
					local es=$ZVM_VI_HIGHLIGHT_EXTRASTYLE 
					region=("$bpos $epos fg=$fg,bg=$bg,$es")  ;;
			esac
			redraw=true  ;;
		(custom) local bpos=$2 epos=$3 
			local bg=${4:-$ZVM_VI_HIGHLIGHT_BACKGROUND} 
			local fg=${5:-$ZVM_VI_HIGHLIGHT_FOREGROUND} 
			local es=${6:-$ZVM_VI_HIGHLIGHT_EXTRASTYLE} 
			region=("${ZVM_REGION_HIGHLIGHT[@]}") 
			region+=("$bpos $epos fg=$fg,bg=$bg,$es") 
			redraw=true  ;;
		(clear) zle redisplay
			redraw=true  ;;
		(redraw) redraw=true  ;;
	esac
	if (( $#region > 0 )) || [[ "$opt" == 'clear' ]]
	then
		local rawhighlight=() 
		local i= j= 
		for ((i=1; i<=${#region_highlight[@]}; i++)) do
			local raw=true 
			local spl=(${(@s/ /)region_highlight[i]}) 
			local pat="${spl[1]} ${spl[2]}" 
			for ((j=1; j<=${#ZVM_REGION_HIGHLIGHT[@]}; j++)) do
				if [[ "$pat" == "${ZVM_REGION_HIGHLIGHT[j]:0:$#pat}" ]]
				then
					raw=false 
					break
				fi
			done
			if $raw
			then
				rawhighlight+=("${region_highlight[i]}") 
			fi
		done
		ZVM_REGION_HIGHLIGHT=("${region[@]}") 
		region_highlight=("${rawhighlight[@]}" "${ZVM_REGION_HIGHLIGHT[@]}") 
	fi
	if $redraw
	then
		zle -R
	fi
}
zvm_init () {
	if $ZVM_INIT_DONE
	then
		return
	fi
	ZVM_INIT_DONE=true 
	zvm_exec_commands 'before_init'
	case $ZVM_READKEY_ENGINE in
		($ZVM_READKEY_ENGINE_NEX | $ZVM_READKEY_ENGINE_ZLE)  ;;
		(*) echo -n "Warning: Unsupported readkey engine! "
			echo "ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE"
			ZVM_READKEY_ENGINE=$ZVM_READKEY_ENGINE_DEFAULT  ;;
	esac
	case $ZVM_READKEY_ENGINE in
		($ZVM_READKEY_ENGINE_NEX) KEYTIMEOUT=1  ;;
		($ZVM_READKEY_ENGINE_ZLE) KEYTIMEOUT=$(($ZVM_KEYTIMEOUT*100))  ;;
	esac
	zvm_define_widget zvm_default_handler
	zvm_define_widget zvm_readkeys_handler
	zvm_define_widget zvm_backward_kill_region
	zvm_define_widget zvm_backward_kill_line
	zvm_define_widget zvm_forward_kill_line
	zvm_define_widget zvm_kill_line
	zvm_define_widget zvm_viins_undo
	zvm_define_widget zvm_select_surround
	zvm_define_widget zvm_change_surround
	zvm_define_widget zvm_move_around_surround
	zvm_define_widget zvm_change_surround_text_object
	zvm_define_widget zvm_enter_insert_mode
	zvm_define_widget zvm_exit_insert_mode
	zvm_define_widget zvm_enter_visual_mode
	zvm_define_widget zvm_exit_visual_mode
	zvm_define_widget zvm_enter_oppend_mode
	zvm_define_widget zvm_exit_oppend_mode
	zvm_define_widget zvm_exchange_point_and_mark
	zvm_define_widget zvm_open_line_below
	zvm_define_widget zvm_open_line_above
	zvm_define_widget zvm_insert_bol
	zvm_define_widget zvm_append_eol
	zvm_define_widget zvm_self_insert
	zvm_define_widget zvm_vi_replace
	zvm_define_widget zvm_vi_replace_chars
	zvm_define_widget zvm_vi_substitute
	zvm_define_widget zvm_vi_substitute_whole_line
	zvm_define_widget zvm_vi_change
	zvm_define_widget zvm_vi_change_eol
	zvm_define_widget zvm_vi_delete
	zvm_define_widget zvm_vi_yank
	zvm_define_widget zvm_vi_put_after
	zvm_define_widget zvm_vi_put_before
	zvm_define_widget zvm_vi_replace_selection
	zvm_define_widget zvm_vi_up_case
	zvm_define_widget zvm_vi_down_case
	zvm_define_widget zvm_vi_opp_case
	zvm_define_widget zvm_vi_edit_command_line
	zvm_define_widget zvm_repeat_change
	zvm_define_widget zvm_switch_keyword
	zvm_define_widget zvm_paste_clipboard_after
	zvm_define_widget zvm_paste_clipboard_before
	zvm_define_widget zvm_visual_paste_clipboard
	zvm_define_widget zvm_open_under_cursor
	zvm_define_widget zle-line-pre-redraw zvm_zle-line-pre-redraw
	zvm_define_widget zle-line-init zvm_zle-line-init
	zvm_define_widget zle-line-finish zvm_zle-line-finish
	zvm_define_widget reset-prompt zvm_reset_prompt
	zvm_bindkey viins '^A' beginning-of-line
	zvm_bindkey viins '^E' end-of-line
	zvm_bindkey viins '^B' backward-char
	zvm_bindkey viins '^F' forward-char
	zvm_bindkey viins '^K' zvm_forward_kill_line
	zvm_bindkey viins '^W' backward-kill-word
	zvm_bindkey viins '^U' zvm_viins_undo
	zvm_bindkey viins '^Y' yank
	zvm_bindkey viins '^_' undo
	zvm_bindkey viins '^[[H' beginning-of-line
	zvm_bindkey vicmd '^[[H' beginning-of-line
	zvm_bindkey viins '^[[F' end-of-line
	zvm_bindkey vicmd '^[[F' end-of-line
	zvm_bindkey viins '^[[3~' delete-char
	zvm_bindkey vicmd '^[[3~' delete-char
	zvm_bindkey viins '^R' history-incremental-search-backward
	zvm_bindkey viins '^S' history-incremental-search-forward
	zvm_bindkey viins '^P' up-line-or-history
	zvm_bindkey viins '^N' down-line-or-history
	zvm_bindkey vicmd 'i' zvm_enter_insert_mode
	zvm_bindkey vicmd 'a' zvm_enter_insert_mode
	zvm_bindkey vicmd 'I' zvm_insert_bol
	zvm_bindkey vicmd 'A' zvm_append_eol
	zvm_bindkey vicmd 'v' zvm_enter_visual_mode
	zvm_bindkey vicmd 'V' zvm_enter_visual_mode
	zvm_bindkey visual 'o' zvm_exchange_point_and_mark
	zvm_bindkey vicmd 'o' zvm_open_line_below
	zvm_bindkey vicmd 'O' zvm_open_line_above
	zvm_bindkey vicmd 'r' zvm_vi_replace_chars
	zvm_bindkey vicmd 'R' zvm_vi_replace
	zvm_bindkey vicmd 's' zvm_vi_substitute
	zvm_bindkey vicmd 'S' zvm_vi_substitute_whole_line
	zvm_bindkey vicmd 'C' zvm_vi_change_eol
	zvm_bindkey visual 'c' zvm_vi_change
	zvm_bindkey visual 'd' zvm_vi_delete
	zvm_bindkey visual 'x' zvm_vi_delete
	zvm_bindkey visual 'y' zvm_vi_yank
	zvm_bindkey vicmd 'p' zvm_vi_put_after
	zvm_bindkey vicmd 'P' zvm_vi_put_before
	zvm_bindkey visual 'p' zvm_vi_replace_selection
	zvm_bindkey visual 'P' zvm_vi_replace_selection
	zvm_bindkey visual 'U' zvm_vi_up_case
	zvm_bindkey visual 'u' zvm_vi_down_case
	zvm_bindkey visual '~' zvm_vi_opp_case
	zvm_bindkey visual 'v' zvm_vi_edit_command_line
	zvm_bindkey vicmd '.' zvm_repeat_change
	zvm_bindkey vicmd 'gx' zvm_open_under_cursor
	zvm_bindkey vicmd 'gp' zvm_paste_clipboard_after
	zvm_bindkey vicmd 'gP' zvm_paste_clipboard_before
	zvm_bindkey visual 'gp' zvm_visual_paste_clipboard
	zvm_bindkey visual 'gP' zvm_visual_paste_clipboard
	zvm_bindkey vicmd '^A' zvm_switch_keyword
	zvm_bindkey vicmd '^X' zvm_switch_keyword
	local exit_oppend_mode_widget= 
	local exit_insert_mode_widget= 
	local exit_visual_mode_widget= 
	local default_handler_widget= 
	case $ZVM_READKEY_ENGINE in
		($ZVM_READKEY_ENGINE_NEX) exit_oppend_mode_widget=zvm_readkeys_handler 
			exit_insert_mode_widget=zvm_readkeys_handler 
			exit_visual_mode_widget=zvm_readkeys_handler  ;;
		($ZVM_READKEY_ENGINE_ZLE) exit_insert_mode_widget=zvm_exit_insert_mode 
			exit_visual_mode_widget=zvm_exit_visual_mode 
			default_handler_widget=zvm_default_handler  ;;
	esac
	zvm_bindkey vicmd "$ZVM_VI_OPPEND_ESCAPE_BINDKEY" $exit_oppend_mode_widget
	zvm_bindkey viins "$ZVM_VI_INSERT_ESCAPE_BINDKEY" $exit_insert_mode_widget
	zvm_bindkey visual "$ZVM_VI_VISUAL_ESCAPE_BINDKEY" $exit_visual_mode_widget
	case "$ZVM_VI_OPPEND_ESCAPE_BINDKEY" in
		('^[' | '\e')  ;;
		(*) zvm_bindkey vicmd '^[' $exit_oppend_mode_widget ;;
	esac
	case "$ZVM_VI_INSERT_ESCAPE_BINDKEY" in
		('^[' | '\e')  ;;
		(*) zvm_bindkey viins '^[' $exit_insert_mode_widget ;;
	esac
	case "$ZVM_VI_VISUAL_ESCAPE_BINDKEY" in
		('^[' | '\e')  ;;
		(*) zvm_bindkey visual '^[' $exit_visual_mode_widget ;;
	esac
	for c in {y,d,c}
	do
		zvm_bindkey vicmd "$c" $default_handler_widget
	done
	local surrounds=() 
	for s in ${(s..)^:-'()[]{}<>'}
	do
		surrounds+=($s) 
	done
	for s in {\',\",\`,\ ,'^['}
	do
		surrounds+=($s) 
	done
	for s in $surrounds
	do
		for c in {a,i}${s}
		do
			zvm_bindkey visual "$c" zvm_select_surround
		done
		for c in {c,d,y}{a,i}${s}
		do
			zvm_bindkey vicmd "$c" zvm_change_surround_text_object
		done
		if [[ $ZVM_VI_SURROUND_BINDKEY == 's-prefix' ]]
		then
			for c in s{d,r}${s}
			do
				zvm_bindkey vicmd "$c" zvm_change_surround
			done
			for c in sa${s}
			do
				zvm_bindkey visual "$c" zvm_change_surround
			done
		else
			for c in {d,c}s${s}
			do
				zvm_bindkey vicmd "$c" zvm_change_surround
			done
			for c in {S,ys}${s}
			do
				zvm_bindkey visual "$c" zvm_change_surround
			done
		fi
	done
	zvm_bindkey vicmd '%' zvm_move_around_surround
	zvm_bindkey viins '^?' backward-delete-char
	case ${ZVM_LINE_INIT_MODE:-$ZVM_MODE_INSERT} in
		($ZVM_MODE_INSERT) ZVM_MODE=$ZVM_MODE_INSERT  ;;
		(*) ZVM_MODE=$ZVM_MODE_NORMAL  ;;
	esac
	bindkey -v
	zvm_exec_commands 'after_init'
}
zvm_insert_bol () {
	ZVM_INSERT_MODE='I' 
	zle vi-first-non-blank
	zvm_exit_visual_mode false
	zvm_select_vi_mode $ZVM_MODE_INSERT
	zvm_reset_repeat_commands $ZVM_MODE_NORMAL $ZVM_INSERT_MODE
}
zvm_is_empty_line () {
	local cursor=${1:-$CURSOR} 
	if [[ ${BUFFER:$cursor:1} == $'\n' && ${BUFFER:$((cursor-1)):1} == $'\n' ]]
	then
		return
	fi
	return 1
}
zvm_is_path () {
	local content="$1" 
	if [[ "$content" =~ '^~' ]]
	then
		content="${HOME}${content:1}" 
	fi
	if [[ -e "$content" ]]
	then
		return 0
	fi
	return 1
}
zvm_is_url () {
	local content="$1" 
	if [[ "$content" =~ $ZVM_URL_REGEX ]]
	then
		return 0
	fi
	return 1
}
zvm_keys () {
	local keys=${ZVM_KEYS:-$KEYS} 
	case "${ZVM_MODE}" in
		($ZVM_MODE_VISUAL) if [[ "$keys" != v* ]]
			then
				keys="v${keys}" 
			fi ;;
		($ZVM_MODE_VISUAL_LINE) if [[ "$keys" != V* ]]
			then
				keys="V${keys}" 
			fi ;;
	esac
	keys=${keys//$'\n'/$ZVM_ESCAPE_NEWLINE} 
	keys=${keys// /$ZVM_ESCAPE_SPACE} 
	echo $keys
}
zvm_kill_line () {
	local ret=($(zvm_calc_selection $ZVM_MODE_VISUAL_LINE)) 
	local bpos=${ret[1]} epos=${ret[2]} 
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}$'\n' 
	BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
	CURSOR=$bpos 
	zvm_clipboard_copy_buffer
}
zvm_kill_whole_line () {
	local ret=($(zvm_calc_selection $ZVM_MODE_VISUAL_LINE)) 
	local bpos=$ret[1] epos=$ret[2] cpos=$ret[3] 
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))}$'\n' 
	if (( $epos < $#BUFFER ))
	then
		epos=$epos+1 
	fi
	BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
	CURSOR=$cpos 
	zvm_clipboard_copy_buffer
}
zvm_match_surround () {
	local bchar=${1// /$ZVM_ESCAPE_SPACE} 
	local echar=$bchar 
	case $bchar in
		('(') echar=')'  ;;
		('[') echar=']'  ;;
		('{') echar='}'  ;;
		('<') echar='>'  ;;
		(')') bchar='(' 
			echar=')'  ;;
		(']') bchar='[' 
			echar=']'  ;;
		('}') bchar='{' 
			echar='}'  ;;
		('>') bchar='<' 
			echar='>'  ;;
		("'")  ;;
		('"')  ;;
		('`')  ;;
		(*) return ;;
	esac
	echo $bchar $echar
}
zvm_move_around_surround () {
	local slen= 
	local bpos=-1 
	local epos=-1 
	local i= s= 
	for ((i=$CURSOR; i>=0; i--)) do
		for s in {\',\",\`,\(,\[,\{,\<}
		do
			slen=${#s} 
			if [[ ${BUFFER:$i:$slen} == "$s" ]]
			then
				bpos=$i 
				break
			fi
		done
		if (($bpos == -1))
		then
			continue
		fi
		local ret=($(zvm_search_surround "$s")) 
		if [[ -z ${ret[@]} ]]
		then
			continue
		fi
		bpos=${ret[1]} 
		epos=${ret[2]} 
		if (( $CURSOR > $((bpos-1)) )) && (( $CURSOR < $((bpos+slen)) ))
		then
			CURSOR=$epos 
		else
			CURSOR=$bpos 
		fi
		break
	done
}
zvm_navigation_handler () {
	[[ -z $1 ]] && return 1
	local keys=$1 
	local count= 
	local cmd= 
	if [[ $keys =~ '^([1-9][0-9]*)?([fFtT].?)$' ]]
	then
		count=${match[1]:-1} 
		if (( ${#match[2]} < 2))
		then
			zvm_enter_oppend_mode
			read -k 1 cmd
			keys+=$cmd 
			case "$(zvm_escape_non_printed_characters ${keys[-1]})" in
				($ZVM_VI_OPPEND_ESCAPE_BINDKEY) return 1 ;;
			esac
			zvm_exit_oppend_mode
		fi
		local forward=true 
		local skip=false 
		[[ ${keys[-2]} =~ '[FT]' ]] && forward=false 
		[[ ${keys[-2]} =~ '[tT]' ]] && skip=true 
		local key=${keys[-1]} 
		if [[ $key =~ "['\\\"\`\~\^\|\#\&\*\;\}\(\)\<\>\ ]" ]]
		then
			key=\\${key} 
		fi
		cmd=(zvm_find_and_move_cursor $key $count $forward $skip) 
		count=1 
	elif [[ $keys =~ '^([1-9][0-9]*)?G$' ]]
	then
		count=${match[1]:-1} 
		cmd=(CURSOR=$#BUFFER) 
	elif [[ $keys =~ '^([1-9][0-9]*)?gg$' ]]
	then
		count=${match[1]:-1} 
		cmd=(CURSOR=0) 
	else
		count=${keys:0:-1} 
		case ${keys: -1} in
			('^') cmd=(zle vi-first-non-blank)  ;;
			('$') cmd=(zle vi-end-of-line)  ;;
			(' ') cmd=(zle vi-forward-char)  ;;
			('0') cmd=(zle vi-digit-or-beginning-of-line)  ;;
			('h') cmd=(zle vi-backward-char)  ;;
			('j') cmd=(zle down-line-or-history)  ;;
			('k') cmd=(zle up-line-or-history)  ;;
			('l') cmd=(zle vi-forward-char)  ;;
			('w') cmd=(zle vi-forward-word)  ;;
			('W') cmd=(zle vi-forward-blank-word)  ;;
			('e') cmd=(zle vi-forward-word-end)  ;;
			('E') cmd=(zle vi-forward-blank-word-end)  ;;
			('b') cmd=(zle vi-backward-word)  ;;
			('B') cmd=(zle vi-backward-blank-word)  ;;
		esac
	fi
	if [[ -z $cmd ]]
	then
		return 0
	fi
	if [[ ! $count =~ ^[0-9]+$ ]]
	then
		count=1 
	fi
	zvm_repeat_command "$cmd" $count
	local exit_code=$? 
	if [[ $exit_code == 0 ]]
	then
		retval=$keys 
	fi
	return $exit_code
}
zvm_open_line_above () {
	local i=$CURSOR 
	for ((; i>0; i--)) do
		if [[ "${BUFFER[$i]}" == $'\n' ]]
		then
			break
		fi
	done
	CURSOR=$i 
	LBUFFER+=$'\n' 
	CURSOR=$((CURSOR-1)) 
	zvm_reset_repeat_commands $ZVM_MODE_NORMAL O
	zvm_select_vi_mode $ZVM_MODE_INSERT
}
zvm_open_line_below () {
	local i=$CURSOR 
	for ((; i<$#BUFFER; i++)) do
		if ((SUFFIX_ACTIVE == 1)) && ((i >= SUFFIX_BEGIN))
		then
			break
		fi
		if [[ "${BUFFER[$i]}" == $'\n' ]]
		then
			i=$((i-1)) 
			break
		fi
	done
	CURSOR=$i 
	LBUFFER+=$'\n' 
	zvm_reset_repeat_commands $ZVM_MODE_NORMAL o
	zvm_select_vi_mode $ZVM_MODE_INSERT
}
zvm_open_under_cursor () {
	local ret=($(zvm_select_url_or_path $CURSOR $BUFFER)) 
	local bpos=${ret[1]} epos=${ret[2]} 
	local content=${BUFFER:$bpos:$((epos-bpos+1))} 
	if zvm_is_url "$content"
	then
		if [[ -n $ZVM_OPEN_URL_CMD ]]
		then
			local -a cmd
			cmd=("${(z)ZVM_OPEN_URL_CMD}") 
			"$cmd[@]" "$content"
		elif zvm_exist_command "open"
		then
			open "$content"
		elif zvm_exist_command "xdg-open"
		then
			xdg-open "$content"
		fi
	elif zvm_is_path "$content"
	then
		if [[ -n $ZVM_OPEN_FILE_CMD ]]
		then
			local -a cmd
			cmd=("${(z)ZVM_OPEN_FILE_CMD}") 
			"$cmd[@]" "$content"
		elif zvm_exist_command "open"
		then
			open "$content"
		elif zvm_exist_command "xdg-open"
		then
			xdg-open "$content"
		fi
	fi
}
zvm_parse_surround_keys () {
	local keys=${1:-${$(zvm_keys)//$ZVM_ESCAPE_SPACE/ }} 
	local action= 
	local surround= 
	case "${keys}" in
		(vS*) action=S 
			surround=${keys:2}  ;;
		(vsa*) action=a 
			surround=${keys:3}  ;;
		(vys*) action=y 
			surround=${keys:3}  ;;
		(s[dr]*) action=${keys:1:1} 
			surround=${keys:2}  ;;
		([acd]s*) action=${keys:0:1} 
			surround=${keys:2}  ;;
		([cdvy][ia]*) action=${keys:0:2} 
			surround=${keys:2}  ;;
	esac
	echo $action ${surround// /$ZVM_ESCAPE_SPACE}
}
zvm_paste_clipboard_after () {
	local content=$(zvm_clipboard_get) 
	[[ -z $content ]] && return
	local saved=$CUTBUFFER 
	CUTBUFFER=$content 
	zvm_vi_put_after
	CUTBUFFER=$saved 
}
zvm_paste_clipboard_before () {
	local content=$(zvm_clipboard_get) 
	[[ -z $content ]] && return
	local saved=$CUTBUFFER 
	CUTBUFFER=$content 
	zvm_vi_put_before
	CUTBUFFER=$saved 
}
zvm_postpone_reset_prompt () {
	local toggle=$1 
	local force=${2:-false} 
	if $force
	then
		ZVM_POSTPONE_RESET_PROMPT=1 
	fi
	if $toggle
	then
		ZVM_POSTPONE_RESET_PROMPT=0 
	else
		if (($ZVM_POSTPONE_RESET_PROMPT > 0))
		then
			ZVM_POSTPONE_RESET_PROMPT=-1 
			zle reset-prompt
		else
			ZVM_POSTPONE_RESET_PROMPT=-1 
		fi
	fi
}
zvm_range_handler () {
	local keys=$1 
	local cursor=$CURSOR 
	local key= 
	local mode= 
	local cmds=($ZVM_MODE) 
	local count=1 
	local exit_code=$ZVM_RANGE_HANDLER_RET_OK 
	zvm_enter_oppend_mode false
	while (( ${#keys} < 2 ))
	do
		zvm_update_cursor
		read -k 1 key
		keys="${keys}${key}" 
	done
	while [[ ${keys: 1} =~ ^[1-9][0-9]*$ ]]
	do
		zvm_update_cursor
		read -k 1 key
		keys="${keys}${key}" 
	done
	if [[ ${keys} =~ '^.[ia]$' ]]
	then
		zvm_update_cursor
		read -k 1 key
		keys="${keys}${key}" 
	elif [[ ${keys} =~ '^.g$' ]]
	then
		zvm_update_cursor
		read -k 1 key
		keys="${keys}${key}" 
	fi
	zvm_exit_oppend_mode
	if [[ $(zvm_escape_non_printed_characters "$keys") =~ ${ZVM_VI_OPPEND_ESCAPE_BINDKEY/\^\[/\\^\\[} ]]
	then
		return $ZVM_RANGE_HANDLER_RET_CANCEL
	fi
	if [[ $ZVM_MODE != $ZVM_MODE_VISUAL && $ZVM_MODE != $ZVM_MODE_VISUAL_LINE ]]
	then
		case "${keys}" in
			([cdy][jk]) mode=$ZVM_MODE_VISUAL_LINE  ;;
			(cc | dd | yy) mode=$ZVM_MODE_VISUAL_LINE  ;;
			(*) mode=$ZVM_MODE_VISUAL  ;;
		esac
		if [[ ! -z $mode ]]
		then
			zvm_select_vi_mode $mode false
		fi
	fi
	local navkey= 
	if [[ $keys =~ '^c([1-9][0-9]*)?[ia][wW]$' ]]
	then
		count=${match[1]:-1} 
		navkey=${keys: -2} 
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?[ia][eE]$' ]]
	then
		navkey= 
	elif [[ $keys =~ '^c([1-9][0-9]*)?[eEwW]$' ]]
	then
		count=${match[1]:-1} 
		navkey=c${keys: -1} 
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?[bB]$' ]]
	then
		MARK=$((MARK-1)) 
		count=${match[1]:-1} 
		navkey=${keys: -1} 
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?([FT].?)$' ]]
	then
		MARK=$((MARK-1)) 
		count=${match[1]:-1} 
		navkey=${match[2]} 
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?j$' ]]
	then
		count=${match[1]:-1} 
		local i= 
		for ((i=$((CURSOR+1)); i<=$#BUFFER; i++)) do
			[[ ${BUFFER[$i]} == $'\n' ]] && navkey='j' 
		done
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?k$' ]]
	then
		count=${match[1]:-1} 
		local i= 
		for ((i=$((CURSOR+1)); i>0; i--)) do
			[[ ${BUFFER[$i]} == $'\n' ]] && navkey='k' 
		done
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?[\^h0]$' ]]
	then
		MARK=$((MARK-1)) 
		count=${match[1]:-1} 
		navkey=${keys: -1} 
		if ((MARK < 0))
		then
			navkey= 
		elif [[ ${BUFFER[$MARK+1]} == $'\n' ]]
		then
			navkey= 
		fi
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?l$' ]]
	then
		count=${match[1]:-1} 
		count=$((count-1)) 
		navkey=${count}l 
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?G$' ]]
	then
		count=${match[1]:-1} 
		navkey=G 
	elif [[ $keys =~ '^[cdy]([1-9][0-9]*)?gg$' ]]
	then
		MARK=$((MARK-1)) 
		count=${match[1]:-1} 
		navkey=gg 
	elif [[ $keys =~ '^.([1-9][0-9]*)?([^0-9]+)$' ]]
	then
		count=${match[1]:-1} 
		navkey=${match[2]} 
	else
		navkey= 
	fi
	case $navkey in
		('') exit_code=$ZVM_RANGE_HANDLER_RET_CONTINUE  ;;
		(*[ia]?) if [[ -z $count ]]
			then
				count=1 
			fi
			cmd= 
			case ${navkey: -2} in
				(iw) cmd=(zle select-in-word)  ;;
				(aw) cmd=(zle select-a-word)  ;;
				(iW) cmd=(zle select-in-blank-word)  ;;
				(aW) cmd=(zle select-a-blank-word)  ;;
			esac
			if [[ -n "$cmd" ]]
			then
				zvm_repeat_command "$cmd" $count
			elif [[ -n "$(zvm_match_surround "${keys[-1]}")" ]]
			then
				ZVM_KEYS="${keys}" 
				exit_code=$ZVM_RANGE_HANDLER_RET_PUSHBACK 
			elif [[ "${keys[1]}" == 'v' ]]
			then
				exit_code=$ZVM_RANGE_HANDLER_RET_CONTINUE 
			else
				exit_code=$ZVM_RANGE_HANDLER_RET_CANCEL 
			fi ;;
		(c[eEwW]) if [[ "${BUFFER[$((CURSOR + 1))]}" == ' ' ]]
			then
				case ${navkey: -1} in
					(w) cmd=(zle vi-forward-word)  ;;
					(W) cmd=(zle vi-forward-blank-word)  ;;
					(e) cmd=(zle vi-forward-word-end)  ;;
					(E) cmd=(zle vi-forward-blank-word-end)  ;;
				esac
				zvm_repeat_command "$cmd" $count
				case ${navkey: -1} in
					(w | W) CURSOR=$((CURSOR-1))  ;;
				esac
			else
				if [[ "${BUFFER[$((CURSOR + 2))]}" == ' ' ]]
				then
					count=$((count - 1)) 
				fi
				case ${navkey: -1} in
					(e | w) cmd=(zle vi-forward-word-end)  ;;
					(E | W) cmd=(zle vi-forward-blank-word-end)  ;;
				esac
				zvm_repeat_command "$cmd" $count
			fi ;;
		(*) local retval= 
			BUFFER+=$'\0' 
			if zvm_navigation_handler "${count}${navkey}"
			then
				keys="${keys[1]}${retval}" 
			else
				exit_code=$ZVM_RANGE_HANDLER_RET_CONTINUE 
			fi
			BUFFER[-1]=''  ;;
	esac
	if [[ $exit_code != 0 ]]
	then
		return $exit_code
	fi
	if [[ $keys =~ '^[cdy]([1-9][0-9]*)?[ia][wW]$' ]]
	then
		cursor=$MARK 
	elif [[ $keys =~ '[dy]([1-9][0-9]*)?[wW]' ]]
	then
		CURSOR=$((CURSOR-1)) 
		if [[ "${BUFFER:$CURSOR:1}" == $'\n' ]]
		then
			CURSOR=$((CURSOR-1)) 
		fi
	else
		cursor=$CURSOR 
	fi
	case "${keys}" in
		(c*) zvm_vi_change false
			cursor=  ;;
		(d*) zvm_vi_delete false
			cursor=  ;;
		(y*) zvm_vi_yank false
			cursor=  ;;
		([vV]*) cursor=  ;;
	esac
	if $ZVM_REPEAT_MODE
	then
		zvm_exit_visual_mode false
	elif [[ $keys =~ '^[cd].*' ]]
	then
		cmds+=($keys) 
		zvm_reset_repeat_commands $cmds
	fi
	if [[ ! -z $cursor ]]
	then
		CURSOR=$cursor 
	fi
}
zvm_readkeys () {
	local keymap=$1 
	local key=${2:-$(zvm_keys)} 
	local keys= 
	local widget= 
	local result= 
	local pattern= 
	local timeout= 
	while :
	do
		if [[ "$key" == $'\e' ]]
		then
			while :
			do
				local k= 
				read -t $ZVM_ESCAPE_KEYTIMEOUT -k 1 k || break
				key="${key}${k}" 
			done
		fi
		keys="${keys}${key}" 
		if [[ -n "$key" ]]
		then
			local k=$(zvm_escape_non_printed_characters "${key}") 
			k=${k//\"/\\\"} 
			k=${k//\`/\\\`} 
			k=${k//$ZVM_ESCAPE_SPACE/ } 
			pattern="${pattern}${k}" 
		fi
		zvm_find_bindkey_widget $keymap "$pattern" true
		result=(${retval[@]}) 
		case ${#result[@]} in
			(2) key= 
				widget=${result[2]} 
				break ;;
			(0) break ;;
		esac
		if [[ "${keys}" == $'\e' ]]
		then
			timeout=$ZVM_ESCAPE_KEYTIMEOUT 
			local i= 
			for ((i=1; i<=${#result[@]}; i=i+2)) do
				if [[ "${result[$i]}" =~ '^\^\[\[?[A-Z0-9]*~?\^\[' ]]
				then
					timeout=$ZVM_KEYTIMEOUT 
					break
				fi
			done
		else
			timeout=$ZVM_KEYTIMEOUT 
		fi
		key= 
		if [[ "${result[1]}" == "${pattern}" ]]
		then
			widget=${result[2]} 
			read -t $timeout -k 1 key || break
		else
			zvm_enter_oppend_mode
			read -k 1 key
		fi
	done
	if $ZVM_OPPEND_MODE
	then
		zvm_exit_oppend_mode
	fi
	if [[ -z "$key" ]]
	then
		retval=(${keys} $widget) 
	else
		retval=(${keys:0:-$#key} $widget $key) 
	fi
}
zvm_readkeys_handler () {
	local keymap=${1} 
	local keys=${2:-$KEYS} 
	local key= 
	local widget= 
	if [[ -z $keymap ]]
	then
		case "$ZVM_MODE" in
			($ZVM_MODE_INSERT) keymap=viins  ;;
			($ZVM_MODE_NORMAL) keymap=vicmd  ;;
			($ZVM_MODE_VISUAL | $ZVM_MODE_VISUAL_LINE) keymap=visual  ;;
		esac
	fi
	zvm_readkeys $keymap $keys
	keys=${retval[1]} 
	widget=${retval[2]} 
	key=${retval[3]} 
	keys=${keys//$ZVM_ESCAPE_SPACE/ } 
	key=${key//$ZVM_ESCAPE_SPACE/ } 
	ZVM_KEYS="${keys}" 
	if [[ "${widget}" == "${funcstack[1]}" ]]
	then
		widget= 
	fi
	if [[ -z ${widget} ]]
	then
		ZVM_RESET_PROMPT_DISABLED=true 
		zle zvm_default_handler "$key"
		ZVM_RESET_PROMPT_DISABLED=false 
		if [[ -n "$ZVM_KEYS" ]]
		then
			zle -U -- "${ZVM_KEYS}"
		else
			zvm_postpone_reset_prompt false
		fi
	else
		zle $widget
	fi
	ZVM_KEYS= 
}
zvm_repeat_change () {
	local times=${NUMERIC:-1} 
	ZVM_REPEAT_MODE=true 
	ZVM_RESET_PROMPT_DISABLED=true 
	local cmd=${ZVM_REPEAT_COMMANDS[2]} 
	local i= 
	for ((i=0; i<$times; i++)) do
		case $cmd in
			([aioAIO]) zvm_repeat_insert ;;
			(c) zvm_repeat_vi_change ;;
			([cd]*) zvm_repeat_range_change ;;
			(R) zvm_repeat_replace ;;
			(r) zvm_repeat_replace_chars ;;
			(*) zle vi-repeat-change ;;
		esac
	done
	zle redisplay
	ZVM_RESET_PROMPT_DISABLED=false 
	ZVM_REPEAT_MODE=false 
}
zvm_repeat_command () {
	local cmd=$1 
	local count=${2:-1} 
	local is_zle_cmd=false 
	if [[ ${cmd} =~ '^zle .*' ]]
	then
		is_zle_cmd=true 
	fi
	local init_cursor=$CURSOR 
	local last_cursor=$CURSOR 
	local exit_code=0 c= 
	for ((c=0; c<count; c++)) do
		eval $cmd
		exit_code=$? 
		if $is_zle_cmd
		then
			exit_code=0 
		elif [[ $exit_code != 0 ]]
		then
			CURSOR=$init_cursor 
			break
		fi
		[[ $last_cursor == $CURSOR ]] && break
		last_cursor=$CURSOR 
	done
	return $exit_code
}
zvm_repeat_insert () {
	local cmd=${ZVM_REPEAT_COMMANDS[2]} 
	local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]}) 
	case $cmd in
		(a) CURSOR+=1  ;;
		(o) zle vi-backward-char
			zle vi-end-of-line
			LBUFFER+=$'\n'  ;;
		(A) zle vi-end-of-line
			CURSOR=$((CURSOR+1))  ;;
		(I) zle vi-first-non-blank ;;
		(O) zle vi-digit-or-beginning-of-line
			LBUFFER+=$'\n' 
			CURSOR=$((CURSOR-1))  ;;
	esac
	local i= 
	for ((i=1; i<=${#cmds[@]}; i++)) do
		cmd="${cmds[$i]}" 
		if [[ $cmd == '' ]]
		then
			if (($#LBUFFER > 0))
			then
				LBUFFER=${LBUFFER:0:-1} 
			fi
			continue
		fi
		if (($#cmd == 1))
		then
			zvm_self_insert "$cmd"
		fi
	done
}
zvm_repeat_range_change () {
	local cmd=${ZVM_REPEAT_COMMANDS[2]} 
	zvm_range_handler $cmd
	zvm_repeat_insert
}
zvm_repeat_replace () {
	local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]}) 
	local cmd= 
	local cursor=$CURSOR 
	local i= 
	for ((i=1; i<=${#cmds[@]}; i++)) do
		cmd="${cmds[$i]}" 
		if [[ $cmd == $'\n' || $BUFFER[$cursor+1] == $'\n' || $BUFFER[$cursor+1] == '' ]]
		then
			LBUFFER+=$cmd 
		else
			BUFFER[$cursor+1]=$cmd 
		fi
		cursor=$((cursor+1)) 
		CURSOR=$cursor 
	done
	zle vi-backward-char
}
zvm_repeat_replace_chars () {
	local mode=${ZVM_REPEAT_COMMANDS[1]} 
	local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]}) 
	local cmd= 
	if [[ $mode == $ZVM_MODE_VISUAL_LINE ]]
	then
		zle vi-digit-or-beginning-of-line
		cmds+=($'\n') 
	fi
	local cursor=$((CURSOR+1)) 
	local i= 
	for ((i=1; i<=${#cmds[@]}; i++)) do
		cmd="${cmds[$i]}" 
		if [[ ${BUFFER[$cursor]} == $'\n' ]]
		then
			if [[ $cmd == $'\n' ]]
			then
				cursor=$((cursor+1)) 
			fi
			continue
		fi
		if [[ $cmd == $'\n' ]]
		then
			i=$((i-1)) 
			cmd="${cmds[$i]}" 
		fi
		if (($#cmd == 1))
		then
			BUFFER[$cursor]="${cmd}" 
		fi
		cursor=$((cursor+1)) 
		if ((cursor > $#BUFFER))
		then
			break
		fi
	done
}
zvm_repeat_vi_change () {
	local mode=${ZVM_REPEAT_COMMANDS[1]} 
	local cmds=(${ZVM_REPEAT_COMMANDS[3,-1]}) 
	if [[ $mode == $ZVM_MODE_VISUAL_LINE ]]
	then
		zle vi-digit-or-beginning-of-line
	fi
	local ncount=${cmds[1]} 
	local ccount=${cmds[2]} 
	local pos=$CURSOR epos=$CURSOR 
	local i= 
	for ((i=0; i<$ncount; i++)) do
		pos=$(zvm_substr_pos $BUFFER $'\n' $pos) 
		if [[ $pos == -1 ]]
		then
			epos=$#BUFFER 
			break
		fi
		pos=$((pos+1)) 
		epos=$pos 
	done
	for ((i=0; i<$ccount; i++)) do
		local char=${BUFFER[$epos+i]} 
		if [[ $char == $'\n' || $char == '' ]]
		then
			ccount=$i 
			break
		fi
	done
	epos=$((epos+ccount)) 
	RBUFFER=${RBUFFER:$((epos-CURSOR))} 
}
zvm_replace_selection () {
	local ret=($(zvm_calc_selection)) 
	local bpos=$ret[1] epos=$ret[2] cpos=$ret[3] 
	local cutbuf=$1 
	if (( $#cutbuf > 0 ))
	then
		cpos=$(($bpos + $#cutbuf - 1)) 
	fi
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))} 
	if [[ $ZVM_MODE == $ZVM_MODE_VISUAL_LINE ]]
	then
		if (( $epos < $#BUFFER ))
		then
			epos=$epos+1 
		elif (( $bpos > 0 ))
		then
			bpos=$bpos-1 
		fi
		CUTBUFFER=${CUTBUFFER}$'\n' 
	fi
	BUFFER="${BUFFER:0:$bpos}${cutbuf}${BUFFER:$epos}" 
	CURSOR=$cpos 
	zvm_clipboard_copy_buffer
}
zvm_reset_prompt () {
	if (($ZVM_POSTPONE_RESET_PROMPT >= 0))
	then
		ZVM_POSTPONE_RESET_PROMPT=$(($ZVM_POSTPONE_RESET_PROMPT + 1)) 
		return
	fi
	if [[ $ZVM_RESET_PROMPT_DISABLED == true ]]
	then
		return
	fi
	local -i retval=0 
	if [[ -z "$rawfunc" ]]
	then
		zle .reset-prompt -- "$@"
		retval=$? 
	else
		$rawfunc -- "$@"
		retval=$? 
	fi
	return $retval
}
zvm_reset_repeat_commands () {
	ZVM_REPEAT_RESET=true 
	ZVM_REPEAT_COMMANDS=($@) 
}
zvm_search_surround () {
	local ret=($(zvm_match_surround "$1")) 
	local bchar=${${ret[1]//$ZVM_ESCAPE_SPACE/ }:- } 
	local echar=${${ret[2]//$ZVM_ESCAPE_SPACE/ }:- } 
	local bpos=$(zvm_substr_pos $BUFFER $bchar $CURSOR false) 
	local epos=$(zvm_substr_pos $BUFFER $echar $CURSOR true) 
	if [[ $bpos == $epos ]]
	then
		epos=$(zvm_substr_pos $BUFFER $echar $((CURSOR+1)) true) 
		if [[ $epos == -1 ]]
		then
			epos=$(zvm_substr_pos $BUFFER $echar $((CURSOR-1)) false) 
			if [[ $epos != -1 ]]
			then
				local tmp=$epos 
				epos=$bpos 
				bpos=$tmp 
			fi
		fi
	fi
	if [[ $bpos == -1 ]] || [[ $epos == -1 ]]
	then
		return
	fi
	echo $bpos $epos $bchar $echar
}
zvm_select_in_word () {
	local cursor=${1:-$CURSOR} 
	local buffer=${2:-$BUFFER} 
	local bpos=$cursor epos=$cursor 
	local pattern='[0-9a-zA-Z_]' 
	if ! [[ "${buffer:$cursor:1}" =~ $pattern ]]
	then
		pattern="[^${pattern:1:-1} ]" 
	fi
	for ((; $bpos>=0; bpos--)) do
		[[ "${buffer:$bpos:1}" =~ $pattern ]] || break
	done
	for ((; $epos<$#buffer; epos++)) do
		[[ "${buffer:$epos:1}" =~ $pattern ]] || break
	done
	bpos=$((bpos+1)) 
	if (( epos > 0 ))
	then
		epos=$((epos-1)) 
	fi
	echo $bpos $epos
}
zvm_select_surround () {
	local ret=($(zvm_parse_surround_keys)) 
	local action=${1:-${ret[1]}} 
	local surround=${2:-${ret[2]//$ZVM_ESCAPE_SPACE/ }} 
	ret=($(zvm_search_surround ${surround})) 
	if [[ ${#ret[@]} == 0 ]]
	then
		zvm_exit_visual_mode
		return
	fi
	local bpos=${ret[1]} 
	local epos=${ret[2]} 
	if [[ ${action:1:1} == 'i' ]]
	then
		((bpos++))
	else
		((epos++))
	fi
	MARK=$bpos 
	CURSOR=$epos-1 
	zle redisplay
}
zvm_select_url_or_path () {
	local cursor=${1:-$CURSOR} 
	local buffer=${2:-$BUFFER} 
	local bpos= epos= 
	local _bpos=0 _epos=$#buffer 
	local content= 
	for ((bpos=$cursor; $bpos>=0; bpos--)) do
		if [[ "${buffer:$bpos:1}" == $'\n' ]]
		then
			_bpos=$((bpos+1)) 
			break
		fi
	done
	for ((epos=$cursor; $epos<$#buffer; epos++)) do
		if [[ "${buffer:$epos:1}" == $'\n' ]]
		then
			_epos=$epos 
			break
		fi
	done
	for ((bpos=$_bpos; $bpos<=$cursor; bpos++)) do
		for ((epos=$((_epos-1)); $epos>=$cursor; epos--)) do
			content=${buffer:$bpos:$((epos-bpos+1))} 
			if zvm_is_url "$content" || zvm_is_path "$content"
			then
				echo $bpos $epos
				return
			fi
		done
	done
	echo $cursor $cursor
}
zvm_select_vi_mode () {
	local mode=$1 
	local reset_prompt=${2:-true} 
	if [[ $mode == "$ZVM_MODE" ]]
	then
		zvm_update_cursor
		return
	fi
	zvm_exec_commands 'before_select_vi_mode'
	zvm_postpone_reset_prompt true
	if $ZVM_OPPEND_MODE
	then
		zvm_exit_oppend_mode false
	fi
	case $mode in
		($ZVM_MODE_NORMAL) ZVM_MODE=$ZVM_MODE_NORMAL 
			zvm_update_cursor
			zle vi-cmd-mode ;;
		($ZVM_MODE_INSERT) ZVM_MODE=$ZVM_MODE_INSERT 
			zvm_update_cursor
			zle vi-insert ;;
		($ZVM_MODE_VISUAL) ZVM_MODE=$ZVM_MODE_VISUAL 
			zvm_update_cursor
			zle visual-mode ;;
		($ZVM_MODE_VISUAL_LINE) ZVM_MODE=$ZVM_MODE_VISUAL_LINE 
			zvm_update_cursor
			zle visual-line-mode ;;
		($ZVM_MODE_REPLACE) ZVM_MODE=$ZVM_MODE_REPLACE 
			zvm_enter_oppend_mode ;;
	esac
	zvm_exec_commands 'after_select_vi_mode'
	$reset_prompt && zvm_postpone_reset_prompt false true
	if [[ $mode == $ZVM_MODE_NORMAL ]] && (( $#ZVM_LAZY_KEYBINDINGS_LIST > 0 ))
	then
		zvm_exec_commands 'before_lazy_keybindings'
		local list=("${ZVM_LAZY_KEYBINDINGS_LIST[@]}") 
		unset ZVM_LAZY_KEYBINDINGS_LIST
		for r in "${list[@]}"
		do
			eval "zvm_bindkey ${r}"
		done
		zvm_exec_commands 'after_lazy_keybindings'
	fi
}
zvm_selection () {
	local bpos= epos= 
	if (( MARK > CURSOR ))
	then
		bpos=$CURSOR epos=$((MARK+1)) 
	else
		bpos=$MARK epos=$((CURSOR+1)) 
	fi
	echo $bpos $epos
}
zvm_self_insert () {
	local keys=${1:-$KEYS} 
	if [[ ${POSTDISPLAY:0:$#keys} == $keys ]]
	then
		POSTDISPLAY=${POSTDISPLAY:$#keys} 
	else
		POSTDISPLAY= 
	fi
	LBUFFER+=${keys} 
}
zvm_set_cursor () {
	if [[ -n $VIM ]]
	then
		return
	fi
	echo -ne "$1"
}
zvm_string_to_hex () {
	local str= i= 
	for ((i=1; i<=$#1; i++)) do
		str+=$(printf '%x' "'${1[$i]}") 
	done
	echo "$str"
}
zvm_substr_pos () {
	local pos=-1 
	local len=${#1} 
	local slen=${#2} 
	local i=${3:-0} 
	local forward=${4:-true} 
	local init=${i:-$($forward && echo "$i" || echo "i=$len-1")} 
	local condition=$($forward && echo "i<$len" || echo "i>=0") 
	local step=$($forward && echo 'i++' || echo 'i--') 
	for (($init; $condition; $step)) do
		if [[ ${1:$i:$slen} == "$2" ]]
		then
			pos=$i 
			break
		fi
	done
	echo $pos
}
zvm_switch_boolean () {
	local word=$1 
	local increase=$2 
	local result= 
	local bpos=0 epos=$#word 
	if [[ $word =~ (^[+-]{0,2}) ]]
	then
		local prefix=${match[1]} 
		bpos=$mend 
		word=${word:$bpos} 
	fi
	case ${(L)word} in
		(true) result=false  ;;
		(false) result=true  ;;
		(yes) result=no  ;;
		(no) result=yes  ;;
		(on) result=off  ;;
		(off) result=on  ;;
		(y) result=n  ;;
		(n) result=y  ;;
		(t) result=f  ;;
		(f) result=t  ;;
		(*) return ;;
	esac
	if [[ $word =~ ^[A-Z]+$ ]]
	then
		result=${(U)result} 
	elif [[ $word =~ ^[A-Z] ]]
	then
		result=${(U)result:0:1}${result:1} 
	fi
	echo $result $bpos $epos
}
zvm_switch_keyword () {
	local bpos= epos= cpos=$CURSOR 
	if [[ ${BUFFER:$cpos:2} =~ [+-][0-9] ]]
	then
		if [[ $cpos == 0 || ${BUFFER:$((cpos-1)):1} =~ [^0-9] ]]
		then
			cpos=$((cpos+1)) 
		fi
	elif [[ ${BUFFER:$cpos:2} =~ [+-][a-zA-Z] ]]
	then
		if [[ $cpos == 0 || ${BUFFER:$((cpos-1)):1} == ' ' ]]
		then
			cpos=$((cpos+1)) 
		fi
	fi
	local result=($(zvm_select_in_word $cpos)) 
	bpos=${result[1]} epos=$((${result[2]}+1)) 
	if [[ $bpos != 0 && ${BUFFER:$((bpos-1)):1} == [+-] ]]
	then
		bpos=$((bpos-1)) 
	fi
	local word=${BUFFER:$bpos:$((epos-bpos))} 
	local keys=$(zvm_keys) 
	if [[ $keys == '' ]]
	then
		local increase=true 
	else
		local increase=false 
	fi
	for handler in $zvm_switch_keyword_handlers
	do
		if ! zvm_exist_command ${handler}
		then
			continue
		fi
		result=($($handler $word $increase)) 
		if (( $#result == 0 ))
		then
			continue
		fi
		epos=$(( bpos + ${result[3]} )) 
		bpos=$(( bpos + ${result[2]} )) 
		if (( cpos < bpos )) || (( cpos >= epos ))
		then
			continue
		fi
		zvm_switch_keyword_history+=("${handler}:${word}") 
		zvm_switch_keyword_history=("${zvm_switch_keyword_history[@]: -10}") 
		BUFFER="${BUFFER:0:$bpos}${result[1]}${BUFFER:$epos}" 
		CURSOR=$((bpos + ${#result[1]} - 1)) 
		zle reset-prompt
		return
	done
}
zvm_switch_month () {
	local word=$1 
	local increase=$2 
	local result=${(L)word} 
	local months=(january february march april may june july august september october november december) 
	local i=1 
	for ((; i<=${#months[@]}; i++)) do
		if [[ ${months[i]:0:$#result} == ${result} ]]
		then
			result=${months[i]} 
			break
		fi
	done
	if (( i > ${#months[@]} ))
	then
		return
	fi
	if $increase
	then
		if (( i == ${#months[@]} ))
		then
			i=1 
		else
			i=$((i+1)) 
		fi
	else
		if (( i == 1 ))
		then
			i=${#months[@]} 
		else
			i=$((i-1)) 
		fi
	fi
	local lastlen=0 
	local last="${zvm_switch_keyword_history[-1]}" 
	local funcmark="${funcstack[1]}:" 
	if [[ "$last" =~ "^${funcmark}" ]]
	then
		lastlen=$(($#last - $#funcmark)) 
	fi
	if [[ "$result" == "may" ]]
	then
		if (($lastlen == 3))
		then
			result=${months[i]:0:3} 
		else
			result=${months[i]} 
		fi
	else
		if (($#word == 3))
		then
			result=${months[i]:0:3} 
		else
			result=${months[i]} 
		fi
	fi
	if [[ $word =~ ^[A-Z]+$ ]]
	then
		result=${(U)result} 
	elif [[ $word =~ ^[A-Z] ]]
	then
		result=${(U)result:0:1}${result:1} 
	fi
	echo $result 0 $#word
}
zvm_switch_number () {
	local word=$1 
	local increase=${2:-true} 
	local result= bpos= epos= 
	if [[ $word =~ [^0-9]?(0[xX][0-9a-fA-F]*) ]]
	then
		local number=${match[1]} 
		local prefix=${number:0:2} 
		bpos=$((mbegin-1)) epos=$mend 
		local lower=true 
		if [[ $number =~ [A-Z][0-9]*$ ]]
		then
			lower=false 
		fi
		if (( $#number > 17 ))
		then
			local d=$(($#number - 15)) 
			local h=${number:0:$d} 
			number="0x${number:$d}" 
		fi
		local p=$(($#number - 2)) 
		if $increase
		then
			if (( $number == 0x${(l:15::f:)} ))
			then
				h=$(([##16]$h+1)) 
				h=${h: -1} 
				number=${(l:15::0:)} 
			else
				h=${h:2} 
				number=$(([##16]$number + 1)) 
			fi
		else
			if (( $number == 0 ))
			then
				if (( ${h:-0} == 0 ))
				then
					h=f 
				else
					h=$(([##16]$h-1)) 
					h=${h: -1} 
				fi
				number=${(l:15::f:)} 
			else
				h=${h:2} 
				number=$(([##16]$number - 1)) 
			fi
		fi
		if (( $#number < $p ))
		then
			number=${(l:$p::0:)number} 
		fi
		result="${h}${number}" 
		if $lower
		then
			result="${(L)result}" 
		fi
		result="${prefix}${result}" 
	elif [[ $word =~ [^0-9]?(0[bB][01]*) ]]
	then
		local number=${match[1]} 
		local prefix=${number:0:2} 
		bpos=$((mbegin-1)) epos=$mend 
		if (( $#number > 65 ))
		then
			local d=$(($#number - 63)) 
			local h=${number:0:$d} 
			number="0b${number:$d}" 
		fi
		local p=$(($#number - 2)) 
		if $increase
		then
			if (( $number == 0b${(l:63::1:)} ))
			then
				h=$(([##2]$h+1)) 
				h=${h: -1} 
				number=${(l:63::0:)} 
			else
				h=${h:2} 
				number=$(([##2]$number + 1)) 
			fi
		else
			if (( $number == 0b0 ))
			then
				if (( ${h:-0} == 0 ))
				then
					h=1 
				else
					h=$(([##2]$h-1)) 
					h=${h: -1} 
				fi
				number=${(l:63::1:)} 
			else
				h=${h:2} 
				number=$(([##2]$number - 1)) 
			fi
		fi
		if (( $#number < $p ))
		then
			number=${(l:$p::0:)number} 
		fi
		result="${prefix}${number}" 
	elif [[ $word =~ ([-+]?[0-9]+) ]]
	then
		local number=${match[1]} 
		bpos=$((mbegin-1)) epos=$mend 
		if $increase
		then
			result=$(($number + 1)) 
		else
			result=$(($number - 1)) 
		fi
		if [[ ${word:$bpos:1} == '+' ]]
		then
			result="+${result}" 
		fi
	fi
	if [[ -n $result ]]
	then
		echo $result $bpos $epos
	fi
}
zvm_switch_operator () {
	local word=$1 
	local increase=$2 
	local result= 
	case ${(L)word} in
		('&&') result='||'  ;;
		('||') result='&&'  ;;
		('++') result='--'  ;;
		('--') result='++'  ;;
		('==') result='!='  ;;
		('!=') result='=='  ;;
		('===') result='!=='  ;;
		('!==') result='==='  ;;
		('+') result='-'  ;;
		('-') result='*'  ;;
		('*') result='/'  ;;
		('/') result='+'  ;;
		('and') result='or'  ;;
		('or') result='and'  ;;
		(*) return ;;
	esac
	if [[ $word =~ ^[A-Z]+$ ]]
	then
		result=${(U)result} 
	elif [[ $word =~ ^[A-Z] ]]
	then
		result=${(U)result:0:1}${result:1} 
	fi
	printf "%s 0 $#word" "${result}"
}
zvm_switch_weekday () {
	local word=$1 
	local increase=$2 
	local result=${(L)word} 
	local weekdays=(sunday monday tuesday wednesday thursday friday saturday) 
	local i=1 
	for ((; i<=${#weekdays[@]}; i++)) do
		if [[ ${weekdays[i]:0:$#result} == ${result} ]]
		then
			result=${weekdays[i]} 
			break
		fi
	done
	if (( i > ${#weekdays[@]} ))
	then
		return
	fi
	if $increase
	then
		if (( i == ${#weekdays[@]} ))
		then
			i=1 
		else
			i=$((i+1)) 
		fi
	else
		if (( i == 1 ))
		then
			i=${#weekdays[@]} 
		else
			i=$((i-1)) 
		fi
	fi
	if (( $#result == $#word ))
	then
		result=${weekdays[i]} 
	else
		result=${weekdays[i]:0:$#word} 
	fi
	if [[ $word =~ ^[A-Z]+$ ]]
	then
		result=${(U)result} 
	elif [[ $word =~ ^[A-Z] ]]
	then
		result=${(U)result:0:1}${result:1} 
	fi
	echo $result 0 $#word
}
zvm_system_report () {
	local os_info= 
	case "$(uname -s)" in
		(Darwin) local product="$(sw_vers -productName)" 
			local version="$(sw_vers -productVersion) ($(sw_vers -buildVersion))" 
			os_info="${product} ${version}"  ;;
		(*) os_info="$(uname -s) ($(uname -r) $(uname -v) $(uname -m) $(uname -o))"  ;;
	esac
	local term_info="${TERM_PROGRAM:-unknown} ${TERM_PROGRAM_VERSION:-unknown}" 
	term_info="${term_info} (${TERM})" 
	local zsh_frameworks=() 
	if zvm_exist_command "omz"
	then
		zsh_frameworks+=("oh-my-zsh $(omz version)") 
	fi
	if zvm_exist_command "starship"
	then
		zsh_frameworks+=("$(starship --version | head -n 1)") 
	fi
	if zvm_exist_command "antigen"
	then
		zsh_frameworks+=("$(antigen version | head -n 1)") 
	fi
	if zvm_exist_command "zplug"
	then
		zsh_frameworks+=("zplug $(zplug --version | head -n 1)") 
	fi
	if zvm_exist_command "zinit"
	then
		local version=$(zinit version \
      | head -n 1 \
      | sed -E $'s/(\033\[[a-zA-Z0-9;]+ ?m)//g') 
		zsh_frameworks+=("${version}") 
	fi
	local shell=$SHELL 
	if [[ -z $shell ]]
	then
		shell=zsh 
	fi
	print - "- Terminal program: ${term_info}"
	print - "- Operating system: ${os_info}"
	print - "- ZSH framework: ${(j:, :)zsh_frameworks}"
	print - "- ZSH version: $($shell --version)"
	print - "- ZVM version: $(zvm_version | head -n 1)"
}
zvm_update_cursor () {
	$ZVM_CURSOR_STYLE_ENABLED || return
	local mode=$1 
	local shape= 
	if $ZVM_OPPEND_MODE
	then
		mode=opp 
		shape=$(zvm_cursor_style $ZVM_OPPEND_MODE_CURSOR) 
	fi
	case "${mode:-$ZVM_MODE}" in
		($ZVM_MODE_NORMAL) shape=$(zvm_cursor_style $ZVM_NORMAL_MODE_CURSOR)  ;;
		($ZVM_MODE_INSERT) shape=$(zvm_cursor_style $ZVM_INSERT_MODE_CURSOR)  ;;
		($ZVM_MODE_VISUAL) shape=$(zvm_cursor_style $ZVM_VISUAL_MODE_CURSOR)  ;;
		($ZVM_MODE_VISUAL_LINE) shape=$(zvm_cursor_style $ZVM_VISUAL_LINE_MODE_CURSOR)  ;;
	esac
	if [[ -n $shape ]]
	then
		zvm_set_cursor $shape
	fi
}
zvm_update_highlight () {
	case "$ZVM_MODE" in
		($ZVM_MODE_VISUAL | $ZVM_MODE_VISUAL_LINE) zvm_highlight ;;
	esac
}
zvm_update_repeat_commands () {
	$ZVM_REPEAT_MODE && return
	if $ZVM_REPEAT_RESET
	then
		ZVM_REPEAT_RESET=false 
		return
	fi
	[[ $ZVM_MODE == $ZVM_MODE_INSERT ]] || return
	local char=$KEYS 
	if [[ "$KEYS" =~ '\[[ABCD]' ]]
	then
		if [[ ${ZVM_REPEAT_COMMANDS[-1]} =~ '\[[ABCD]' ]]
		then
			ZVM_REPEAT_COMMANDS=(${ZVM_REPEAT_COMMANDS[@]:0:-1}) 
		fi
	else
		if [[ ${ZVM_REPEAT_COMMANDS[-1]} =~ '\[[ABCD]' ]]
		then
			zvm_reset_repeat_commands $ZVM_MODE_NORMAL i
		fi
		char=${BUFFER[$CURSOR]} 
	fi
	if [[ "$KEYS" == '' ]]
	then
		if ((${#ZVM_REPEAT_COMMANDS[@]} > 2)) && [[ ${ZVM_REPEAT_COMMANDS[-1]} != '' ]]
		then
			ZVM_REPEAT_COMMANDS=(${ZVM_REPEAT_COMMANDS[@]:0:-1}) 
		elif (($#LBUFFER > 0))
		then
			ZVM_REPEAT_COMMANDS+=($KEYS) 
		fi
	else
		ZVM_REPEAT_COMMANDS+=($char) 
	fi
}
zvm_version () {
	local git_info=$(git show -s --format="(%h, %ci)" 2>/dev/null) 
	echo -e "$ZVM_NAME $ZVM_VERSION $git_info"
	echo -e "\e[4m$ZVM_REPOSITORY\e[0m"
	echo -e "$ZVM_DESCRIPTION"
}
zvm_vi_change () {
	local ret=($(zvm_calc_selection)) 
	local bpos=$ret[1] epos=$ret[2] 
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))} 
	if [[ $ZVM_MODE == $ZVM_MODE_VISUAL_LINE ]]
	then
		CUTBUFFER=${CUTBUFFER}$'\n' 
	fi
	BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
	CURSOR=$bpos 
	zvm_clipboard_copy_buffer
	$ZVM_REPEAT_MODE && return
	if [[ $ZVM_MODE != $ZVM_MODE_NORMAL ]]
	then
		local npos=0 ncount=0 ccount=0 
		while :
		do
			npos=$(zvm_substr_pos $CUTBUFFER $'\n' $npos) 
			if [[ $npos == -1 ]]
			then
				if (($ncount == 0))
				then
					ccount=$#CUTBUFFER 
				fi
				break
			fi
			npos=$((npos+1)) 
			ncount=$(($ncount + 1)) 
			ccount=$(($#CUTBUFFER - $npos)) 
		done
		zvm_reset_repeat_commands $ZVM_MODE c $ncount $ccount
	fi
	zvm_exit_visual_mode false
	zvm_select_vi_mode $ZVM_MODE_INSERT ${1:-true}
}
zvm_vi_change_eol () {
	local bpos=$CURSOR epos=$CURSOR 
	for ((; $epos<$#BUFFER; epos++)) do
		if [[ "${BUFFER:$epos:1}" == $'\n' ]]
		then
			break
		fi
	done
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))} 
	BUFFER="${BUFFER:0:$bpos}${BUFFER:$epos}" 
	zvm_clipboard_copy_buffer
	zvm_reset_repeat_commands $ZVM_MODE c 0 $#CUTBUFFER
	zvm_select_vi_mode $ZVM_MODE_INSERT
}
zvm_vi_delete () {
	zvm_replace_selection
	zvm_exit_visual_mode ${1:-true}
}
zvm_vi_down_case () {
	local ret=($(zvm_selection)) 
	local bpos=${ret[1]} epos=${ret[2]} 
	local content=${BUFFER:$bpos:$((epos-bpos))} 
	BUFFER="${BUFFER:0:$bpos}${(L)content}${BUFFER:$epos}" 
	zvm_exit_visual_mode
}
zvm_vi_edit_command_line () {
	local tmp_file=$(mktemp ${ZVM_TMPDIR}/zshXXXXXX) 
	echo "$BUFFER" >| "$tmp_file"
	"${(@Q)${(z)${ZVM_VI_EDITOR}}}" $tmp_file < /dev/tty
	BUFFER=$(cat "$tmp_file") 
	rm "$tmp_file"
	case $ZVM_MODE in
		($ZVM_MODE_VISUAL | $ZVM_MODE_VISUAL_LINE) zvm_exit_visual_mode ;;
	esac
}
zvm_vi_opp_case () {
	local ret=($(zvm_selection)) 
	local bpos=${ret[1]} epos=${ret[2]} 
	local content=${BUFFER:$bpos:$((epos-bpos))} 
	local i= 
	for ((i=1; i<=$#content; i++)) do
		if [[ ${content[i]} =~ [A-Z] ]]
		then
			content[i]=${(L)content[i]} 
		elif [[ ${content[i]} =~ [a-z] ]]
		then
			content[i]=${(U)content[i]} 
		fi
	done
	BUFFER="${BUFFER:0:$bpos}${content}${BUFFER:$epos}" 
	zvm_exit_visual_mode
}
zvm_vi_put_after () {
	local count=${NUMERIC:-1} 
	local head= foot= 
	local content=${CUTBUFFER} 
	local offset=1 
	if [[ ${content: -1} == $'\n' ]]
	then
		local pos=${CURSOR} 
		for ((; $pos<$#BUFFER; pos++)) do
			if [[ ${BUFFER:$pos:1} == $'\n' ]]
			then
				pos=$pos+1 
				break
			fi
		done
		head=${BUFFER:0:$pos} 
		foot=${BUFFER:$pos} 
		if ! zvm_is_empty_line
		then
			if [[ $pos == $#BUFFER ]]
			then
				content=$'\n'${content:0:-1} 
				pos=$pos+1 
				head=${BUFFER:0:$pos} 
				foot=${BUFFER:$pos} 
			fi
		fi
		local repeated= i= 
		for ((i=1; i<=count; i++)) do
			repeated+="$content" 
		done
		offset=0 
		BUFFER="${head}${repeated}${foot}" 
		CURSOR=$pos 
	else
		local char_at_cursor=${BUFFER:$CURSOR:1} 
		if zvm_is_empty_line
		then
			head="${BUFFER:0:$((CURSOR-1))}" 
			foot="${BUFFER:$CURSOR}" 
		else
			head="${BUFFER:0:$CURSOR}" 
			foot="${BUFFER:$((CURSOR+1))}" 
		fi
		local repeated= i= 
		for ((i=1; i<=count; i++)) do
			repeated+="$content" 
		done
		BUFFER="${head}${char_at_cursor}${repeated}${foot}" 
		CURSOR=$CURSOR+$#repeated 
	fi
	zvm_highlight clear
	zvm_highlight custom $(($#head+$offset)) $(($#head+$#repeated+$offset))
}
zvm_vi_put_before () {
	local count=${NUMERIC:-1} 
	local head= foot= 
	local content=${CUTBUFFER} 
	if [[ ${content: -1} == $'\n' ]]
	then
		local pos=$CURSOR 
		for ((; $pos>0; pos--)) do
			if [[ "${BUFFER:$pos:1}" == $'\n' ]]
			then
				pos=$pos+1 
				break
			fi
		done
		if zvm_is_empty_line
		then
			head=${BUFFER:0:$((pos-1))} 
			foot=$'\n'${BUFFER:$pos} 
			pos=$((pos-1)) 
		else
			head=${BUFFER:0:$pos} 
			foot=${BUFFER:$pos} 
		fi
		local repeated= i= 
		for ((i=1; i<=count; i++)) do
			repeated+="$content" 
		done
		BUFFER="${head}${repeated}${foot}" 
		CURSOR=$pos 
	else
		head="${BUFFER:0:$CURSOR}" 
		foot="${BUFFER:$((CURSOR+1))}" 
		local repeated= i= 
		for ((i=1; i<=count; i++)) do
			repeated+="$content" 
		done
		BUFFER="${head}${repeated}${BUFFER:$CURSOR:1}${foot}" 
		CURSOR=$CURSOR+$#repeated 
		CURSOR=$((CURSOR-1)) 
	fi
	zvm_highlight clear
	zvm_highlight custom $#head $(($#head+$#repeated))
}
zvm_vi_replace () {
	if [[ $ZVM_MODE == $ZVM_MODE_NORMAL ]]
	then
		local cursor=$CURSOR 
		local cache=() 
		local cmds=() 
		local key= 
		zvm_select_vi_mode $ZVM_MODE_REPLACE
		while :
		do
			zvm_update_cursor
			zle -R
			read -k 1 key
			case $(zvm_escape_non_printed_characters $key) in
				('^[' | $ZVM_VI_OPPEND_ESCAPE_BINDKEY) break ;;
				('^M') key=$'\n'  ;;
			esac
			if [[ $key == '' ]]
			then
				if ((cursor > 0))
				then
					cursor=$((cursor-1)) 
				fi
				if ((${#cache[@]} > 0))
				then
					key=${cache[-1]} 
					if [[ $key == '<I>' ]]
					then
						key= 
					fi
					cache=(${cache[@]:0:-1}) 
					BUFFER[$cursor+1]=$key 
					cmds=(${cmds[@]:0:-1}) 
				fi
			else
				if [[ $key == $'\n' || $BUFFER[$cursor+1] == $'\n' || $BUFFER[$cursor+1] == '' ]]
				then
					cache+=('<I>') 
					LBUFFER+=$key 
				else
					cache+=(${BUFFER[$cursor+1]}) 
					BUFFER[$cursor+1]=$key 
				fi
				cursor=$((cursor+1)) 
				cmds+=($key) 
			fi
			CURSOR=$cursor 
			zle redisplay
		done
		zle vi-backward-char
		zvm_select_vi_mode $ZVM_MODE_NORMAL
		zvm_reset_repeat_commands $ZVM_MODE R $cmds
	elif [[ $ZVM_MODE == $ZVM_MODE_VISUAL ]]
	then
		zvm_enter_visual_mode V
		zvm_vi_change
	elif [[ $ZVM_MODE == $ZVM_MODE_VISUAL_LINE ]]
	then
		zvm_vi_change
	fi
}
zvm_vi_replace_chars () {
	local cmds=() 
	local key= 
	zvm_enter_oppend_mode
	zle redisplay
	zle -R
	read -k 1 key
	zvm_exit_oppend_mode
	case $(zvm_escape_non_printed_characters $key) in
		($ZVM_VI_OPPEND_ESCAPE_BINDKEY) zvm_exit_visual_mode
			return ;;
	esac
	if [[ $ZVM_MODE == $ZVM_MODE_NORMAL ]]
	then
		cmds+=($key) 
		BUFFER[$CURSOR+1]=$key 
	else
		local ret=($(zvm_calc_selection)) 
		local bpos=${ret[1]} epos=${ret[2]} 
		for ((bpos=bpos+1; bpos<=epos; bpos++)) do
			if [[ $BUFFER[$bpos] == $'\n' ]]
			then
				cmds+=($'\n') 
				continue
			fi
			cmds+=($key) 
			BUFFER[$bpos]=$key 
		done
		zvm_exit_visual_mode
	fi
	zvm_reset_repeat_commands $ZVM_MODE r $cmds
}
zvm_vi_replace_selection () {
	zvm_replace_selection $CUTBUFFER
	zvm_exit_visual_mode ${1:-true}
}
zvm_vi_substitute () {
	if [[ $ZVM_MODE == $ZVM_MODE_NORMAL ]]
	then
		BUFFER="${BUFFER:0:$CURSOR}${BUFFER:$((CURSOR+1))}" 
		zvm_reset_repeat_commands $ZVM_MODE c 0 1
		zvm_select_vi_mode $ZVM_MODE_INSERT
	else
		zvm_vi_change
	fi
}
zvm_vi_substitute_whole_line () {
	zvm_select_vi_mode $ZVM_MODE_VISUAL_LINE false
	zvm_vi_substitute
}
zvm_vi_up_case () {
	local ret=($(zvm_selection)) 
	local bpos=${ret[1]} epos=${ret[2]} 
	local content=${BUFFER:$bpos:$((epos-bpos))} 
	BUFFER="${BUFFER:0:$bpos}${(U)content}${BUFFER:$epos}" 
	zvm_exit_visual_mode
}
zvm_vi_yank () {
	zvm_yank
	zvm_exit_visual_mode ${1:-true}
}
zvm_viins_undo () {
	if $ZVM_VI_INSERT_MODE_LEGACY_UNDO
	then
		zvm_kill_line
	else
		zvm_backward_kill_line
	fi
}
zvm_visual_paste_clipboard () {
	local content=$(zvm_clipboard_get) 
	if [[ -z $content ]]
	then
		zvm_exit_visual_mode
		return
	fi
	local ret=($(zvm_calc_selection)) 
	local bpos=$ret[1] epos=$ret[2] 
	local cpos=$((bpos + $#content - 1)) 
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))} 
	BUFFER="${BUFFER:0:$bpos}${content}${BUFFER:$epos}" 
	CURSOR=$cpos 
	zvm_exit_visual_mode
}
zvm_widget_wrapper () {
	local rawfunc=$1 
	local func=$2 
	local called=$3 
	local -i retval=0 
	if ! $called
	then
		$rawfunc "${@:4}"
		retval=$? 
	fi
	$func "${@:4}"
	[[ $retval -eq 0 ]] && retval=$? 
	return $retval
}
zvm_yank () {
	local ret=($(zvm_calc_selection $1)) 
	local bpos=$ret[1] epos=$ret[2] cpos=$ret[3] 
	CUTBUFFER=${BUFFER:$bpos:$((epos-bpos))} 
	if [[ ${1:-$ZVM_MODE} == $ZVM_MODE_VISUAL_LINE ]]
	then
		CUTBUFFER=${CUTBUFFER}$'\n' 
	fi
	CURSOR=$bpos MARK=$epos 
	zvm_clipboard_copy_buffer
}
zvm_zle-line-finish () {
	local shape=$(zvm_cursor_style $ZVM_CURSOR_USER_DEFAULT) 
	zvm_set_cursor $shape
	zvm_switch_keyword_history=() 
}
zvm_zle-line-init () {
	local mode=${ZVM_MODE:-$ZVM_MODE_INSERT} 
	zvm_select_vi_mode $ZVM_MODE_INSERT false
	case ${ZVM_LINE_INIT_MODE:-$mode} in
		($ZVM_MODE_INSERT) zvm_select_vi_mode $ZVM_MODE_INSERT ;;
		(*) zvm_select_vi_mode $ZVM_MODE_NORMAL ;;
	esac
}
zvm_zle-line-pre-redraw () {
	if [[ -n $TMUX ]]
	then
		zvm_update_cursor
		[[ "$TERMINAL_EMULATOR" == "JetBrains-JediTerm" ]] && zle redisplay
	fi
	zvm_update_highlight
	zvm_update_repeat_commands
}

# setopts 18
setopt alwaystoend
setopt autocd
setopt autopushd
setopt completeinword
setopt extendedhistory
setopt noflowcontrol
setopt nohashdirs
setopt histexpiredupsfirst
setopt histignoredups
setopt histignorespace
setopt histverify
setopt interactivecomments
setopt login
setopt longlistjobs
setopt promptsubst
setopt pushdignoredups
setopt pushdminus
setopt sharehistory

# aliases 252
alias -- -='cd -'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -g .....=../../../..
alias -g ......=../../../../..
alias 1='cd -1'
alias 2='cd -2'
alias 3='cd -3'
alias 4='cd -4'
alias 5='cd -5'
alias 6='cd -6'
alias 7='cd -7'
alias 8='cd -8'
alias 9='cd -9'
alias _='sudo '
alias cd=zd
alias current_branch=$'\n    print -Pu2 "%F{yellow}[oh-my-zsh] \'%F{red}current_branch%F{yellow}\' is deprecated, using \'%F{green}git_current_branch%F{yellow}\' instead.%f"\n    git_current_branch'
alias d=docker
alias decompress='tar -xzf'
alias dockilla='docker kill $(docker ps -q)'
alias egrep='grep -E'
alias ff='fzf --preview '\''bat --style=numbers --color=always {}'\'
alias fgrep='grep -F'
alias g=git
alias ga='git add'
alias gaa='git add --all'
alias gam='git am'
alias gama='git am --abort'
alias gamc='git am --continue'
alias gams='git am --skip'
alias gamscp='git am --show-current-patch'
alias gap='git apply'
alias gapa='git add --patch'
alias gapt='git apply --3way'
alias gau='git add --update'
alias gav='git add --verbose'
alias gb='git branch'
alias gbD='git branch --delete --force'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbg='LANG=C git branch -vv | grep ": gone\]"'
alias gbgD='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -D'
alias gbgd='LANG=C git branch --no-color -vv | grep ": gone\]" | cut -c 3- | awk '\''{print $1}'\'' | xargs git branch -d'
alias gbl='git blame -w'
alias gbm='git branch --move'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsn='git bisect new'
alias gbso='git bisect old'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit --verbose'
alias gc!='git commit --verbose --amend'
alias gcB='git checkout -B'
alias gca='git commit --verbose --all'
alias gca!='git commit --verbose --all --amend'
alias gcad='git commit -a --amend'
alias gcam='git commit -a -m'
alias gcan!='git commit --verbose --all --no-edit --amend'
alias gcann!='git commit --verbose --all --date=now --no-edit --amend'
alias gcans!='git commit --verbose --all --signoff --no-edit --amend'
alias gcas='git commit --all --signoff'
alias gcasm='git commit --all --signoff --message'
alias gcb='git checkout -b'
alias gcd='git checkout $(git_develop_branch)'
alias gcf='git config --list'
alias gcfu='git commit --fixup'
alias gcl='git clone --recurse-submodules'
alias gclean='git clean --interactive -d'
alias gclf='git clone --recursive --shallow-submodules --filter=blob:none --also-filter-submodules'
alias gcm='git commit -m'
alias gcmsg='git commit --message'
alias gcn='git commit --verbose --no-edit'
alias gcn!='git commit --verbose --no-edit --amend'
alias gco='git checkout'
alias gcor='git checkout --recurse-submodules'
alias gcount='git shortlog --summary --numbered'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit --gpg-sign'
alias gcsm='git commit --signoff --message'
alias gcss='git commit --gpg-sign --signoff'
alias gcssm='git commit --gpg-sign --signoff --message'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdct='git describe --tags $(git rev-list --tags --max-count=1)'
alias gdcw='git diff --cached --word-diff'
alias gds='git diff --staged'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdup='git diff @{upstream}'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --tags --prune --jobs=10'
alias gfg='git ls-files | grep'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpull='git pull origin "$(git_current_branch)"'
alias ggpur=ggu
alias ggpush='git push origin "$(git_current_branch)"'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github $(git_main_branch):svntrunk'
alias gk='\gitk --all --branches &!'
alias gke='\gitk --all $(git log --walk-reflogs --pretty=%h) &!'
alias gl='git pull'
alias glg='git log --stat'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glgp='git log --stat --patch'
alias glo='git log --oneline --decorate'
alias glod='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset"'
alias glods='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ad) %C(bold blue)<%an>%Creset" --date=short'
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'
alias glola='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --all'
alias glols='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset" --stat'
alias glp=_git_log_prettily
alias gluc='git pull upstream $(git_current_branch)'
alias glum='git pull upstream $(git_main_branch)'
alias gm='git merge'
alias gma='git merge --abort'
alias gmc='git merge --continue'
alias gmff='git merge --ff-only'
alias gmom='git merge origin/$(git_main_branch)'
alias gms='git merge --squash'
alias gmtl='git mergetool --no-prompt'
alias gmtlvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/$(git_main_branch)'
alias gp='git add . && git commit -m "auto push" && git push'
alias gpd='git push --dry-run'
alias gpf='git push --force-with-lease --force-if-includes'
alias gpf!='git push --force'
alias gpoat='git push origin --all && git push origin --tags'
alias gpod='git push origin --delete'
alias gpr='git pull --rebase'
alias gpra='git pull --rebase --autostash'
alias gprav='git pull --rebase --autostash -v'
alias gpristine='git reset --hard && git clean --force -dfx'
alias gprom='git pull --rebase origin $(git_main_branch)'
alias gpromi='git pull --rebase=interactive origin $(git_main_branch)'
alias gprum='git pull --rebase upstream $(git_main_branch)'
alias gprumi='git pull --rebase=interactive upstream $(git_main_branch)'
alias gprv='git pull --rebase -v'
alias gps='git push --set-upstream origin'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias gpsupf='git push --set-upstream origin $(git_current_branch) --force-with-lease --force-if-includes'
alias gpu='git push upstream'
alias gpv='git push --verbose'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbd='git rebase $(git_develop_branch)'
alias grbi='git rebase --interactive'
alias grbm='git rebase $(git_main_branch)'
alias grbo='git rebase --onto'
alias grbom='git rebase origin/$(git_main_branch)'
alias grbs='git rebase --skip'
alias grbum='git rebase upstream/$(git_main_branch)'
alias grep='grep --color=auto --exclude-dir={.bzr,CVS,.git,.hg,.svn,.idea,.tox,.venv,venv}'
alias grev='git revert'
alias greva='git revert --abort'
alias grevc='git revert --continue'
alias grf='git reflog'
alias grh='git reset'
alias grhh='git reset --hard'
alias grhk='git reset --keep'
alias grhs='git reset --soft'
alias grm='git rm'
alias grmc='git rm --cached'
alias grmv='git remote rename'
alias groh='git reset origin/$(git_current_branch) --hard'
alias grrm='git remote remove'
alias grs='git restore'
alias grset='git remote set-url'
alias grss='git restore --source'
alias grst='git restore --staged'
alias grt='cd "$(git rev-parse --show-toplevel || echo .)"'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote --verbose'
alias gsb='git status --short --branch'
alias gsd='git svn dcommit'
alias gsh='git show'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status --short'
alias gst='git status'
alias gsta='git stash push'
alias gstaa='git stash apply'
alias gstall='git stash --all'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --patch'
alias gstu='gsta --include-untracked'
alias gsu='git submodule update'
alias gsw='git switch'
alias gswc='git switch --create'
alias gswd='git switch $(git_develop_branch)'
alias gswm='git switch $(git_main_branch)'
alias gta='git tag --annotate'
alias gtl='gtl(){ git tag --sort=-v:refname -n --list "${1}*" }; noglob gtl'
alias gts='git tag --sign'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git rev-list --max-count=1 --format="%s" HEAD | grep -q "\--wip--" && git reset HEAD~1'
alias gwch='git log --patch --abbrev-commit --pretty=medium --raw'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify --no-gpg-sign --message "--wip-- [skip ci]"'
alias gwipe='git reset --hard && git clean --force -df'
alias gwt='git worktree'
alias gwta='git worktree add'
alias gwtls='git worktree list'
alias gwtmv='git worktree move'
alias gwtrm='git worktree remove'
alias history=omz_history
alias l='ls -lah'
alias la='ls -lAh'
alias ll='ls -lh'
alias ls='eza -lh --group-directories-first --icons=auto'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias md='mkdir -p'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias onsched='tmuxinator onsched'
alias p='sudo pacman -S'
alias pacup='sudo pacman -Syu'
alias r=rails
alias rd=rmdir
alias run-help=man
alias vim=nvim
alias vimrc='nvim ~/.config/nvim/'
alias which-command=whence
alias y='yay -S'
alias yayup='sudo yay -Syu'
alias zrc='nvim ~/.zshrc'
alias zshconfig='nvim ~/.config/zsh'
alias zsource='source ~/.zshrc'

# exports 209
export BACKGROUND='#1e1e2e'
export BORDER_BACKGROUND='#1e1e2e'
export BORDER_FOREGROUND='#89b4fa'
export CLICOLOR=1
export CODEX_MANAGED_BY_NPM=1
export COLORTERM=truecolor
export DBUS_SESSION_BUS_ADDRESS='unix:path=/run/user/1000/bus'
export DEBUGINFOD_URLS='https://debuginfod.archlinux.org '
export DESKTOP_SESSION=omarchy
export DISPLAY=:0
export EDITOR=nvim
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export FOREGROUND='#cdd6f4'
export FZF_ALT_C_COMMAND='rg --files --hidden'
export FZF_DEFAULT_COMMAND='rg --files --hidden'
export GDK_BACKEND='wayland,x11,*'
export GDK_SCALE=2
export GHOSTTY_BIN_DIR=/usr/bin
export GHOSTTY_RESOURCES_DIR=/usr/share/ghostty
export GHOSTTY_SHELL_FEATURES=path,ssh-env,ssh-terminfo,title
export GOPATH=/home/unbalanced/Development/go
export GOROOT=/usr/lib/go
export GUM_CHOOSE_CURSOR_BACKGROUND='#1e1e2e'
export GUM_CHOOSE_CURSOR_FOREGROUND='#89b4fa'
export GUM_CHOOSE_HEADER_BACKGROUND='#1e1e2e'
export GUM_CHOOSE_HEADER_FOREGROUND='#cdd6f4'
export GUM_CHOOSE_ITEM_BACKGROUND='#1e1e2e'
export GUM_CHOOSE_ITEM_FOREGROUND='#cdd6f4'
export GUM_CHOOSE_SELECTED_BACKGROUND='#f5e0dc'
export GUM_CHOOSE_SELECTED_FOREGROUND='#1e1e2e'
export GUM_CONFIRM_PROMPT_BACKGROUND='#1e1e2e'
export GUM_CONFIRM_PROMPT_FOREGROUND='#89b4fa'
export GUM_CONFIRM_SELECTED_BACKGROUND='#f5e0dc'
export GUM_CONFIRM_SELECTED_FOREGROUND='#1e1e2e'
export GUM_CONFIRM_UNSELECTED_BACKGROUND='#1e1e2e'
export GUM_CONFIRM_UNSELECTED_FOREGROUND='#cdd6f4'
export GUM_FILE_CURSOR_BACKGROUND='#1e1e2e'
export GUM_FILE_CURSOR_FOREGROUND='#f5e0dc'
export GUM_FILE_DIRECTORY_BACKGROUND='#1e1e2e'
export GUM_FILE_DIRECTORY_FOREGROUND='#cdd6f4'
export GUM_FILE_FILE_BACKGROUND='#1e1e2e'
export GUM_FILE_FILE_FOREGROUND='#cdd6f4'
export GUM_FILE_FILE_SIZE_BACKGROUND='#1e1e2e'
export GUM_FILE_FILE_SIZE_FOREGROUND='#585b70'
export GUM_FILE_HEADER_BACKGROUND='#1e1e2e'
export GUM_FILE_HEADER_FOREGROUND='#cdd6f4'
export GUM_FILE_PERMISSIONS_BACKGROUND='#1e1e2e'
export GUM_FILE_PERMISSIONS_FOREGROUND='#585b70'
export GUM_FILE_SELECTED_BACKGROUND='#f5e0dc'
export GUM_FILE_SELECTED_FOREGROUND='#1e1e2e'
export GUM_FILE_SYMLINK_BACKGROUND='#1e1e2e'
export GUM_FILE_SYMLINK_FOREGROUND='#cdd6f4'
export GUM_FILTER_CURSOR_TEXT_BACKGROUND='#1e1e2e'
export GUM_FILTER_CURSOR_TEXT_FOREGROUND='#f5e0dc'
export GUM_FILTER_HEADER_BACKGROUND='#1e1e2e'
export GUM_FILTER_HEADER_FOREGROUND='#cdd6f4'
export GUM_FILTER_INDICATOR_BACKGROUND='#1e1e2e'
export GUM_FILTER_INDICATOR_FOREGROUND='#89b4fa'
export GUM_FILTER_MATCH_BACKGROUND='#1e1e2e'
export GUM_FILTER_MATCH_FOREGROUND='#89b4fa'
export GUM_FILTER_PLACEHOLDER_BACKGROUND='#1e1e2e'
export GUM_FILTER_PLACEHOLDER_FOREGROUND='#585b70'
export GUM_FILTER_PROMPT_BACKGROUND='#1e1e2e'
export GUM_FILTER_PROMPT_FOREGROUND='#89b4fa'
export GUM_FILTER_SELECTED_BACKGROUND='#f5e0dc'
export GUM_FILTER_SELECTED_FOREGROUND='#1e1e2e'
export GUM_FILTER_SELECTED_PREFIX_BACKGROUND='#f5e0dc'
export GUM_FILTER_SELECTED_PREFIX_FOREGROUND='#1e1e2e'
export GUM_FILTER_TEXT_BACKGROUND='#1e1e2e'
export GUM_FILTER_TEXT_FOREGROUND='#cdd6f4'
export GUM_FILTER_UNSELECTED_PREFIX_BACKGROUND='#1e1e2e'
export GUM_FILTER_UNSELECTED_PREFIX_FOREGROUND='#585b70'
export GUM_INPUT_CURSOR_BACKGROUND='#1e1e2e'
export GUM_INPUT_CURSOR_FOREGROUND='#f5e0dc'
export GUM_INPUT_HEADER_BACKGROUND='#1e1e2e'
export GUM_INPUT_HEADER_FOREGROUND='#cdd6f4'
export GUM_INPUT_PLACEHOLDER_BACKGROUND='#1e1e2e'
export GUM_INPUT_PLACEHOLDER_FOREGROUND='#585b70'
export GUM_INPUT_PROMPT_BACKGROUND='#1e1e2e'
export GUM_INPUT_PROMPT_FOREGROUND='#89b4fa'
export GUM_LOG_KEY_BACKGROUND='#1e1e2e'
export GUM_LOG_KEY_FOREGROUND='#cdd6f4'
export GUM_LOG_LEVEL_BACKGROUND='#1e1e2e'
export GUM_LOG_LEVEL_FOREGROUND='#89b4fa'
export GUM_LOG_MESSAGE_BACKGROUND='#1e1e2e'
export GUM_LOG_MESSAGE_FOREGROUND='#cdd6f4'
export GUM_LOG_PREFIX_BACKGROUND='#1e1e2e'
export GUM_LOG_PREFIX_FOREGROUND='#cdd6f4'
export GUM_LOG_SEPARATOR_BACKGROUND='#1e1e2e'
export GUM_LOG_SEPARATOR_FOREGROUND='#585b70'
export GUM_LOG_TIME_BACKGROUND='#1e1e2e'
export GUM_LOG_TIME_FOREGROUND='#585b70'
export GUM_LOG_VALUE_BACKGROUND='#1e1e2e'
export GUM_LOG_VALUE_FOREGROUND='#cdd6f4'
export GUM_PAGER_BACKGROUND='#1e1e2e'
export GUM_PAGER_FOREGROUND='#cdd6f4'
export GUM_PAGER_HELP_BACKGROUND='#1e1e2e'
export GUM_PAGER_HELP_FOREGROUND='#585b70'
export GUM_PAGER_LINE_NUMBER_BACKGROUND='#1e1e2e'
export GUM_PAGER_LINE_NUMBER_FOREGROUND='#585b70'
export GUM_PAGER_MATCH_BACKGROUND='#1e1e2e'
export GUM_PAGER_MATCH_FOREGROUND='#89b4fa'
export GUM_PAGER_MATCH_HIGH_BACKGROUND='#1e1e2e'
export GUM_PAGER_MATCH_HIGH_FOREGROUND='#89b4fa'
export GUM_SPIN_SPINNER_BACKGROUND='#1e1e2e'
export GUM_SPIN_SPINNER_FOREGROUND='#89b4fa'
export GUM_SPIN_TITLE_BACKGROUND='#1e1e2e'
export GUM_SPIN_TITLE_FOREGROUND='#cdd6f4'
export GUM_TABLE_BORDER_BACKGROUND='#1e1e2e'
export GUM_TABLE_BORDER_FOREGROUND='#585b70'
export GUM_TABLE_CELL_BACKGROUND='#1e1e2e'
export GUM_TABLE_CELL_FOREGROUND='#cdd6f4'
export GUM_TABLE_HEADER_BACKGROUND='#1e1e2e'
export GUM_TABLE_HEADER_FOREGROUND='#cdd6f4'
export GUM_TABLE_SELECTED_BACKGROUND='#f5e0dc'
export GUM_TABLE_SELECTED_FOREGROUND='#1e1e2e'
export GUM_WRITE_BASE_BACKGROUND='#1e1e2e'
export GUM_WRITE_BASE_FOREGROUND='#cdd6f4'
export GUM_WRITE_CURSOR_BACKGROUND='#1e1e2e'
export GUM_WRITE_CURSOR_FOREGROUND='#f5e0dc'
export GUM_WRITE_CURSOR_LINE_BACKGROUND='#f5e0dc'
export GUM_WRITE_CURSOR_LINE_FOREGROUND='#cdd6f4'
export GUM_WRITE_CURSOR_LINE_NUMBER_BACKGROUND='#1e1e2e'
export GUM_WRITE_CURSOR_LINE_NUMBER_FOREGROUND='#585b70'
export GUM_WRITE_END_OF_BUFFER_BACKGROUND='#1e1e2e'
export GUM_WRITE_END_OF_BUFFER_FOREGROUND='#585b70'
export GUM_WRITE_HEADER_BACKGROUND='#1e1e2e'
export GUM_WRITE_HEADER_FOREGROUND='#cdd6f4'
export GUM_WRITE_LINE_NUMBER_BACKGROUND='#1e1e2e'
export GUM_WRITE_LINE_NUMBER_FOREGROUND='#585b70'
export GUM_WRITE_PLACEHOLDER_BACKGROUND='#1e1e2e'
export GUM_WRITE_PLACEHOLDER_FOREGROUND='#585b70'
export GUM_WRITE_PROMPT_BACKGROUND='#1e1e2e'
export GUM_WRITE_PROMPT_FOREGROUND='#cdd6f4'
export HL_INITIAL_WORKSPACE_TOKEN=6c990c52-46d6-4f0e-89b2-29ed89cc3c2d
export HOME=/home/unbalanced
export HYPRCURSOR_SIZE=24
export HYPRLAND_CMD='Hyprland --watchdog-fd 4'
export HYPRLAND_INSTANCE_SIGNATURE=521ece463c4a9d3d128670688a34756805a4328f_1778806320_414337440
export INPUT_METHOD=fcitx
export LANG=en_US.UTF-8
export LANGUAGE
export LC_ADDRESS
export LC_IDENTIFICATION
export LC_MEASUREMENT
export LC_MONETARY
export LC_NAME
export LC_PAPER
export LC_TELEPHONE
export LESS=-R
export LOGNAME=unbalanced
export LSCOLORS=Gxfxcxdxbxegedabagacad
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.jxl=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:'
export MAIL=/var/spool/mail/unbalanced
export MANAGERPID=766
export MANAGERPIDFDID=767
export MANPAGER='nvim +Man!'
export MANWIDTH=999
export MEMORY_PRESSURE_WATCH=/sys/fs/cgroup/user.slice/user-1000.slice/user@1000.service/session.slice/wayland-wm@hyprland.desktop.service/memory.pressure
export MEMORY_PRESSURE_WRITE='c29tZSAyMDAwMDAgMjAwMDAwMAA='
export MOTD_SHOWN=pam
export MOZ_ENABLE_WAYLAND=1
export NODE_COMPILE_CACHE=/var/tmp/openclaw-compile-cache
export NVM_BIN=/home/unbalanced/.config/nvm/versions/node/v24.14.1/bin
export NVM_CD_FLAGS=-q
export NVM_DIR=/home/unbalanced/.config/nvm
export NVM_INC=/home/unbalanced/.config/nvm/versions/node/v24.14.1/include/node
export OMARCHY_PATH=/home/unbalanced/.local/share/omarchy
export OZONE_PLATFORM=wayland
export PAGER=less
export QT_IM_MODULE=fcitx
export QT_QPA_PLATFORM='wayland;xcb'
export QT_STYLE_OVERRIDE=kvantum
export SDL_IM_MODULE=fcitx
export SHELL=/usr/bin/zsh
export SYSTEMD_EXEC_PID=1133
export TERM=xterm-ghostty
export TERMINAL=xdg-terminal-exec
export TERMINFO=/usr/share/terminfo
export TERM_PROGRAM=ghostty
export TERM_PROGRAM_VERSION=1.3.1-arch2
export TF_FORCE_GPU_ALLOW_GROWTH=true
export USER=unbalanced
export UWSM_FINALIZE_VARNAMES='HYPRLAND_INSTANCE_SIGNATURE HYPRLAND_CMD HYPRCURSOR_THEME HYPRCURSOR_SIZE XCURSOR_SIZE XCURSOR_THEME'
export UWSM_WAIT_VARNAMES=HYPRLAND_INSTANCE_SIGNATURE
export WAYLAND_DISPLAY=wayland-1
export XCOMPOSEFILE='~/.XCompose'
export XCURSOR_SIZE=24
export XDG_BACKEND=wayland
export XDG_CACHE_HOME=/home/unbalanced/.cache
export XDG_CONFIG_DIRS=/etc/xdg
export XDG_CONFIG_HOME=/home/unbalanced/.config
export XDG_CURRENT_DESKTOP=Hyprland
export XDG_DATA_DIRS=/usr/local/share:/usr/share
export XDG_DATA_HOME=/home/unbalanced/.local/share
export XDG_MENU_PREFIX=hyprland-
export XDG_RUNTIME_DIR=/run/user/1000
export XDG_SEAT=seat0
export XDG_SEAT_PATH=/org/freedesktop/DisplayManager/Seat0
export XDG_SESSION_CLASS=user
export XDG_SESSION_DESKTOP=Hyprland
export XDG_SESSION_ID=2
export XDG_SESSION_PATH=/org/freedesktop/DisplayManager/Session0
export XDG_SESSION_TYPE=wayland
export XDG_STATE_HOME=/home/unbalanced/.local/state
export XDG_VTNR=1
export XMODIFIERS='@im=fcitx'
export ZSH=/home/unbalanced/.oh-my-zsh
export _JAVA_AWT_WM_NONREPARENTING=1
