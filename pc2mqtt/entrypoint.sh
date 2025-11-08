#!/usr/bin/env bashio

export PORT=50206

if ! bashio::config.has_value 'mqtt.broker' && bashio::services.available "mqtt"; then
  bashio::log.info "MQTT service found, fetching credentials ..."
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
if bashio::config.has_value 'device_config_path'; then
  export DEVICE_CONFIG_PATH=$(bashio::config "device_config_path")
fi
if bashio::config.has_value 'availability_interval'; then
  export AVAILABILITY_INTERVAL=$(bashio::config "availability_interval")
fi
if bashio::config.has_value 'state_change_pause_duration'; then
  export STATE_CHANGE_PAUSE_DURATION=$(bashio::config "state_change_pause_duration")
fi
if bashio::config.has_value 'check_alive_interval'; then
  export CHECK_ALIVE_INTERVAL=$(bashio::config "check_alive_interval")
fi

exec node dist/index
