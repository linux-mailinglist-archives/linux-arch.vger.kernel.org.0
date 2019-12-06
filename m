Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5EB311551C
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:24:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbfLFQYn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:24:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41972 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726321AbfLFQYi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9CBAEAD75;
        Fri,  6 Dec 2019 16:24:35 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        trenn@suse.de, fschnitzlein@suse.de,
        Felix Schnizlein <fschnizlein@suse.com>
Subject: [PATCH 1/3] cpuinfo: add sysfs based arch independent cpuinfo framework
Date:   Fri,  6 Dec 2019 17:24:19 +0100
Message-Id: <20191206162421.15050-2-trenn@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191206162421.15050-1-trenn@suse.de>
References: <20191206162421.15050-1-trenn@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Felix Schnizlein <fschnizlein@suse.de>

Create a new sysfs attribute group called 'info' for each
online cpu. The cleaned up cpuinfo shows up in a sysfs
subdirectory here: /sys/devices/system/cpu/cpu#/info.

Define preprocessor macros (CPUINFO_DEFINE_* and CPUINFO_ATTR) to make
defining new sysfs attributes for cpuinfo more easy.

Add basic documentation for the info sysfs tree.

Signed-off-by: Felix Schnizlein <fschnizlein@suse.com>
Signed-off-by: Thomas Renninger <trenn@suse.de>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu |  7 ++++
 arch/Kconfig                                       | 11 +++++
 drivers/base/Makefile                              |  1 +
 drivers/base/cpuinfo.c                             | 48 ++++++++++++++++++++++
 include/linux/cpuhotplug.h                         |  1 +
 include/linux/cpuinfo.h                            | 43 +++++++++++++++++++
 6 files changed, 111 insertions(+)
 create mode 100644 drivers/base/cpuinfo.c
 create mode 100644 include/linux/cpuinfo.h

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index fc20cde63d1e..84c324773b36 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -574,3 +574,10 @@ Description:	Secure Virtual Machine
 		If 1, it means the system is using the Protected Execution
 		Facility in POWER9 and newer processors. i.e., it is a Secure
 		Virtual Machine.
+
+What:		/sys/devices/system/cpu/cpu#/info/
+Date:		June 2019
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Various information about the online cpu. Which attributes are
+		available depends on the architecture, kernel configuration and
+		cpu model.
diff --git a/arch/Kconfig b/arch/Kconfig
index 48b5e103bdb0..39015570b1ca 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -882,6 +882,17 @@ config STRICT_MODULE_RWX
 	  and non-text memory will be made non-executable. This provides
 	  protection against certain security exploits (e.g. writing to text)
 
+config CPUINFO_SYSFS
+	bool "Provides processor information in sysfs. Successor of /proc/cpuinfo"
+	def_bool y
+	depends on HAVE_CPUINFO_SYSFS
+	help
+	  Provides architecture specific processor information in /sys/devices/system/cpu/info
+	  Use this instead of /proc/cpuinfo
+
+config HAVE_CPUINFO_SYSFS
+	bool
+
 # select if the architecture provides an asm/dma-direct.h header
 config ARCH_HAS_PHYS_TO_DMA
 	bool
diff --git a/drivers/base/Makefile b/drivers/base/Makefile
index 4db2e8f1a1f4..68701f94774c 100644
--- a/drivers/base/Makefile
+++ b/drivers/base/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_PINCTRL) += pinctrl.o
 obj-$(CONFIG_DEV_COREDUMP) += devcoredump.o
 obj-$(CONFIG_GENERIC_MSI_IRQ_DOMAIN) += platform-msi.o
 obj-$(CONFIG_GENERIC_ARCH_TOPOLOGY) += arch_topology.o
+obj-$(CONFIG_CPUINFO_SYSFS) += cpuinfo.o
 
 obj-y			+= test/
 
diff --git a/drivers/base/cpuinfo.c b/drivers/base/cpuinfo.c
new file mode 100644
index 000000000000..09b554d09bfa
--- /dev/null
+++ b/drivers/base/cpuinfo.c
@@ -0,0 +1,48 @@
+/*
+ * Copyright (C) 2017 SUSE Linux GmbH
+ * Written by: Felix Schnizlein <fschnizlein@suse.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ */
+
+#include <linux/cpu.h>
+#include <linux/module.h>
+#include <linux/cpuinfo.h>
+
+static struct attribute_group cpuinfo_attr_group = {
+	.attrs = cpuinfo_attrs,
+	.name = "info"
+};
+
+static int cpuinfo_add_dev(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	return sysfs_create_group(&dev->kobj, &cpuinfo_attr_group);
+}
+
+static int cpuinfo_remove_dev(unsigned int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	sysfs_remove_group(&dev->kobj, &cpuinfo_attr_group);
+	return 0;
+}
+
+static int cpuinfo_sysfs_init(void)
+{
+	return cpuhp_setup_state(CPUHP_CPUINFO_PREPARE,
+				 "base/cpuinfo:prepare",
+				 cpuinfo_add_dev,
+				 cpuinfo_remove_dev);
+}
+
+device_initcall(cpuinfo_sysfs_init);
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index e51ee772b9f5..2c4c59304bdb 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -78,6 +78,7 @@ enum cpuhp_state {
 	CPUHP_SH_SH3X_PREPARE,
 	CPUHP_NET_FLOW_PREPARE,
 	CPUHP_TOPOLOGY_PREPARE,
+	CPUHP_CPUINFO_PREPARE,
 	CPUHP_NET_IUCV_PREPARE,
 	CPUHP_ARM_BL_PREPARE,
 	CPUHP_TRACE_RB_PREPARE,
diff --git a/include/linux/cpuinfo.h b/include/linux/cpuinfo.h
new file mode 100644
index 000000000000..112ff76d64d5
--- /dev/null
+++ b/include/linux/cpuinfo.h
@@ -0,0 +1,43 @@
+/*
+ * Copyright (C) 2017 SUSE Linux GmbH
+ * Written by: Felix Schnizlein <fschnizlein@suse.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version
+ * 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ */
+#ifndef _LINUX_CPUINFO_H
+#define _LINUX_CPUINFO_H
+
+#ifdef CONFIG_HAVE_CPUINFO_SYSFS
+extern struct attribute *cpuinfo_attrs[];
+
+#define CPUINFO_DEFINE_ATTR(name, format)				\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr,		\
+			   char *buf)					\
+{									\
+	return sprintf(buf, format"\n", cpuinfo_##name(dev->id));	\
+}									\
+static DEVICE_ATTR_RO(name)
+
+
+#define CPUINFO_DEFINE_ATTR_FUNC(name)					\
+static ssize_t name##_show(struct device *dev,				\
+			   struct device_attribute *attr,		\
+			   char *buf)					\
+{									\
+	return cpuinfo_##name(dev->id, buf);				\
+}									\
+static DEVICE_ATTR_RO(name)
+
+
+#define CPUINFO_ATTR(name)			(&dev_attr_##name.attr)
+#endif /* CONFIG_HAVE_CPUINFO_SYSFS */
+
+#endif /* _LINUX_CPUINFO_H */
-- 
2.16.4

