This is the repository of my tiny nginx and deployment manager. It's based on a Makefile and some git hooks, has no 
other dependecy unlike the other tools. I use it for deploying static websites built by Jekyll, and some NodeJS apps.

# Usage

Below command creates a new website, clones given git repo and runs
`make setup` command for once.

```bash
$ make new hostname=foobar.com git=git@github.com:azer/foobar.com
```

**Deployment:**

Once you create the new site, a new remote of given repository is created
under `sites/$hostname/git` path and `make deploy` command will be run after
every update.

```
$ git remote add production ssh://ada/~/www/sites/azer.io/git
$ git push production master
```

Use `pass` parameter to set a proxy pass:

```bash
make new hostname=api.foobar.com git=git@github.com:azer/api.foobar.com pass=/:http://127.0.0.1:8888,/v2:http://127.0.0.1:8080
```

The command above will output this config:

```nginx
location / {
  proxy_pass http://127.0.0.1:8888
}

location /v2 {
  proxy_pass http://127.0.0.1:8080
}
```

# Available Commands

## make new

Creates a new site.

```bash
$ make new hostname=foobar.com git=git@github.com:azer/foobar.com
```

## make rm

Removes a site.

## make start

Starts a new nginx process loading local configurations.

## make stop

Stops nginx.

## make reload

Reloads nginx configs.
