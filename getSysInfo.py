#-----------------------------------------------------------------------------
# This script is used to retrieve a computer hardware/windows OS information
#-----------------------------------------------------------------------------
#
# TODO:: Use python to retrieve computer information
#
#
# pip install wmi
#

import wmi



try:
    conn = wmi.WMI()                                                               # Local computer
    #conn = wmi.WMI("192.168.1.10", user="administrator", password="admin_password")
 
    print('\n---------- Win32_ComputerSystem -------------')
    for cs in conn.Win32_ComputerSystem():
        print('Manufacturer: {}'.format(cs.Manufacturer))
        print('Model: {}'.format(cs.Model))
        print('SystemSKUNumber: {}'.format(cs.SystemSKUNumber))
        print('Product Name: {}'.format(cs.SystemFamily))
        print('Caption: {}'.format(cs.Caption))
        print('Computer Name: {}'.format(cs.Name))
        print('DNSHostName: {}'.format(cs.DNSHostName))
        print('Domain: {}'.format(cs.Domain))
        print('Workgroup: {}'.format(cs.Workgroup))
        print('UserName: {}'.format(cs.UserName))
        print('PrimaryOwnerName: {}'.format(cs.PrimaryOwnerName))
 
	# Network Configuration
    print('\n---------- Win32_NetworkAdapterConfiguration -------------')
    for interface in conn.Win32_NetworkAdapterConfiguration (IPEnabled=1):
        if interface.DefaultIPGateway != None:
            for ip in interface.IPAddress:
                if ip != "":
                    print (interface.Description, interface.MACAddress, ip)
                print

except Exception as e:
    print(e)



 