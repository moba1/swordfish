function sword --description 'pnpm, yarn, npm wrapper'
  set -l project_directory (pwd)
  set -l package_json_path ""

  function path_join
    string join / (string trim -c / -r $argv)
  end

  while true
    set \
      package_json_path \
      (path_join "$project_directory" package.json)
    if [ -f "$package_json_path" ]
      break
    end

    if [ "$project_directory" = / ]
      echo not in Node.js project >&2
      return 1
    end
    set project_directory (dirname "$project_directory")
  end

  set -l package_manager ""
  if [ -f (path_join "$project_directory" package-lock.json) ]
    set package_manager npm
  else if [ -f (path_join "$project_directory" yarn.lock) ]
    set package_manager yarn
  else if [ -f (path_join "$project_directory" pnpm-lock.yaml) ]
    set package_manager pnpm
  else if set -q SWORDFISH_DEFAULT_PACKAGE_MANAGER
    set package_manager "$SWORDFISH_DEFAULT_PACKAGE_MANAGER"
  else
    echo "cannot find Node.js package manager" >&2
    return 2
  end
  "$package_manager" $argv
end
