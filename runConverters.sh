JAVA_HOME=$1
jvmOpts=$2
converterType=$3
warmupTime=$4
measurementTime=$5
codepages=$6

#Usage example:
# ./run.sh /home/jdk17 -XX:+CompactStrings ByteToString 60 240 UTF-8

# run/check on zos
#oeconsol "T OPT=M2"
#oeconsol "D M=CPU"

echo $jvmOpts
echo $jvmOpts $converterType $codepages

jarFile=convperf-new.jar

for i in {1..3}
do
	$JAVA_HOME/bin/java -Xshareclasses:destroyAll
	$JAVA_HOME/bin/java $jvmOpts -Xmx512m -Xms512m -Dtestdata=ascii -Xcompressedrefs -cp $jarFile com.ibm.tests.$converterType 4096 $warmupTime $measurementTime $codepages
done
