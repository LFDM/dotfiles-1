use_gitconfig_for_identification() {
  unset GIT_AUTHOR_NAME
  unset GIT_AUTHOR_EMAIL
  unset GIT_COMMITTER_NAME
  unset GIT_COMMITTER_EMAIL
}

set_git_user() {
  local git_author
  local git_email
  echo "------- Git Identification -------"
  echo "Leave field empty to use your .gitconfig files"
  vared -p "Set your username: " git_author

  if [[ $git_author == '' ]]; then
    use_gitconfig_for_identification
    echo "Git identification handled by .gitconfig files"
    return 1
  fi

  vared -p "Set your email: " git_email

  export GIT_AUTHOR_NAME=$git_author
  export GIT_AUTHOR_EMAIL=$git_email
  export GIT_COMMITTER_NAME=$git_author
  export GIT_COMMITTER_EMAIL=$git_email
}

set_default_git_user() {
  set_git_user || return

  cat << STR > $PWD/custom/git_user.zsh
# This file defines your default git user
export GIT_AUTHOR_NAME=$git_author
export GIT_AUTHOR_EMAIL=$git_email
export GIT_COMMITTER_NAME=$git_author
export GIT_COMMITTER_EMAIL=$git_email
STR
}

use_default_git_user() {
  if ! source $PWD/custom/git_user.zsh 2> /dev/null; then
    use_gitconfig_for_identification
  fi
}
