#!/bin/bash
#: Create a Vue3 + TypeScript + Tailwind + Vitest project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating Vue + TS + Tailwind + Vitest project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" -- --template vue-ts

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

rm -f \
"$SRC/components/HelloWorld.vue" \
"$SRC/App.vue" \
"$SRC/counter.ts" \
"$SRC/typescript.svg" \
"$SRC/assets/vue.svg" \
"$SRC/style.css" \
"$PUBLIC/vite.svg"

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

cat > "$SRC/main.ts" <<EOL
import { createApp } from 'vue';
import './styles/style.css';

createApp({}).mount('#app');
EOL

cat > "$SRC/styles/style.css" <<EOL
@charset "UTF-8";
@import "tailwindcss";
EOL

cat > "$SRC/setupTests.ts" <<EOL
import '@testing-library/jest-dom';
EOL

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
        <script type="module" src="/src/main.ts"></script>
    </body>
</html>
EOL

cat > "$PROJECT_PATH/vite.config.ts" <<EOL
/// <reference types="vitest" />

import { defineConfig } from 'vite';
import vue from '@vitejs/plugin-vue';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [vue(), tailwindcss()],
    test: {
        environment: 'jsdom',
        setupFiles: './src/setupTests.ts',
        globals: true,
        coverage: {
            provider: 'v8',
            reporter: ['text', 'html'],
            include: ['src/components/**/*.{ts,vue}'],
            exclude: [
                'src/components/**/*.{types,stories,test,spec}.{ts,vue}',
            ],
        },
    },
});
EOL

cat > "$PROJECT_PATH/package.json" <<EOL
{
    "name": "$PROJECT_NAME",
    "private": true,
    "version": "0.0.0",
    "type": "module",
    "scripts": {
        "dev": "vite",
        "build": "vite build",
        "preview": "vite preview",
        "test": "vitest",
        "coverage": "vitest run --coverage"
    },
    "dependencies": {
        "vue": "^3.5.0",
        "tailwindcss": "^4.1.16",
        "@tailwindcss/vite": "^4.1.16"
    },
    "devDependencies": {
        "vite": "^5.4.0",
        "@vitejs/plugin-vue": "^5.1.4",
        "vitest": "^1.6.0",
        "jsdom": "^24.0.0",
        "@testing-library/vue": "^8.0.0",
        "@testing-library/jest-dom": "^6.9.1",
        "typescript": "^5.3.3",
        "@vue/tsconfig": "^0.5.1"
    }
}
EOL

cd "$PROJECT_PATH" || exit
rm -rf node_modules package-lock.json
npm install
npm i @types/node
npx prettier --write .

code "$PROJECT_PATH"

echo "Vue + TS + Tailwind + Vitest project created and ready: $PROJECT_NAME"
