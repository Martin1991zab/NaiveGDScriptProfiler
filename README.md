# Naive GDScript Profiler

The idea is to create a profiler for godot's GDScript script language, which
looks like the NYTprof (New York Times Profiler) for perl.

## Things to be seen:

- per line
  - execution count
  - executions per second
  - minimum time
  - maximum time
  - average time
- flamegraph (because there are cool .. i mean hot ... ah you know what i mean - flames)
  - average time spend
- color coded output of the scripts

## Needed metadata from godot

to keep things simple and a little bit less resource hungry on the godot side
we need simply a (or more, perhaps per script) stream of metadata

example in csv format the minimum would be:
```
<file>;<line>;<timestamp>;<optional the actual line>
```

## how to get the data from godot

to get this informations i wont to take a 2 step approach

1. writing a script that patch the actual GDScript files
   - writing the output in a file via an autoload function
   - do's not need to be perfect; good formatted gdscript and regex is enough for the start
2. when every thing worked out and proven to be helpful try to get this directly from the engine
   - needs modifications on the c++ codebase so i would need to learn c++ (not a problem simply costs time)

