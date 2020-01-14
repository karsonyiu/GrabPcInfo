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
                print('-')

    # Operating system & OS version
    print('\n---------- Win32_OperatingSystem -------------')
    for os in conn.Win32_OperatingSystem():
        print('OS : {}'.format(os.Caption))
        print('Version: {}'.format(os.Version))
        print('CountryCode: {}'.format(os.CountryCode))
        print('OSLanguage: {}'.format(os.OSLanguage))
        print('Locale: {}'.format(os.Locale))
        print('CSName: {}'.format(os.CSName))
        print('Organization: {}'.format(os.Organization))
        print('SerialNumber: {}'.format(os.SerialNumber))
        print('-')
        
		
	# BIOS information
    print('\n---------- Win32_BIOS -------------')
    for b in conn.Win32_BIOS():
        print('Caption: {}'.format(b.Caption))
        print('Name: {}'.format(b.Name))
        print('SerialNumber: {}'.format(b.SerialNumber))
        print('-')
        

    # Processor name
    print('\n---------- Win32_Processor -------------')
    for pr in conn.Win32_Processor():
        print( 'CPU: {}'.format(pr.Name))
        print( 'ProcessorId: {}'.format(pr.ProcessorId))
        print('-')


except Exception as e:
    print(e)



 