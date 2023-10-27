function sword --description 'pnpm, yarn, npm wrapper'
  set -l directory (pwd)

  while true
    set -l \
      package_json_path \
      (string join / (string trim -c / -r "$directory") package.json)
    echo $package_json_path

    if [ "$directory" = / ]
      echo not in Node.js project >&2
      return 1
    end
    set directory (dirname "$directory")
  end
end
