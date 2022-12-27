#!/bin/sh

set -ex

ANX1_ENV_LIB_LARAVEL_AUTH_USER=${ANX1_ENV_LIB_LARAVEL_AUTH_USER:-anx1-gb-pharmacy-core}
ANX1_ENV_LIB_LARAVEL_AUTH_PASSWD=${ANX1_ENV_LIB_LARAVEL_AUTH_PASSWD:-$(makepasswd)}

htpasswd -cb /etc/apache2/.htpasswd "$ANX1_ENV_LIB_LARAVEL_AUTH_USER" "$ANX1_ENV_LIB_LARAVEL_AUTH_PASSWD"
