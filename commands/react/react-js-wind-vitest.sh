#!/bin/bash
#: Create a React + JavaScript + Tailwind + Vitest project with Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating React + JS + Tailwind + Vitest project in $PROJECT_PATH ..."

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

rm -f \
"$PROJECT_PATH/tsconfig.json" \
"$PROJECT_PATH/tsconfig.app.json" \
"$PROJECT_PATH/tsconfig.node.json" \
"$SRC/main.ts" \
"$SRC/main.tsx" \
"$SRC/counter.ts" \
"$SRC/assets/vite.svg" \
"$SRC/assets/hero.png" \
"$PUBLIC/vite.svg" \
"$PUBLIC/favicon.svg" \
"$PUBLIC/icons.svg" \
"$SRC/typescript.svg"

rm -f \
"$SRC/App.css" \
"$SRC/App.jsx" \
"$SRC/style.css" \
"$SRC/assets/react.svg" \
"$PUBLIC/vite.svg"

cat > "$SRC/main.jsx" <<EOL
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

import './styles/style.css';

createRoot(document.getElementById('root')).render(
    <StrictMode>
        
    </StrictMode>
);
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

cat > "$SRC/styles/style.css" <<EOL
@charset "UTF-8";
@import "tailwindcss";
EOL

cd "$PROJECT_PATH" || exit
npm install tailwindcss @tailwindcss/vite

npm install -D vitest jsdom \
@testing-library/react \
@testing-library/jest-dom

cat > "$SRC/setupTests.js" <<EOL
import '@testing-library/jest-dom';
EOL

cat > "vite.config.js" <<EOL
/// <reference types="vitest" />

import { defineConfig } from 'vitest/config';
import react from '@vitejs/plugin-react';
import tailwindcss from '@tailwindcss/vite';

export default defineConfig({
    plugins: [react(), tailwindcss()],
    test: {
        environment: 'jsdom',
        setupFiles: './src/setupTests.js',
        globals: true,
        coverage: {
            provider: 'v8',
            reporter: ['text', 'html'],
            include: ['src/components/**/*.{js,jsx}'],
            exclude: [
                'src/components/**/*.{types,stories,constants,test,spec}.{js,jsx}',
            ],
        },
    },
});
EOL

cat > "index.html" <<EOL
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

cat > "package.json" <<EOL
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
        "react": "^19.2.0",
        "react-dom": "^19.2.0",
        "tailwindcss": "^4.1.16",
        "@tailwindcss/vite": "^4.1.16"
    },
    "devDependencies": {
        "vite": "^7.1.7",
        "@vitejs/plugin-react": "^5.1.0",
        "vitest": "^2.1.0",
        "jsdom": "^24.0.0",
        "@testing-library/react": "^16.3.2",
        "@testing-library/jest-dom": "^6.9.1"
    }
}
EOL

npm install

npx prettier --write .

code "$PROJECT_PATH"

echo "React + JS + Tailwind + Vitest project ready: $PROJECT_NAME"
