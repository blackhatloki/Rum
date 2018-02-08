$TTL 3h
@ IN SOA trusted.ny root.trusted.ny (
          4    ; Serial 
          3h   ; Refresh after 3 hours
          1h   ; Retry after 1 hour 
          1w   ; Expire after 1 week 
          1h ) ; Negative caching TTL of 1 hour

;
;
;  Name servers
; 
  IN NS trusted.ny. 
  IN NS ns1.ny.
  IN NS ns2.ny. 
 
; 
; Address for the caconical names
; 
localhost            IN A  127.0.0.1 
router               IN A  192.168.1.1 
esxi                 IN A  192.168.1.40
rcli                 IN A  192.168.1.42
stewie               IN A  192.168.1.60 
cartman              IN A  192.168.1.61
prod                 IN A  192.168.1.62
qa                   IN A  192.168.1.64
dev                  IN A  192.168.1.65
beta                 IN A  192.168.1.70
kickstart            IN A  192.168.1.72
jumpstart            IN A  192.168.1.76
daemon               IN A  192.168.1.100
dhcp101              IN A  192.168.1.101
dhcp102              IN A  192.168.1.102
dhcp103              IN A  192.168.1.103
dhcp104              IN A  192.168.1.104
dhcp105              IN A  192.168.1.105
dhcp106              IN A  192.168.1.106
dhcp107              IN A  192.168.1.107
dhcp108              IN A  192.168.1.108
dhcp109              IN A  192.168.1.109
dhcp110              IN A  192.168.1.110
dhcp111              IN A  192.168.1.111
dhcp112              IN A  192.168.1.112
dhcp113              IN A  192.168.1.113
dhcp114              IN A  192.168.1.114
dhcp115              IN A  192.168.1.115
nx01                 IN A  192.168.1.116
dhcp117              IN A  192.168.1.117
dhcp118              IN A  192.168.1.118
dhcp119              IN A  192.168.1.119
dhcp120              IN A  192.168.1.120
theta-sol            IN A  192.168.1.210
beta-sol             IN A  192.168.1.215
bridge               IN A  192.168.1.220
trusted             IN A  192.168.1.200
freeIp201             IN A  192.168.1.201
freeIp202             IN A  192.168.1.202
freeIp203             IN A  192.168.1.203
freeIp204             IN A  192.168.1.204
freeIp205             IN A  192.168.1.205
freeIp206             IN A  192.168.1.206
freeIp207             IN A  192.168.1.207
freeIp208             IN A  192.168.1.208
freeIp209             IN A  192.168.1.209
freeIp210             IN A  192.168.1.210
freeIp211             IN A  192.168.1.211
freeIp212             IN A  192.168.1.212
freeIp213             IN A  192.168.1.213
freeIp214             IN A  192.168.1.214
freeIp215             IN A  192.168.1.215
freeIp216             IN A  192.168.1.216
freeIp217             IN A  192.168.1.217
freeIp218             IN A  192.168.1.218
freeIp219             IN A  192.168.1.219
freeIp221             IN A  192.168.1.221
freeIp222             IN A  192.168.1.222
freeIp223             IN A  192.168.1.223
freeIp224             IN A  192.168.1.224
freeIp225             IN A  192.168.1.225
freeIp226             IN A  192.168.1.226
freeIp227             IN A  192.168.1.227
freeIp228             IN A  192.168.1.228
freeIp229             IN A  192.168.1.229
freeIp230             IN A  192.168.1.230
freeIp231             IN A  192.168.1.231
freeIp232             IN A  192.168.1.232
freeIp233             IN A  192.168.1.233
freeIp234             IN A  192.168.1.234
freeIp235             IN A  192.168.1.235
freeIp236             IN A  192.168.1.236
freeIp237             IN A  192.168.1.237
freeIp238             IN A  192.168.1.238
freeIp239             IN A  192.168.1.239
freeIp240             IN A  192.168.1.240
freeIp241             IN A  192.168.1.241
freeIp242             IN A  192.168.1.242
freeIp243             IN A  192.168.1.243
freeIp244             IN A  192.168.1.244
freeIp245             IN A  192.168.1.245
freeIp246             IN A  192.168.1.246
freeIp247             IN A  192.168.1.247
freeIp248             IN A  192.168.1.248
freeIp249             IN A  192.168.1.249
freeIp250             IN A  192.168.1.250
theta                 IN A  192.168.1.251
freeIp252             IN A  192.168.1.252
freeIp253             IN A  192.168.1.253
freeIp254             IN A  192.168.1.254
