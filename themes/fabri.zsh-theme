# autoload zkbd
# [[ ! -f ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE ]] && zkbd
# # source ${ZDOTDIR:-$HOME}/.zkbd/$TERM-$VENDOR-$OSTYPE
# 
# [[ -n ${key[Backspace]} ]] && bindkey "${key[Backspace]}" backward-delete-char
# [[ -n ${key[Insert]} ]] && bindkey "${key[Insert]}" overwrite-mode
# [[ -n ${key[Home]} ]] && bindkey "${key[Home]}" beginning-of-line
# [[ -n ${key[PageUp]} ]] && bindkey "${key[PageUp]}" up-line-or-history
# [[ -n ${key[Delete]} ]] && bindkey "${key[Delete]}" delete-char
# [[ -n ${key[End]} ]] && bindkey "${key[End]}" end-of-line
# [[ -n ${key[PageDown]} ]] && bindkey "${key[PageDown]}" down-line-or-history
# [[ -n ${key[Up]} ]] && bindkey "${key[Up]}" up-line-or-search
# [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
# [[ -n ${key[Down]} ]] && bindkey "${key[Down]}" down-line-or-search
# [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char

rails_git() {  
  echo "log/*.log" >> .gitignore
  echo "tmp/**/*" >> .gitignore
  echo "doc/api" >> .gitignore
  echo "doc/app" >> .gitignore   
  touch log/.gitignore
  touch tmp/.gitignore  
}

function project_info() {
  # d=$(pwd | egrep 'Work\/(\w+)' -o )  
  d=$(pwd | egrep "Work\/(\w+)" -o | egrep -e "[0-9A-za-z]+\$"  -o )
  # d=$( echo $(cd .. && pwd) | grep -e "\w\+/\w\+\$" -o )  
  if test $d ; then 
    # PROJECT_NAME="%{$fg_bold[yellow]%}> $d%{$reset_color%}"
    PROJECT_NAME="%{$fg_bold[yellow]%}$d%{$reset_color%}"    
  else
    PROJECT_NAME=''
  fi
  echo $PROJECT_NAME
}

PROMPT='%{$fg_bold[red]%}%m%{$fg_bold[green]%} $(project_info) %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'

export WORDCHARS=${WORDCHARS//\//}