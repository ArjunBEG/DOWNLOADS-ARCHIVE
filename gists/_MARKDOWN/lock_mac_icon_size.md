I wanted my Mac's dock icons to be a consistent size, not subject to change and not "off" by a pixel or two, thereby making them look less crisp.

---

So, I pieced this together after reading these two articles…

https://www.macobserver.com/tmo/article/how-to-lock-the-dock-size-position-and-contents-in-os-x

https://www.intego.com/mac-security-blog/unlock-the-macos-docks-hidden-secrets-in-terminal/

---

```
defaults write com.apple.dock tilesize -integer 48;

defaults write com.apple.dock size-immutable -bool yes;

killAll Dock;
```