#!/usr/bin/env bashio

export PORT=3000

if ! bashio::config.has_value 'mqtt.broker' && bashio::services.available "mqtt"; then
  if bashio::var.true "$(bashio::services mqtt "ssl")"; then
    MQTT_SCHEME="mqtts://";
  else
    MQTT_SCHEME="mqtt://";
  fi
  MQTT_HOST=$(bashio::services mqtt "host")
  MQTT_PORT=$(bashio::services mqtt "port")
  export MQTT_BROKER="${MQTT_SCHEME}${MQTT_HOST}:${MQTT_PORT}";
  export MQTT_USERNAME=$(bashio::services mqtt "username")
  export MQTT_PASSWORD=$(bashio::services mqtt "password")
fi

if bashio::config.has_value 'mqtt.broker'; then
  export MQTT_BROKER=$(bashio::config "mqtt.broker")
fi
if bashio::config.has_value 'mqtt.username'; then
  export MQTT_USERNAME=$(bashio::config "mqtt.username")
fi
if bashio::config.has_value 'mqtt.password'; then
  export MQTT_PASSWORD=$(bashio::config "mqtt.password")
fi
if bashio::config.has_value 'ha_discovery_prefix'; then
  export HA_DISCOVERY_PREFIX=$(bashio::config "ha_discovery_prefix")
fi
if bashio::config.has_value 'log_level'; then
  export LOG_LEVEL=$(bashio::config "log_level")
fi
if bashio::config.has_value 'echonetlite2mqtt_base_topic'; then
  export ECHONETLITE2MQTT_BASE_TOPIC=$(bashio::config "echonetlite2mqtt_base_topic")
fi
if bashio::config.has_value 'description_language'; then
  export DESCRIPTION_LANGUAGE=$(bashio::config "description_language")
fi
if bashio::config.has_value 'auto_request_interval'; then
  export AUTO_REQUEST_INTERVAL=$(bashio::config "auto_request_interval")
fi

exec node dist/index
