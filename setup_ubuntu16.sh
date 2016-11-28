#!/usr/bin/env bash
# Install elasticsearch and kibana
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
sudo apt-get install apt-transport-https
echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list
sudo apt-get update
sudo apt-get install -y \
    openjdk-8-jre \
    elasticsearch \
    kibana

# Change config
sudo sysctl -w vm.max_map_count=262144
sudo bash -c "echo 'vm.max_map_count=262144' >> /etc/sysctl.conf"
sudo sed -i 's/^-Xms2g/-Xms384m/' /etc/elasticsearch/jvm.options
sudo sed -i 's/^-Xmx2g/-Xmx384m/' /etc/elasticsearch/jvm.options
sudo bash -c "echo 'network.host: 0.0.0.0' >> /etc/elasticsearch/elasticsearch.yml"
sudo bash -c "echo 'server.host: 0.0.0.0' >> /etc/kibana/kibana.yml"

# Start
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable elasticsearch.service
sudo /bin/systemctl start elasticsearch.service
sudo /bin/systemctl enable kibana.service
sudo /bin/systemctl start kibana.service
