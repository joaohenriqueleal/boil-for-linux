#!/bin/bash
#: Create a React + JavaScript project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating React + JS project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" react-js

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
[ -f "$SRC/counter.ts" ] && rm "$SRC/counter.ts"
[ -f "$SRC/main.ts" ] && rm "$SRC/main.ts"
[ -f "$SRC/style.css" ] && rm "$SRC/style.css"
[ -f "$SRC/typescript.svg" ] && rm "$SRC/typescript.svg"
[ -f "$SRC/App.jsx" ] && rm "$SRC/App.jsx"
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
         "$SRC/tests" "$SRC/shared" "$SRC/services" "$SRC/hooks" "$SRC/assets"

cat > "$PROJECT_PATH/index.html" <<EOL
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>$PROJECT_NAME</title>
    </head>
    <body>
        <div id="root"></div>
        <script type="module" src="./src/main.jsx"></script>
    </body>
</html>
EOL

rm "$PROJECT_PATH/tsconfig.json"

npm install react react-dom

cat > "$PROJECT_PATH/package.json" << EOL
{
    "name": "my-project",
    "private": true,
    "version": "0.0.0",
    "type": "module",
    "scripts": {
        "dev": "vite",
        "build": "vite build",
        "preview": "vite preview"
    },
    "devDependencies": {
        "typescript": "~5.9.3",
        "vite": "^7.1.7"
    }
}
EOL

npm install -D @vitejs/plugin-react --prefix "$PROJECT_PATH"

if [ ! -f "$PROJECT_PATH/vite.config.js" ]; then
cat > "$PROJECT_PATH/vite.config.js" <<EOL
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

export default defineConfig({
    plugins: [react()],
})
EOL
fi

code "$PROJECT_PATH"
npx prettier --write "$PROJECT_PATH"

echo "React + JS project created and ready: $PROJECT_NAME"
