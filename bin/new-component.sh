#!/usr/bin/env bash

cd ./packages/lib
mkdir $1
cd $1

if [ -n "$3" ]
then
  echo '
{
  "name": "'$1'.js",
  "version": "1.0.0",
  "description": "",
  "main": "dist/index.min.js",
  "scripts": {
    "build": "./node_modules/.bin/rollup -c"
  },
  "author": "'$2'",
  "license": "MIT",
  "dependencies": {},
  "devDependencies": {
    "@babel/core": "^7.0.0",
    "@babel/plugin-external-helpers": "^7.0.0",
    "@babel/preset-env": "^7.0.0",
    "cross-origin": "^1.0.6",
    "eslint-config-airbnb": "^18.0.1",
    "eslint-plugin-import": "^2.19.1",
    "rollup": "^0.66.6",
    "rollup-plugin-babel": "^4.0.1",
    "rollup-plugin-babel-minify": "^6.1.1",
    "rollup-plugin-css-only": "^1.0.0",
    "rollup-plugin-eslint": "^7.0.0",
    "rollup-plugin-stylus-compiler": "^1.0.1"
  }
}
    ' > package.json
else
  echo '
{
  "name": "'$1'.js",
  "version": "1.0.0",
  "description": "",
  "main": "dist/index.min.js",
  "scripts": {
    "build": "./node_modules/.bin/rollup -c"
  },
  "author": "'$2'",
  "license": "MIT",
  "dependencies": {},
  "devDependencies": {
    "@babel/core": "^7.0.0",
    "@babel/plugin-external-helpers": "^7.0.0",
    "@babel/preset-env": "^7.0.0",
    "cross-origin": "^1.0.6",
    "eslint-config-airbnb": "^18.0.1",
    "eslint-plugin-import": "^2.19.1",
    "rollup": "^0.66.6",
    "rollup-plugin-babel": "^4.0.1",
    "rollup-plugin-babel-minify": "^6.1.1",
    "rollup-plugin-eslint": "^7.0.0",
  }
}
    ' > package.json
fi

echo "
# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Runtime data
pids
*.pid
*.seed
*.pid.lock

# Directory for instrumented libs generated by jscoverage/JSCover
lib-cov

# Coverage directory used by tools like istanbul
coverage

# nyc test coverage
.nyc_output

# Grunt intermediate storage (http://gruntjs.com/creating-plugins#storing-task-files)
.grunt

# Bower dependency directory (https://bower.io/)
bower_components

# node-waf configuration
.lock-wscript

# Compiled binary addons (http://nodejs.org/api/addons.html)
build/Release

# Dependency directories
node_modules/
jspm_packages/

# Typescript v1 declaration files
typings/

# Optional npm cache directory
.npm

# Optional eslint cache
.eslintcache

# Optional REPL history
.node_repl_history

# Output of 'npm pack'
*.tgz

# Yarn Integrity file
.yarn-integrity

# dotenv environment variables file
.env
" > .gitignore

echo "
  module.exports = {
  'root': true,
  'extends': 'eslint:recommended',
  'globals': {
    'wp': true,
  },
  'env': {
    'node': true,
    'es6': true,
    'amd': true,
    'browser': true
  },
  'parserOptions': {
    'ecmaFeatures': {
      'globalReturn': true,
      'generators': false,
      'objectLiteralDuplicateProperties': false,
      'experimentalObjectRestSpread': true,
    },
    'ecmaVersion': 2017,
    'sourceType': 'module',
  },
  'plugins': [
    'import',
  ],
  'settings': {
    'import/core-modules': [],
    'import/ignore': [
      'node_modules',
      '\\\\\.(coffee|scss|css|less|hbs|svg|json)$',
    ],
  },
  'rules': {
    'no-console': 0,
    'quotes': ['error', 'single'],
    'comma-dangle': [
      'error',
      {
        'arrays': 'always-multiline',
        'objects': 'always-multiline',
        'imports': 'always-multiline',
        'exports': 'always-multiline',
        'functions': 'ignore',
      },
    ],
  },
};
" > .eslintrc.js

echo '
{
  "presets": [
    [
      "@babel/preset-env",
      {
        "useBuiltIns": "entry",
        "corejs": {
          "version": 3
        },
        "targets": {
          "browsers": [
            "last 2 versions",
            "ie >= 11"
          ]
        }
      }
    ]
  ]
} ' > .babelrc

if [ -n "$3" ]
then
  echo "
import babel from 'rollup-plugin-babel';
import minify from 'rollup-plugin-babel-minify';
import stylus  from 'rollup-plugin-stylus-compiler';
import css from 'rollup-plugin-css-only';
import { eslint } from 'rollup-plugin-eslint';
const minifyConfig = { comments: false };

export default [
  {
    input: 'src/index.js',
    output: {
      name: 'index',
      file: 'dist/index.min.js',
      format: 'umd'
    },
    interop: false,
    plugins: [
      eslint(),
      babel(),
      minify(minifyConfig),
    ]
  },
  {
    input: 'src/stylus/app.styl',
    output: {
      file: 'dist/$1.js',
      format: 'system'
    },
    plugins: [
      stylus(),
      css()
    ]
  }
]
    " > rollup.config.js
else
  echo "
    import babel from 'rollup-plugin-babel';
    import minify from 'rollup-plugin-babel-minify';
    import { eslint } from 'rollup-plugin-eslint';
    const minifyConfig = { comments: false };

    export default [
      {
        input: 'src/index.js',
        output: {
          name: 'index',
          file: 'dist/index.min.js',
          format: 'umd'
        },
        interop: false,
        plugins: [
          eslint(),
          babel(),
          minify(minifyConfig),
        ]
      }
    ]
    " > rollup.config.js
fi

mkdir src
cd src

echo "
export default () => console.log('hello halley');
" > index.js

if [ -n "$3" ]
then
  mkdir stylus
  cd stylus
  echo " " > app.styl
  cd ../..
else
  cd ..
fi

npm install