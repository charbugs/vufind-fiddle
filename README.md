
In ./docker-run.sh set `xdebug.client_host` to the ip of the docker bridge (can change from machine to machine).

```
$ docker build -t vufind-fiddle-8.0.4 .
$ ./docker-run.sh
```

http://localhost:8080
http://localhost:8983/solr/#

There is also an VSCode debugger launch script that should work out of the box.