all:
	rm -rf _site
	bundle exec jekyll serve --verbose --trace

install:Gemfile
	bundle install
