#!/bin/bash

# Bump version
flutter pub run version

# Commit the changes
git add pubspec.yaml
git commit -m "Bump version"
git config --global user.email "sumit.lal007@gmail.com"
git config --global user.name "sumit113"