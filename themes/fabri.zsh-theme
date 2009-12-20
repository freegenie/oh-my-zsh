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

function project_info() {  
  d=$( echo $(cd .. && pwd) | grep -e "\w\+/\w\+\$" -o )
  if test $d ; then 
    PROJECT_NAME="%{$fg_bold[yellow]%}> $d%{$reset_color%}
 "
  else
    PROJECT_NAME=''
  fi

  echo $PROJECT_NAME
}

function lwork() {  
  i=0
  # for entry in $(ls -ltr1 ~/Work | tail -n10 | grep -e "/\$" | sed -e "s/\///g") ; do 
  for entry in $(ls -lt1 ~/.work_func | head) ; do 
    i=$(($i+1))
    echo "$i)  $entry" 
  done 
  echo "Number?"
  read line 
  i=0    
  # for entry in $(ls -ltr1 ~/Work | tail -n10 | grep -e "/\$" | sed -e "s/\///g") ; do 
  for entry in $(ls -lt1 ~/.work_func | head) ; do   
    i=$(($i+1))
    if test $i -eq $line ; then        
      open_work_dir $entry
    fi
  done  
}
function check_dir() {
  if test -d ~/.work_func ; then 
  else 
    mkdir ~/.work_func 
  fi
}

function open_work_dir() {
  check_dir
  touch ~/.work_func/$1
  cd ~/Work/$1
}


function work() {  
  if test "$1" = "" ; then 
    lwork
    return 
  fi  
  l=$(ls -1 ~/Work | grep $1 | grep -e "/\$" | sed -e "s/\///g" )
  d=$(echo $l | wc -l | grep -e "\w\+" | sed -e "s/ //g" )
  if test $d -eq 1 ; then 
    cd ~/Work/$l
  else    
    i=0
    for entry in $(ls ~/Work | grep $1 | grep -e "/\$" | sed -e "s/\///g") ; do
      i=$(($i+1))
      echo "$i)  $entry" | grep $1 
    done
    echo "Number? "      
    read line
    i=0
    for entry in $(ls ~/Work | grep $1 | grep -e "/\$" | sed -e "s/\///g") ; do     
      i=$(($i+1))
      if test $i -eq $line ; then        
        open_work_dir $entry        
      fi
    done
  fi
}

PROMPT='$(project_info)%{$fg_bold[red]%}%m%{$fg_bold[green]%}%p %{$fg[cyan]%}%c %{$fg_bold[blue]%}$(git_prompt_info)%{$fg_bold[blue]%} % %{$reset_color%}'


