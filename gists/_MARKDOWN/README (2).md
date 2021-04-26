Requires a YAML file with mappings, e.g.
```yaml
:task_a:
  :task_b:
    :task_c:
  :task_d:
  :task_e:
```

View interactive graph:
```
brew install xdot
xdot graph.dot
```
  
View static graph:
```
brew install graphviz
dot graph.dot -Tsvg -o graph.svg   # SVG
dot graph.dot -Tsvgz -o graph.svgz # Compressed SVG
```

Recommend using [Gapplin](http://gapplin.wolfrosch.com/) to view the SVG files.