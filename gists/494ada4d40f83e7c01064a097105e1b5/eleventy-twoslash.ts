import MarkdownIt from "markdown-it";
import { createShikiHighlighter, renderCodeToHTML, runTwoSlash, canHighlightLang } from "shiki-twoslash";
import { HighlighterOptions, Highlighter } from "shiki/dist/highlighter";

export default function markdownItShikiTwoslash(markdownit: MarkdownIt, userOptions: HighlighterOptions): void {
  let highlighter:Highlighter = null!
  // @ts-ignore - fixed in next release to always be a promise
  createShikiHighlighter(userOptions).then(h => highlighter = h)

  const oldFence = markdownit.renderer.rules.fence;
  if (!oldFence) throw new Error("No fence set");

  // The highlighter API doesn't get the info in the codeblocks,
  // so we extract twoslash references and drop it into the language
  // which means it can be picked up below
  markdownit.renderer.rules.fence = (...args) => {
    const tokens = args[0];
    const idx = args[1];
    const token = tokens[idx];
    if (token.info && token.info.includes("twoslash")) {
      const before = token.info.split(/\s+/g)[0];
      token.info = before + "-twoslash";
    }
    const theirs = oldFence(...args);
    return theirs;
  };

  // Look for a twoslash result in the language, and use that to run the sample
  markdownit.options.highlight = function (text: string, _lang: string) {
    const hasTwoslash = _lang.includes("-twoslash")
    let lang = _lang.replace("-twoslash", "")
    let code = text

    let twoslashResults: import("@typescript/twoslash").TwoSlashReturn | undefined = undefined

    if (hasTwoslash) {
      twoslashResults = runTwoSlash(text, lang)
      code = twoslashResults.code
      lang = twoslashResults.extension
    }

    if (canHighlightLang(lang)) {
      const results = renderCodeToHTML(code, lang, highlighter, twoslashResults)
      return results
    } else {
      return `<pre><code>${text}</code></pre>`
    }
  };
}
