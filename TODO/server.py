import xml.etree.ElementTree as ET
import sys, socket, random, time, thread

response_delay = 0.04
errorcode = 0
custinfo_responses = 1
era_version = True
token_reset = False
interactive = False
mutex = 0

try:
    port = int(sys.argv[2])
    ip = sys.argv[1]
except:
    port = 4020
    ip = '168.207.215.12'
listenaddress = (ip, port)

voicemail_audio, platform_response_xml, voicemail_url_xml, switch_response_xml, followup_response_xml, call_response_xml, mark_response_xml, transfer_response_xml, settings_response_xml, voicemail_response_xml, active_response_xml, history_response_xml, custinfo_response_zero_xml, custinfo_response_xml, custinfo_response_multiple_xml, contacts_response_xml = '', '', '', '', '', '', '', '', '', '', '', '', '', '', '', ''

def poll_for_go():
    return mutex == 1

def set_xml():
    global era_version, switch_response_xml, followup_response_xml, call_response_xml, mark_response_xml, transfer_response_xml, settings_response_xml, voicemail_response_xml, active_response_xml, history_response_xml, custinfo_response_xml, custinfo_response_multiple_xml, contacts_response_xml, custinfo_response_zero_xml, voicemail_url_xml, platform_response_xml, voicemail_audio

    custinfo_response_zero_xml = switch_response_xml = followup_response_xml = call_response_xml = mark_response_xml = transfer_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response>\n\t' \
      '<id>x</id>\n\t' \
      '<errorcode>%s</errorcode>\n\t' \
      '<errordesc>Success</errordesc>\n' \
    '</response>'

    #switch_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    #'<response>\n\t' \
      #'<id>%s</id>\n' \
    #'</response>'

    voicemail_audio = 'fkdlafjlskfj;dklasfjkdsafjsafdsafsa'

    platform_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
      '<Platform>%s</Platform>\n' \
    '</response>\n'

    voicemail_url_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
    '<VMUrl>http://168.207.215.6:4030/wavsample.wav</VMUrl>\n' \
    '</response>\n'
    #'<VMUrl>http://10.2.50.10/cgi/servefile.cgi?vmid=45_1358369465207237_1358369465215969_2010_2020&:amp;secret=bogus</VMUrl>\n' \

    settings_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response>\n\t<id>6</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
      '<CallForwarding UserExtn="101,102" TwinEnabled="%s" CallForwardEnabled="%s"></CallForwarding>\n\t' \
      '<UserExtensions>201,203</UserExtensions>\n' \
    '</response>'

    voicemail_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response><id>36</id><errorcode>%s</errorcode><errordesc>Success</errordesc>\n\t' \
      '<VoicemailList>\n\t\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969865215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>unknown</Name>\n\t\t\t' \
          '<Number>3334445555</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969465215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Unknown</Name>\n\t\t\t' \
          '<Number>7473333</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969465215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Unknown</Name>\n\t\t\t' \
          '<Number>7473333</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969465215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Unknown</Name>\n\t\t\t' \
          '<Number>7473333</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969465215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Unknown</Name>\n\t\t\t' \
          '<Number>7473333</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969465215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Unknown</Name>\n\t\t\t' \
          '<Number>7473333</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969465215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Unknown</Name>\n\t\t\t' \
          '<Number>7473333</Number>\n\t\t\t' \
          '<DateTime>1289215105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969165215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>UNKNOWN</Name>\n\t\t\t' \
          '<Number>18003339999</Number>\n\t\t\t' \
          '<DateTime>1289206105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358269265215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name></Name>\n\t\t\t' \
          '<Number>2010</Number>\n\t\t\t' \
          '<DateTime>1289202484</DateTime>\n\t\t\t' \
          '<IsNew>Y</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358969365215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name>Test caller</Name>\n\t\t\t' \
          '<Number>2010</Number>\n\t\t\t' \
          '<DateTime>1289205105</DateTime>\n\t\t\t' \
          '<IsNew>N</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
        '<Voicemail>\n\t\t\t' \
          '<Identifier>45_1358369465207237_1358269665215969_2010_2020.au</Identifier>\n\t\t\t' \
          '<Name></Name>\n\t\t\t' \
          '<Number>2010</Number>\n\t\t\t' \
          '<DateTime>1289202484</DateTime>\n\t\t\t' \
          '<IsNew>Y</IsNew>\n\t\t\t' \
          '<Length>5</Length>\n\t\t\t' \
        '</Voicemail>\n\t' \
      '</VoicemailList>\n' \
    '</response>'

    active_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response>\n\t<id>12</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
      '<Calls Time="1355345823" ID="doejohnx">\n\t\t' \
        '<CallInfo Time="1341756302" CallType="external" Direction="I" State="InCall" StateTime="1355345815" AnswerTime="%s" Record="on" RemoteNum="2223334444" RemoteName="" RemoteCallID="" LocalExt="7135550001" LocalName="Doe, John" LocalLineExt="101" LocalLineName="Doe, John" LocalCallID="SIP/10.2.40.2-0000001c" OutsideLineNum="7135550101" OutsideLineName="My_DNID" RefExt="101" RefName="Doe, John" StoreID="01" BranchID="02" />\n\t\t' \
        '<CallInfo Time="1341756202" CallType="external" Direction="O" State="OnHold" StateTime="1355345815" AnswerTime="1355345815" Record="on" RemoteNum="7135551234" RemoteName="Loblaw, Bob" RemoteCallID="SIP/10.2.40.2-0000001a" LocalExt="7135550001" LocalName="Doe, John" LocalLineExt="101" LocalLineName="Doe, John" LocalCallID="SIP/10.2.40.2-0000001c" OutsideLineNum="7135550101" OutsideLineName="My_DNID" RefExt="101" RefName="Doe, John" StoreID="01" BranchID="02" />\n\t' \
      '</Calls>\n' \
    '</response>'

    history_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
    '<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
      '<CallHistoryList>\n\t\t' \
        '<Call>\n\t\t\t' \
          '<Identifier>0003</Identifier>\n\t\t\t' \
          '<CallerID></CallerID>\n\t\t\t' \
          '<DMSmatch>N</DMSmatch>\n\t\t\t' \
          '<Number>3834551155</Number>\n\t\t\t' \
          '<DateTime>1112446800</DateTime>\n\t\t\t' \
          '<Direction>I</Direction>\n\t\t\t' \
          '<Missed>N</Missed>\n\t\t\t' \
          '<FollowUp>N</FollowUp>\n\t\t\t' \
          '<Duration>103</Duration>\n\t\t' \
        '</Call>\n\t\t' \
        '<Call>\n\t\t\t' \
          '<Identifier>0004</Identifier>\n\t\t\t' \
          '<CallerID>unknoWn</CallerID>\n\t\t\t' \
          '<DMSmatch>Y</DMSmatch>\n\t\t\t' \
          '<Number>7371812828</Number>\n\t\t\t' \
          '<DateTime>1112529600</DateTime>\n\t\t\t' \
          '<Direction>N</Direction>\n\t\t\t' \
          '<Missed>Y</Missed>\n\t\t\t' \
          '<FollowUp>N</FollowUp>\n\t\t\t' \
          '<Duration>103</Duration>\n\t\t' \
        '</Call>\n\t\t' \
        '<Call>\n\t\t\t' \
          '<Identifier>0005</Identifier>\n\t\t\t' \
          '<CallerID>George Michael</CallerID>\n\t\t\t' \
          '<DMSmatch>N</DMSmatch>\n\t\t\t' \
          '<Number>8131313</Number>\n\t\t\t' \
          '<DateTime>1130587200</DateTime>\n\t\t\t' \
          '<Direction>O</Direction>\n\t\t\t' \
          '<Missed>Y</Missed>\n\t\t\t' \
          '<FollowUp>N</FollowUp>\n\t\t\t' \
          '<Duration>103</Duration>\n\t\t' \
        '</Call>\n\t\t' \
        '<Call>\n\t\t\t' \
          '<Identifier>0006</Identifier>\n\t\t\t' \
          '<CallerID>Tobias Funke</CallerID>\n\t\t\t' \
          '<DMSmatch>N</DMSmatch>\n\t\t\t' \
          '<Number>8341702</Number>\n\t\t\t' \
          '<DateTime>1130677200</DateTime>\n\t\t\t' \
          '<Direction>I</Direction>\n\t\t\t' \
          '<Missed>Y</Missed>\n\t\t\t' \
          '<FollowUp>Y</FollowUp>\n\t\t\t' \
          '<Duration>103</Duration>\n\t\t' \
        '</Call>\n\t\t' \
        '<Call>\n\t\t\t' \
          '<Identifier>0007</Identifier>\n\t\t\t' \
          '<CallerID></CallerID>\n\t\t\t' \
          '<DMSmatch>N</DMSmatch>\n\t\t\t' \
          '<Number>8823713</Number>\n\t\t\t' \
          '<DateTime>1341752202</DateTime>\n\t\t\t' \
          '<Direction>O</Direction>\n\t\t\t' \
          '<Missed>Y</Missed>\n\t\t\t' \
          '<FollowUp>Y</FollowUp>\n\t\t\t' \
          '<Duration>103</Duration>\n\t\t' \
        '</Call>\n\t\t' \
        '<Call>\n\t\t\t' \
          '<Identifier>0008</Identifier>\n\t\t\t' \
          '<CallerID>Tony Wonder</CallerID>\n\t\t\t' \
          '<DMSmatch>Y</DMSmatch>\n\t\t\t' \
          '<Number>12301313112</Number>\n\t\t\t' \
          '<DateTime>1342752202</DateTime>\n\t\t\t' \
          '<Direction>I</Direction>\n\t\t\t' \
          '<Missed>Y</Missed>\n\t\t\t' \
          '<FollowUp>N</FollowUp>\n\t\t\t' \
          '<Duration>103</Duration>\n\t\t' \
        '</Call>\n\t' \
      '</CallHistoryList>\n' \
    '</response>'

    if era_version == True:
        custinfo_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
            '<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
              '<CustInfo>\n\t\t' \
                '<CallerID>Williamson, William W.</CallerID>\n\t\t' \
                '<IndOrCompany>I</IndOrCompany>\n\t\t' \
                '<Address>12345 Bruce B Downs Blvd</Address>\n\t\t' \
                '<Address2>Apt 1234</Address2>\n\t\t' \
                '<City>L.A.</City>\n\t\t' \
                '<State>California</State>\n\t\t' \
                '<Zip>12412</Zip>\n\t\t' \
                '<ServiceInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<type>R</type>\n\t\t\t\t' \
                    '<date>1341716302</date>\n\t\t\t\t' \
                    '<record>833125x</record>\n\t\t\t\t' \
                    '<status>Complete</status>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<type>A</type>\n\t\t\t\t' \
                    '<date>1321656302</date>\n\t\t\t\t' \
                    '<record>208298</record>\n\t\t\t\t' \
                    '<status>Complete</status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</ServiceInfo>\n\t\t' \
                '<ProspectInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<Prospect>Phone Hot 01/22/13</Prospect>\n\t\t\t\t' \
                    '<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t' \
                    '<NextActivity>Walk in</NextActivity>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</ProspectInfo>\n\t\t' \
                '<VehicleInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<VIN>1431o4321840148vin</VIN>\n\t\t\t\t' \
                    '<ModelYear>2004</ModelYear>\n\t\t\t\t' \
                    '<ModelName>Cherokee</ModelName>\n\t\t\t\t' \
                    '<Color>Silver</Color>\n\t\t\t\t' \
                    '<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t\t' \
                    '<ServiceAdvisor>Bill Bobster</ServiceAdvisor>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<VIN></VIN>\n\t\t\t\t' \
                    '<ModelYear>1998</ModelYear>\n\t\t\t\t' \
                    '<ModelName>Taurus</ModelName>\n\t\t\t\t' \
                    '<Color>Red</Color>\n\t\t\t\t' \
                    '<SalesPerson></SalesPerson>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</VehicleInfo>\n\t\t' \
                '<FinanceInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DealNumber>92375</DealNumber>\n\t\t\t\t' \
                    '<ModelYear>2011</ModelYear>\n\t\t\t\t' \
                    '<ModelName>RX-8</ModelName>\n\t\t\t\t' \
                    '<VehicleType>New</VehicleType>\n\t\t\t\t' \
                    '<Type>Lease</Type>\n\t\t\t\t' \
                    '<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t' \
                    '<SoldDate>1341756302</SoldDate>\n\t\t\t\t' \
                    '<Status>Sold</Status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DealNumber>92375</DealNumber>\n\t\t\t\t' \
                    '<ModelYear>2010</ModelYear>\n\t\t\t\t' \
                    '<ModelName>F150</ModelName>\n\t\t\t\t' \
                    '<VehicleType></VehicleType>\n\t\t\t\t' \
                    '<Type>Lease</Type>\n\t\t\t\t' \
                    '<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t' \
                    '<SoldDate>1341756302</SoldDate>\n\t\t\t\t' \
                    '<Status>Sold</Status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DealNumber>92375</DealNumber>\n\t\t\t\t' \
                    '<ModelYear>2012</ModelYear>\n\t\t\t\t' \
                    '<ModelName>Gallardo</ModelName>\n\t\t\t\t' \
                    '<VehicleType>New</VehicleType>\n\t\t\t\t' \
                    '<Type>Lease</Type>\n\t\t\t\t' \
                    '<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t' \
                    '<Status>Sold</Status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</FinanceInfo>\n\t\t' \
                '<SpoInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<OrderNumber>12345</OrderNumber>\n\t\t\t\t' \
                    '<DateAdded>1341756302</DateAdded>\n\t\t\t\t' \
                    '<Status>Ordered</Status>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DateAdded></DateAdded>\n\t\t\t\t' \
                    '<Status></Status>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DateAdded>1341714131</DateAdded>\n\t\t\t\t' \
                    '<Status></Status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</SpoInfo>\n\t' \
              '</CustInfo>\n' \
            '</response>'
    else:
        custinfo_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n' \
            '<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t' \
              '<CustInfo>\n\t\t' \
                '<CallerID>Williamson, William W.</CallerID>\n\t\t' \
                '<IndOrCompany>I</IndOrCompany>\n\t\t' \
                '<Address>123 Fake St.</Address>\n\t\t' \
                '<City>L.A.</City>\n\t\t' \
                '<State>California</State>\n\t\t' \
                '<Zip>12412</Zip>\n\t\t' \
                '<ServiceInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<type>A</type>\n\t\t\t\t' \
                    '<date></date>\n\t\t\t\t' \
                    '<record>912311x</record>\n\t\t\t\t' \
                    '<status></status>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<type>R</type>\n\t\t\t\t' \
                    '<date>1341716302</date>\n\t\t\t\t' \
                    '<record>833125x</record>\n\t\t\t\t' \
                    '<status>Complete</status>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<type>A</type>\n\t\t\t\t' \
                    '<date>1321656302</date>\n\t\t\t\t' \
                    '<record>831312x</record>\n\t\t\t\t' \
                    '<status>Complete</status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</ServiceInfo>\n\t\t' \
                '<ProspectInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<Prospect>105082</Prospect>\n\t\t\t\t' \
                    '<SalesPerson>Harris, Jessica</SalesPerson>\n\t\t\t\t' \
                    '<CrmRep>HARRISJO</CrmRep>\n\t\t\t\t' \
                    '<SalesStep>greet</SalesStep>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</ProspectInfo>\n\t\t' \
                '<VehicleInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<VIN>1431o4321840148vin</VIN>\n\t\t\t\t' \
                    '<ModelYear>2004</ModelYear>\n\t\t\t\t' \
                    '<ModelName>Cherokee</ModelName>\n\t\t\t\t' \
                    '<Color>Silver</Color>\n\t\t\t\t' \
                    '<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<VIN></VIN>\n\t\t\t\t' \
                    '<ModelYear>1998</ModelYear>\n\t\t\t\t' \
                    '<ModelName>Taurus</ModelName>\n\t\t\t\t' \
                    '<Color>Red</Color>\n\t\t\t\t' \
                    '<SalesPerson></SalesPerson>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</VehicleInfo>\n\t\t' \
                '<FinanceInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DealNumber></DealNumber>\n\t\t\t\t' \
                    '<ModelYear>1998</ModelYear>\n\t\t\t\t' \
                    '<ModelName>Taurus</ModelName>\n\t\t\t\t' \
                    '<VehicleType>New</VehicleType>\n\t\t\t\t' \
                    '<Type>Lease</Type>\n\t\t\t\t' \
                    '<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t' \
                    '<SoldDate></SoldDate>\n\t\t\t\t' \
                    '<Status></Status>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</FinanceInfo>\n\t\t' \
                '<SpoInfo>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<OrderNumber>12345</OrderNumber>\n\t\t\t\t' \
                    '<DateAdded>1341756302</DateAdded>\n\t\t\t\t' \
                    '<Status>Ordered</Status>\n\t\t\t\t' \
                    '<MultiKey>Multikey</MultiKey>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DateAdded></DateAdded>\n\t\t\t\t' \
                    '<Status></Status>\n\t\t\t\t' \
                    '<MultiKey></MultiKey>\n\t\t\t' \
                  '</entry>\n\t\t\t' \
                  '<entry>\n\t\t\t\t' \
                    '<DateAdded>1341714131</DateAdded>\n\t\t\t\t' \
                    '<Status></Status>\n\t\t\t\t' \
                    '<MultiKey></MultiKey>\n\t\t\t' \
                  '</entry>\n\t\t' \
                '</SpoInfo>\n\t' \
              '</CustInfo>\n' \
            '</response>'

    if era_version == True:
        custinfo_response_multiple_xml = '<?xml version="1.0" encoding="UTF-8"?>\n<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t<CustInfo>\n\t\t<CallerID>Michael Bluth</CallerID>\n\t\t<IndOrCompany>I</IndOrCompany>\n\t\t<Address>123 Fake St.</Address>\n\t\t<City>L.A.</City>\n\t\t<State>California</State>\n\t\t<Zip>12412</Zip>' \
        '\n\t\t<ServiceInfo>\n\t\t\t<entry>\n\t\t\t\t<type>R</type>\n\t\t\t\t<date>1341756302</date>\n\t\t\t\t<record>912311x</record>\n\t\t\t\t<status>Ongoing</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>R</type>\n\t\t\t\t<date>1341716302</date>\n\t\t\t\t<record>833125x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>A</type>\n\t\t\t\t<date>1321656302</date>\n\t\t\t\t<record>831312x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>\n\t\t</ServiceInfo>\n\t\t<ProspectInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<NextActivity>Call Back</NextActivity>\n\t\t\t\t<Prospect>Joe Buyer</Prospect>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<NextActivity>Walk in</NextActivity>\n\t\t\t</entry>\n\t\t</ProspectInfo>\n\t\t<VehicleInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>1431o4321840148vin</VIN>\n\t\t\t\t<ModelYear>2004</ModelYear>\n\t\t\t\t<ModelName>Cherokee</ModelName>\n\t\t\t\t<Color>Silver</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>612371afaf31321vin</VIN>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<Color>Red</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>\n\t\t</VehicleInfo>\n\t\t<FinanceInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<DealNumber>9876</DealNumber>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<SoldDate>1341756302</SoldDate>\n\t\t\t\t<Status>Approved</Status>\n\t\t\t</entry>\n\t\t</FinanceInfo>\n\t\t<SpoInfo>' \
    '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1271811</OrderNumber>\n\t\t\t\t<DateAdded>1341756302</DateAdded>\n\t\t\t\t<Status>Installed</Status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1231718</OrderNumber>\n\t\t\t\t<DateAdded>1340756102</DateAdded>\n\t\t\t\t<Status>Received</Status>\n\t\t\t</entry>\n\t\t</SpoInfo>\n\t</CustInfo>' \
        '\n\t<CustInfo>\n\t\t<CallerID>Barry Zuckercorn</CallerID>\n\t\t<IndOrCompany>C</IndOrCompany>\n\t\t<Address>123 Fake St.</Address>\n\t\t<City>L.A.</City>\n\t\t<State>California</State>\n\t\t<Zip>12412</Zip>' \
        '\n\t\t<ServiceInfo>\n\t\t\t<entry>\n\t\t\t\t<type>Repair Order</type>\n\t\t\t\t<date>1341756302</date>\n\t\t\t\t<record>912311x</record>\n\t\t\t\t<status>Ongoing</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>Repair Order</type>\n\t\t\t\t<date>1341716302</date>\n\t\t\t\t<record>833125x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>appointment</type>\n\t\t\t\t<date>1321656302</date>\n\t\t\t\t<record>831312x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>\n\t\t</ServiceInfo>\n\t\t<ProspectInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<NextActivity>Call Back</NextActivity>\n\t\t\t\t<Prospect>Joe Buyer</Prospect>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<NextActivity>Walk in</NextActivity>\n\t\t\t</entry>\n\t\t</ProspectInfo>\n\t\t<VehicleInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>1431o4321840148vin</VIN>\n\t\t\t\t<ModelYear>2004</ModelYear>\n\t\t\t\t<ModelName>Cherokee</ModelName>\n\t\t\t\t<Color>Silver</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>612371afaf31321vin</VIN>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<Color>Red</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>\n\t\t</VehicleInfo>\n\t\t<FinanceInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<DealNumber>9876</DealNumber>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<SoldDate>1341756302</SoldDate>\n\t\t\t\t<Status>Approved</Status>\n\t\t\t</entry>\n\t\t</FinanceInfo>\n\t\t<SpoInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1271811</OrderNumber>\n\t\t\t\t<DateAdded>1341756302</DateAdded>\n\t\t\t\t<Status>Installed</Status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1231718</OrderNumber>\n\t\t\t\t<DateAdded>1340756102</DateAdded>\n\t\t\t\t<Status>Received</Status>\n\t\t\t</entry>\n\t\t</SpoInfo>\n\t</CustInfo>\n</response>'
    else:
        custinfo_response_multiple_xml = '<?xml version="1.0" encoding="UTF-8"?>\n<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t<CustInfo>\n\t\t<CallerID>Michael Bluth</CallerID>\n\t\t<IndOrCompany>I</IndOrCompany>\n\t\t<Address>123 Fake St.</Address>\n\t\t<City>L.A.</City>\n\t\t<State>California</State>\n\t\t<Zip>12412</Zip>' \
        '\n\t\t<ServiceInfo>\n\t\t\t<entry>\n\t\t\t\t<type>R</type>\n\t\t\t\t<date>1341756302</date>\n\t\t\t\t<record>912311x</record>\n\t\t\t\t<status>Ongoing</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>R</type>\n\t\t\t\t<date>1341716302</date>\n\t\t\t\t<record>833125x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>A</type>\n\t\t\t\t<date>1321656302</date>\n\t\t\t\t<record>831312x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>\n\t\t</ServiceInfo>\n\t\t<ProspectInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<NextActivity>Call Back</NextActivity>\n\t\t\t\t<Prospect>Joe Buyer</Prospect>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<CrmRep>John Crmrep</CrmRep>\n\t\t\t\t<SalesStep>Sales Step</SalesStep>\n\t\t\t</entry>\n\t\t</ProspectInfo>\n\t\t<VehicleInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>1431o4321840148vin</VIN>\n\t\t\t\t<ModelYear>2004</ModelYear>\n\t\t\t\t<ModelName>Cherokee</ModelName>\n\t\t\t\t<Color>Silver</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>612371afaf31321vin</VIN>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<Color>Red</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>\n\t\t</VehicleInfo>\n\t\t<FinanceInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<DealNumber>9876</DealNumber>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<SoldDate>1341756302</SoldDate>\n\t\t\t\t<Status>Approved</Status>\n\t\t\t</entry>\n\t\t</FinanceInfo>\n\t\t<SpoInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1271811</OrderNumber>\n\t\t\t\t<DateAdded>1341756302</DateAdded>\n\t\t\t\t<Status>Installed</Status>\n\t\t\t\t<MultiKey>Multikey</MultiKey>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1231718</OrderNumber>\n\t\t\t\t<DateAdded>1340756102</DateAdded>\n\t\t\t\t<Status>Received</Status>\n\t\t\t\t<MultiKey>Multikey</MultiKey>\n\t\t\t</entry>\n\t\t</SpoInfo>\n\t</CustInfo>' \
        '\n\t<CustInfo>\n\t\t<CallerID>Barry Zuckercorn</CallerID>\n\t\t<IndOrCompany>C</IndOrCompany>\n\t\t<Address>123 Fake St.</Address>\n\t\t<City>L.A.</City>\n\t\t<State>California</State>\n\t\t<Zip>12412</Zip>' \
        '\n\t\t<ServiceInfo>\n\t\t\t<entry>\n\t\t\t\t<type>Repair Order</type>\n\t\t\t\t<date>1341756302</date>\n\t\t\t\t<record>912311x</record>\n\t\t\t\t<status>Ongoing</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>Repair Order</type>\n\t\t\t\t<date>1341716302</date>\n\t\t\t\t<record>833125x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<type>appointment</type>\n\t\t\t\t<date>1321656302</date>\n\t\t\t\t<record>831312x</record>\n\t\t\t\t<status>Complete</status>\n\t\t\t</entry>\n\t\t</ServiceInfo>\n\t\t<ProspectInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<NextActivity>Call Back</NextActivity>\n\t\t\t\t<Prospect>Joe Buyer</Prospect>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<CrmRep>John Crmrep</CrmRep>\n\t\t\t\t<SalesStep>Sales Step</SalesStep>\n\t\t\t</entry>\n\t\t</ProspectInfo>\n\t\t<VehicleInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>1431o4321840148vin</VIN>\n\t\t\t\t<ModelYear>2004</ModelYear>\n\t\t\t\t<ModelName>Cherokee</ModelName>\n\t\t\t\t<Color>Silver</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<VIN>612371afaf31321vin</VIN>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<Color>Red</Color>\n\t\t\t\t<SalesPerson>Bill AdvisorName</SalesPerson>\n\t\t\t</entry>\n\t\t</VehicleInfo>\n\t\t<FinanceInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<DealNumber>9876</DealNumber>\n\t\t\t\t<ModelYear>1998</ModelYear>\n\t\t\t\t<ModelName>Taurus</ModelName>\n\t\t\t\t<SalesPerson>Joe Salesperson</SalesPerson>\n\t\t\t\t<SoldDate>1341756302</SoldDate>\n\t\t\t\t<Status>Approved</Status>\n\t\t\t</entry>\n\t\t</FinanceInfo>\n\t\t<SpoInfo>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1271811</OrderNumber>\n\t\t\t\t<DateAdded>1341756302</DateAdded>\n\t\t\t\t<Status>Installed</Status>\n\t\t\t\t<MultiKey>Multikey</MultiKey>\n\t\t\t</entry>' \
        '\n\t\t\t<entry>\n\t\t\t\t<OrderNumber>1231718</OrderNumber>\n\t\t\t\t<DateAdded>1340756102</DateAdded>\n\t\t\t\t<Status>Received</Status>\n\t\t\t\t<MultiKey>Multikey</MultiKey>\n\t\t\t</entry>\n\t\t</SpoInfo>\n\t</CustInfo>\n</response>'

    contacts_response_xml = '<?xml version="1.0" encoding="UTF-8"?>\n<response>\n\t<id>x</id>\n\t<errorcode>%s</errorcode>\n\t<errordesc>Success</errordesc>\n\t<Phonebook>' \
    '\n\t\t<entry>\n\t\t\t<name>Bob Loblaw</name>\n\t\t\t<number>7100</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    '\n\t\t<entry>\n\t\t\t<name>Maebe Funke</name>\n\t\t\t<number>7371812828</number>\n\t\t\t<alternate>3338888</alternate>\n\t\t</entry>' \
    '\n\t\t<entry>\n\t\t\t<name>Tony Wonder</name>\n\t\t\t<number>8301321</number>\n\t\t\t<alternate>18003332232</alternate>\n\t\t</entry>\n\t</Phonebook>\n</response>\n'

    #'\n\t\t<entry>\n\t\t\t<name>George Michael Bluth</name>\n\t\t\t<number>9031238383</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' 
    #'\n\t\t<entry>\n\t\t\t<name>Gob Bluth</name>\n\t\t\t<number>34821</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>El Hermano</name>\n\t\t\t<number>2131841</number>\n\t\t\t<alternate>3338888</alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>STEVE HOLT</name>\n\t\t\t<number>13021310193</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>Michael Bluth</name>\n\t\t\t<number>8410821</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>Buster Bluth</name>\n\t\t\t<number>10293</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>Tobias Funke</name>\n\t\t\t<number>12313217212</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>Lindsey Funke</name>\n\t\t\t<number>8013211</number>\n\t\t\t<alternate>18003332232</alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>George Bluth</name>\n\t\t\t<number>17001238484</number>\n\t\t\t<alternate></alternate>\n\t\t</entry>' \
    #'\n\t\t<entry>\n\t\t\t<name>Tony Wonder</name>\n\t\t\t<number>8301321</number>\n\t\t\t<alternate>18003332232</alternate>\n\t\t</entry>\n\t</Phonebook>\n</response>\n'

def is_numeric(strnum):
    try:
        float(strnum)
        return True
    except:
        return False

def input_handler():
    global errorcode, response_delay, single_response_custinfo, custinfo_responses, era_version, token_reset, interactive, mutex
    while 1:
        split_data = raw_input().split()
        if len(split_data) == 0: continue

        if split_data[0] == 'c':
            print '\n' * 80

        elif split_data[0] == 't':
            if len(split_data) > 1 and is_numeric(split_data[1]):
                response_delay = float(split_data[1])
            print 'timeout set to', response_delay, '\n'

        elif split_data[0] == 'ec':
            if len(split_data) > 1 and split_data[1].isdigit():
                errorcode = split_data[1]
            print 'errorcode of next request set to', errorcode, '\n'

        elif split_data[0] == 'z':
            custinfo_responses = 0
            print 'custinfo returning no customers now\n'

        elif split_data[0] == 's':
            custinfo_responses = 1
            print 'custinfo returning a single customer now\n'

        elif split_data[0] == 'm':
            custinfo_responses = 2
            print 'custinfo returning multiple customers now\n'

        elif split_data[0] == 'e':
            era_version = True
            set_xml()
            print 'era version selected\n'

        elif split_data[0] == 'p':
            era_version = False
            set_xml()
            print 'power version selected\n'

        elif split_data[0] == 'k':
            if not token_reset:
                errorcode = 19
                print 'resetting token'
            else:
                errorcode = 0
                print 'setting token'

            token_reset = not token_reset

        elif split_data[0] == 'i':
            if interactive:
                interactive = False
                print 'interactive mode off'
            else:
                interactive = True
                print 'interactive mode on'

        elif split_data[0] == 'go':
            mutex = 1

        elif split_data[0] == 'h':
            custinfo_responses = 2
            print """\ninput codes\n""" \
                  """----------------------------------------------------\n""" \
                  """c                   clear screen\n""" \
                  """ec <number>         set errocode to <number>\n""" \
                  """                 0 - success (all)\n""" \
                  """                19 - token expired (non-login)\n""" \
                  """i (toggle)          interactive mode\n""" \
                  """t <number>          set timeout to <number>\n""" \
                  """----------------------------------------------------\n""" \
                  """e                   era version\n""" \
                  """p                   power version\n""" \
                  """----------------------------------------------------\n""" \
                  """z                   no customers from CustInfo\n""" \
                  """s                   one customer from CustInfo\n""" \
                  """m                   multiple customers from CustInfo\n""" \
                  """----------------------------------------------------\n""" \
                  """k (toggle)          set errorcode to 19 (invalid token) and\n""" \
                  """                    return HTML statuscode 500\n""" \
                  """----------------------------------------------------\n"""

def send_response(msg, conn, isGetToken=False):
    global mutex

    if isGetToken:
        if token_reset:
            to_send = 'HTTP/1.1 401 Server Error\nContent-Type:text/plain\n\nbad token derp'
        else:
            to_send = 'HTTP/1.1 200 OK\nContent-Type:text/plain\nwebsession-token:hi there\n\nY\n'
            #to_send = 'HTTP/1.1 200 OK\nContent-Type:text/plain\n\n' \
                        #'<?xml version="1.0" encoding="UTF-8"?>\n' \
                        #'<response>\n\t' \
                          #'<id>%s</id>\n\t' \
                          #'<errorcode>1</errorcode>\n\t' \
                          #'<errordesc>Invalid Login</errordesc>\n' \
                        #'</response>\n'
    else:
        to_send = 'HTTP/1.1 200 OK\nContent-Type:text/plain\n\n%s' % msg
    #to_send = 'HTTP/1.1 503 Service Unavailable\nContent-Type:text/plain\nwebsession-error:invalid request received.\n\nblah blah'

    if interactive:
        print '\nEnter \'go\' to send the response...\n'
        while not poll_for_go():
            pass
        mutex = 0

    conn.send(to_send)
    print '\n_______________________________________\nsent to', conn.getpeername(), '\n', to_send
    conn.close()

def parse_xml(data, conn):
    tree = ET.fromstring("<?xml" + data.split("<?xml")[1])
    time.sleep(response_delay)

    if tree.tag != 'request':
        print 'invalid xml request'
        return

    # find name of request (the command to execute)
    command = ''
    for item in tree.items():
        if ('name' == item[0]):
            command = item[1]
    if not command:
        print 'failed to parse command name'
        return

    if command == 'GetSettings':
        twinning = random.choice(['Y', 'N'])
        forwarding = random.choice(['Y', 'N'])
        send_response(settings_response_xml % (errorcode, twinning, forwarding), conn)

    elif command == 'GetToken':
        send_response('', conn, True)

    elif command == 'GetPlatform':
        send_response(platform_response_xml % (errorcode, era_version and 'ERA' or 'PWR'), conn)

    elif command == 'ModifySettings':
        send_response(switch_response_xml % errorcode, conn)

    elif command == 'MakeCall':
        send_response(call_response_xml % errorcode, conn)

    elif command == 'Phonebook':
        send_response(contacts_response_xml % errorcode, conn)

    elif command == 'GetActiveCalls':
        send_response(active_response_xml % (errorcode, time.time() - 203), conn)

    elif command == 'CallHistoryList':
        send_response(history_response_xml % errorcode, conn)

    elif command == 'FollowUp':
        send_response(followup_response_xml % errorcode, conn)

    elif command == 'GetVoicemailURL':
        send_response(voicemail_url_xml % errorcode, conn)

    elif command == 'GetVoicemailAudio':
        send_response(voicemail_audio, conn)

    elif command == 'MarkVoicemail':
        send_response(mark_response_xml % errorcode, conn)

    elif command == 'VoicemailList':
        send_response(voicemail_response_xml % errorcode, conn)

    elif command == 'CustInfo':
        if custinfo_responses == 0:
            send_response(custinfo_response_zero_xml % errorcode, conn)
        elif custinfo_responses == 1:
            send_response(custinfo_response_xml % errorcode, conn)
        elif custinfo_responses == 2:
            send_response(custinfo_response_multiple_xml % errorcode, conn)

    elif command == 'TransferReq':
        send_response(transfer_response_xml % errorcode, conn)

##################################################################
if __name__ == '__main__':
    set_xml()
    thread.start_new_thread(input_handler, ())

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    print "...connecting on %s:%i" % listenaddress
    print "...type 'h' for commands\n"
    s.bind(listenaddress)
    s.listen(5)

    while True:
        client, address = s.accept()
        print "\n____________________________________\nrecv from", address
        data = ''
        while 1:
            tmp = client.recv(1024)
            if tmp != '':
                data += tmp
                break
            data += tmp
        print data,
        parse_xml(data, client)
