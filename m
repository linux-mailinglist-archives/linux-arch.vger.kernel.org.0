Return-Path: <linux-arch+bounces-9294-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CD59E7B9F
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 23:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481BF188733A
	for <lists+linux-arch@lfdr.de>; Fri,  6 Dec 2024 22:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 790BF1F4706;
	Fri,  6 Dec 2024 22:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sWQ0SH08"
X-Original-To: linux-arch@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B013422C6C1;
	Fri,  6 Dec 2024 22:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733523739; cv=none; b=JsF+u07dhXvhse/UUpybUialB7SkOGB1pyJ0hRdvBqUz3U+Y1ItUwtsH8s3vjPaa2kUhRSRvKPLxUu4Ik7ohquGwLZTeGzzAHWugJ82EEWCQnCEZYSRGGH4RIVrHOPiyfeiszQyDdFILPTkdp2kQAMCX7svovkfASlHe+fB9YXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733523739; c=relaxed/simple;
	bh=ehV2KIoYo1qG3BcEdWXbUpZdwJhZlqDkPnxpl0xoZP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=fxBNsx6FqphshvmVp9wsLwhX5qMiHxvPEhsRyZ13mwuzn1w9AJvC7g7p36iVTim50yT2KGxBzmZ5SvFQx66iwBHLDl54r6/GKhYm0rWjkGdlvNbsT1f42AARcvrVebSCnfzGU2dBboMzpZ7AO8ETCMrMu8Zgwarn0HKixcIfpeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sWQ0SH08; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5583F20ACD9A;
	Fri,  6 Dec 2024 14:22:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5583F20ACD9A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733523737;
	bh=qWhJO32QaX3zCsv7TE/p5YopM8ATfeZewveYiJmJv4o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sWQ0SH08qm9VeXGl27eQ7mStuAPq1heKmJyhk3J6cj9XUjc8DFgaG+08qqeATQszN
	 En7kA8JL0Zkwh0/pBwysDXySLzYD7lw6gRiinipklXpaQypollKkxKcmKs4gTZ/eWg
	 t9tL+IQodGWl8dNVT7ugatUSEdOW5unboz6+FCiQ=
From: Nuno Das Neves <nunodasneves@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org
Cc: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	mhklinux@outlook.com,
	decui@microsoft.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	jinankjain@linux.microsoft.com,
	muminulrussell@gmail.com,
	skinsburskii@linux.microsoft.com,
	mukeshrathor@microsoft.com
Subject: [PATCH 2/2] hyperv: Move create_vp and deposit_pages hvcalls to hv_common.c
Date: Fri,  6 Dec 2024 14:21:47 -0800
Message-Id: <1733523707-15954-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1733523707-15954-1-git-send-email-nunodasneves@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>

From: Nuno Das Neves <nudasnev@microsoft.com>

These are not specific to x86_64 and will be needed by common code.

Signed-off-by: Nuno Das Neves <nudasnev@microsoft.com>
---
 arch/x86/hyperv/hv_proc.c       | 144 -------------------------------
 arch/x86/include/asm/mshyperv.h |   2 -
 drivers/hv/hv_common.c          | 145 ++++++++++++++++++++++++++++++++
 include/asm-generic/mshyperv.h  |   2 +
 4 files changed, 147 insertions(+), 146 deletions(-)

diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
index 3fa1f2ee7b0d..119354d00637 100644
--- a/arch/x86/hyperv/hv_proc.c
+++ b/arch/x86/hyperv/hv_proc.c
@@ -10,109 +10,8 @@
 #include <asm/hypervisor.h>
 #include <asm/mshyperv.h>
 #include <asm/apic.h>
-
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
 	struct hv_input_add_logical_processor *input;
@@ -154,46 +53,3 @@ int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
 	return ret;
 }
 
-int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
-{
-	struct hv_create_vp *input;
-	u64 status;
-	unsigned long irq_flags;
-	int ret = HV_STATUS_SUCCESS;
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
-		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
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
index 9eeca2a6d047..5bad88cfccba 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -57,9 +57,7 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 #define HV_AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
 #define HV_AP_SEGMENT_LIMIT		0xffffffff
 
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
 int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
-int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 
 /*
  * If the hypercall involves no input or output parameters, the hypervisor
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 819bcfd2b149..591cc51e8817 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -679,3 +679,148 @@ u64 __weak hv_tdx_hypercall(u64 control, u64 param1, u64 param2)
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
+		input->proximity_domain_info = hv_numa_node_to_pxm_info(node);
+		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
+		local_irq_restore(irq_flags);
+
+		if (hv_result(status) != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (!hv_result_success(status)) {
+				pr_err("%s: vcpu %u, lp %u, %lld\n", __func__,
+				       vp_index, flags, status);
+				ret = hv_result(status);
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
+		pr_err("Failed to deposit pages: %lld\n", status);
+		ret = hv_result(status);
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
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8c4ff6e9aae7..46c0a6cae4e6 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -305,6 +305,8 @@ u64 hv_tdx_hypercall(u64 control, u64 param1, u64 param2);
 void hyperv_cleanup(void);
 bool hv_query_ext_cap(u64 cap_query);
 void hv_setup_dma_ops(struct device *dev, bool coherent);
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
 #else /* CONFIG_HYPERV */
 static inline bool hv_is_hyperv_initialized(void) { return false; }
 static inline bool hv_is_hibernation_supported(void) { return false; }
-- 
2.34.1


