_toggleUvShell() {
  # Determine if currently in a Poetry-managed directory
  local in_uv_dir=0
  if [[ -f "$PWD/pyproject.toml" ]]; then
    in_uv_dir=1
  fi

  # Deactivate the current environment if moving out of a Poetry directory or into a different Poetry directory
  if [[ $uv_active -eq 1 ]] && { [[ $in_uv_dir -eq 0 ]] && [[ "$PWD" != "$uv_dir"* ]]; }; then
    export uv_active=0
    unset uv_dir
    deactivate
  fi

  # Activate the environment if in a Poetry directory and no environment is currently active
  if [[ $in_uv_dir -eq 1 ]] && [[ $uv_active -ne 1 ]]; then
    venv_dir=".venv"
    if [[ -n "$venv_dir" ]]; then
      export uv_active=1
      export uv_dir="$PWD"
      source "${venv_dir}/bin/activate"
    fi
  fi
}
autoload -U add-zsh-hook
add-zsh-hook chpwd _toggleUvShell
_toggleUvShell # Initial call to check the current directory at shell startup
