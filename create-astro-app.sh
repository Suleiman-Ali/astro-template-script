create-astro "$1" --yes;
cd "$1";
rm -rf public/ src/ README.md tsconfig.json astro.config.mjs;
mkdir src public;
echo '{
  "extends": "astro/tsconfigs/strict",
  "exclude": ["/node_modules"],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["src/*"]
    }
  }
}
' >> tsconfig.json;
echo 'import { defineConfig } from "astro/config";

export default defineConfig({
  output: "hybrid",
});
' >> astro.config.mjs;
touch .env;
cd src;
echo '/// <reference types="astro/client" />' >> env.d.ts;
mkdir pages components layouts;
echo '---
interface Props {
  title?: string;
  description?: string;
}

const { title = "", description = "" } = Astro.props;
---


<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="description" content={description} />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="generator" content={Astro.generator} />
    <title>{title}</title>
  </head>
  <body>
  <main><slot /></main>
  </body>
</html>
' >> ./layouts/main.astro;
echo '---
import Main from "@/layouts/main.astro";
---

<Main>Home</Main>
' >> ./pages/index.astro;
cd ..;

