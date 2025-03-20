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

export AWS_ACCESS_KEY_ID=$access_key
export AWS_SECRET_ACCESS_KEY=$secret_key

bashio::log.info "Starting backup to S3..."
duplicity backup --no-encryption --s3-region-name $region --s3-endpoint-url $endpoint_url --progress /backup s3://$bucket/$prefix

if [ $? -ne 0 ]; then
    bashio::log.error "Backup failed"
    exit 1
else
    bashio::log.info "Backup completed successfully"
    exit 0
fi
