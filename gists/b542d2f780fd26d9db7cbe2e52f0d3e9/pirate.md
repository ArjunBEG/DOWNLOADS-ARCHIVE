<a href='#Basic_Options_6172'>#</a><h2 id='Basic_Options_6172'>Options fer All</h2>

It be the basic options. Aye

<a href='#incremental'>#</a><h2 id='incremental'>Incremental</h2>

Enable incremental compilation

|         |               |
| ------- | ------------- |
| Value   | `incremental` |
| Default | `true`        |

---

<a href='#target'>#</a><h2 id='target'>Target</h2>

Specify ECMAScript target version: 'ES3' (default), 'ES5', 'ES2015', 'ES2016', 'ES2017', 'ES2018', 'ES2019' or 'ESNEXT'.

|         |          |
| ------- | -------- |
| Value   | `target` |
| Default | `false`  |

---

<a href='#module'>#</a><h2 id='module'>Module</h2>

Specify module code generation: 'none', 'commonjs', 'amd', 'system', 'umd', 'es2015', or 'ESNext'.

|       |          |
| ----- | -------- |
| Value | `module` |

---

<a href='#lib'>#</a><h2 id='lib'>Lib</h2>

Specify library files to be included in the compilation.

|         |       |
| ------- | ----- |
| Value   | `lib` |
| Default | `n/a` |

---

<a href='#allowJs'>#</a><h2 id='allowJs'>yar</h2>

Allow javascript files to be compiled.

|         |           |
| ------- | --------- |
| Value   | `allowJs` |
| Default | `false`   |

---

<a href='#checkJs'>#</a><h2 id='checkJs'>Check JS</h2>

Report errors in .js files.

|         |           |
| ------- | --------- |
| Value   | `checkJs` |
| Default | `false`   |

---

<a href='#jsx'>#</a><h2 id='jsx'>JSx</h2>

Specify JSX code generation: 'preserve', 'react-native', or 'react'.

|         |              |
| ------- | ------------ |
| Value   | `jsx`        |
| Default | `"preserve"` |

---

<a href='#declaration'>#</a><h2 id='declaration'>Declaration</h2>

Generates corresponding '.d.ts' file.

|         |               |
| ------- | ------------- |
| Value   | `declaration` |
| Default | True when TS  |

---

<a href='#declarationMap'>#</a><h2 id='declarationMap'>Declaration Map</h2>

Generates a sourcemap for each corresponding '.d.ts' file.

|         |                  |
| ------- | ---------------- |
| Value   | `declarationMap` |
| Default | `false`          |

---

<a href='#sourceMap'>#</a><h2 id='sourceMap'>Source Map</h2>

Generates corresponding '.map' file.

|         |             |
| ------- | ----------- |
| Value   | `sourceMap` |
| Default | `false`     |

---

<a href='#outFile'>#</a><h2 id='outFile'>Out File</h2>

Concatenate and emit output to single file.

|         |                                    |
| ------- | ---------------------------------- |
| Value   | `outFile`                          |
| Default | `n/a`                              |
| Related | [`out`](#out), [`outDir`](#outDir) |

---

<a href='#outDir'>#</a><h2 id='outDir'>Out Dir</h2>

Redirect output structure to the directory.

|         |                                      |
| ------- | ------------------------------------ |
| Value   | `outDir`                             |
| Default | `n/a`                                |
| Related | [`out`](#out), [`outFile`](#outFile) |

---

<a href='#rootDir'>#</a><h2 id='rootDir'>Root Dir</h2>

Specify the root directory of input files. Use to control the output directory structure with --outDir.

|         |                                       |
| ------- | ------------------------------------- |
| Value   | `rootDir`                             |
| Default | Computed from the list of input files |

---

<a href='#composite'>#</a><h2 id='composite'>Composite</h2>

Enable project compilation

|         |             |
| ------- | ----------- |
| Value   | `composite` |
| Default | `true`      |

---

<a href='#tsBuildInfoFile'>#</a><h2 id='tsBuildInfoFile'>TS Build Info File</h2>

Specify file to store incremental compilation information

|         |                   |
| ------- | ----------------- |
| Value   | `tsBuildInfoFile` |
| Default | .tsbuildin        |

---

<a href='#removeComments'>#</a><h2 id='removeComments'>Remove Comments</h2>

Do not emit comments to output.

|         |                  |
| ------- | ---------------- |
| Value   | `removeComments` |
| Default | `false`          |

---

<a href='#noEmit'>#</a><h2 id='noEmit'>No Emit</h2>

Do not emit outputs.

|         |          |
| ------- | -------- |
| Value   | `noEmit` |
| Default | `false`  |

---

<a href='#importHelpers'>#</a><h2 id='importHelpers'>Import Helpers</h2>

Import emit helpers from 'tslib'.

|         |                 |
| ------- | --------------- |
| Value   | `importHelpers` |
| Default | `false`         |

---

<a href='#downlevelIteration'>#</a><h2 id='downlevelIteration'>Downlevel Iteration</h2>

Provide full support for iterables in 'for-of', spread, and destructuring when targeting 'ES5' or 'ES3'.

|         |                      |
| ------- | -------------------- |
| Value   | `downlevelIteration` |
| Default | `false`              |

---

<a href='#isolatedModules'>#</a><h2 id='isolatedModules'>Isolated Modules</h2>

Transpile each file as a separate module (similar to 'ts.transpileModule').

|         |                   |
| ------- | ----------------- |
| Value   | `isolatedModules` |
| Default | `false`           |

---

<a href='#Strict_Type_Checking_Options_6173'>#</a><h2 id='Strict_Type_Checking_Options_6173'>Strict Checks</h2>

Additional Checks Copy

<a href='#strict'>#</a><h2 id='strict'>Strict</h2>

Enable all strict type-checking options.

|         |                                                                                                                                                               |
| ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Value   | `strict`                                                                                                                                                      |
| Default | `false`                                                                                                                                                       |
| Related | [`strictBindCallApply`](#strictBindCallApply), [`strictFunctionTypes`](#strictFunctionTypes), [`strictPropertyInitialization`](#strictPropertyInitialization) |

---

<a href='#noImplicitAny'>#</a><h2 id='noImplicitAny'>No Implicit Any</h2>

Raise error on expressions and declarations with an implied 'any' type.

|         |                 |
| ------- | --------------- |
| Value   | `noImplicitAny` |
| Default | `false`         |

---

<a href='#strictNullChecks'>#</a><h2 id='strictNullChecks'>Strict Null Checks</h2>

Enable strict null checks.

|         |                    |
| ------- | ------------------ |
| Value   | `strictNullChecks` |
| Default | `false`            |

---

<a href='#strictFunctionTypes'>#</a><h2 id='strictFunctionTypes'>Strict Function Types</h2>

Enable strict checking of function types.

|         |                       |
| ------- | --------------------- |
| Value   | `strictFunctionTypes` |
| Default | `false`               |

---

<a href='#strictBindCallApply'>#</a><h2 id='strictBindCallApply'>Strict Bind Call Apply</h2>

Enable strict 'bind', 'call', and 'apply' methods on functions.

|         |                       |
| ------- | --------------------- |
| Value   | `strictBindCallApply` |
| Default | `false`               |

---

<a href='#strictPropertyInitialization'>#</a><h2 id='strictPropertyInitialization'>Strict Property Initialization</h2>

Enable strict checking of property initialization in classes.

|         |                                |
| ------- | ------------------------------ |
| Value   | `strictPropertyInitialization` |
| Default | `false`                        |

---

<a href='#noImplicitThis'>#</a><h2 id='noImplicitThis'>No Implicit This</h2>

Raise error on 'this' expressions with an implied 'any' type.

|         |                  |
| ------- | ---------------- |
| Value   | `noImplicitThis` |
| Default | `false`          |

---

<a href='#alwaysStrict'>#</a><h2 id='alwaysStrict'>Always Strict</h2>

Parse in strict mode and emit "use strict" for each source file.

|         |                |
| ------- | -------------- |
| Value   | `alwaysStrict` |
| Default | `false`        |

---

<a href='#Module_Resolution_Options_6174'>#</a><h2 id='Module_Resolution_Options_6174'>Module Resolution</h2>

Additional Checks Copy

<a href='#moduleResolution'>#</a><h2 id='moduleResolution'>Module Resolution</h2>

Specify module resolution strategy: 'node' (Node.js) or 'classic' (TypeScript pre-1.6).

|       |                    |
| ----- | ------------------ |
| Value | `moduleResolution` |

---

<a href='#baseUrl'>#</a><h2 id='baseUrl'>Base Url</h2>

Base directory to resolve non-absolute module names.

|         |           |
| ------- | --------- |
| Value   | `baseUrl` |
| Default | `n/a`     |

---

<a href='#paths'>#</a><h2 id='paths'>Paths</h2>

A series of entries which re-map imports to lookup locations relative to the 'baseUrl'.

|       |         |
| ----- | ------- |
| Value | `paths` |

---

<a href='#rootDirs'>#</a><h2 id='rootDirs'>Root Dirs</h2>

List of root folders whose combined content represents the structure of the project at runtime.

|       |            |
| ----- | ---------- |
| Value | `rootDirs` |

---

<a href='#typeRoots'>#</a><h2 id='typeRoots'>Type Roots</h2>

List of folders to include type definitions from.

|       |             |
| ----- | ----------- |
| Value | `typeRoots` |

---

<a href='#types'>#</a><h2 id='types'>Types</h2>

Type declaration files to be included in compilation.

|       |         |
| ----- | ------- |
| Value | `types` |

---

<a href='#allowSyntheticDefaultImports'>#</a><h2 id='allowSyntheticDefaultImports'>Allow Synthetic Default Imports</h2>

Allow default imports from modules with no default export. This does not affect code emit, just typechecking.

|         |                                        |
| ------- | -------------------------------------- |
| Value   | `allowSyntheticDefaultImports`         |
| Default | module === "system" or esModuleInterop |

---

<a href='#esModuleInterop'>#</a><h2 id='esModuleInterop'>Es Module Interop</h2>

Enables emit interoperability between CommonJS and ES Modules via creation of namespace objects for all imports. Implies 'allowSyntheticDefaultImports'.

|         |                   |
| ------- | ----------------- |
| Value   | `esModuleInterop` |
| Default | `false`           |

---

<a href='#preserveSymlinks'>#</a><h2 id='preserveSymlinks'>Preserve Symlinks</h2>

Do not resolve the real path of symlinks.

|         |                    |
| ------- | ------------------ |
| Value   | `preserveSymlinks` |
| Default | `false`            |

---

<a href='#allowUmdGlobalAccess'>#</a><h2 id='allowUmdGlobalAccess'>Allow Umd Global Access</h2>

Allow accessing UMD globals from modules.

|         |                        |
| ------- | ---------------------- |
| Value   | `allowUmdGlobalAccess` |
| Default | `false`                |

---

<a href='#Source_Map_Options_6175'>#</a><h2 id='Source_Map_Options_6175'>Source Maps</h2>

Additional Checks Copy

<a href='#sourceRoot'>#</a><h2 id='sourceRoot'>Source Root</h2>

Specify the location where debugger should locate TypeScript files instead of source locations.

|       |              |
| ----- | ------------ |
| Value | `sourceRoot` |

---

<a href='#mapRoot'>#</a><h2 id='mapRoot'>Map Root</h2>

Specify the location where debugger should locate map files instead of generated locations.

|         |           |
| ------- | --------- |
| Value   | `mapRoot` |
| Default | `n/a`     |

---

<a href='#inlineSourceMap'>#</a><h2 id='inlineSourceMap'>Inline Source Map</h2>

Emit a single file with source maps instead of having a separate file.

|         |                   |
| ------- | ----------------- |
| Value   | `inlineSourceMap` |
| Default | `false`           |

---

<a href='#inlineSources'>#</a><h2 id='inlineSources'>Inline Sources</h2>

Emit the source alongside the sourcemaps within a single file; requires '--inlineSourceMap' or '--sourceMap' to be set.

|         |                 |
| ------- | --------------- |
| Value   | `inlineSources` |
| Default | `false`         |

---

<a href='#Additional_Checks_6176'>#</a><h2 id='Additional_Checks_6176'>Additional Checks</h2>

Additional Checks Copy

<a href='#noUnusedLocals'>#</a><h2 id='noUnusedLocals'>No Unused Locals</h2>

Report errors on unused locals.

|         |                  |
| ------- | ---------------- |
| Value   | `noUnusedLocals` |
| Default | `false`          |

---

<a href='#noUnusedParameters'>#</a><h2 id='noUnusedParameters'>No Unused Parameters</h2>

Report errors on unused parameters.

|         |                      |
| ------- | -------------------- |
| Value   | `noUnusedParameters` |
| Default | `false`              |

---

<a href='#noImplicitReturns'>#</a><h2 id='noImplicitReturns'>No Implicit Returns</h2>

Report error when not all code paths in function return a value.

|         |                     |
| ------- | ------------------- |
| Value   | `noImplicitReturns` |
| Default | `false`             |

---

<a href='#noFallthroughCasesInSwitch'>#</a><h2 id='noFallthroughCasesInSwitch'>No Fallthrough Cases In Switch</h2>

Report errors for fallthrough cases in switch statement.

|         |                              |
| ------- | ---------------------------- |
| Value   | `noFallthroughCasesInSwitch` |
| Default | `false`                      |

---

<a href='#Experimental_Options_6177'>#</a><h2 id='Experimental_Options_6177'>Experimental</h2>

Additional Checks Copy

<a href='#experimentalDecorators'>#</a><h2 id='experimentalDecorators'>Experimental Decorators</h2>

Enables experimental support for ES7 decorators.

|       |                          |
| ----- | ------------------------ |
| Value | `experimentalDecorators` |

---

<a href='#emitDecoratorMetadata'>#</a><h2 id='emitDecoratorMetadata'>Emit Decorator Metadata</h2>

Enables experimental support for emitting type metadata for decorators.

|       |                         |
| ----- | ----------------------- |
| Value | `emitDecoratorMetadata` |

---

<a href='#Advanced_Options_6178'>#</a><h2 id='Advanced_Options_6178'>Advanced</h2>

Additional Checks Copy

<a href='#listFiles'>#</a><h2 id='listFiles'>List Files</h2>

Print names of files part of the compilation.

|         |             |
| ------- | ----------- |
| Value   | `listFiles` |
| Default | `false`     |

---

<a href='#listEmittedFiles'>#</a><h2 id='listEmittedFiles'>List Emitted Files</h2>

Print names of generated files part of the compilation.

|         |                    |
| ------- | ------------------ |
| Value   | `listEmittedFiles` |
| Default | `false`            |

---

<a href='#traceResolution'>#</a><h2 id='traceResolution'>Trace Resolution</h2>

Enable tracing of the name resolution process.

|         |                   |
| ------- | ----------------- |
| Value   | `traceResolution` |
| Default | `false`           |

---

<a href='#diagnostics'>#</a><h2 id='diagnostics'>Diagnostics</h2>

Show diagnostic information.

|         |               |
| ------- | ------------- |
| Value   | `diagnostics` |
| Default | `false`       |

---

<a href='#extendedDiagnostics'>#</a><h2 id='extendedDiagnostics'>Extended Diagnostics</h2>

Show verbose diagnostic information.

|         |                       |
| ------- | --------------------- |
| Value   | `extendedDiagnostics` |
| Default | `false`               |

---

<a href='#locale'>#</a><h2 id='locale'>Locale</h2>

The locale used when displaying messages to the user (e.g. 'en-us')

|         |                   |
| ------- | ----------------- |
| Value   | `locale`          |
| Default | Platform specific |

---

<a href='#emitDeclarationOnly'>#</a><h2 id='emitDeclarationOnly'>Emit Declaration Only</h2>

Only emit '.d.ts' declaration files.

|         |                       |
| ------- | --------------------- |
| Value   | `emitDeclarationOnly` |
| Default | `false`               |

---

<a href='#jsxFactory'>#</a><h2 id='jsxFactory'>JSx Factory</h2>

Specify the JSX factory function to use when targeting 'react' JSX emit, e.g. 'React.createElement' or 'h'.

|         |              |
| ------- | ------------ |
| Value   | `jsxFactory` |
| Default | `React"`     |

---

<a href='#resolveJsonModule'>#</a><h2 id='resolveJsonModule'>Resolve JSon Module</h2>

Include modules imported with '.json' extension

|         |                     |
| ------- | ------------------- |
| Value   | `resolveJsonModule` |
| Default | `false`             |

---

<a href='#out'>#</a><h2 id='out'>Out</h2>

[Deprecated] Use '--outFile' instead. Concatenate and emit output to single file

|         |                                            |
| ------- | ------------------------------------------ |
| Value   | `out`                                      |
| Status  | Deprecated                                 |
| Default | `n/a`                                      |
| Related | [`outDir`](#outDir), [`outFile`](#outFile) |

---

<a href='#reactNamespace'>#</a><h2 id='reactNamespace'>React Namespace</h2>

[Deprecated] Use '--jsxFactory' instead. Specify the object invoked for createElement when targeting 'react' JSX emit

|         |                  |
| ------- | ---------------- |
| Value   | `reactNamespace` |
| Default | `"React"`        |

---

<a href='#skipDefaultLibCheck'>#</a><h2 id='skipDefaultLibCheck'>Skip Default Lib Check</h2>

[Deprecated] Use '--skipLibCheck' instead. Skip type checking of default library declaration files.

|         |                       |
| ------- | --------------------- |
| Value   | `skipDefaultLibCheck` |
| Default | `false`               |

---

<a href='#charset'>#</a><h2 id='charset'>Charset</h2>

The character set of the input files.

|         |           |
| ------- | --------- |
| Value   | `charset` |
| Default | `utf8`    |

---

<a href='#emitBOM'>#</a><h2 id='emitBOM'>Emit B O M</h2>

Emit a UTF-8 Byte Order Mark (BOM) in the beginning of output files.

|         |           |
| ------- | --------- |
| Value   | `emitBOM` |
| Default | `false`   |

---

<a href='#newLine'>#</a><h2 id='newLine'>New Line</h2>

Specify the end of line sequence to be used when emitting files: 'CRLF' (dos) or 'LF' (unix).

|         |                   |
| ------- | ----------------- |
| Value   | `newLine`         |
| Default | Platform specific |

---

<a href='#noErrorTruncation'>#</a><h2 id='noErrorTruncation'>No Error Truncation</h2>

Do not truncate error messages.

|         |                     |
| ------- | ------------------- |
| Value   | `noErrorTruncation` |
| Default | `false`             |

---

<a href='#noLib'>#</a><h2 id='noLib'>No Lib</h2>

Do not include the default library file (lib.d.ts).

|         |         |
| ------- | ------- |
| Value   | `noLib` |
| Default | `false` |

---

<a href='#noResolve'>#</a><h2 id='noResolve'>No Resolve</h2>

Do not add triple-slash references or imported modules to the list of compiled files.

|         |             |
| ------- | ----------- |
| Value   | `noResolve` |
| Default | `false`     |

---

<a href='#stripInternal'>#</a><h2 id='stripInternal'>Strip Internal</h2>

Do not emit declarations for code that has an '@internal' annotation.

|       |                 |
| ----- | --------------- |
| Value | `stripInternal` |

---

<a href='#disableSizeLimit'>#</a><h2 id='disableSizeLimit'>Disable Size Limit</h2>

Disable size limitations on JavaScript projects.

|         |                    |
| ------- | ------------------ |
| Value   | `disableSizeLimit` |
| Default | `false`            |

---

<a href='#noImplicitUseStrict'>#</a><h2 id='noImplicitUseStrict'>No Implicit Use Strict</h2>

Do not emit 'use strict' directives in module output.

|         |                       |
| ------- | --------------------- |
| Value   | `noImplicitUseStrict` |
| Default | `false`               |

---

<a href='#noEmitHelpers'>#</a><h2 id='noEmitHelpers'>No Emit Helpers</h2>

Do not generate custom helper functions like '\_\_extends' in compiled output.

|         |                 |
| ------- | --------------- |
| Value   | `noEmitHelpers` |
| Default | `false`         |

---

<a href='#noEmitOnError'>#</a><h2 id='noEmitOnError'>No Emit On Error</h2>

Do not emit outputs if any errors were reported.

|         |                 |
| ------- | --------------- |
| Value   | `noEmitOnError` |
| Default | `false`         |

---

<a href='#preserveConstEnums'>#</a><h2 id='preserveConstEnums'>Preserve Const Enums</h2>

Do not erase const enum declarations in generated code.

|         |                      |
| ------- | -------------------- |
| Value   | `preserveConstEnums` |
| Default | `false`              |

---

<a href='#declarationDir'>#</a><h2 id='declarationDir'>Declaration Dir</h2>

Output directory for generated declaration files.

|         |                  |
| ------- | ---------------- |
| Value   | `declarationDir` |
| Default | n/a              |

---

<a href='#skipLibCheck'>#</a><h2 id='skipLibCheck'>Skip Lib Check</h2>

Skip type checking of declaration files.

|         |                |
| ------- | -------------- |
| Value   | `skipLibCheck` |
| Default | `false`        |

---

<a href='#allowUnusedLabels'>#</a><h2 id='allowUnusedLabels'>Allow Unused Labels</h2>

Do not report errors on unused labels.

|         |                     |
| ------- | ------------------- |
| Value   | `allowUnusedLabels` |
| Default | `false`             |

---

<a href='#allowUnreachableCode'>#</a><h2 id='allowUnreachableCode'>Allow Unreachable Code</h2>

Do not report errors on unreachable code.

|         |                        |
| ------- | ---------------------- |
| Value   | `allowUnreachableCode` |
| Default | `false`                |

---

<a href='#suppressExcessPropertyErrors'>#</a><h2 id='suppressExcessPropertyErrors'>Suppress Excess Property Errors</h2>

Suppress excess property checks for object literals.

|         |                                |
| ------- | ------------------------------ |
| Value   | `suppressExcessPropertyErrors` |
| Default | `false`                        |

---

<a href='#suppressImplicitAnyIndexErrors'>#</a><h2 id='suppressImplicitAnyIndexErrors'>Suppress Implicit Any Index Errors</h2>

Suppress noImplicitAny errors for indexing objects lacking index signatures.

|         |                                  |
| ------- | -------------------------------- |
| Value   | `suppressImplicitAnyIndexErrors` |
| Default | `false`                          |

---

<a href='#forceConsistentCasingInFileNames'>#</a><h2 id='forceConsistentCasingInFileNames'>Force Consistent Casing In File Names</h2>

Disallow inconsistently-cased references to the same file.

|         |                                    |
| ------- | ---------------------------------- |
| Value   | `forceConsistentCasingInFileNames` |
| Default | `false`                            |

---

<a href='#maxNodeModuleJsDepth'>#</a><h2 id='maxNodeModuleJsDepth'>Max Node Module JS Depth</h2>

The maximum dependency depth to search under node_modules and load JavaScript files.

|         |                        |
| ------- | ---------------------- |
| Value   | `maxNodeModuleJsDepth` |
| Default | `0`                    |

---

<a href='#noStrictGenericChecks'>#</a><h2 id='noStrictGenericChecks'>No Strict Generic Checks</h2>

Disable strict checking of generic signatures in function types.

|         |                         |
| ------- | ----------------------- |
| Value   | `noStrictGenericChecks` |
| Default | `false`                 |

---

<a href='#keyofStringsOnly'>#</a><h2 id='keyofStringsOnly'>Keyof Strings Only</h2>

Resolve 'keyof' to string valued property names only (no numbers or symbols).

|         |                    |
| ------- | ------------------ |
| Value   | `keyofStringsOnly` |
| Default | `false`            |

---

<a href='#Command_line_Options_6171'>#</a><h2 id='Command_line_Options_6171'>Command Line</h2>

Additional Checks Copy

<a href='#preserveWatchOutput'>#</a><h2 id='preserveWatchOutput'>Preserve Watch Output</h2>

Whether to keep outdated console output in watch mode instead of clearing the screen.

|         |                       |
| ------- | --------------------- |
| Value   | `preserveWatchOutput` |
| Default | `false`               |

---

<a href='#pretty'>#</a><h2 id='pretty'>Pretty</h2>

Stylize errors and messages using color and context (experimental).

|         |          |
| ------- | -------- |
| Value   | `pretty` |
| Default | `true`   |

---
