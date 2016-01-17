coffee-sourcemaps [![build](https://travis-ci.org/daggerok/coffee-sourcemaps.svg?branch=master)](https://travis-ci.org/daggerok/coffee-sourcemaps.svg?branch=master)
=================

### this is an example, how to build stage with coffeescript source maps (:

1. build and run serber

```
npm start
```

wait until page opens

2. press command+alt+i (F12 on windows) to open javascript consol and find log

```shell
required module 1...                    module1.coffee:1
required module 2...                    module2.coffee:1 
required both modules...                 bundle.coffee:7
```

you can click on on of the coffee file to watching coffee source code
also, to brows coffee script source code you can open developer tools, Sources tab and refresh with command+r

read more

- https://www.npmjs.com/package/gulp-coffeeify
- https://github.com/jnordberg/coffeeify
- http://browserify.org/
