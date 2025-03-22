#!/command/with-contenv bashio

declare secret_key
declare access_key
declare region
declare bucket
declare endpoint_url
declare prefix

CONFIG=/data/config.json

secret_key=$(bashio::config 'secret_key')
access_key=$(bashio::config 'access_key')
region=$(bashio::config 'region')
bucket=$(bashio::config 'bucket')
endpoint_url=$(bashio::config 'endpoint_url')
prefix=$(bashio::config 'prefix')
retain_full=$(bashio::config 'retain_full')
retention=$(bashio::config 'retention')

export AWS_ACCESS_KEY_ID=$access_key
export AWS_SECRET_ACCESS_KEY=$secret_key

bashio::log.info "Starting backup to S3..."
duplicity \
    --full-if-older-than $retention \
    --no-encryption \
    --s3-region-name $region \
    --s3-endpoint-url $endpoint_url \
    --progress \
    /backup \
    s3://$bucket/$prefix
bashio::log.info "Done"

bashio::log.info "Starting remove old full backup..."
duplicity \
    --s3-region-name $region \
    --s3-endpoint-url $endpoint_url \
    remove-all-but-n-full $retain_full \
    s3://$bucket/$prefix \
    --force
bashio::log.info "Done"

if [ $? -ne 0 ]; then
    bashio::log.error "Backup failed"
    exit 1
else
    bashio::log.info "Backup completed successfully"
    exit 0
fi
