#!/bin/bash
echo "building angular and copying into public"
git co production # should be new branch each time
git merge master
cd lineman
bower install
lineman build
cd ..
cp -R lineman/dist/* public/
git add public/img public/css/app.css public/js/app.js public/fonts
git commit -m "production build commit"
git push loomio-production production:master
rm -r public/img public/css public/js
git co master
