#!/bin/bash

git daemon \
  --port=8000 \
  --export-all \
  --reuseaddr \
  --base-path=. \
  --listen=localhost
