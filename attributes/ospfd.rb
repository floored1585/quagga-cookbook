include_attribute 'quagga'

default[:quagga][:ospf][:area] = ''
default[:quagga][:ospf][:networks] = []
default[:quagga][:ospf][:protocols] = []
default[:quagga][:ospf][:interfaces] = {}
default[:quagga][:ospf][:passive_ints] = []
