Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 032C17B3978
	for <lists+linux-arch@lfdr.de>; Fri, 29 Sep 2023 20:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjI2SCR (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Sep 2023 14:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233793AbjI2SCI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2023 14:02:08 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3939DCDE;
        Fri, 29 Sep 2023 11:02:05 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 13B2620B74CD;
        Fri, 29 Sep 2023 11:01:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13B2620B74CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696010517;
        bh=5wIyfU33sWJ3MEpvNZDBa+bxzGi5MogsXJchKZPywhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sn+R8289WrpvBPqbfCKHgqwsvc9S4VTHvsaXb738hqr4JyulYJ48WLAYV54D0oEXc
         aV/KWgHge5mE8c7JFhpsvfJ1gGucvxtDkvBCDkAOvS6/qnlDAQA+7zCKpzuOZTGYFR
         obd+MCZ8ByMj2jjFij2VugZ1NV+D21txw+9OquL0=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v4 07/15] Drivers: hv: Move hv_call_deposit_pages and hv_call_create_vp to common code
Date:   Fri, 29 Sep 2023 11:01:33 -0700
Message-Id: <1696010501-24584-8-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

These hypercalls are not arch-specific. Move them to common code.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 arch/x86/hyperv/hv_proc.c       | 152 --------------------------------
 arch/x86/include/asm/mshyperv.h |   1 -
 drivers/hv/hv_common.c          | 147 ++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |   2 +
 4 files changed, 149 insertions(+), 153 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index ed80da64649e..0a35cb865427 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -3,7 +3,6 @@
 #include <linux/vmalloc.h>
 #include <linux/mm.h>
 #include <linux/clockchips.h>
-#include <linux/acpi.h>
 #include <linux/hyperv.h>
 #include <linux/slab.h>
 #include <linux/cpuhotplug.h>
@@ -14,106 +13,6 @@
 
 #include <asm/trace/hyperv.h>
 
-/*
- * See struct hv_deposit_memory. The first u64 is partition ID, the rest
- * are GPAs.
- */
-#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
-
-/* Deposits exact number of pages. Must be called with interrupts enabled.  */
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
-{
-	struct page **pages, *page;
-	int *counts;
-	int num_allocations;
-	int i, j, page_count;
-	int order;
-	u64 status;
-	int ret;
-	u64 base_pfn;
-	struct hv_deposit_memory *input_page;
-	unsigned long flags;
-
-	if (num_pages > HV_DEPOSIT_MAX)
-		return -E2BIG;
-	if (!num_pages)
-		return 0;
-
-	/* One buffer for page pointers and counts */
-	page = alloc_page(GFP_KERNEL);
-	if (!page)
-		return -ENOMEM;
-	pages = page_address(page);
-
-	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
-	if (!counts) {
-		free_page((unsigned long)pages);
-		return -ENOMEM;
-	}
-
-	/* Allocate all the pages before disabling interrupts */
-	i = 0;
-
-	while (num_pages) {
-		/* Find highest order we can actually allocate */
-		order = 31 - __builtin_clz(num_pages);
-
-		while (1) {
-			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
-			if (pages[i])
-				break;
-			if (!order) {
-				ret = -ENOMEM;
-				num_allocations = i;
-				goto err_free_allocations;
-			}
-			--order;
-		}
-
-		split_page(pages[i], order);
-		counts[i] = 1 << order;
-		num_pages -= counts[i];
-		i++;
-	}
-	num_allocations = i;
-
-	local_irq_save(flags);
-
-	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-	input_page->partition_id = partition_id;
-
-	/* Populate gpa_page_list - these will fit on the input page */
-	for (i = 0, page_count = 0; i < num_allocations; ++i) {
-		base_pfn = page_to_pfn(pages[i]);
-		for (j = 0; j < counts[i]; ++j, ++page_count)
-			input_page->gpa_page_list[page_count] = base_pfn + j;
-	}
-	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
-				     page_count, 0, input_page, NULL);
-	local_irq_restore(flags);
-	if (!hv_result_success(status)) {
-		pr_err("Failed to deposit pages: %lld\n", status);
-		ret = hv_result(status);
-		goto err_free_allocations;
-	}
-
-	ret = 0;
-	goto free_buf;
-
-err_free_allocations:
-	for (i = 0; i < num_allocations; ++i) {
-		base_pfn = page_to_pfn(pages[i]);
-		for (j = 0; j < counts[i]; ++j)
-			__free_page(pfn_to_page(base_pfn + j));
-	}
-
-free_buf:
-	free_page((unsigned long)pages);
-	kfree(counts);
-	return ret;
-}
-
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 {
 	struct hv_add_logical_processor_in *input;
@@ -156,54 +55,3 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	return ret;
 }
 
-int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
-{
-	struct hv_create_vp *input;
-	u64 status;
-	unsigned long irq_flags;
-	int ret = HV_STATUS_SUCCESS;
-	int pxm = node_to_pxm(node);
-
-	/* Root VPs don't seem to need pages deposited */
-	if (partition_id != hv_current_partition_id) {
-		/* The value 90 is empirically determined. It may change. */
-		ret = hv_call_deposit_pages(node, partition_id, 90);
-		if (ret)
-			return ret;
-	}
-
-	do {
-		local_irq_save(irq_flags);
-
-		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-
-		input->partition_id = partition_id;
-		input->vp_index = vp_index;
-		input->flags = flags;
-		input->subnode_type = HvSubnodeAny;
-		if (node != NUMA_NO_NODE) {
-			input->proximity_domain_info.domain_id = pxm;
-			input->proximity_domain_info.flags.reserved = 0;
-			input->proximity_domain_info.flags.proximity_info_valid = 1;
-			input->proximity_domain_info.flags.proximity_preferred = 1;
-		} else {
-			input->proximity_domain_info.as_uint64 = 0;
-		}
-		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
-		local_irq_restore(irq_flags);
-
-		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
-			if (!hv_result_success(status)) {
-				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
-				       vp_index, flags, status);
-				ret = hv_result(status);
-			}
-			break;
-		}
-		ret = hv_call_deposit_pages(node, partition_id, 1);
-
-	} while (!ret);
-
-	return ret;
-}
-
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index e918b4132de8..e3768d787065 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -62,7 +62,6 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 
 int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
-int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
 /*
  * If the hypercall involves no input or output parameters, the hypervisor
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 0be3fbec52dd..9d9f6f90f99e 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -584,3 +584,150 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
 	return HV_STATUS_INVALID_PARAMETER;
 }
 EXPORT_SYMBOL_GPL(hv_tdx_hypercall);
+
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
+{
+	struct hv_create_vp *input;
+	u64 status;
+	unsigned long irq_flags;
+	int ret = HV_STATUS_SUCCESS;
+
+	/* Root VPs don't seem to need pages deposited */
+	if (partition_id != hv_current_partition_id) {
+		/* The value 90 is empirically determined. It may change. */
+		ret = hv_call_deposit_pages(node, partition_id, 90);
+		if (ret)
+			return ret;
+	}
+
+	do {
+		local_irq_save(irq_flags);
+
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+		input->partition_id = partition_id;
+		input->vp_index = vp_index;
+		input->flags = flags;
+		input->subnode_type = HvSubnodeAny;
+		input->proximity_domain_info =
+			numa_node_to_proximity_domain_info(node);
+		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
+		local_irq_restore(irq_flags);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status)) {
+				pr_err("%s: vcpu %u, lp %u, %s\n", __func__,
+				       vp_index, flags, hv_status_to_string(status));
+				ret = hv_status_to_errno(status);
+			}
+			break;
+		}
+		ret = hv_call_deposit_pages(node, partition_id, 1);
+
+	} while (!ret);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_call_create_vp);
+
+/*
+ * See struct hv_deposit_memory. The first u64 is partition ID, the rest
+ * are GPAs.
+ */
+#define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
+
+/* Deposits exact number of pages. Must be called with interrupts enabled.  */
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+{
+	struct page **pages, *page;
+	int *counts;
+	int num_allocations;
+	int i, j, page_count;
+	int order;
+	u64 status;
+	int ret;
+	u64 base_pfn;
+	struct hv_deposit_memory *input_page;
+	unsigned long flags;
+
+	if (num_pages > HV_DEPOSIT_MAX)
+		return -E2BIG;
+	if (!num_pages)
+		return 0;
+
+	/* One buffer for page pointers and counts */
+	page = alloc_page(GFP_KERNEL);
+	if (!page)
+		return -ENOMEM;
+	pages = page_address(page);
+
+	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
+	if (!counts) {
+		free_page((unsigned long)pages);
+		return -ENOMEM;
+	}
+
+	/* Allocate all the pages before disabling interrupts */
+	i = 0;
+
+	while (num_pages) {
+		/* Find highest order we can actually allocate */
+		order = 31 - __builtin_clz(num_pages);
+
+		while (1) {
+			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
+			if (pages[i])
+				break;
+			if (!order) {
+				ret = -ENOMEM;
+				num_allocations = i;
+				goto err_free_allocations;
+			}
+			--order;
+		}
+
+		split_page(pages[i], order);
+		counts[i] = 1 << order;
+		num_pages -= counts[i];
+		i++;
+	}
+	num_allocations = i;
+
+	local_irq_save(flags);
+
+	input_page = *this_cpu_ptr(hyperv_pcpu_input_arg);
+
+	input_page->partition_id = partition_id;
+
+	/* Populate gpa_page_list - these will fit on the input page */
+	for (i = 0, page_count = 0; i < num_allocations; ++i) {
+		base_pfn = page_to_pfn(pages[i]);
+		for (j = 0; j < counts[i]; ++j, ++page_count)
+			input_page->gpa_page_list[page_count] = base_pfn + j;
+	}
+	status = hv_do_rep_hypercall(HVCALL_DEPOSIT_MEMORY,
+				     page_count, 0, input_page, NULL);
+	local_irq_restore(flags);
+	if (!hv_result_success(status)) {
+		pr_err("Failed to deposit pages: %s\n", hv_status_to_string(status));
+		ret = hv_status_to_errno(status);
+		goto err_free_allocations;
+	}
+
+	ret = 0;
+	goto free_buf;
+
+err_free_allocations:
+	for (i = 0; i < num_allocations; ++i) {
+		base_pfn = page_to_pfn(pages[i]);
+		for (j = 0; j < counts[i]; ++j)
+			__free_page(pfn_to_page(base_pfn + j));
+	}
+
+free_buf:
+	free_page((unsigned long)pages);
+	kfree(counts);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
+
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index d6310a40fbde..4f2bb6099063 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -349,6 +349,8 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
-- 
2.25.1

