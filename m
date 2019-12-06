Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26EA2115517
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2019 17:24:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbfLFQYh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Dec 2019 11:24:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:41968 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbfLFQYh (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Dec 2019 11:24:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A9EB4B1D2;
        Fri,  6 Dec 2019 16:24:35 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.de>
To:     linux-kernel@vger.kernel.org
Cc:     gregkh@linuxfoundation.org, Felix Schnizlein <fschnizlein@suse.de>,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux@armlinux.org.uk, will.deacon@arm.com, x86@kernel.org,
        trenn@suse.de, fschnitzlein@suse.de,
        Felix Schnizlein <fschnizlein@suse.com>
Subject: [PATCH 3/3] arm64 cpuinfo: implement sysfs nodes for arm64
Date:   Fri,  6 Dec 2019 17:24:21 +0100
Message-Id: <20191206162421.15050-4-trenn@suse.de>
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

Export all information from /proc/cpuinfo to sysfs:
implementer, architecture, variant, part, revision,
bogomips and flags are exported.

Example:
/sys/devices/system/cpu/cpu1/info/:[0]# head *
==> architecture <==
8

==> bogomips <==
40.00

==> flags <==
fp asimd evtstrm aes pmull sha1 sha2 crc32 cpuid asimdrdm

==> implementer <==
0x51

==> part <==
0xc00

==> revision <==
1

==> variant <==
0x0

Signed-off-by: Thomas Renninger <trenn@suse.de>
Signed-off-by: Felix Schnizlein <fschnizlein@suse.com>
---
 Documentation/ABI/testing/sysfs-devices-system-cpu | 22 +++++++++
 arch/arm64/Kconfig                                 |  1 +
 arch/arm64/kernel/cpuinfo.c                        | 55 ++++++++++++++++++++++
 3 files changed, 78 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index 791390ab66d5..b6a167cd0beb 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -604,3 +604,25 @@ Description:	Expose information about x86 cpu information.
 		flags: Extended capabilities supported by the cpu
 		bugs: Known bugs by cpu
 		bogomips: calculated bogomips
+
+
+What:		/sys/devices/system/cpu/cpu#/info/
+		/sys/devices/system/cpu/cpu#/info/implementer
+		/sys/devices/system/cpu/cpu#/info/architecture
+		/sys/devices/system/cpu/cpu#/info/variant
+		/sys/devices/system/cpu/cpu#/info/part
+		/sys/devices/system/cpu/cpu#/info/revision
+		/sys/devices/system/cpu/cpu#/info/flags
+		/sys/devices/system/cpu/cpu#/info/bogomips
+Date:		August 2017
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:	Expose information about arm64 cpu.
+
+		implementer,
+		architecture,
+		variant,
+		part,
+		revision: Cpu identification depending on each vendor
+
+		flags: Extended capabilities supported by the cpu
+		bogomips: calculated bogomips
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 43aa1de727f4..0e8f7733e8c3 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -169,6 +169,7 @@ config ARM64
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
+	select HAVE_CPUINFO_SYSFS if SYSFS
 	select IOMMU_DMA if IOMMU_SUPPORT
 	select IRQ_DOMAIN
 	select IRQ_FORCED_THREADING
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 56bba746da1c..d142e2d37ead 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -24,6 +24,7 @@
 #include <linux/sched.h>
 #include <linux/smp.h>
 #include <linux/delay.h>
+#include <linux/cpuinfo.h>
 
 /*
  * In case the boot CPU is hotpluggable, we record its initial state and
@@ -33,6 +34,8 @@
 DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
 
+#define cpu_data(cpu)			per_cpu(cpu_data, cpu)
+
 static const char *icache_policy_str[] = {
 	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
 	[ICACHE_POLICY_VIPT]		= "VIPT",
@@ -285,6 +288,58 @@ static int cpuid_cpu_offline(unsigned int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_HAVE_CPUINFO_SYSFS
+
+#define cpuinfo_implementer(cpu)	MIDR_IMPLEMENTOR(cpu_data(cpu).reg_midr)
+#define cpuinfo_architecture(cpu)	"8"
+#define cpuinfo_variant(cpu)		MIDR_VARIANT(cpu_data(cpu).reg_midr)
+#define cpuinfo_part(cpu)		MIDR_PARTNUM(cpu_data(cpu).reg_midr)
+#define cpuinfo_revision(cpu)		MIDR_REVISION(cpu_data(cpu).reg_midr)
+
+static ssize_t cpuinfo_flags(unsigned int c, char *buf)
+{
+	unsigned int i;
+	ssize_t len = 0;
+
+	for (i = 0; hwcap_str[i]; i++) {
+		if (cpu_have_feature(i))
+			len += sprintf(buf+len, len == 0 ? "%s" : " %s",
+				       hwcap_str[i]);
+	}
+	if (!len)
+		return 0;
+	return len + sprintf(buf+len, "\n");
+}
+
+static ssize_t cpuinfo_bogomips(unsigned int c, char *buf)
+{
+	return sprintf(buf, "%lu.%02lu\n", loops_per_jiffy / (500000 / HZ),
+		       (loops_per_jiffy / (5000 / HZ)) % 100);
+
+}
+
+CPUINFO_DEFINE_ATTR(implementer, "0x%02x");
+CPUINFO_DEFINE_ATTR(architecture, "%s");
+CPUINFO_DEFINE_ATTR(variant, "0x%x");
+CPUINFO_DEFINE_ATTR(part, "0x%03x");
+CPUINFO_DEFINE_ATTR(revision, "%d");
+
+CPUINFO_DEFINE_ATTR_FUNC(bogomips);
+CPUINFO_DEFINE_ATTR_FUNC(flags);
+
+struct attribute *cpuinfo_attrs[] = {
+	CPUINFO_ATTR(implementer),
+	CPUINFO_ATTR(architecture),
+	CPUINFO_ATTR(variant),
+	CPUINFO_ATTR(part),
+	CPUINFO_ATTR(revision),
+	CPUINFO_ATTR(bogomips),
+	CPUINFO_ATTR(flags),
+	NULL
+};
+#endif /* CONFIG_HAVE_CPUINFO_SYSFS */
+
+
 static int __init cpuinfo_regs_init(void)
 {
 	int cpu, ret;
-- 
2.16.4

