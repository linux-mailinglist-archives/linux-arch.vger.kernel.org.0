Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31FA435E2A3
	for <lists+linux-arch@lfdr.de>; Tue, 13 Apr 2021 17:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346614AbhDMPW6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Apr 2021 11:22:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346606AbhDMPW5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Apr 2021 11:22:57 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02495C061756;
        Tue, 13 Apr 2021 08:22:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m18so6192235plc.13;
        Tue, 13 Apr 2021 08:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VCvpfni3tSAbSi77TUkA2y1YbUZDkx34x/OnlYhxw8U=;
        b=pyPDZeRNv3/9hGT3aEEdsz6mRwP/c+WJs0kjqWqyIkIY1tK4D9KhsH3dOH7iKeL36E
         XGaXV7oQVP+LOfLoWINf5PxajpS2PealoJVLWr1bpNlkDjKehkYdN4zRFxy8kvZ7Q898
         we8vVaWDZKV+77egefPQU/JdC3Y8D4Zs6GO4Rsl6fJP7zQjQLGukNDd3znEdOSF9V/pe
         +twBrrMUUCiG24aeQ8cE8x+tyhhguHiFZxS5KkcIghZCWJ7L7XPdDUvdSWJUUU+HKAEG
         BXCpRG5MPapJe9hYP7r8Y1nZUz9Q3oDhT27nWC36ivFay9q1U3dRH8eG+bw1d6EjZ310
         JM1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VCvpfni3tSAbSi77TUkA2y1YbUZDkx34x/OnlYhxw8U=;
        b=a6bkuOHxCGpygzc5WLDnua4mHdgoNC9h8xXohAxdJtlIWLZUtNTyD3jugQvUyK4lYx
         OMMhY5N5w70ExDA6cdL2KzdKqUvBeAKpda3yobZQKgM/1QxNFv+x1PfHfFN6ZC0MQxVo
         G0CEQhh89FU+AAD9msY5/f5FRGXAIdbE5wzJKaLe56cm3FG1Y87tsJEVRRJJ83kDUcca
         7VV1WM0RZGGjZsonrRSg/27jirjfZnBZSE+U7283vc93H6/SsbDLcYewFszwZ3x9sP3/
         cOs0EPLZi2SG2SGkDhUjSn587os0cKtYf1arMOf2UgakKY8B9qNVmsKzD3YKRpnSIoKc
         Ux5Q==
X-Gm-Message-State: AOAM53029avRxuzkOs8YLgAUtb9UxcQDz+svz7GTxhmQBLfdd5DZ6co4
        Q5JWor+/X1Vg0CjglmWbmmF9NNsMpjDdP65e
X-Google-Smtp-Source: ABdhPJwshwP2Vy1d0/GtErGI8lfqfjravtv9Pv7BTLjsG2nbPaQjPV/Uoey4Ob6Du7L7VSut9bf6gQ==
X-Received: by 2002:a17:90b:285:: with SMTP id az5mr593051pjb.0.1618327356560;
        Tue, 13 Apr 2021 08:22:36 -0700 (PDT)
Received: from ubuntu-Virtual-Machine.corp.microsoft.com ([2001:4898:80e8:36:5b29:fe1a:45c9:c61c])
        by smtp.gmail.com with ESMTPSA id y3sm12882026pfg.145.2021.04.13.08.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 08:22:36 -0700 (PDT)
From:   Tianyu Lan <ltykernel@gmail.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, arnd@arndb.de
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, vkuznets@redhat.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com,
        sunilmut@microsoft.com
Subject: [RFC V2 PATCH 3/12] x86/Hyper-V: Add new hvcall guest address host visibility support
Date:   Tue, 13 Apr 2021 11:22:08 -0400
Message-Id: <20210413152217.3386288-4-ltykernel@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210413152217.3386288-1-ltykernel@gmail.com>
References: <20210413152217.3386288-1-ltykernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Add new hvcall guest address host visibility support. Mark vmbus
ring buffer visible to host when create gpadl buffer and mark back
to not visible when tear down gpadl buffer.

Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 arch/x86/hyperv/Makefile           |  2 +-
 arch/x86/hyperv/ivm.c              | 90 ++++++++++++++++++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h | 22 ++++++++
 arch/x86/include/asm/mshyperv.h    |  2 +
 drivers/hv/channel.c               | 34 ++++++++++-
 include/asm-generic/hyperv-tlfs.h  |  1 +
 include/linux/hyperv.h             | 12 +++-
 7 files changed, 159 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/hyperv/ivm.c

diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
index 48e2c51464e8..5d2de10809ae 100644
--- a/arch/x86/hyperv/Makefile
+++ b/arch/x86/hyperv/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-y			:= hv_init.o mmu.o nested.o irqdomain.o
+obj-y			:= hv_init.o mmu.o nested.o irqdomain.o ivm.o
 obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
 
 ifdef CONFIG_X86_64
diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
new file mode 100644
index 000000000000..a5950b7a9214
--- /dev/null
+++ b/arch/x86/hyperv/ivm.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Hyper-V Isolation VM interface with paravisor and hypervisor
+ *
+ * Author:
+ *  Tianyu Lan <Tianyu.Lan@microsoft.com>
+ */
+
+#include <linux/hyperv.h>
+#include <linux/types.h>
+#include <linux/bitfield.h>
+#include <asm/io.h>
+#include <asm/mshyperv.h>
+
+/*
+ * hv_set_mem_host_visibility - Set host visibility for specified memory.
+ */
+int hv_set_mem_host_visibility(void *kbuffer, u32 size, u32 visibility)
+{
+	int i, pfn;
+	int pagecount = size >> HV_HYP_PAGE_SHIFT;
+	u64 *pfn_array;
+	int ret = 0;
+
+	pfn_array = vzalloc(HV_HYP_PAGE_SIZE);
+	if (!pfn_array)
+		return -ENOMEM;
+
+	for (i = 0, pfn = 0; i < pagecount; i++) {
+		pfn_array[pfn] = virt_to_hvpfn(kbuffer + i * HV_HYP_PAGE_SIZE);
+		pfn++;
+
+		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
+			ret = hv_mark_gpa_visibility(pfn, pfn_array, visibility);
+			pfn = 0;
+
+			if (ret)
+				goto err_free_pfn_array;
+		}
+	}
+
+ err_free_pfn_array:
+	vfree(pfn_array);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(hv_set_mem_host_visibility);
+
+int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility)
+{
+	struct hv_input_modify_sparse_gpa_page_host_visibility **input_pcpu;
+	struct hv_input_modify_sparse_gpa_page_host_visibility *input;
+	u16 pages_processed;
+	u64 hv_status;
+	unsigned long flags;
+
+	/* no-op if partition isolation is not enabled */
+	if (!hv_is_isolation_supported())
+		return 0;
+
+	if (count > HV_MAX_MODIFY_GPA_REP_COUNT) {
+		pr_err("Hyper-V: GPA count:%d exceeds supported:%lu\n", count,
+			HV_MAX_MODIFY_GPA_REP_COUNT);
+		return -EINVAL;
+	}
+
+	local_irq_save(flags);
+	input_pcpu = (struct hv_input_modify_sparse_gpa_page_host_visibility **)
+			this_cpu_ptr(hyperv_pcpu_input_arg);
+	input = *input_pcpu;
+	if (unlikely(!input)) {
+		local_irq_restore(flags);
+		return -1;
+	}
+
+	input->partition_id = HV_PARTITION_ID_SELF;
+	input->host_visibility = visibility;
+	input->reserved0 = 0;
+	input->reserved1 = 0;
+	memcpy((void *)input->gpa_page_list, pfn, count * sizeof(*pfn));
+	hv_status = hv_do_rep_hypercall(
+			HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY, count,
+			0, input, &pages_processed);
+	local_irq_restore(flags);
+
+	if (!(hv_status & HV_HYPERCALL_RESULT_MASK))
+		return 0;
+
+	return hv_status & HV_HYPERCALL_RESULT_MASK;
+}
+EXPORT_SYMBOL(hv_mark_gpa_visibility);
diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index e6cd3fee562b..1f1ce9afb6f1 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -236,6 +236,15 @@ enum hv_isolation_type {
 /* TSC invariant control */
 #define HV_X64_MSR_TSC_INVARIANT_CONTROL	0x40000118
 
+/* Hyper-V GPA map flags */
+#define HV_MAP_GPA_PERMISSIONS_NONE            0x0
+#define HV_MAP_GPA_READABLE                    0x1
+#define HV_MAP_GPA_WRITABLE                    0x2
+
+#define VMBUS_PAGE_VISIBLE_READ_ONLY HV_MAP_GPA_READABLE
+#define VMBUS_PAGE_VISIBLE_READ_WRITE (HV_MAP_GPA_READABLE|HV_MAP_GPA_WRITABLE)
+#define VMBUS_PAGE_NOT_VISIBLE HV_MAP_GPA_PERMISSIONS_NONE
+
 /*
  * Declare the MSR used to setup pages used to communicate with the hypervisor.
  */
@@ -564,4 +573,17 @@ enum hv_interrupt_type {
 
 #include <asm-generic/hyperv-tlfs.h>
 
+/* All input parameters should be in single page. */
+#define HV_MAX_MODIFY_GPA_REP_COUNT		\
+	((PAGE_SIZE / sizeof(u64)) - 2)
+
+/* HvCallModifySparseGpaPageHostVisibility hypercall */
+struct hv_input_modify_sparse_gpa_page_host_visibility {
+	u64 partition_id;
+	u32 host_visibility:2;
+	u32 reserved0:30;
+	u32 reserved1;
+	u64 gpa_page_list[HV_MAX_MODIFY_GPA_REP_COUNT];
+} __packed;
+
 #endif
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index ccf60a809a17..d9437f096ce5 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -269,6 +269,8 @@ int hv_map_ioapic_interrupt(int ioapic_id, bool level, int vcpu, int vector,
 		struct hv_interrupt_entry *entry);
 int hv_unmap_ioapic_interrupt(int ioapic_id, struct hv_interrupt_entry *entry);
 
+int hv_set_mem_host_visibility(void *kbuffer, u32 size, u32 visibility);
+int hv_mark_gpa_visibility(u16 count, const u64 pfn[], u32 visibility);
 #else /* CONFIG_HYPERV */
 static inline void hyperv_init(void) {}
 static inline void hyperv_setup_mmu_ops(void) {}
diff --git a/drivers/hv/channel.c b/drivers/hv/channel.c
index 0bd202de7960..407b74d72f3f 100644
--- a/drivers/hv/channel.c
+++ b/drivers/hv/channel.c
@@ -400,7 +400,7 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	struct list_head *curr;
 	u32 next_gpadl_handle;
 	unsigned long flags;
-	int ret = 0;
+	int ret = 0, index;
 
 	next_gpadl_handle =
 		(atomic_inc_return(&vmbus_connection.next_gpadl_handle) - 1);
@@ -409,6 +409,13 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	if (ret)
 		return ret;
 
+	ret = hv_set_mem_host_visibility(kbuffer, size,
+					 VMBUS_PAGE_VISIBLE_READ_WRITE);
+	if (ret) {
+		pr_warn("Failed to set host visibility.\n");
+		return ret;
+	}
+
 	init_completion(&msginfo->waitevent);
 	msginfo->waiting_channel = channel;
 
@@ -484,6 +491,16 @@ static int __vmbus_establish_gpadl(struct vmbus_channel *channel,
 	}
 
 	kfree(msginfo);
+
+	if (type == HV_GPADL_BUFFER)
+		index = 0;
+	else
+		index = channel->gpadl_range[1].gpadlhandle ? 2 : 1;
+
+	channel->gpadl_range[index].size = size;
+	channel->gpadl_range[index].buffer = kbuffer;
+	channel->gpadl_range[index].gpadlhandle = *gpadl_handle;
+
 	return ret;
 }
 
@@ -743,7 +760,7 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	struct vmbus_channel_gpadl_teardown *msg;
 	struct vmbus_channel_msginfo *info;
 	unsigned long flags;
-	int ret;
+	int ret, i;
 
 	info = kzalloc(sizeof(*info) +
 		       sizeof(struct vmbus_channel_gpadl_teardown), GFP_KERNEL);
@@ -791,6 +808,19 @@ int vmbus_teardown_gpadl(struct vmbus_channel *channel, u32 gpadl_handle)
 	spin_unlock_irqrestore(&vmbus_connection.channelmsg_lock, flags);
 
 	kfree(info);
+
+	/* Find gpadl buffer virtual address and size. */
+	for (i = 0; i < VMBUS_GPADL_RANGE_COUNT; i++)
+		if (channel->gpadl_range[i].gpadlhandle == gpadl_handle)
+			break;
+
+	if (hv_set_mem_host_visibility(channel->gpadl_range[i].buffer,
+				       channel->gpadl_range[i].size,
+				       VMBUS_PAGE_NOT_VISIBLE))
+		pr_warn("Fail to set mem host visibility.\n");
+
+	channel->gpadl_range[i].gpadlhandle = 0;
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(vmbus_teardown_gpadl);
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index 83448e837ded..ad19f4199f90 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -158,6 +158,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_RETARGET_INTERRUPT		0x007e
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
 #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
+#define HVCALL_MODIFY_SPARSE_GPA_PAGE_HOST_VISIBILITY 0x00db
 
 #define HV_FLUSH_ALL_PROCESSORS			BIT(0)
 #define HV_FLUSH_ALL_VIRTUAL_ADDRESS_SPACES	BIT(1)
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index f1d74dcf0353..b877a68f326c 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -788,6 +788,14 @@ struct vmbus_device {
 	bool allowed_in_isolated;
 };
 
+struct vmbus_gpadl_range {
+	u32 gpadlhandle;
+	u32 size;
+	void *buffer;
+};
+
+#define VMBUS_GPADL_RANGE_COUNT		3
+
 struct vmbus_channel {
 	struct list_head listentry;
 
@@ -808,6 +816,8 @@ struct vmbus_channel {
 	struct completion rescind_event;
 
 	u32 ringbuffer_gpadlhandle;
+	/* GPADL_RING and Send/Receive GPADL_BUFFER. */
+	struct vmbus_gpadl_range gpadl_range[VMBUS_GPADL_RANGE_COUNT];
 
 	/* Allocated memory for ring buffer */
 	struct page *ringbuffer_page;
@@ -1182,7 +1192,7 @@ extern int vmbus_establish_gpadl(struct vmbus_channel *channel,
 				      u32 *gpadl_handle);
 
 extern int vmbus_teardown_gpadl(struct vmbus_channel *channel,
-				     u32 gpadl_handle);
+				u32 gpadl_handle);
 
 void vmbus_reset_channel_cb(struct vmbus_channel *channel);
 
-- 
2.25.1

