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
  echo found: "$package_json_path"
end
