@echo off

echo Motherboard's Information :
wmic baseboard get product,Manufacturer,version,serialnumber
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------


echo Bios Information :
wmic bios get manufacturer,name,version,serialnumber
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------


echo RAM information :
wmic path win32_physicalmemory get Manufacturer,Capacity,Speed,PartNumber
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------

echo CPU information :
wmic cpu get caption,deviceid,name,numberofcores,maxclockspeed
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------

echo Hard Drive information :
wmic diskdrive get model,interfacetype,size,partitions
echo ------------------------------------------------------------------------------
echo ------------------------------------------------------------------------------

pause