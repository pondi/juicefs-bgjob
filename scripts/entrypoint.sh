#!/bin/sh -e

if [ ! -f /etc/timezone ] && [ ! -z "$TZ" ]; then
  # At first startup, set timezone
  cp /usr/share/zoneinfo/$TZ /etc/localtime
  echo $TZ >/etc/timezone
fi

# Check if all required environment variables are set
for var in JUICEFS_MOUNTSTRING; do
  if [ -z "$(eval echo \$$var)" ]; then
    echo "** Error: This container will not run without setting for $var **"
    exit 1
  fi
done

# Build the optional parameters string
OPTIONAL_PARAMS=""
[ ! -z "$USAGE_REPORT" ] && OPTIONAL_PARAMS="$OPTIONAL_PARAMS --no-usage-report"
[ ! -z "$CACHE_SIZE" ] && OPTIONAL_PARAMS="$OPTIONAL_PARAMS --cache-size $CACHE_SIZE"
[ ! -z "$BACKUP_META" ] && OPTIONAL_PARAMS="$OPTIONAL_PARAMS --backup-meta $BACKUP_META"

/usr/bin/juicefs mount $JUICEFS_MOUNTSTRING /mnt/juicefs $OPTIONAL_PARAMS