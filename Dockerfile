FROM alpine:3.10
LABEL maintainer="mg@consol.de"
LABEL version="0.1"

RUN apk --no-cache add net-snmp net-snmp-tools net-snmp-perl snmptt bash tcpdump vim
RUN echo -e 'authCommunity log,execute,net public\n \
	     snmpTrapdAddr 0.0.0.0\n \
             traphandle IF-MIB::linkDown /usr/bin/snmptt --ini=/snmp/config/snmptt.ini\n \
	     traphandle default /snmp/scripts/dosomething.sh /snmp/log/something.log' > /etc/snmp/snmptrapd.conf
RUN echo -e 'agentAddress 0.0.0.0' > /etc/snmp/snmpd.conf

EXPOSE 162
EXPOSE 161
CMD ["snmptrapd","-O","n","-L","f","/snmp/log/snmptrapd.log","-f","-M","/mibs","-m","ALL"]
#CMD ["snmptrapd","-L","f","/snmp/log/snmptrapd.log","-f","-M","/mibs","-m","ALL"]
