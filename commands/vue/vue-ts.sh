#!/bin/bash
#: Create a Vue 3 + TypeScript project with Prettier and Vite.

TARGET_DIR=$1
PROJECT_NAME=${2:-my-project}

PROJECT_PATH="$TARGET_DIR/$PROJECT_NAME"
SRC="$PROJECT_PATH/src"
PUBLIC="$PROJECT_PATH/public"

echo "Creating Vue + TS project in $PROJECT_PATH ..."

cd "$TARGET_DIR" || exit
yes n | npm create vite@latest "$PROJECT_NAME" -- --template vue-ts

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

[ -f "$SRC/components/HelloWorld.vue" ] && rm "$SRC/components/HelloWorld.vue"
[ -f "$SRC/counter.ts" ] && rm "$SRC/counter.ts"
[ -f "$SRC/App.vue" ] && rm "$SRC/App.vue"
[ -f "$SRC/typescript.svg" ] && rm "$SRC/typescript.svg"
[ -f "$SRC/assets/vue.svg" ] && rm "$SRC/assets/vue.svg"
[ -f "$SRC/style.css" ] && rm "$SRC/style.css"
[ -f "$PUBLIC/vite.svg" ] && rm "$PUBLIC/vite.svg"

rm -f \
"$SRC/assets/vite.svg" \
"$SRC/assets/hero.png" \
"$PUBLIC/vite.svg" \
"$PUBLIC/favicon.svg" \
"$PUBLIC/icons.svg"

cat > "$SRC/main.ts" <<EOL
import { createApp } from 'vue';

createApp({}).mount('#app');
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
        <div id="app"></div>
        <script type="module" src="./src/main.ts"></script>
    </body>
</html>
EOL

code "$PROJECT_PATH"

echo "Vue + TS project created and ready: $PROJECT_NAME"
