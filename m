Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 921BD6E9F4D
	for <lists+linux-arch@lfdr.de>; Fri, 21 Apr 2023 00:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjDTWuF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 20 Apr 2023 18:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjDTWuF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 20 Apr 2023 18:50:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDEE835AF;
        Thu, 20 Apr 2023 15:50:02 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1004)
        id 4F3A421C20A7; Thu, 20 Apr 2023 15:50:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4F3A421C20A7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
        s=default; t=1682031002;
        bh=ojayM19PwEdi0q229Ygd4Rsgg5fIbrEj5bJwTOT8doY=;
        h=From:To:Cc:Subject:Date:From;
        b=rO4qlOIt1esmsNkD/3b5zCrnMm21SChMzLSdZOKY/fsdnKcTZJGVvkV9jFfRYlBKV
         20MxukVQrT0xq++m3VR2hOxbkCjjmbgYWzM/Ljs3aZUh3OAOVKs9rz9UTB9svTgMjl
         FZnqtKhNFyBouY/wpU4QBzQiwNeMQXckXVG93dzo=
From:   longli@linuxonhyperv.com
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: [PATCH v4] Drivers: hv: move panic report code from vmbus to hv early init code
Date:   Thu, 20 Apr 2023 15:49:06 -0700
Message-Id: <1682030946-6372-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Long Li <longli@microsoft.com>

The panic reporting code was added in commit 81b18bce48af
("Drivers: HV: Send one page worth of kmsg dump over Hyper-V during panic")

It was added to the vmbus driver. The panic reporting has no dependence
on vmbus, and can be enabled at an earlier boot time when Hyper-V is
initialized.

This patch moves the panic reporting code out of vmbus. There is no
functionality changes. During moving, also refactored some cleanup
functions into hv_kmsg_dump_unregister().

Signed-off-by: Long Li <longli@microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>

---
Change log v4:
1. Rebase to hyperv-next

Change log v3:
1. Rebase to linux-next

Change log v2:
1. Check on hv_is_isolation_supported() before reporting crash dump
2. Remove hyperv_report_reg(), inline the check condition instead
3. Remove the test NULL on hv_panic_page when freeing it

 drivers/hv/hv.c        |  36 -------
 drivers/hv/hv_common.c | 231 +++++++++++++++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c | 199 -----------------------------------
 3 files changed, 231 insertions(+), 235 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 4e1407d59ba0..de6708dbe0df 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -38,42 +38,6 @@ int hv_init(void)
 	return 0;
 }
 
-/*
- * Functions for allocating and freeing memory with size and
- * alignment HV_HYP_PAGE_SIZE. These functions are needed because
- * the guest page size may not be the same as the Hyper-V page
- * size. We depend upon kmalloc() aligning power-of-two size
- * allocations to the allocation size boundary, so that the
- * allocated memory appears to Hyper-V as a page of the size
- * it expects.
- */
-
-void *hv_alloc_hyperv_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
-
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL);
-	else
-		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-}
-
-void *hv_alloc_hyperv_zeroed_page(void)
-{
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	else
-		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-}
-
-void hv_free_hyperv_page(unsigned long addr)
-{
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		free_page(addr);
-	else
-		kfree((void *)addr);
-}
-
 /*
  * hv_post_message - Post a message using the hypervisor message IPC.
  *
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 6d40b6c7b23b..64f9ceca887b 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -17,8 +17,11 @@
 #include <linux/export.h>
 #include <linux/bitfield.h>
 #include <linux/cpumask.h>
+#include <linux/sched/task_stack.h>
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
+#include <linux/kdebug.h>
+#include <linux/kmsg_dump.h>
 #include <linux/slab.h>
 #include <linux/dma-map-ops.h>
 #include <asm/hyperv-tlfs.h>
@@ -54,6 +57,10 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
 void * __percpu *hyperv_pcpu_output_arg;
 EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
+static void hv_kmsg_dump_unregister(void);
+
+static struct ctl_table_header *hv_ctl_table_hdr;
+
 /*
  * Hyper-V specific initialization and shutdown code that is
  * common across all architectures.  Called from architecture
@@ -62,6 +69,12 @@ EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
 
 void __init hv_common_free(void)
 {
+	unregister_sysctl_table(hv_ctl_table_hdr);
+	hv_ctl_table_hdr = NULL;
+
+	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE)
+		hv_kmsg_dump_unregister();
+
 	kfree(hv_vp_index);
 	hv_vp_index = NULL;
 
@@ -72,10 +85,203 @@ void __init hv_common_free(void)
 	hyperv_pcpu_input_arg = NULL;
 }
 
+/*
+ * Functions for allocating and freeing memory with size and
+ * alignment HV_HYP_PAGE_SIZE. These functions are needed because
+ * the guest page size may not be the same as the Hyper-V page
+ * size. We depend upon kmalloc() aligning power-of-two size
+ * allocations to the allocation size boundary, so that the
+ * allocated memory appears to Hyper-V as a page of the size
+ * it expects.
+ */
+
+void *hv_alloc_hyperv_page(void)
+{
+	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
+
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL);
+	else
+		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
+
+void *hv_alloc_hyperv_zeroed_page(void)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	else
+		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
+
+void hv_free_hyperv_page(unsigned long addr)
+{
+	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
+		free_page(addr);
+	else
+		kfree((void *)addr);
+}
+EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
+
+static void *hv_panic_page;
+
+/*
+ * Boolean to control whether to report panic messages over Hyper-V.
+ *
+ * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
+ */
+static int sysctl_record_panic_msg = 1;
+
+/*
+ * sysctl option to allow the user to control whether kmsg data should be
+ * reported to Hyper-V on panic.
+ */
+static struct ctl_table hv_ctl_table[] = {
+	{
+		.procname	= "hyperv_record_panic_msg",
+		.data		= &sysctl_record_panic_msg,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE
+	},
+	{}
+};
+
+static int hv_die_panic_notify_crash(struct notifier_block *self,
+				     unsigned long val, void *args);
+
+static struct notifier_block hyperv_die_report_block = {
+	.notifier_call = hv_die_panic_notify_crash,
+};
+
+static struct notifier_block hyperv_panic_report_block = {
+	.notifier_call = hv_die_panic_notify_crash,
+};
+
+/*
+ * The following callback works both as die and panic notifier; its
+ * goal is to provide panic information to the hypervisor unless the
+ * kmsg dumper is used [see hv_kmsg_dump()], which provides more
+ * information but isn't always available.
+ *
+ * Notice that both the panic/die report notifiers are registered only
+ * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE set.
+ */
+static int hv_die_panic_notify_crash(struct notifier_block *self,
+				     unsigned long val, void *args)
+{
+	struct pt_regs *regs;
+	bool is_die;
+
+	/* Don't notify Hyper-V unless we have a die oops event or panic. */
+	if (self == &hyperv_panic_report_block) {
+		is_die = false;
+		regs = current_pt_regs();
+	} else { /* die event */
+		if (val != DIE_OOPS)
+			return NOTIFY_DONE;
+
+		is_die = true;
+		regs = ((struct die_args *)args)->regs;
+	}
+
+	/*
+	 * Hyper-V should be notified only once about a panic/die. If we will
+	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
+	 * notification here.
+	 */
+	if (!sysctl_record_panic_msg || !hv_panic_page)
+		hyperv_report_panic(regs, val, is_die);
+
+	return NOTIFY_DONE;
+}
+
+/*
+ * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
+ * buffer and call into Hyper-V to transfer the data.
+ */
+static void hv_kmsg_dump(struct kmsg_dumper *dumper,
+			 enum kmsg_dump_reason reason)
+{
+	struct kmsg_dump_iter iter;
+	size_t bytes_written;
+
+	/* We are only interested in panics. */
+	if (reason != KMSG_DUMP_PANIC || !sysctl_record_panic_msg)
+		return;
+
+	/*
+	 * Write dump contents to the page. No need to synchronize; panic should
+	 * be single-threaded.
+	 */
+	kmsg_dump_rewind(&iter);
+	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
+			     &bytes_written);
+	if (!bytes_written)
+		return;
+	/*
+	 * P3 to contain the physical address of the panic page & P4 to
+	 * contain the size of the panic data in that page. Rest of the
+	 * registers are no-op when the NOTIFY_MSG flag is set.
+	 */
+	hv_set_register(HV_REGISTER_CRASH_P0, 0);
+	hv_set_register(HV_REGISTER_CRASH_P1, 0);
+	hv_set_register(HV_REGISTER_CRASH_P2, 0);
+	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
+	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
+
+	/*
+	 * Let Hyper-V know there is crash data available along with
+	 * the panic message.
+	 */
+	hv_set_register(HV_REGISTER_CRASH_CTL,
+			(HV_CRASH_CTL_CRASH_NOTIFY |
+			 HV_CRASH_CTL_CRASH_NOTIFY_MSG));
+}
+
+static struct kmsg_dumper hv_kmsg_dumper = {
+	.dump = hv_kmsg_dump,
+};
+
+static void hv_kmsg_dump_unregister(void)
+{
+	kmsg_dump_unregister(&hv_kmsg_dumper);
+	unregister_die_notifier(&hyperv_die_report_block);
+	atomic_notifier_chain_unregister(&panic_notifier_list,
+					 &hyperv_panic_report_block);
+
+	hv_free_hyperv_page((unsigned long)hv_panic_page);
+	hv_panic_page = NULL;
+}
+
+static void hv_kmsg_dump_register(void)
+{
+	int ret;
+
+	hv_panic_page = hv_alloc_hyperv_zeroed_page();
+	if (!hv_panic_page) {
+		pr_err("Hyper-V: panic message page memory allocation failed\n");
+		return;
+	}
+
+	ret = kmsg_dump_register(&hv_kmsg_dumper);
+	if (ret) {
+		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
+		hv_free_hyperv_page((unsigned long)hv_panic_page);
+		hv_panic_page = NULL;
+	}
+}
+
 int __init hv_common_init(void)
 {
 	int i;
 
+	if (hv_is_isolation_supported())
+		sysctl_record_panic_msg = 0;
+
 	/*
 	 * Hyper-V expects to get crash register data or kmsg when
 	 * crash enlightment is available and system crashes. Set
@@ -84,8 +290,33 @@ int __init hv_common_init(void)
 	 * kernel.
 	 */
 	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
+		u64 hyperv_crash_ctl;
+
 		crash_kexec_post_notifiers = true;
 		pr_info("Hyper-V: enabling crash_kexec_post_notifiers\n");
+
+		/*
+		 * Panic message recording (sysctl_record_panic_msg)
+		 * is enabled by default in non-isolated guests and
+		 * disabled by default in isolated guests; the panic
+		 * message recording won't be available in isolated
+		 * guests should the following registration fail.
+		 */
+		hv_ctl_table_hdr = register_sysctl("kernel", hv_ctl_table);
+		if (!hv_ctl_table_hdr)
+			pr_err("Hyper-V: sysctl table register error");
+
+		/*
+		 * Register for panic kmsg callback only if the right
+		 * capability is supported by the hypervisor.
+		 */
+		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
+		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
+			hv_kmsg_dump_register();
+
+		register_die_notifier(&hyperv_die_report_block);
+		atomic_notifier_chain_register(&panic_notifier_list,
+					       &hyperv_panic_report_block);
 	}
 
 	/*
diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 19a0069dc4a9..309c78ce1d30 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -30,7 +30,6 @@
 #include <linux/panic_notifier.h>
 #include <linux/ptrace.h>
 #include <linux/screen_info.h>
-#include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
 #include <linux/kernel.h>
@@ -50,26 +49,12 @@ static struct device  *hv_dev;
 
 static int hyperv_cpuhp_online;
 
-static void *hv_panic_page;
-
 static long __percpu *vmbus_evt;
 
 /* Values parsed from ACPI DSDT */
 int vmbus_irq;
 int vmbus_interrupt;
 
-/*
- * Boolean to control whether to report panic messages over Hyper-V.
- *
- * It can be set via /proc/sys/kernel/hyperv_record_panic_msg
- */
-static int sysctl_record_panic_msg = 1;
-
-static int hyperv_report_reg(void)
-{
-	return !sysctl_record_panic_msg || !hv_panic_page;
-}
-
 /*
  * The panic notifier below is responsible solely for unloading the
  * vmbus connection, which is necessary in a panic event.
@@ -90,54 +75,6 @@ static struct notifier_block hyperv_panic_vmbus_unload_block = {
 	.priority	= INT_MIN + 1, /* almost the latest one to execute */
 };
 
-static int hv_die_panic_notify_crash(struct notifier_block *self,
-				     unsigned long val, void *args);
-
-static struct notifier_block hyperv_die_report_block = {
-	.notifier_call = hv_die_panic_notify_crash,
-};
-static struct notifier_block hyperv_panic_report_block = {
-	.notifier_call = hv_die_panic_notify_crash,
-};
-
-/*
- * The following callback works both as die and panic notifier; its
- * goal is to provide panic information to the hypervisor unless the
- * kmsg dumper is used [see hv_kmsg_dump()], which provides more
- * information but isn't always available.
- *
- * Notice that both the panic/die report notifiers are registered only
- * if we have the capability HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE set.
- */
-static int hv_die_panic_notify_crash(struct notifier_block *self,
-				     unsigned long val, void *args)
-{
-	struct pt_regs *regs;
-	bool is_die;
-
-	/* Don't notify Hyper-V unless we have a die oops event or panic. */
-	if (self == &hyperv_panic_report_block) {
-		is_die = false;
-		regs = current_pt_regs();
-	} else { /* die event */
-		if (val != DIE_OOPS)
-			return NOTIFY_DONE;
-
-		is_die = true;
-		regs = ((struct die_args *)args)->regs;
-	}
-
-	/*
-	 * Hyper-V should be notified only once about a panic/die. If we will
-	 * be calling hv_kmsg_dump() later with kmsg data, don't do the
-	 * notification here.
-	 */
-	if (hyperv_report_reg())
-		hyperv_report_panic(regs, val, is_die);
-
-	return NOTIFY_DONE;
-}
-
 static const char *fb_mmio_name = "fb_range";
 static struct resource *fb_mmio;
 static struct resource *hyperv_mmio;
@@ -1379,98 +1316,6 @@ static irqreturn_t vmbus_percpu_isr(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-/*
- * Callback from kmsg_dump. Grab as much as possible from the end of the kmsg
- * buffer and call into Hyper-V to transfer the data.
- */
-static void hv_kmsg_dump(struct kmsg_dumper *dumper,
-			 enum kmsg_dump_reason reason)
-{
-	struct kmsg_dump_iter iter;
-	size_t bytes_written;
-
-	/* We are only interested in panics. */
-	if ((reason != KMSG_DUMP_PANIC) || (!sysctl_record_panic_msg))
-		return;
-
-	/*
-	 * Write dump contents to the page. No need to synchronize; panic should
-	 * be single-threaded.
-	 */
-	kmsg_dump_rewind(&iter);
-	kmsg_dump_get_buffer(&iter, false, hv_panic_page, HV_HYP_PAGE_SIZE,
-			     &bytes_written);
-	if (!bytes_written)
-		return;
-	/*
-	 * P3 to contain the physical address of the panic page & P4 to
-	 * contain the size of the panic data in that page. Rest of the
-	 * registers are no-op when the NOTIFY_MSG flag is set.
-	 */
-	hv_set_register(HV_REGISTER_CRASH_P0, 0);
-	hv_set_register(HV_REGISTER_CRASH_P1, 0);
-	hv_set_register(HV_REGISTER_CRASH_P2, 0);
-	hv_set_register(HV_REGISTER_CRASH_P3, virt_to_phys(hv_panic_page));
-	hv_set_register(HV_REGISTER_CRASH_P4, bytes_written);
-
-	/*
-	 * Let Hyper-V know there is crash data available along with
-	 * the panic message.
-	 */
-	hv_set_register(HV_REGISTER_CRASH_CTL,
-	       (HV_CRASH_CTL_CRASH_NOTIFY | HV_CRASH_CTL_CRASH_NOTIFY_MSG));
-}
-
-static struct kmsg_dumper hv_kmsg_dumper = {
-	.dump = hv_kmsg_dump,
-};
-
-static void hv_kmsg_dump_register(void)
-{
-	int ret;
-
-	hv_panic_page = hv_alloc_hyperv_zeroed_page();
-	if (!hv_panic_page) {
-		pr_err("Hyper-V: panic message page memory allocation failed\n");
-		return;
-	}
-
-	ret = kmsg_dump_register(&hv_kmsg_dumper);
-	if (ret) {
-		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
-		hv_free_hyperv_page((unsigned long)hv_panic_page);
-		hv_panic_page = NULL;
-	}
-}
-
-static struct ctl_table_header *hv_ctl_table_hdr;
-
-/*
- * sysctl option to allow the user to control whether kmsg data should be
- * reported to Hyper-V on panic.
- */
-static struct ctl_table hv_ctl_table[] = {
-	{
-		.procname       = "hyperv_record_panic_msg",
-		.data           = &sysctl_record_panic_msg,
-		.maxlen         = sizeof(int),
-		.mode           = 0644,
-		.proc_handler   = proc_dointvec_minmax,
-		.extra1		= SYSCTL_ZERO,
-		.extra2		= SYSCTL_ONE
-	},
-	{}
-};
-
-static struct ctl_table hv_root_table[] = {
-	{
-		.procname	= "kernel",
-		.mode		= 0555,
-		.child		= hv_ctl_table
-	},
-	{}
-};
-
 /*
  * vmbus_bus_init -Main vmbus driver initialization routine.
  *
@@ -1534,38 +1379,6 @@ static int vmbus_bus_init(void)
 	if (ret)
 		goto err_connect;
 
-	if (hv_is_isolation_supported())
-		sysctl_record_panic_msg = 0;
-
-	/*
-	 * Only register if the crash MSRs are available
-	 */
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-		u64 hyperv_crash_ctl;
-		/*
-		 * Panic message recording (sysctl_record_panic_msg)
-		 * is enabled by default in non-isolated guests and
-		 * disabled by default in isolated guests; the panic
-		 * message recording won't be available in isolated
-		 * guests should the following registration fail.
-		 */
-		hv_ctl_table_hdr = register_sysctl_table(hv_root_table);
-		if (!hv_ctl_table_hdr)
-			pr_err("Hyper-V: sysctl table register error");
-
-		/*
-		 * Register for panic kmsg callback only if the right
-		 * capability is supported by the hypervisor.
-		 */
-		hyperv_crash_ctl = hv_get_register(HV_REGISTER_CRASH_CTL);
-		if (hyperv_crash_ctl & HV_CRASH_CTL_CRASH_NOTIFY_MSG)
-			hv_kmsg_dump_register();
-
-		register_die_notifier(&hyperv_die_report_block);
-		atomic_notifier_chain_register(&panic_notifier_list,
-						&hyperv_panic_report_block);
-	}
-
 	/*
 	 * Always register the vmbus unload panic notifier because we
 	 * need to shut the VMbus channel connection on panic.
@@ -1590,8 +1403,6 @@ static int vmbus_bus_init(void)
 	}
 err_setup:
 	bus_unregister(&hv_bus);
-	unregister_sysctl_table(hv_ctl_table_hdr);
-	hv_ctl_table_hdr = NULL;
 	return ret;
 }
 
@@ -2887,13 +2698,6 @@ static void __exit vmbus_exit(void)
 	vmbus_free_channels();
 	kfree(vmbus_connection.channels);
 
-	if (ms_hyperv.misc_features & HV_FEATURE_GUEST_CRASH_MSR_AVAILABLE) {
-		kmsg_dump_unregister(&hv_kmsg_dumper);
-		unregister_die_notifier(&hyperv_die_report_block);
-		atomic_notifier_chain_unregister(&panic_notifier_list,
-						&hyperv_panic_report_block);
-	}
-
 	/*
 	 * The vmbus panic notifier is always registered, hence we should
 	 * also unconditionally unregister it here as well.
@@ -2901,9 +2705,6 @@ static void __exit vmbus_exit(void)
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					&hyperv_panic_vmbus_unload_block);
 
-	free_page((unsigned long)hv_panic_page);
-	unregister_sysctl_table(hv_ctl_table_hdr);
-	hv_ctl_table_hdr = NULL;
 	bus_unregister(&hv_bus);
 
 	cpuhp_remove_state(hyperv_cpuhp_online);
-- 
2.32.0

