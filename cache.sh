#!/bin/bash

#removal of page cache
cache_dir="/some/dir/on/your/server/*"
rm -rf ${cache_dir}

#sitemap to be crawled
sitemap="https://example.com/sitemap.xml"

#the loop - page cache prewarm and cloudflare page cache purge
for b in ` wget -q ${sitemap} -O - | grep '^\s*<loc>' | sed 's/^\s*<loc>\(.*\)<\/loc>/\1/' `; do
    for i in ` wget -q ${b} -O - | grep '^\s*<loc>' | sed 's/^\s*<loc>\(.*\)<\/loc>/\1/' `; do
        wget -q ${i} -O /dev/null
    done
done
