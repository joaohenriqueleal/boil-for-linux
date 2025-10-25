#!/bin/bash
#: Create a React + JavaScript + Tailwind project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating React + JS +  Tailwind project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" -- --template react-js

cat > "$PROJECT_PATH/.prettierrc" <<EOL
{
    "tabWidth": 4,
    "useTabs": false,
    "semi": true,
    "singleQuote": true,
    "trailingComma": "es5",
    "printWidth": 80
}
EOL

npm install --prefix "$PROJECT_PATH"

[ -f "$SRC/App.css" ] && rm "$SRC/App.css"
[ -f "$SRC/App.jsx" ] && rm "$SRC/App.jsx"
[ -f "$SRC/counter.ts" ] && rm "$SRC/counter.ts"
[ -f "$SRC/main.ts" ] && rm "$SRC/main.ts"
[ -f "$SRC/style.css" ] && rm "$SRC/style.css"
[ -f "$SRC/typescript.svg" ] && rm "$SRC/typescript.svg"
[ -f "$SRC/index.css" ] && rm "$SRC/index.css"
[ -f "$SRC/assets/react.svg" ] && rm "$SRC/assets/react.svg"
[ -f "$PUBLIC/vite.svg" ] && rm "$PUBLIC/vite.svg"

cat > "$SRC/main.jsx" <<EOL
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

createRoot(document.getElementById('root')).render(
    <StrictMode>
        
    </StrictMode>
);
EOL

mkdir -p "$SRC/pages" "$SRC/components" "$SRC/styles" "$SRC/utils" \
         "$SRC/tests" "$SRC/shared" "$SRC/services" "$SRC/hooks"

cd "$PROJECT_PATH" || exit
npm install tailwindcss @tailwindcss/vite
mkdir "dist"
cd "dist" || exit
touch "style.css"
cat > "style.css" <<EOL
@charset "UTF-8";
@import "tailwindcss";
EOL

cd ".." || exit
cat > "vite.config.js" <<EOL
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite'

export default defineConfig({
  plugins: [
    react(), tailwindcss()
  ],
})
EOL

cat > "$PROJECT_PATH/index.html" <<EOL
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>$PROJECT_NAME</title>
        <link rel="stylesheet" href="./dist/style.css">
    </head>
    <body>
        <div id="root"></div>
        <script type="module" src="./src/main.jsx"></script>
    </body>
</html>
EOL

rm "tsconfig.json"

npx prettier --write "$PROJECT_PATH"
npm install @vitejs/plugin-react
npm install react react-dom

code "$PROJECT_PATH"

echo "React + JS + Tailwind project created and ready: $PROJECT_NAME"
