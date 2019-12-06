Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC02011551E
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfLFQYn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:24:43 -0500
Received: from mx2.suse.de ([195.135.220.15]:41976 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726336AbfLFQYi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:38 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A57EBB1AA;
        Fri,  6 Dec 2019 16:24:35 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        trenn@suse.de, fschnitzlein@suse.de,
        Felix Schnizlein <fschnizlein@suse.com>,
        Thomas Renninger <trenn@suse.com>
Subject: [PATCH 2/3] x86 cpuinfo: implement sysfs nodes for x86
Date:   Fri,  6 Dec 2019 17:24:20 +0100
Message-Id: <20191206162421.15050-3-trenn@suse.de>
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

Enable sysfs cpuinfo for x86 based cpus.
Export often used cpu information to sysfs:
stepping, flags, bugs, bogomips, family, vendor_id,
model, and model_name are exported.

Sysfs documentation is updated to reflect changes.

Example (on a kvm instance running no an intel cpu):
/sys/devices/system/cpu/cpu1/info/:[0]# head *
==> bogomips <==
5187.72

==> bugs <==
cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds swapgs itlb_multihit

==> cpu_family <==
6

==> flags <==
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm cpuid_fault invpcid_single pti ssbd ibrs ibpb fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid xsaveopt arat umip

==> model <==
60

==> model_name <==
Intel Core Processor (Haswell, no TSX, IBRS)

==> stepping <==
1

==> vendor_id <==
GenuineIntel

Signed-off-by: Felix Schnizlein <fschnizlein@suse.com>
Signed-off-by: Thomas Renninger <trenn@suse.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 23 +++++
 arch/x86/Kconfig                                   |  1 +
 arch/x86/kernel/Makefile                           |  2 +
 arch/x86/kernel/cpuinfo.c                          | 99 ++++++++++++++++++++++
 4 files changed, 125 insertions(+)
 create mode 100644 arch/x86/kernel/cpuinfo.c

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 84c324773b36..791390ab66d5 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -581,3 +581,26 @@ Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 Description:	Various information about the online cpu. Which attributes are
 		available depends on the architecture, kernel configuration and
 		cpu model.
+
+What:		/sys/devices/system/cpu/cpu#/info/
+		/sys/devices/system/cpu/cpu#/info/vendor_id
+		/sys/devices/system/cpu/cpu#/info/cpu_family
+		/sys/devices/system/cpu/cpu#/info/model
+		/sys/devices/system/cpu/cpu#/info/model_name
+		/sys/devices/system/cpu/cpu#/info/stepping
+		/sys/devices/system/cpu/cpu#/info/flags
+		/sys/devices/system/cpu/cpu#/info/bugs
+		/sys/devices/system/cpu/cpu#/info/bogomips
+Date:		June 2017
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Expose information about x86 cpu information.
+
+		vendor_id,
+		cpu_family,
+		model,
+		model_name,
+		stepping: Cpu identification depending on each vendor
+
+		flags: Extended capabilities supported by the cpu
+		bugs: Known bugs by cpu
+		bogomips: calculated bogomips
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 8529a9dbd5ca..29fadd69d541 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -154,6 +154,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING		if X86_64
 	select HAVE_COPY_THREAD_TLS
+	select HAVE_CPUINFO_SYSFS		if SYSFS
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index ccb13271895d..ccf1a338bc37 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -146,6 +146,8 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
+obj-$(CONFIG_CPUINFO_SYSFS)		+= cpuinfo.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/cpuinfo.c b/arch/x86/kernel/cpuinfo.c
new file mode 100644
index 000000000000..3b772faf9f5f
--- /dev/null
+++ b/arch/x86/kernel/cpuinfo.c
@@ -0,0 +1,99 @@
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
+#include <linux/cpuinfo.h>
+#include <linux/cpufreq.h>
+#include <linux/smp.h>
+
+static ssize_t cpuinfo_stepping(unsigned int c, char *buf)
+{
+	if (cpu_data(c).x86_stepping || cpu_data(c).cpuid_level >= 0)
+		return sprintf(buf, "%d\n", cpu_data(c).x86_stepping);
+	return sprintf(buf, "unknown\n");
+}
+
+static ssize_t cpuinfo_flags(unsigned int c, char *buf)
+{
+	struct cpuinfo_x86 *cpu = &cpu_data(c);
+	unsigned int i;
+	ssize_t len = 0;
+
+	for (i = 0; i < (32 * NCAPINTS); i++) {
+		if (cpu_has(cpu, i) && x86_cap_flags[i] != NULL)
+			len += sprintf(buf+len, len == 0 ? "%s" : " %s",
+				       x86_cap_flags[i]);
+	}
+	if (!len)
+		return 0;
+	return len + sprintf(buf+len, "\n");
+}
+
+static ssize_t cpuinfo_bugs(unsigned int c, char *buf)
+{
+	struct cpuinfo_x86 *cpu = &cpu_data(c);
+	unsigned int i;
+	ssize_t len = 0;
+
+	for (i = 0; i < 32*NBUGINTS; i++) {
+		unsigned int bug_bit = 32*NCAPINTS + i;
+
+		if (cpu_has_bug(cpu, bug_bit) && x86_bug_flags[i])
+			len += sprintf(buf+len, len == 0 ? "%s" : " %s",
+				       x86_bug_flags[i]);
+	}
+	if (!len)
+		return 0;
+	return len + sprintf(buf+len, "\n");
+}
+
+static ssize_t cpuinfo_bogomips(unsigned int c, char *buf)
+{
+	struct cpuinfo_x86 cpu = cpu_data(c);
+
+	return sprintf(buf, "%lu.%02lu\n", cpu.loops_per_jiffy / (500000 / HZ),
+		       (cpu.loops_per_jiffy / (5000 / HZ)) % 100);
+}
+
+#define cpuinfo_cpu_family(cpu)		cpu_data(cpu).x86
+#define cpuinfo_model(cpu)		cpu_data(cpu).x86_model
+
+#define cpuinfo_vendor_id(cpu)		cpu_data(cpu).x86_vendor_id[0] ?\
+	cpu_data(cpu).x86_vendor_id : "unknown"
+
+#define cpuinfo_model_name(cpu)		cpu_data(cpu).x86_model_id[0] ? \
+	cpu_data(cpu).x86_model_id : "unknown"
+
+CPUINFO_DEFINE_ATTR(cpu_family, "%d");
+CPUINFO_DEFINE_ATTR(model, "%u");
+CPUINFO_DEFINE_ATTR(vendor_id, "%s");
+CPUINFO_DEFINE_ATTR(model_name, "%s");
+
+CPUINFO_DEFINE_ATTR_FUNC(stepping);
+CPUINFO_DEFINE_ATTR_FUNC(flags);
+CPUINFO_DEFINE_ATTR_FUNC(bugs);
+CPUINFO_DEFINE_ATTR_FUNC(bogomips);
+
+struct attribute *cpuinfo_attrs[] = {
+	CPUINFO_ATTR(vendor_id),
+	CPUINFO_ATTR(cpu_family),
+	CPUINFO_ATTR(model),
+	CPUINFO_ATTR(model_name),
+	CPUINFO_ATTR(stepping),
+	CPUINFO_ATTR(flags),
+	CPUINFO_ATTR(bugs),
+	CPUINFO_ATTR(bogomips),
+	NULL
+};
-- 
2.16.4

