Return-Path: <linux-arch+bounces-1944-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA52F8445F4
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 18:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1700EB22E15
	for <lists+linux-arch@lfdr.de>; Wed, 31 Jan 2024 16:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE00B12DDAD;
	Wed, 31 Jan 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="1PtJggS5"
X-Original-To: linux-arch@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0679B12C55A;
	Wed, 31 Jan 2024 16:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706720179; cv=none; b=HrXEo5bYsIjtPK7XL65dlP9HALb1/rDNYDsLHZdZ3r3WzCkz1ixUh9USilrXmOOuiL3+bS4E8CIUn9cni9S7iS1+oFpmNewIlJS+ENxNDJk1IqH0rp9y1nQpSRx6+sZeNIszcpbt/0XFcscoHgCMtKa+VoEV8ddwDQSQ6ZFAbW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706720179; c=relaxed/simple;
	bh=EkVr8qkWgomRYpricd0zPmrR7pe29SgULm4sDGCbpQI=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=GYtmFH4T037kcBqQJyUbFO26bxgccvubj7lhMcNeOHErPtxzXLw3aEIl7fvddEz+1xtm2vE2x+KrJA0RpfYzLXma90qRmaes/It1QY6RkTopCks0gr2v4SGTfB7HRJZgDJRH43m7PUMW1iSpSg56wG5B98EAyCQq2YkjXBigM9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=1PtJggS5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=oPnhCwiKg9San/i05zV4ZOuN3WuOL1Uu7mhLCP64Beg=; b=1PtJggS59E8nf2Oup93oE/RTBA
	fNHpjJuukMuha+sNR7njHZomuyBzSzKwQnCbHdjp9pbY5a8v6hN+eVN4rIwfuIAAORdkLuKdkOAuD
	ERk+pMkhl5SuQqvlKstr/1XGTKUMDKLM+6zF2me6UftWm/dKNoXW0P1nQ+yyP9w7y8sC+t/d220Ow
	+mqd+JfKEKNPjEk8J8LdS+oDg82vrcUOxVTZio+4DFCv0LEEKeVRkv3Iv8e5bB6my+RMzPykq9RQa
	SMImavUzV2y1R1efsvLCJoTR3QoKzpsvUfcMD5AX/d+ApSjBnfVNQp9kDhCtwvrRtCdkbSkzQFW66
	r8Rw/qRA==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:38552 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1rVDnb-0003Wp-09;
	Wed, 31 Jan 2024 16:50:55 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1rVDnZ-0027Zl-Kr; Wed, 31 Jan 2024 16:50:53 +0000
In-Reply-To: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
References: <Zbp5xzmFhKDAgHws@shell.armlinux.org.uk>
From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
To: linux-pm@vger.kernel.org,
	 loongarch@lists.linux.dev,
	 linux-acpi@vger.kernel.org,
	 linux-arch@vger.kernel.org,
	 linux-kernel@vger.kernel.org,
	 linux-arm-kernel@lists.infradead.org,
	 linux-riscv@lists.infradead.org,
	 kvmarm@lists.linux.dev,
	 x86@kernel.org,
	 acpica-devel@lists.linuxfoundation.org,
	 linux-csky@vger.kernel.org,
	 linux-doc@vger.kernel.org,
	 linux-ia64@vger.kernel.org,
	 linux-parisc@vger.kernel.org
Cc: Salil Mehta <salil.mehta@huawei.com>,
	 Jean-Philippe Brucker <jean-philippe@linaro.org>,
	 jianyong.wu@arm.com,
	 justin.he@arm.com,
	 James Morse <james.morse@arm.com>,
	 Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
	 "Rafael J. Wysocki" <rafael@kernel.org>
Subject: [PATCH RFC v4 15/15] cpumask: Add enabled cpumask for present CPUs
 that can be brought online
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1rVDnZ-0027Zl-Kr@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 31 Jan 2024 16:50:53 +0000

From: James Morse <james.morse@arm.com>

The 'offline' file in sysfs shows all offline CPUs, including those
that aren't present. User-space is expected to remove not-present CPUs
from this list to learn which CPUs could be brought online.

CPUs can be present but not-enabled. These CPUs can't be brought online
until the firmware policy changes, which comes with an ACPI notification
that will register the CPUs.

With only the offline and present files, user-space is unable to
determine which CPUs it can try to bring online. Add a new CPU mask
that shows this based on all the registered CPUs.

Signed-off-by: James Morse <james.morse@arm.com>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Tested-by: Vishnu Pajjuri <vishnu@os.amperecomputing.com>
Tested-by: Jianyong Wu <jianyong.wu@arm.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
Changes since RFCv3 (smaller series);
 * Added Documentation/ABI/testing/sysfs-devices-system-cpu entry
---
 .../ABI/testing/sysfs-devices-system-cpu      |  6 +++++
 drivers/base/cpu.c                            | 10 ++++++++
 include/linux/cpumask.h                       | 25 +++++++++++++++++++
 kernel/cpu.c                                  |  3 +++
 4 files changed, 44 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-devices-system-cpu b/Documentation/ABI/testing/sysfs-devices-system-cpu
index a1db6db47505..59482c10e0ad 100644
--- a/Documentation/ABI/testing/sysfs-devices-system-cpu
+++ b/Documentation/ABI/testing/sysfs-devices-system-cpu
@@ -693,3 +693,9 @@ Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
 		(RO) indicates whether or not the kernel directly supports
 		modifying the crash elfcorehdr for CPU hot un/plug and/or
 		on/offline changes.
+
+What:		/sys/devices/system/cpu/enabled
+Date:		Nov 2022
+Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
+Description:
+		(RO) the list of CPUs that can be brought online.
diff --git a/drivers/base/cpu.c b/drivers/base/cpu.c
index 13d052bf13f4..a6e96a0a92b7 100644
--- a/drivers/base/cpu.c
+++ b/drivers/base/cpu.c
@@ -95,6 +95,7 @@ void unregister_cpu(struct cpu *cpu)
 {
 	int logical_cpu = cpu->dev.id;
 
+	set_cpu_enabled(logical_cpu, false);
 	unregister_cpu_under_node(logical_cpu, cpu_to_node(logical_cpu));
 
 	device_unregister(&cpu->dev);
@@ -273,6 +274,13 @@ static ssize_t print_cpus_offline(struct device *dev,
 }
 static DEVICE_ATTR(offline, 0444, print_cpus_offline, NULL);
 
+static ssize_t print_cpus_enabled(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%*pbl\n", cpumask_pr_args(cpu_enabled_mask));
+}
+static DEVICE_ATTR(enabled, 0444, print_cpus_enabled, NULL);
+
 static ssize_t print_cpus_isolated(struct device *dev,
 				  struct device_attribute *attr, char *buf)
 {
@@ -413,6 +421,7 @@ int register_cpu(struct cpu *cpu, int num)
 	register_cpu_under_node(num, cpu_to_node(num));
 	dev_pm_qos_expose_latency_limit(&cpu->dev,
 					PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
+	set_cpu_enabled(num, true);
 
 	return 0;
 }
@@ -494,6 +503,7 @@ static struct attribute *cpu_root_attrs[] = {
 	&cpu_attrs[2].attr.attr,
 	&dev_attr_kernel_max.attr,
 	&dev_attr_offline.attr,
+	&dev_attr_enabled.attr,
 	&dev_attr_isolated.attr,
 #ifdef CONFIG_NO_HZ_FULL
 	&dev_attr_nohz_full.attr,
diff --git a/include/linux/cpumask.h b/include/linux/cpumask.h
index cfb545841a2c..cc72a0887f04 100644
--- a/include/linux/cpumask.h
+++ b/include/linux/cpumask.h
@@ -92,6 +92,7 @@ static inline void set_nr_cpu_ids(unsigned int nr)
  *
  *     cpu_possible_mask- has bit 'cpu' set iff cpu is populatable
  *     cpu_present_mask - has bit 'cpu' set iff cpu is populated
+ *     cpu_enabled_mask  - has bit 'cpu' set iff cpu can be brought online
  *     cpu_online_mask  - has bit 'cpu' set iff cpu available to scheduler
  *     cpu_active_mask  - has bit 'cpu' set iff cpu available to migration
  *
@@ -124,11 +125,13 @@ static inline void set_nr_cpu_ids(unsigned int nr)
 
 extern struct cpumask __cpu_possible_mask;
 extern struct cpumask __cpu_online_mask;
+extern struct cpumask __cpu_enabled_mask;
 extern struct cpumask __cpu_present_mask;
 extern struct cpumask __cpu_active_mask;
 extern struct cpumask __cpu_dying_mask;
 #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
 #define cpu_online_mask   ((const struct cpumask *)&__cpu_online_mask)
+#define cpu_enabled_mask   ((const struct cpumask *)&__cpu_enabled_mask)
 #define cpu_present_mask  ((const struct cpumask *)&__cpu_present_mask)
 #define cpu_active_mask   ((const struct cpumask *)&__cpu_active_mask)
 #define cpu_dying_mask    ((const struct cpumask *)&__cpu_dying_mask)
@@ -993,6 +996,7 @@ extern const DECLARE_BITMAP(cpu_all_bits, NR_CPUS);
 #else
 #define for_each_possible_cpu(cpu) for_each_cpu((cpu), cpu_possible_mask)
 #define for_each_online_cpu(cpu)   for_each_cpu((cpu), cpu_online_mask)
+#define for_each_enabled_cpu(cpu)   for_each_cpu((cpu), cpu_enabled_mask)
 #define for_each_present_cpu(cpu)  for_each_cpu((cpu), cpu_present_mask)
 #endif
 
@@ -1015,6 +1019,15 @@ set_cpu_possible(unsigned int cpu, bool possible)
 		cpumask_clear_cpu(cpu, &__cpu_possible_mask);
 }
 
+static inline void
+set_cpu_enabled(unsigned int cpu, bool can_be_onlined)
+{
+	if (can_be_onlined)
+		cpumask_set_cpu(cpu, &__cpu_enabled_mask);
+	else
+		cpumask_clear_cpu(cpu, &__cpu_enabled_mask);
+}
+
 static inline void
 set_cpu_present(unsigned int cpu, bool present)
 {
@@ -1096,6 +1109,7 @@ static __always_inline unsigned int num_online_cpus(void)
 	return raw_atomic_read(&__num_online_cpus);
 }
 #define num_possible_cpus()	cpumask_weight(cpu_possible_mask)
+#define num_enabled_cpus()	cpumask_weight(cpu_enabled_mask)
 #define num_present_cpus()	cpumask_weight(cpu_present_mask)
 #define num_active_cpus()	cpumask_weight(cpu_active_mask)
 
@@ -1104,6 +1118,11 @@ static inline bool cpu_online(unsigned int cpu)
 	return cpumask_test_cpu(cpu, cpu_online_mask);
 }
 
+static inline bool cpu_enabled(unsigned int cpu)
+{
+	return cpumask_test_cpu(cpu, cpu_enabled_mask);
+}
+
 static inline bool cpu_possible(unsigned int cpu)
 {
 	return cpumask_test_cpu(cpu, cpu_possible_mask);
@@ -1128,6 +1147,7 @@ static inline bool cpu_dying(unsigned int cpu)
 
 #define num_online_cpus()	1U
 #define num_possible_cpus()	1U
+#define num_enabled_cpus()	1U
 #define num_present_cpus()	1U
 #define num_active_cpus()	1U
 
@@ -1141,6 +1161,11 @@ static inline bool cpu_possible(unsigned int cpu)
 	return cpu == 0;
 }
 
+static inline bool cpu_enabled(unsigned int cpu)
+{
+	return cpu == 0;
+}
+
 static inline bool cpu_present(unsigned int cpu)
 {
 	return cpu == 0;
diff --git a/kernel/cpu.c b/kernel/cpu.c
index e6ec3ba4950b..23b5568fb378 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -3117,6 +3117,9 @@ EXPORT_SYMBOL(__cpu_possible_mask);
 struct cpumask __cpu_online_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_online_mask);
 
+struct cpumask __cpu_enabled_mask __read_mostly;
+EXPORT_SYMBOL(__cpu_enabled_mask);
+
 struct cpumask __cpu_present_mask __read_mostly;
 EXPORT_SYMBOL(__cpu_present_mask);
 
-- 
2.30.2


