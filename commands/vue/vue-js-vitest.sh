#!/bin/bash
#: Create a Vue3 + JavaScript + Vitest project with Prettier and Vite (clean template).

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating Vue 3 + JS + Vitest project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" -- --template vue

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
"$PUBLIC/vite.svg" \
"$SRC/App.vue" \
"$SRC/assets/vue.svg" \
"$SRC/typescript.svg" \
"$SRC/main.ts" \
"$SRC/counter.ts" \
"$SRC/style.css" \
"$SRC/components/HelloWorld.vue"

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

cat > "$SRC/setupTests.js" <<EOL
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
        <script type="module" src="/src/main.js"></script>
    </body>
</html>
EOL

rm -f \
"$PROJECT_PATH/tsconfig.json" \
"$PROJECT_PATH/tsconfig.app.json" \
"$PROJECT_PATH/tsconfig.node.json"

rm -f \
"$SRC/assets/vite.svg" \
"$SRC/assets/hero.png" \
"$PUBLIC/vite.svg" \
"$PUBLIC/favicon.svg" \
"$PUBLIC/icons.svg"

cat > "$PROJECT_PATH/vite.config.js" <<EOL
import { defineConfig } from 'vitest/config';
import vue from '@vitejs/plugin-vue';

export default defineConfig({
    plugins: [vue()],
    test: {
        environment: 'jsdom',
        setupFiles: './src/setupTests.js',
        globals: true,
        coverage: {
            provider: 'v8',
            reporter: ['text', 'html'],
            include: ['src/components/**/*.{js,vue}'],
            exclude: [
                'src/components/**/*.{stories,test,spec}.{js,vue}',
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
        "vue": "^3.5.0"
    },
    "devDependencies": {
        "vite": "^6.0.0",
        "@vitejs/plugin-vue": "^5.2.4",
        "vitest": "^2.1.0",
        "jsdom": "^24.0.0",
        "@testing-library/vue": "^8.0.0",
        "@testing-library/jest-dom": "^6.9.1"
    }
}
EOL

cd "$PROJECT_PATH" || exit
npm install
npx prettier --write .

code "$PROJECT_PATH"

echo "Vue3 + JS + Vitest project created and clean: $PROJECT_NAME"
