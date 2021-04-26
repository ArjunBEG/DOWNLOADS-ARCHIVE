echo "<button on:click='set({ count: count + 1 })'>{count}</button>" > App.html

npx svelte compile App.html --format iife --name App > App.js

echo "<div id=target></div>
<script src=App.js></script>
<script>
  new App({
    target,
    data: { count: 0 }
  });
</script>" > index.html

open index.html
