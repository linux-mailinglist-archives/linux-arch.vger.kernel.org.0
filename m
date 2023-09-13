Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F8EA79EEAF
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230526AbjIMQkl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231245AbjIMQj5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CBC51BD6;
        Wed, 13 Sep 2023 09:39:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BBDB1FB;
        Wed, 13 Sep 2023 09:40:10 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 57FDF3F5A1;
        Wed, 13 Sep 2023 09:39:31 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 20/35] ACPI: Rename acpi_processor_hotadd_init and remove pre-processor guards
Date:   Wed, 13 Sep 2023 16:38:08 +0000
Message-Id: <20230913163823.7880-21-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 75257fae10e7..22a15a614f95 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -182,13 +182,15 @@ static void __init acpi_pcc_cpufreq_init(void) {}
 #endif /* CONFIG_X86 */
 
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
 
@@ -222,12 +224,6 @@ static int acpi_processor_hotadd_init(struct acpi_processor *pr)
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
@@ -335,7 +331,7 @@ static int acpi_processor_get_info(struct acpi_device *device)
 	 *  because cpuid <-> apicid mapping is persistent now.
 	 */
 	if (invalid_logical_cpuid(pr->id) || !cpu_present(pr->id)) {
-		int ret = acpi_processor_hotadd_init(pr);
+		int ret = acpi_processor_make_present(pr);
 
 		if (ret)
 			return ret;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 651dd43976a9..b7ab85857bb7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -316,12 +316,10 @@ static inline int acpi_processor_evaluate_cst(acpi_handle handle, u32 cpu,
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
2.39.2

