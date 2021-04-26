#!/bin/bash
rm -rf node_modules package.json package-lock.json a b

mkdir a
cd a
git init
cat >package.json <<APKG
{
  "name": "a",
  "version": "1.2.3",
  "dependencies": {
    "b": "git://localhost:8000/b"
  },
  "scripts": {
    "prepare": "echo prepare a"
  }
}
APKG
git add package.json
gci -m 'package a'
cd ..

mkdir b
cd b
git init
cat >package.json <<APKG
{
  "name": "b",
  "version": "1.2.3",
  "dependencies": {
    "a": "git://localhost:8000/a"
  },
  "scripts": {
    "prepare": "echo prepare b"
  }
}
APKG
git add package.json
gci -m 'package b'
cd ..

cat >package.json <<PKG
{
  "name": "project",
  "version": "1.2.3",
  "dependencies": {
    "a": "git://localhost:8000/a"
  }
}
PKG

node ../../scripts/reify.js
