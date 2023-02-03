Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B852689B03
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 15:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbjBCOEP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 09:04:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbjBCOD6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 09:03:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448D5A56E0;
        Fri,  3 Feb 2023 06:01:46 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16D091688;
        Fri,  3 Feb 2023 05:54:25 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4979D3F71E;
        Fri,  3 Feb 2023 05:53:39 -0800 (PST)
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
Subject: [RFC PATCH 25/32] irqchip/gic-v3: Don't return errors from gic_acpi_match_gicc()
Date:   Fri,  3 Feb 2023 13:50:36 +0000
Message-Id: <20230203135043.409192-26-james.morse@arm.com>
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

gic_acpi_match_gicc() is only called via gic_acpi_count_gicr_regions().
It should only count the number of enabled redistributors, but it
also tries to sanity check the GICC entry, currently returning an
error if the Enabled bit is set, but the gicr_base_address is zero.

Adding support for the online-capable bit to the sanity check
complictes it, for no benefit. The existing check implicitly
depends on gic_acpi_count_gicr_regions() previous failing to find
any GICR regions (as it is valid to have gicr_base_address of zero if
the redistributors are described via a GICR entry).

Instead of complicating the check, remove it. Failures that happen
at this point cause the irqchip not to register, meaning no irqs
can be requested. The kernel grinds to a panic() pretty quickly.

Without the check, MADT tables that exhibit this problem are still
caught by gic_populate_rdist(), which helpfully also prints what
went wrong:
| CPU4: mpidr 100 has no re-distributor!

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/irqchip/irq-gic-v3.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index d484cccfd612..a8b969d652b6 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2237,21 +2237,15 @@ static int __init gic_acpi_match_gicc(union acpi_subtable_headers *header,
 
 	/*
 	 * If GICC is enabled and has valid gicr base address, then it means
-	 * GICR base is presented via GICC
+	 * GICR base is presented via GICC. The redistributor is only known to
+	 * be accessible if the GICC is marked as enabled. If this bit is not
+	 * set, we'd need to add the redistributor at runtime, which isn't
+	 * supported.
 	 */
-	if (acpi_gicc_is_usable(gicc) && gicc->gicr_base_address) {
+	if (gicc->flags & ACPI_MADT_ENABLED && gicc->gicr_base_address)
 		acpi_data.enabled_rdists++;
-		return 0;
-	}
 
-	/*
-	 * It's perfectly valid firmware can pass disabled GICC entry, driver
-	 * should not treat as errors, skip the entry instead of probe fail.
-	 */
-	if (!acpi_gicc_is_usable(gicc))
-		return 0;
-
-	return -ENODEV;
+	return 0;
 }
 
 static int __init gic_acpi_count_gicr_regions(void)
-- 
2.30.2

