# Building the blog locally

Jekyll is a program built on top of Ruby, and so building the blog to
serve locally requires you to install 

1. `ruby` itself, 
1. the package manager `gem` that ships Ruby libraries,
1. `jekyll` itself, and
1. the _other package manager_ `bundler` that handles the packages
   needed by Jekyll. 
   
Therefore, the steps are as follows:

1. [Install](https://www.ruby-lang.org/en/downloads/) `ruby`, whether
   through your OS package manager, through a distributed binary,
   through source code etc.
2. The installation should also provide `gem`. If not, install that as
   well.
3. In this repo's path, run `gem install jekyll bundler` to install
   `jekyll` and the `bundler` program that will fetch whatever
   packages are necessary for the blog to run in the next step (these
   dependencies are listed in `./Gemfile`)
4. Run `bundle install` to install the dependencies.
5. Finally, run `jekyll serve` to serve the blog as visible through a
   browser.
   
These steps are also reproduced in the `Dockerfile`, which exposes
port 4000. You can then build the docker image and run the blog
locally by
```bash
docker build -t jekyll-blog .
docker run --rm -p <your-port-here>:4000 -it jekyll-blog
```
