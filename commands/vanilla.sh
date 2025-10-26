#!/bin/bash
#: Create a Vanilla(HTML, CSS, JS) project with Prettier.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"

echo "Creating Vanilla + Tailwind project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

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
</head>
<body>
    
</body>
</html>
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
