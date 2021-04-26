1. Roadmap: https://github.com/microsoft/TypeScript-Website/issues/94
1. Updates: https://github.com/microsoft/TypeScript-Website/issues/130

1. Design - Figma
    1. First joined, did prototype designs for playground https://www.figma.com/file/Q0872II3wi1EzCXV9eUNBqb7/Playground?node-id=5%3A87
    1. From that design went back to a doc page https://www.figma.com/file/x8FJrNqj6oupqWn1s3uMg4/Website?node-id=7%3A1
    1. From doc page went to https://www.figma.com/file/x8FJrNqj6oupqWn1s3uMg4/Website?node-id=1%3A129
  
1. Dev: Start off, what is Gatsby -> https://www.gatsbyjs.org
1. Why do I think Gatsby is a good fit -> https://www.gatsbyjs.org/blog/2020-01-23-why-typescript-chose-gatsby/
1. Mono-repo packages -> https://github.com/microsoft/TypeScript-Website/tree/v2/packages
1. Simple page `/empty` -> http://www.typescriptlang.org/v2/empty
    1. Example code: https://github.com/microsoft/TypeScript-Website/blob/v2/packages/typescriptlang-org/src/templates/pages/empty.tsx
1. More complex page `/docs/home` -> http://www.typescriptlang.org/v2/docs/home
    1. Code: https://github.com/microsoft/TypeScript-website/blob/v2/packages/typescriptlang-org/src/templates/pages/docs/home.tsx

1. Doc Generation
    1. https://github.com/microsoft/TypeScript-Website/tree/v2/packages/handbook-v1/en
    1. https://github.com/microsoft/TypeScript-Website/tree/v2/packages/playground-examples
    1. https://github.com/microsoft/TypeScript-Website/tree/v2/packages/tsconfig-reference
  
1. i8n
    1. Overview https://github.com/microsoft/TypeScript-Website/issues/100
    1. Writeup: https://github.com/microsoft/TypeScript-Website/issues/130#issuecomment-587943151
    1. Incrementally applied, compare /ja/ with /en/ in playground-examples
    1. Grabbed at build time and pages are created per-lang here -> https://github.com/microsoft/TypeScript-Website/blob/v2/packages/typescriptlang-org/lib/bootup/ingestion/createPlaygrounds.ts
    1. URLs are all in English, special linking code looks at all URLs to determine if you can stay in lang: https://github.com/microsoft/TypeScript-Website/blob/v2/packages/typescriptlang-org/src/components/IntlLink.tsx

1. Automation
    1. Deploys 
        1. Prod - https://github.com/microsoft/TypeScript-Website/blob/master/.github/workflows/Release.yml
        1. Staging - https://github.com/microsoft/TypeScript-Website/blob/master/.github/workflows/Staging.yml
    2. Code Owners
        1. https://github.com/microsoft/TypeScript-repos-automation
        1. https://github.com/microsoft/TypeScript-Website/blob/v2/.github/CODEOWNERS
    3. Danger
        1. Spell Check - https://github.com/microsoft/TypeScript-Website/pull/47#issuecomment-527518690
        1. a11y audit - https://github.com/microsoft/TypeScript-Website/pull/173#issuecomment-572068364
        1. visual changes - https://github.com/microsoft/TypeScript-Website/pull/250

1. New tools
    1. Twoslash: http://www.typescriptlang.org/v2/dev/twoslash
    1. Sandbox: http://www.typescriptlang.org/v2/dev/sandbox
    1. Playground Plugins: http://www.typescriptlang.org/v2/dev/playground-plugins
    1. typescript-vfs: https://github.com/microsoft/TypeScript-Website/tree/v2/packages/typescript-vfs