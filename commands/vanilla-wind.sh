#!/bin/bash
#: Create a Vanilla(HTML, CSS, JS) + Tailwindcss project with Prettier.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"

echo "Creating Vanilla + Tailwind project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

npm init -y

mkdir "styles"
mkdir "pages"
mkdir "scripts"
mkdir "tests"
mkdir "services"
mkdir "components"
mkdir "assets"

touch "index.html"
cat > "index.html" << EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$PROJECT_NAME</title>
    <link href="./styles/tailwind.css" rel="stylesheet">
</head>
<body>
    
</body>
</html>
EOL

npm install tailwindcss @tailwindcss/cli

cd "styles" || exit

touch "style.css"
cat > "style.css" << EOL
@charset "UTF-8";
@import "tailwindcss";
EOL

cd ".."

cat > "package.json" << EOL
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "wind-wacth": "npx @tailwindcss/cli -i styles/style.css -o styles/tailwind.css --watch"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "type": "commonjs",
  "dependencies": {
    "@tailwindcss/cli": "^4.1.16",
    "tailwindcss": "^4.1.16"
  }
}
EOL

touch ".prettierrc"
cat > ".prettierrc" <<EOL
{
    "tabWidth": 4,
    "useTabs": false,
    "semi": true,
    "singleQuote": true,
    "trailingComma": "es5",
    "printWidth": 80
}
EOL

npx prettier --write .


code .
npx @tailwindcss/cli -i styles/style.css -o styles/tailwind.css --watch
