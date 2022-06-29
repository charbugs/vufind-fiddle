docker run \
  -it \
  -p 8080:8080 \
  -p 8983:8983 \
  -v "$(pwd):/vufind" \
  -w /vufind \
  vufind-fiddle-8.0.4 \
  sh -c "\
    export PATH=/vufind/vendor/bin:$PATH && \
    composer install --no-interaction && \
    php install.php --non-interactive &&  \
    npm install node-sass@7.0.1 grunt-sass@3.1.0 && \
    echo xdebug.client_host=10.1.0.1 >> /etc/php/7.4/cli/php.ini && \
    ./solr/vendor/bin/solr start && \
    ./solr/vendor/bin/solr create -c biblio && \
    php -S 0.0.0.0:8080 public/index.php"