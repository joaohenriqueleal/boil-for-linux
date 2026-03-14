#!/bin/bash
# Create a React + JavaScript project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

if [ -z "$TARGET_DIR" ]; then
  echo "Usage: ./script.sh <target_directory> [project_name]"
  exit 1
fi

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"

echo "Creating React + JS project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit

npm create vite@latest "$PROJECT_NAME" -- --template react

cd "$PROJECT_NAME" || exit

npm install

cat > .prettierrc <<EOL
{
    "tabWidth": 4,
    "useTabs": false,
    "semi": true,
    "singleQuote": true,
    "trailingComma": "es5",
    "printWidth": 80
}
EOL

rm -f src/App.css
rm -f src/index.css
rm -f src/assets/react.svg
rm -f public/vite.svg
rm -f src/App.jsx

rm -f \
"$SRC/assets/vite.svg" \
"$SRC/assets/hero.png" \
"$PUBLIC/vite.svg" \
"$PUBLIC/favicon.svg" \
"$PUBLIC/icons.svg"

cat > src/main.jsx <<EOL
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

createRoot(document.getElementById('root')).render(
    <StrictMode>
        
    </StrictMode>
);
EOL

mkdir -p src/pages \
         src/components \
         src/styles \
         src/utils \
         src/tests \
         src/shared \
         src/services \
         src/hooks \
         src/assets

npm install -D @vitejs/plugin-react

if [ ! -f vite.config.js ]; then
cat > vite.config.js <<EOL
import { defineConfig } from 'vite';
import react from '@vitejs/plugin-react';

export default defineConfig({
    plugins: [react()],
});
EOL
fi

cat > index.html <<EOL
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>$PROJECT_NAME</title>
    </head>
    <body>
        <div id="root"></div>
        <script type="module" src="/src/main.jsx"></script>
    </body>
</html>

EOL

npx prettier --write .

echo "React + JS project created and ready: $PROJECT_NAME"

code .
