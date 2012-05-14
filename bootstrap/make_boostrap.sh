#!/bin/sh

#
# Bootstrap parameters
#

# Bootstrap script
OUTPUT=bootstrap.sh

# Install script run when the bootstrap script is executed
INSTALL_SCRIPT=bootstrap.sh.in

# Files to be included in the bootstrap script
EMBEDDED_DIR=files

if [ ! -d $EMBEDDED_DIR ]
then
	echo "Can't embed '$EMBEDDED_DIR'."
	exit 1
fi


#
# Bootstrap script creation
#

# Install script
cat $INSTALL_SCRIPT > $OUTPUT
chmod a+x $OUTPUT

# Payload data to embed
echo 'DATA:' >> $OUTPUT
tar cf - $EMBEDDED_DIR >> $OUTPUT
