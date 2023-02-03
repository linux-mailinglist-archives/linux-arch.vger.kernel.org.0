Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BA8E689AB3
	for <lists+linux-arch@lfdr.de>; Fri,  3 Feb 2023 14:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjBCNzv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 3 Feb 2023 08:55:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbjBCNzF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 3 Feb 2023 08:55:05 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BB73A7EEC;
        Fri,  3 Feb 2023 05:53:31 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FBC11650;
        Fri,  3 Feb 2023 05:53:42 -0800 (PST)
Received: from eglon.cambridge.arm.com (eglon.cambridge.arm.com [10.1.196.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D29A43F71E;
        Fri,  3 Feb 2023 05:52:56 -0800 (PST)
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
Subject: [RFC PATCH 16/32] ACPI: Rename acpi_processor_hotadd_init and remove pre-processor guards
Date:   Fri,  3 Feb 2023 13:50:27 +0000
Message-Id: <20230203135043.409192-17-james.morse@arm.com>
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

acpi_processor_hotadd_init() will make a CPU present by mapping it
based on its hardware id.

'hotadd_init' is ambiguous once there are two different behaviours
for cpu hotplug. This is for toggling the _STA present bit. Subsequent
patches will add support for toggling the _STA enabled bit, named
acpi_processor_make_enabled().

Rename it acpi_processor_make_present() to make it clear this is
for CPUs that were not previously present.

Expose the function prototypes it uses to allow the preprocessor
guards to be removed. The IS_ENABLED() check will let the compiler
dead-code elimination pass remove this if it isn't going to be
used.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/acpi_processor.c | 14 +++++---------
 include/linux/acpi.h          |  2 --
 2 files changed, 5 insertions(+), 11 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 682721594820..6ab55f109417 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -149,13 +149,15 @@ static int acpi_processor_errata(void)
 }
 
 /* Initialization */
-#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
-static int acpi_processor_hotadd_init(struct acpi_processor *pr)
+static int acpi_processor_make_present(struct acpi_processor *pr)
 {
 	unsigned long long sta;
 	acpi_status status;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
+		return -ENODEV;
+
 	if (invalid_phys_cpuid(pr->phys_id))
 		return -ENODEV;
 
@@ -189,12 +191,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
 	cpu_maps_update_done();
 	return ret;
 }
-#else
-static inline int acpi_processor_hotadd_init(struct acpi_processor *pr)
-{
-	return -ENODEV;
-}
-#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 static int acpi_processor_get_info(struct acpi_device *device)
 {
@@ -287,7 +283,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_make_present(pr);
 
 		if (ret)
 			return ret;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0bc1eacd0dfc..a59bca4dbcd5 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -327,12 +327,10 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
 }
 #endif
 
-#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Arch dependent functions for cpu hotplug support */
 int acpi_map_cpu(acpi_handle handle, phys_cpuid_t physid, u32 acpi_id,
 		 int *pcpu);
 int acpi_unmap_cpu(int cpu);
-#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
 
 #ifdef CONFIG_ACPI_HOTPLUG_IOAPIC
 int acpi_get_ioapic_id(acpi_handle handle, u32 gsi_base, u64 *phys_addr);
-- 
2.30.2

