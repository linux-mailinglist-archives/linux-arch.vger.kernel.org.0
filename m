Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 284D579EED1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Sep 2023 18:41:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjIMQlG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Sep 2023 12:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231127AbjIMQj7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Sep 2023 12:39:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 657731BEC;
        Wed, 13 Sep 2023 09:39:37 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B6AA1FB;
        Wed, 13 Sep 2023 09:40:14 -0700 (PDT)
Received: from merodach.members.linode.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60F763F5A1;
        Wed, 13 Sep 2023 09:39:35 -0700 (PDT)
From:   James Morse <james.morse@arm.com>
To:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev
Cc:     x86@kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com
Subject: [RFC PATCH v2 22/35] ACPI: Check _STA present bit before making CPUs not present
Date:   Wed, 13 Sep 2023 16:38:10 +0000
Message-Id: <20230913163823.7880-23-james.morse@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230913163823.7880-1-james.morse@arm.com>
References: <20230913163823.7880-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When called acpi_processor_post_eject() unconditionally make a CPU
not-present and unregisters it.

To add support for AML events where the CPU has become disabled, but
remains present, the _STA method should be checked before calling
acpi_processor_remove().

Rename acpi_processor_post_eject() acpi_processor_remove_possible(), and
check the _STA before calling.

Adding the function prototype for arch_unregister_cpu() allows the
preprocessor guards to be removed.

After this change CPUs will remain registered and visible to
user-space as offline if buggy firmware triggers an eject-request,
but doesn't clear the corresponding _STA bits after _EJ0 has been
called.

Signed-off-by: James Morse <james.morse@arm.com>
---
 drivers/acpi/acpi_processor.c | 31 +++++++++++++++++++++++++------
 include/linux/cpu.h           |  1 +
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/acpi_processor.c b/drivers/acpi/acpi_processor.c
index 00dcc23d49a8..2cafea1edc24 100644
--- a/drivers/acpi/acpi_processor.c
+++ b/drivers/acpi/acpi_processor.c
@@ -457,13 +457,12 @@ static int acpi_processor_add(struct acpi_device *device,
 	return result;
 }
 
-#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 /* Removal */
-static void acpi_processor_post_eject(struct acpi_device *device)
+static void acpi_processor_make_not_present(struct acpi_device *device)
 {
 	struct acpi_processor *pr;
 
-	if (!device || !acpi_driver_data(device))
+	if (!IS_ENABLED(CONFIG_ACPI_HOTPLUG_PRESENT_CPU))
 		return;
 
 	pr = acpi_driver_data(device);
@@ -501,7 +500,29 @@ static void acpi_processor_post_eject(struct acpi_device *device)
 	free_cpumask_var(pr->throttling.shared_cpu_map);
 	kfree(pr);
 }
-#endif /* CONFIG_ACPI_HOTPLUG_PRESENT_CPU */
+
+static void acpi_processor_post_eject(struct acpi_device *device)
+{
+	struct acpi_processor *pr;
+	unsigned long long sta;
+	acpi_status status;
+
+	if (!device)
+		return;
+
+	pr = acpi_driver_data(device);
+	if (!pr || pr->id >= nr_cpu_ids || invalid_phys_cpuid(pr->phys_id))
+		return;
+
+	status = acpi_evaluate_integer(pr->handle, "_STA", NULL, &sta);
+	if (ACPI_FAILURE(status))
+		return;
+
+	if (cpu_present(pr->id) && !(sta & ACPI_STA_DEVICE_PRESENT)) {
+		acpi_processor_make_not_present(device);
+		return;
+	}
+}
 
 #ifdef CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC
 bool __init processor_physically_present(acpi_handle handle)
@@ -626,9 +647,7 @@ static const struct acpi_device_id processor_device_ids[] = {
 static struct acpi_scan_handler processor_handler = {
 	.ids = processor_device_ids,
 	.attach = acpi_processor_add,
-#ifdef CONFIG_ACPI_HOTPLUG_PRESENT_CPU
 	.post_eject = acpi_processor_post_eject,
-#endif
 	.hotplug = {
 		.enabled = true,
 	},
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index a71691d7c2ca..e117c06e0c6b 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -81,6 +81,7 @@ struct device *cpu_device_create(struct device *parent, void *drvdata,
 				 const struct attribute_group **groups,
 				 const char *fmt, ...);
 extern int arch_register_cpu(int cpu);
+extern void arch_unregister_cpu(int cpu);
 #ifdef CONFIG_HOTPLUG_CPU
 extern void unregister_cpu(struct cpu *cpu);
 extern ssize_t arch_cpu_probe(const char *, size_t);
-- 
2.39.2

