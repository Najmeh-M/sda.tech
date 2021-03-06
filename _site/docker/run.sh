#!/bin/bash
DIR="/var/www/"
PROJECT="sda.tech"
BRANCH="develop"

if [ "$(ls -A $DIR/$PROJECT)" ]; then
     mkdir -p $DIR/$PROJECT && cd $DIR/$PROJECT
     git pull origin $BRANCH
else
    git clone -b $BRANCH https://github.com/SmartDataAnalytics/sda.tech.git $DIR/$PROJECT
    cd $DIR/$PROJECT && git pull
fi

if [ -s $DIR/$PROJECT/Gemfile ]
then
    cd $DIR/$PROJECT

    echo "Install dependencies from Gemfile"
    # update gems
    bundle install

    # generate the site with jekyll
    bundle exec jekyll build -s $DIR/$PROJECT -d $DIR/$PROJECT
else
    echo "No Gemfile found use standard jekyll installation"
    # generate the site with jekyll
    jekyll build -s $DIR/$PROJECT -d $DIR/$PROJECT
fi

echo
date