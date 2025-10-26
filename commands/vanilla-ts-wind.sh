#!/bin/bash
#: Create a Vanilla(HTML, CSS) + Typescript and Tailwind project with Prettier.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"

echo "Creating Vanilla + Typescript project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
mkdir "$PROJECT_NAME"
cd "$PROJECT_NAME" || exit

mkdir src
mkdir dist

tsc --init
cat > "tsconfig.json" << EOL
{
  // Visit https://aka.ms/tsconfig to read more about this file
  "compilerOptions": {
    // File Layout
    "rootDir": "./src",
    "outDir": "./dist",

    // Environment Settings
    // See also https://aka.ms/tsconfig/module
    "module": "esnext",
    "target": "esnext",
    "types": [],
    // For nodejs:
    // "lib": ["esnext"],
    // "types": ["node"],
    // and npm install -D @types/node

    // Other Outputs
    "sourceMap": true,
    "declaration": true,
    "declarationMap": true,

    // Stricter Typechecking Options
    "noUncheckedIndexedAccess": true,
    "exactOptionalPropertyTypes": true,

    // Style Options
    // "noImplicitReturns": true,
    // "noImplicitOverride": true,
    // "noUnusedLocals": true,
    // "noUnusedParameters": true,
    // "noFallthroughCasesInSwitch": true,
    // "noPropertyAccessFromIndexSignature": true,

    // Recommended Options
    "strict": true,
    "jsx": "react-jsx",
    "verbatimModuleSyntax": true,
    "isolatedModules": true,
    "noUncheckedSideEffectImports": true,
    "moduleDetection": "force",
    "skipLibCheck": true,
  }
}
EOL

cd src || exit

mkdir "assets"
mkdir "scripts"
mkdir "styles"
mkdir "pages"
mkdir "tests"
mkdir "components"
mkdir "services"

cd ..

touch "index.html"
cat > "index.html" << EOL
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>$PROJECT_NAME</title>
    <link href="./dist/tailwind.css" rel="stylesheet">
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

npm install tailwindcss @tailwindcss/cli
cd "src/styles"  || exit

touch "styles.css"
cat > "styles.css" << EOL
@charset "UTF-8";
@import "tailwindcss";
EOL

cd "../../" || exit

cat > "package.json" << EOL
{
  "name": "my-project",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "wind-wacth": "npx @tailwindcss/cli -i ./src/styles/styles.css -o ./src/styles/tailwind.css --watch"
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


npx prettier --write .

code .
npx @tailwindcss/cli -i ./src/styles/styles.css -o ./dist/tailwind.css --watch
