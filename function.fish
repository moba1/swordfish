function sword --description 'pnpm, yarn, npm wrapper'
  set -l directory (pwd)
  set -l package_json_path ""

  while true
    set \
      package_json_path \
      (string join / (string trim -c / -r "$directory") package.json)
    if [ -f "$package_json_path" ]
      break
    end

    if [ "$directory" = / ]
      echo not in Node.js project >&2
      return 1
    end
    set directory (dirname "$directory")
  end
  echo found: "$package_json_path"
end
