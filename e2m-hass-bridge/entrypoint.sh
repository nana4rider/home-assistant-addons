#!/usr/bin/env bashio

export PORT=3000

bashio::log.info "MQTT service found, fetching credentials ..."
if bashio::var.true "$(bashio::services 'mqtt' 'ssl')"; then
  MQTT_SCHEME="mqtts://";
else
  MQTT_SCHEME="mqtt://";
fi
MQTT_HOST=$(bashio::services mqtt "host")
MQTT_PORT=$(bashio::services mqtt "port")
export MQTT_BROKER="${MQTT_SCHEME}${MQTT_HOST}:${MQTT_PORT}";
export MQTT_USERNAME=$(bashio::services mqtt "username")
export MQTT_PASSWORD=$(bashio::services mqtt "password")
export HA_DISCOVERY_PREFIX=$(bashio::services 'mqtt' 'discovery_prefix')

if (bashio::config.has_value 'log_level'); then
  export LOG_LEVEL=$(bashio::config "log_level")
fi
if (bashio::config.has_value 'echonetlite2mqtt_base_topic'); then
  export ECHONETLITE2MQTT_BASE_TOPIC=$(bashio::config "echonetlite2mqtt_base_topic")
fi
if (bashio::config.has_value 'DESCRIPTION_LANGUAGE'); then
  export DESCRIPTION_LANGUAGE=$(bashio::config "description_language")
fi
if (bashio::config.has_value 'AUTO_REQUEST_INTERVAL'); then
  export AUTO_REQUEST_INTERVAL=$(bashio::config "auto_request_interval")
fi

node dist/index
