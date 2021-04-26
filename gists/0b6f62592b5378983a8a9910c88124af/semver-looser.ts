import * as semver from 'semver'
declare module 'semver' {
  export const re: {[K in SourceParts]: RegExp}
  export const src: {[K in SourceParts]: string}
  export const enum SourceParts {
    NUMERICIDENTIFIER,
    NUMERICIDENTIFIERLOOSE,
    NONNUMERICIDENTIFIER,
    MAINVERSION,
    MAINVERSIONLOOSE,
    PRERELEASEIDENTIFIER,
    PRERELEASEIDENTIFIERLOOSE,
    PRERELEASE,
    PRERELEASELOOSE,
    BUILDIDENTIFIER,
    BUILD,
    FULL,
    LOOSE,
    GTLT,
    XRANGEIDENTIFIERLOOSE,
    XRANGEIDENTIFIER,
    XRANGEPLAIN,
    XRANGEPLAINLOOSE,
    XRANGE,
    XRANGELOOSE,
    COERCE,
    LONETILDE,
    TILDETRIM,
    TILDE,
    TILDELOOSE,
    LONECARET,
    CARETTRIM,
    CARET,
    CARETLOOSE,
    COMPARATORLOOSE,
    COMPARATOR,
    COMPARATORTRIM,
    HYPHENRANGE,
    HYPHENRANGELOOSE,
    STAR,
  }
}
const MAINVERSION_LOOSER = `(${
  semver.src[semver.SourceParts.NUMERICIDENTIFIER]
})(?:\\.(${
  semver.src[semver.SourceParts.NUMERICIDENTIFIER]
})(?:\\.(${
  semver.src[semver.SourceParts.NUMERICIDENTIFIER]
}))?)?`
const LOOSER = `${
  MAINVERSION_LOOSER
}${
  semver.src[semver.SourceParts.PRERELEASELOOSE]
}?${
  semver.src[semver.SourceParts.BUILD]
}?`
const RE_LOOSER = new RegExp(LOOSER, 'g')
export function fixVersion(s: string) {
  return s.replace(RE_LOOSER, (_val, major, minor, patch, pre, build) => `${
    major}.${minor || '0'}.${patch || '0'
  }${pre ? `-${pre}` : ''}${build ? `.${build}` : ''}`)
}
