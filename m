Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09A6A2A8442
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 17:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731967AbgKEQ7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 11:59:05 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45987 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726214AbgKEQ6b (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 11:58:31 -0500
Received: by mail-wr1-f67.google.com with SMTP id p1so2576560wrf.12;
        Thu, 05 Nov 2020 08:58:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AYXHYiIAlPHCmbIi+YKVWZ0abNnEogN4UQxaP9vSX2U=;
        b=Ize8tNJrd53cNqgtRud9BYFcS6kC2tfU3QeUGGwIdqTsNHcwXk7S3PxvUSdRzntKjD
         AWi/8rlI5qwqIFybt7q63EO1C7GIu404nU8oikLjvPE9voBBkMBo2WjyH8fQ1YY07kjJ
         8AT7B8m2T6vPulIWNdDvTmnUf4rmrhkWG+u1Hswm76U1v8oeWRzPVJLilyR/1TMetN2h
         Z6PrEVNUnQqTl0S2YcHItVRHPdbrit8OlQdQgll+9WkmbLld/Gdg4X25CoFvLM+nW5u7
         fIXYcyhXt4DFsfeHM11WTgLGvMhHxKuiNEVPXvSXpbrb3AHZrXDUFXlWp/vvD8tnVgF4
         xvqQ==
X-Gm-Message-State: AOAM5313qeNqTa6UvJgBAmDg7jm1BfXlqXJg3M2hkn9U1TGCCnj1yaEc
        qvbn5Eo18meLmo0hqeItWjiChEODWhE=
X-Google-Smtp-Source: ABdhPJywRtxPaansyRK73xP1zGsxQuKXcrEgM3rIoC0q5yir54gbKc7l6M/KJddfR0gvPiSPLRLsFg==
X-Received: by 2002:adf:e447:: with SMTP id t7mr4025340wrm.384.1604595507884;
        Thu, 05 Nov 2020 08:58:27 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:27 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v2 09/17] x86/hyperv: provide a bunch of helper functions
Date:   Thu,  5 Nov 2020 16:58:06 +0000
Message-Id: <20201105165814.29233-10-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

They are used to deposit pages into Microsoft Hypervisor and bring up
logical and virtual processors.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Co-Developed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v2:
1. Adapt to hypervisor side changes
2. Address Vitaly's comments
---
 arch/x86/hyperv/Makefile          |   2 +-
 arch/x86/hyperv/hv_proc.c         | 217 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |   4 +
 include/asm-generic/hyperv-tlfs.h |  67 +++++++++
 4 files changed, 289 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/hyperv/hv_proc.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 89b1f74d3225..565358020921 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 obj-y			:= hv_init.o mmu.o nested.o
-obj-$(CONFIG_X86_64)	+= hv_apic.o
+obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
 
 ifdef CONFIG_X86_64
 obj-$(CONFIG_PARAVIRT_SPINLOCKS)	+= hv_spinlock.o
diff --git a/arch/x86/hyperv/hv_proc.c b/arch/x86/hyperv/hv_proc.c
new file mode 100644
index 000000000000..0fd972c9129a
--- /dev/null
+++ b/arch/x86/hyperv/hv_proc.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/types.h>
+#include <linux/version.h>
+#include <linux/vmalloc.h>
+#include <linux/mm.h>
+#include <linux/clockchips.h>
+#include <linux/acpi.h>
+#include <linux/hyperv.h>
+#include <linux/slab.h>
+#include <linux/cpuhotplug.h>
+#include <linux/minmax.h>
+#include <asm/hypervisor.h>
+#include <asm/mshyperv.h>
+#include <asm/apic.h>
+
+#include <asm/trace/hyperv.h>
+
+#define HV_DEPOSIT_MAX_ORDER (8)
+#define HV_DEPOSIT_MAX (1 << HV_DEPOSIT_MAX_ORDER)
+
+/*
+ * Deposits exact number of pages
+ * Must be called with interrupts enabled
+ * Max 256 pages
+ */
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+{
+	struct page **pages;
+	int *counts;
+	int num_allocations;
+	int i, j, page_count;
+	int order;
+	int desired_order;
+	u16 status;
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
+	pages = page_address(alloc_page(GFP_KERNEL));
+	if (!pages)
+		return -ENOMEM;
+
+	counts = kcalloc(HV_DEPOSIT_MAX, sizeof(int), GFP_KERNEL);
+	if (!counts) {
+		free_page((unsigned long)pages);
+		return -ENOMEM;
+	}
+
+	/* Allocate all the pages before disabling interrupts */
+	num_allocations = 0;
+	i = 0;
+	order = HV_DEPOSIT_MAX_ORDER;
+
+	while (num_pages) {
+		/* Find highest order we can actually allocate */
+		desired_order = 31 - __builtin_clz(num_pages);
+		order = min(desired_order, order);
+		do {
+			pages[i] = alloc_pages_node(node, GFP_KERNEL, order);
+			if (!pages[i]) {
+				if (!order) {
+					ret = -ENOMEM;
+					goto err_free_allocations;
+				}
+				--order;
+			}
+		} while (!pages[i]);
+
+		split_page(pages[i], order);
+		counts[i] = 1 << order;
+		num_pages -= counts[i];
+		i++;
+		num_allocations++;
+	}
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
+				     page_count, 0, input_page,
+				     NULL) & HV_HYPERCALL_RESULT_MASK;
+	local_irq_restore(flags);
+
+	if (status != HV_STATUS_SUCCESS) {
+		pr_err("Failed to deposit pages: %d\n", status);
+		ret = status;
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
+int hv_call_add_logical_proc(int node, u32 lp_index, u32 apic_id)
+{
+	struct hv_add_logical_processor_in *input;
+	struct hv_add_logical_processor_out *output;
+	int status;
+	unsigned long flags;
+	int ret = 0;
+
+	/*
+	 * When adding a logical processor, the hypervisor may return
+	 * HV_STATUS_INSUFFICIENT_MEMORY. When that happens, we deposit more
+	 * pages and retry.
+	 */
+	do {
+		local_irq_save(flags);
+
+		input = *this_cpu_ptr(hyperv_pcpu_input_arg);
+		/* We don't do anything with the output right now */
+		output = *this_cpu_ptr(hyperv_pcpu_output_arg);
+
+		input->lp_index = lp_index;
+		input->apic_id = apic_id;
+		input->flags = 0;
+		input->proximity_domain_info.domain_id = node_to_pxm(node);
+		input->proximity_domain_info.flags.reserved = 0;
+		input->proximity_domain_info.flags.proximity_info_valid = 1;
+		input->proximity_domain_info.flags.proximity_preferred = 1;
+		status = hv_do_hypercall(HVCALL_ADD_LOGICAL_PROCESSOR,
+					 input, output);
+		local_irq_restore(flags);
+
+		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (status != HV_STATUS_SUCCESS) {
+				pr_err("%s: cpu %u apic ID %u, %d\n", __func__,
+				       lp_index, apic_id, status);
+				ret = status;
+			}
+			break;
+		}
+		ret = hv_call_deposit_pages(node, hv_current_partition_id, 1);
+	} while (!ret);
+
+	return ret;
+}
+
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags)
+{
+	struct hv_create_vp *input;
+	u16 status;
+	unsigned long irq_flags;
+	int ret = 0;
+
+	/* Root VPs don't seem to need pages deposited */
+	if (partition_id != hv_current_partition_id) {
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
+		if (node != NUMA_NO_NODE) {
+			input->proximity_domain_info.domain_id = node_to_pxm(node);
+			input->proximity_domain_info.flags.reserved = 0;
+			input->proximity_domain_info.flags.proximity_info_valid = 1;
+			input->proximity_domain_info.flags.proximity_preferred = 1;
+		} else {
+			input->proximity_domain_info.as_uint64 = 0;
+		}
+		status = hv_do_hypercall(HVCALL_CREATE_VP, input, NULL);
+		local_irq_restore(irq_flags);
+
+		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
+			if (status != HV_STATUS_SUCCESS) {
+				pr_err("%s: vcpu %u, lp %u, %d\n", __func__,
+				       vp_index, flags, status);
+				ret = status;
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
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 67f5d35a73d3..4e590a167160 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -80,6 +80,10 @@ extern void  __percpu  **hyperv_pcpu_output_arg;
 
 extern u64 hv_current_partition_id;
 
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages);
+int hv_call_add_logical_proc(int node, u32 lp_index, u32 acpi_id);
+int hv_call_create_vp(int node, u64 partition_id, u32 vp_index, u32 flags);
+
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 87b1a79b19eb..b6c74e1a5524 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -142,6 +142,8 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
 #define HVCALL_GET_PARTITION_ID			0x0046
+#define HVCALL_DEPOSIT_MEMORY			0x0048
+#define HVCALL_CREATE_VP			0x004e
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
 #define HVCALL_POST_MESSAGE			0x005c
@@ -149,6 +151,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_POST_DEBUG_DATA			0x0069
 #define HVCALL_RETRIEVE_DEBUG_DATA		0x006a
 #define HVCALL_RESET_DEBUG_SESSION		0x006b
+#define HVCALL_ADD_LOGICAL_PROCESSOR		0x0076
 #define HVCALL_RETARGET_INTERRUPT		0x007e
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
@@ -413,6 +416,70 @@ struct hv_get_partition_id {
 	u64 partition_id;
 } __packed;
 
+/* HvDepositMemory hypercall */
+struct hv_deposit_memory {
+	u64 partition_id;
+	u64 gpa_page_list[];
+} __packed;
+
+struct hv_proximity_domain_flags {
+	u32 proximity_preferred : 1;
+	u32 reserved : 30;
+	u32 proximity_info_valid : 1;
+};
+
+/* Not a union in windows but useful for zeroing */
+union hv_proximity_domain_info {
+	struct {
+		u32 domain_id;
+		struct hv_proximity_domain_flags flags;
+	};
+	u64 as_uint64;
+};
+
+struct hv_lp_startup_status {
+	u64 hv_status;
+	u64 substatus1;
+	u64 substatus2;
+	u64 substatus3;
+	u64 substatus4;
+	u64 substatus5;
+	u64 substatus6;
+};
+
+/* HvAddLogicalProcessor hypercall */
+struct hv_add_logical_processor_in {
+	u32 lp_index;
+	u32 apic_id;
+	union hv_proximity_domain_info proximity_domain_info;
+	u64 flags;
+};
+
+struct hv_add_logical_processor_out {
+	struct hv_lp_startup_status startup_status;
+};
+
+enum HV_SUBNODE_TYPE
+{
+    HvSubnodeAny = 0,
+    HvSubnodeSocket,
+    HvSubnodeAmdNode,
+    HvSubnodeL3,
+    HvSubnodeCount,
+    HvSubnodeInvalid = -1
+};
+
+/* HvCreateVp hypercall */
+struct hv_create_vp {
+	u64 partition_id;
+	u32 vp_index;
+	u8 padding[3];
+	u8 subnode_type;
+	u64 subnode_id;
+	union hv_proximity_domain_info proximity_domain_info;
+	u64 flags;
+};
+
 /* HvRetargetDeviceInterrupt hypercall */
 union hv_msi_entry {
 	u64 as_uint64;
-- 
2.20.1

