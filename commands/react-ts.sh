#!/bin/bash
#: Create a React + TypeScript project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating React + TS project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" -- --template react-ts

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

npx prettier --write "$PROJECT_PATH"
npm install --prefix "$PROJECT_PATH"

[ -f "$SRC/App.css" ] && rm "$SRC/App.css"
[ -f "$SRC/App.tsx" ] && rm "$SRC/App.tsx"
[ -f "$SRC/index.css" ] && rm "$SRC/index.css"
[ -f "$SRC/assets/react.svg" ] && rm "$SRC/assets/react.svg"
[ -f "$PUBLIC/vite.svg" ] && rm "$PUBLIC/vite.svg"

cat > "$SRC/main.tsx" <<EOL
import { StrictMode } from 'react';
import { createRoot } from 'react-dom/client';

createRoot(document.getElementById('root')!).render(
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
        <script type="module" src="./src/main.tsx"></script>
    </body>
</html>
EOL

code "$PROJECT_PATH"

echo "React + TS project created and ready: $PROJECT_NAME"
