yum install GeoIP GeoIP-data
cat ./ip_list.txt | sort | uniq | xargs -n 1 geoiplookup { }

