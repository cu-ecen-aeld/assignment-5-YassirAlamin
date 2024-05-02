
##############################################################
#
# AESD-ASSIGNMENTS
#
##############################################################

#TODO: Fill up the contents below in order to reference your assignment 3 git contents
#AESD_ASSIGNMENTS_VERSION = '5e51d06684269fb2545540a5e543095cfdd67c49' #//assignment 4 buildroot//#
AESD_ASSIGNMENTS_VERSION = '66fa4a8e4e4d5b6196aa54f89bed9c053afded55'
# Note: Be sure to reference the *ssh* repository URL here (not https) to work properly
# with ssh keys and the automated build/test system.
# Your site should start with git@github.com:
AESD_ASSIGNMENTS_SITE = 'git@github.com:cu-ecen-aeld/assignments-3-and-later-YassirAlamin.git'
AESD_ASSIGNMENTS_SITE_METHOD = git
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
	echo "cmd 1 done"
	$(MAKE) -C $(AESD_ASSIGNMENTS_SRCDIR)/server CROSS_COMPILER=$(TARGET_CROSS) aesdsocket
	echo "cmd 2 done"
endef

# TODO add your writer, finder and finder-test utilities/scripts to the installation steps below
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	$(INSTALL) -d 0755 $(@D)/conf/ $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin
	echo "Installation 1 done"

	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/writer.c $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/bin
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/bin
	echo "Installation 2 done"

	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
        $(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
	
	#$(INSTALL) -m 0755 $(AESD_ASSIGNMENTS_SRCDIR)/server/aesdsocket $(TARGET_DIR)/usr/bin/aesdsocket
	#$(INSTALL) -m 0755 $(AESD_ASSIGNMENTS_SRCDIR)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
	echo "Installation 3 done"
endef

$(eval $(generic-package))
