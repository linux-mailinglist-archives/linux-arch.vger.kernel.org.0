Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF58689AF7
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 15:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232834AbjBCOFX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 09:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233765AbjBCOEk (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 09:04:40 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DDECA8799;
        Fri,  3 Feb 2023 06:02:22 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D82DE1596;
        Fri,  3 Feb 2023 05:54:20 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 169063F71E;
        Fri,  3 Feb 2023 05:53:34 -0800 (PST)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        kvmarm@lists.linux.dev, kvm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Borislav Petkov <bp@alien8.de>, H Peter Anvin <hpa@zytor.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        Len Brown <lenb@kernel.org>,
        Rafael Wysocki <rafael@kernel.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: [RFC PATCH 24/32] arm64, irqchip/gic-v3, ACPI: Move MADT GICC enabled check into a helper
Date:   Fri,  3 Feb 2023 13:50:35 +0000
Message-Id: <20230203135043.409192-25-james.morse@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230203135043.409192-1-james.morse@arm.com>
References: <20230203135043.409192-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

ACPI, irqchip and the architecture code all inspect the MADT
enabled bit for a GICC entry in the MADT.

The addition of an 'online capable' bit means all these sites need updating.

Move the current checks behind a helper to make future updates easier.

Signed-off-by: James Morse <james.morse@arm.com>
---
 arch/arm64/kernel/smp.c       |  2 +-
 drivers/acpi/processor_core.c |  2 +-
 drivers/irqchip/irq-gic-v3.c  | 10 ++++------
 include/linux/acpi.h          |  5 +++++
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index ffc5d76cf695..5669b013c2b7 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -525,7 +525,7 @@ acpi_map_gic_cpu_interface(struct acpi_madt_generic_interrupt *processor)
 {
 	u64 hwid = processor->arm_mpidr;
 
-	if (!(processor->flags & ACPI_MADT_ENABLED)) {
+	if (!acpi_gicc_is_usable(processor)) {
 		pr_debug("skipping disabled CPU entry with 0x%llx MPIDR\n", hwid);
 		return;
 	}
diff --git a/drivers/acpi/processor_core.c b/drivers/acpi/processor_core.c
index 2ac48cda5b20..1ba273622faa 100644
--- a/drivers/acpi/processor_core.c
+++ b/drivers/acpi/processor_core.c
@@ -90,7 +90,7 @@ static int map_gicc_mpidr(struct acpi_subtable_header *entry,
 	struct acpi_madt_generic_interrupt *gicc =
 	    container_of(entry, struct acpi_madt_generic_interrupt, header);
 
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return -ENODEV;
 
 	/* device_declaration means Device object in DSDT, in the
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 997104d4338e..d484cccfd612 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2189,8 +2189,7 @@ gic_acpi_parse_madt_gicc(union acpi_subtable_headers *header,
 	u32 size = reg == GIC_PIDR2_ARCH_GICv4 ? SZ_64K * 4 : SZ_64K * 2;
 	void __iomem *redist_base;
 
-	/* GICC entry which has !ACPI_MADT_ENABLED is not unusable so skip */
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
 	redist_base = ioremap(gicc->gicr_base_address, size);
@@ -2240,7 +2239,7 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * If GICC is enabled and has valid gicr base address, then it means
 	 * GICR base is presented via GICC
 	 */
-	if ((gicc->flags & ACPI_MADT_ENABLED) && gicc->gicr_base_address) {
+	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
 		acpi_data.enabled_rdists++;
 		return 0;
 	}
@@ -2249,7 +2248,7 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 	 * It's perfectly valid firmware can pass disabled GICC entry, driver
 	 * should not treat as errors, skip the entry instead of probe fail.
 	 */
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
 	return -ENODEV;
@@ -2308,8 +2307,7 @@ static int __init gic_acpi_parse_virt_madt_gicc(union acpi_subtable_headers *hea
 	int maint_irq_mode;
 	static int first_madt = true;
 
-	/* Skip unusable CPUs */
-	if (!(gicc->flags & ACPI_MADT_ENABLED))
+	if (!acpi_gicc_is_usable(gicc))
 		return 0;
 
 	maint_irq_mode = (gicc->flags & ACPI_MADT_VGIC_IRQ_MODE) ?
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index a59bca4dbcd5..d8e59953a27f 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -267,6 +267,11 @@ acpi_table_parse_cedt(enum acpi_cedt_type id,
 int acpi_parse_mcfg (struct acpi_table_header *header);
 void acpi_table_print_madt_entry (struct acpi_subtable_header *madt);
 
+static inline bool acpi_gicc_is_usable(struct acpi_madt_generic_interrupt *gicc)
+{
+	return (gicc->flags & ACPI_MADT_ENABLED);
+}
+
 /* the following numa functions are architecture-dependent */
 void acpi_numa_slit_init (struct acpi_table_slit *slit);
 
-- 
2.30.2

