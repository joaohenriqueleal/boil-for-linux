#!/bin/bash
#: Create a Vue 3 + JavaScript project with Prettier and Vite (clean template).

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating Vue 3 + JS project in $PROJECT_PATH ..."

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

createApp({}).mount('#app');
EOL

mkdir -p \
    "$SRC/pages" \
    "$SRC/components" \
    "$SRC/styles" \
    "$SRC/utils" \
    "$SRC/tests" \
    "$SRC/shared" \
    "$SRC/services" \
    "$SRC/hooks" \
    "$SRC/assets"

cat > "$PROJECT_PATH/index.html" <<EOL
<!doctype html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <title>$PROJECT_NAME</title>
    </head>
    <body>
        <div id="app"></div>
        <script type="module" src="/src/main.js"></script>
    </body>
</html>
EOL

rm -f "$PROJECT_PATH/tsconfig.json"
rm -f "$PROJECT_PATH/tsconfig.app.json"
rm -f "$PROJECT_PATH/tsconfig.node.json"

rm -f \
"$SRC/assets/vite.svg" \
"$SRC/assets/hero.png" \
"$PUBLIC/vite.svg" \
"$PUBLIC/favicon.svg" \
"$PUBLIC/icons.svg"

cat > "$PROJECT_PATH/package.json" <<EOL
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
        "vue": "^3.5.0"
    },
    "devDependencies": {
        "vite": "^7.1.7",
        "@vitejs/plugin-vue": "^5.1.0"
    }
}
EOL

cat > "$PROJECT_PATH/vite.config.js" <<EOL
import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [vue()],
});
EOL

code "$PROJECT_PATH"
npx prettier --write "$PROJECT_PATH"

echo "Vue 3 + JS project created and clean: $PROJECT_NAME"
