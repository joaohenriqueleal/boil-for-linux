#!/bin/bash
#: Create a Vue 3 + JavaScript + Tailwind project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating Vue 3 + JS + Tailwind project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" vue

npm install --prefix "$PROJECT_PATH"

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

rm -f "$PUBLIC/vite.svg"
rm -f "$SRC/typescript.svg"
rm -f "$SRC/main.ts"
rm -f "$SRC/counter.ts"
rm -f "$SRC/style.css"
rm -f "$SRC/components/HelloWorld.vue"

cat > "$SRC/main.js" <<EOL
import { createApp } from 'vue';
import './styles/style.css';

createApp({}).mount('#app');
EOL

mkdir -p "$SRC/pages" "$SRC/components" "$SRC/styles" "$SRC/utils" \
         "$SRC/tests" "$SRC/shared" "$SRC/services" "$SRC/hooks" "$SRC/assets"

cat > "$SRC/styles/style.css" <<EOL
@charset "UTF-8";
@import "tailwindcss";
EOL

cd "$PROJECT_PATH" || exit

npm install tailwindcss @tailwindcss/vite

cat > "vite.config.js" <<EOL
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [vue(), tailwindcss()],
});
EOL

cat > "index.html" <<EOL
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>$PROJECT_NAME</title>
        <link rel="stylesheet" href="/src/styles/style.css" />
    </head>
    <body>
        <div id="app"></div>
        <script type="module" src="/src/main.js"></script>
    </body>
</html>
EOL

rm -f tsconfig.json
rm -f tsconfig.app.json
rm -f tsconfig.node.json

rm -f \
"$SRC/assets/vite.svg" \
"$SRC/assets/hero.png" \
"$PUBLIC/vite.svg" \
"$PUBLIC/favicon.svg" \
"$PUBLIC/icons.svg"

cat > "package.json" <<EOL
{
    "name": "$PROJECT_NAME",
    "private": true,
    "version": "0.0.0",
    "type": "module",
    "scripts": {
        "dev": "vite",
        "build": "vite build",
        "preview": "vite preview"
    },
    "dependencies": {
        "vue": "^3.5.0",
        "tailwindcss": "^4.1.16",
        "@tailwindcss/vite": "^4.1.16"
    },
    "devDependencies": {
        "vite": "^7.1.7",
        "@vitejs/plugin-vue": "^5.1.0"
    }
}
EOL

npx prettier --write "$PROJECT_PATH"
code "$PROJECT_PATH"

echo "Vue 3 + JS + Tailwind project created and ready: $PROJECT_NAME"
