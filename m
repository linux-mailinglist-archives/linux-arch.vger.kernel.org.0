Return-Path: <linux-arch+bounces-4086-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E6E8B7A14
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 16:39:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46F62285A0A
	for <lists+linux-arch@lfdr.de>; Tue, 30 Apr 2024 14:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905C81BED71;
	Tue, 30 Apr 2024 14:31:51 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6871BED6C;
	Tue, 30 Apr 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714487511; cv=none; b=pEFpbgrP+t4YpDGs++7Wdm69Rb6dbo6C6tqMxh35qM8tqzFRcz5SQXRI+afRjcNU5L1N7K/aVjTgixH0x5sC6Ml392A3whXIO1TtBooCyWunP6swvCB5Xv6IWXT5Y+NUBLmmUqniWk3Jc+Q1c81MEasv680a4s6IbNuvGQuiVOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714487511; c=relaxed/simple;
	bh=zn1cnSdhKUB4p+WfqgfEWRLVL20zjMCBCGPxi19RkFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jvNKUf6A0vA1Dt5ezPO6DmrvrCApPreaB6K554gldjwAUT+5e8yttyl8VEB+vnAm0Dc+3a/Fpf4iJHgNPhH3/MQHZ43pzslHkiKKWytI2WZkNCzNyYuu350ZOcIjrqDRnmonDxq3w0OqC7bKlX6GLB5pzrEqkVWrlvnu5iIJHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTMyV3mpVz6J6tW;
	Tue, 30 Apr 2024 22:29:06 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 57CF31400DC;
	Tue, 30 Apr 2024 22:31:47 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 15:31:46 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>, <linux-pm@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-acpi@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <kvmarm@lists.linux.dev>,
	<x86@kernel.org>, Russell King <linux@armlinux.org.uk>, "Rafael J . Wysocki"
	<rafael@kernel.org>, Miguel Luis <miguel.luis@oracle.com>, James Morse
	<james.morse@arm.com>, Salil Mehta <salil.mehta@huawei.com>, Jean-Philippe
 Brucker <jean-philippe@linaro.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Marc Zyngier
	<maz@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, Gavin Shan
	<gshan@redhat.com>
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave
 Hansen <dave.hansen@linux.intel.com>, <linuxarm@huawei.com>,
	<justin.he@arm.com>, <jianyong.wu@arm.com>
Subject: [PATCH v9 14/19] irqchip/gic-v3: Add support for ACPI's disabled but 'online capable' CPUs
Date: Tue, 30 Apr 2024 15:24:29 +0100
Message-ID: <20240430142434.10471-15-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
References: <20240430142434.10471-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

From: James Morse <james.morse@arm.com>

To support virtual CPU hotplug, ACPI has added an 'online capable' bit
to the MADT GICC entries. This indicates a disabled CPU entry may not
be possible to online via PSCI until firmware has set enabled bit in
_STA.

This means that a "usable" GIC redistributor is one that is marked as
either enabled, or online capable. The meaning of the
acpi_gicc_is_usable() would become less clear than just checking the
pair of flags at call sites. As such, drop that helper function.
The test in gic_acpi_match_gicc() remains as testing just the
enabled bit so the count of enabled distributors is correct.

What about the redistributor in the GICC entry? ACPI doesn't want to say.
Assume the worst: When a redistributor is described in the GICC entry,
but the entry is marked as disabled at boot, assume the redistributor
is inaccessible.

The GICv3 driver doesn't support late online of redistributors, so this
means the corresponding CPU can't be brought online either.
Rather than modifying cpu masks that may already have been used,
register a new cpuhp callback to fail this case. This must run earlier
than the main gic_starting_cpu() so that this case can be rejected
before the section of cpuhp that runs on the CPU that is coming up as
that is not allowed to fail. This solution keeps the handling of this
broken firmware corner case local to the GIC driver. As precise ordering
of this callback doesn't need to be controlled as long as it is
in that initial prepare phase, use CPUHP_BP_PREPARE_DYN.

Systems that want CPU hotplug in a VM can ensure their redistributors
are always-on, and describe them that way with a GICR entry in the MADT.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: James Morse <james.morse@arm.com>
Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Tested-by: Miguel Luis <miguel.luis@oracle.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v9: Thanks to Marc for quick follow up.
    Fix up description and drop the acpi_gicc_is_usable() check helper
    function in favour of checks inline, given that now doesn't
    actually mean they are usable.
    Only set the broken_rdists mask bit if we have a valid CPU ID with
    which to do so.
---
 arch/arm64/kernel/smp.c       |  3 ++-
 drivers/acpi/processor_core.c |  3 ++-
 drivers/irqchip/irq-gic-v3.c  | 46 ++++++++++++++++++++++++++++++++---
 include/linux/acpi.h          |  5 ----
 4 files changed, 46 insertions(+), 11 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index 4ced34f62dab..afe835c1cbe2 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -523,7 +523,8 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	u64 hwid = processor->arm_mpidr;
 
-	if (!acpi_gicc_is_usable(processor)) {
+	if (!(processor->flags &
+	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE))) {
 		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
 		return;
 	}
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index b203cfe28550..b04b684f3190 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -90,7 +90,8 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 	struct acpi_madt_generic_interrupt *gicc =
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
 
-	if (!acpi_gicc_is_usable(gicc))
+	if (!(gicc->flags &
+	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return -ENODEV;
 
 	/* device_declaration means Device object in DSDT, in the
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 10af15f93d4d..cc81515c1413 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -44,6 +44,8 @@
 
 #define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
 
+static struct cpumask broken_rdists __read_mostly;
+
 struct redist_region {
 	void __iomem		*redist_base;
 	phys_addr_t		phys_base;
@@ -1293,6 +1295,18 @@ static void gic_cpu_init(void)
 #define MPIDR_TO_SGI_RS(mpidr)	(MPIDR_RS(mpidr) << ICC_SGI1R_RS_SHIFT)
 #define MPIDR_TO_SGI_CLUSTER_ID(mpidr)	((mpidr) & ~0xFUL)
 
+/*
+ * gic_starting_cpu() is called after the last point where cpuhp is allowed
+ * to fail. So pre check for problems earlier.
+ */
+static int gic_check_rdist(unsigned int cpu)
+{
+	if (cpumask_test_cpu(cpu, &broken_rdists))
+		return -EINVAL;
+
+	return 0;
+}
+
 static int gic_starting_cpu(unsigned int cpu)
 {
 	gic_cpu_init();
@@ -1384,6 +1398,10 @@ static void __init gic_smp_init(void)
 	};
 	int base_sgi;
 
+	cpuhp_setup_state_nocalls(CPUHP_BP_PREPARE_DYN,
+				  "irqchip/arm/gicv3:checkrdist",
+				  gic_check_rdist, NULL);
+
 	cpuhp_setup_state_nocalls(CPUHP_AP_IRQ_GIC_STARTING,
 				  "irqchip/arm/gicv3:starting",
 				  gic_starting_cpu, NULL);
@@ -2365,8 +2383,24 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
-	if (!acpi_gicc_is_usable(gicc))
+	/* Neither enabled or online capable means it doesn't exist, skip it */
+	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
+		return 0;
+
+	/*
+	 * Capable but disabled CPUs can be brought online later. What about
+	 * the redistributor? ACPI doesn't want to say!
+	 * Virtual hotplug systems can use the MADT's "always-on" GICR entries.
+	 * Otherwise, prevent such CPUs from being brought online.
+	 */
+	if (!(gicc->flags & ACPI_MADT_ENABLED)) {
+		int cpu = get_cpu_for_acpi_id(gicc->uid);
+
+		pr_warn("CPU %u's redistributor is inaccessible: this CPU can't be brought online\n", cpu);
+		if (cpu >= 0)
+			cpumask_set_cpu(cpu, &broken_rdists);
 		return 0;
+	}
 
 	redist_base = ioremap(gicc->gicr_base_address, size);
 	if (!redist_base)
@@ -2413,9 +2447,12 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 
 	/*
 	 * If GICC is enabled and has valid gicr base address, then it means
-	 * GICR base is presented via GICC
+	 * GICR base is presented via GICC. The redistributor is only known to
+	 * be accessible if the GICC is marked as enabled. If this bit is not
+	 * set, we'd need to add the redistributor at runtime, which isn't
+	 * supported.
 	 */
-	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address)
+	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
 		acpi_data.enabled_rdists++;
 
 	return 0;
@@ -2474,7 +2511,8 @@ static int __init gic_acpi_parse_virt_madt_gicc(union acpi_subtable_headers *hea
 	int maint_irq_mode;
 	static int first_madt = true;
 
-	if (!acpi_gicc_is_usable(gicc))
+	if (!(gicc->flags &
+	      (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
 		return 0;
 
 	maint_irq_mode = (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 9844a3f9c4e5..cf5d2a6950ec 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -237,11 +237,6 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
-static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
-{
-	return gicc->flags & ACPI_MADT_ENABLED;
-}
-
 /* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 
-- 
2.39.2


