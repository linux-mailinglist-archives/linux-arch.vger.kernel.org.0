Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2830DDA4
	for <lists+linux-arch@lfdr.de>; Wed,  3 Feb 2021 16:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233608AbhBCPH0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 3 Feb 2021 10:07:26 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41]:53250 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233715AbhBCPF1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 3 Feb 2021 10:05:27 -0500
Received: by mail-wm1-f41.google.com with SMTP id j11so5040629wmi.3;
        Wed, 03 Feb 2021 07:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JiwT4d0c2plrVyKu6A/BaptRRdXcWB3JWI+1E/5miWg=;
        b=XqjIxVMZGFej2yQsBuxAFahzHTGmLV3id56PqIUWVKtx5yfpqVPxLRiVesEMpROSDt
         TXnxS2t9dm6pailZ9Z2fiDRb4w+1v7eWk7YkIb5d5FXgR8LcybX26lk1x4DuYC8oHlzi
         JvcxbqQ7ryFGsR5c+e/JtPh199oKNVXgwSW3hTjfN88cbt4NThkBgWsC2uNcOlsX1YkE
         heQxuEFTGeNsB8iR46LiKb3lK+CMvAJlGeXmDeg6LeIev0zTkNCObMQweiA/zIrBbvgh
         TyI5eylyqbjcjyoPGTJtVxqIaLC6f1jat9sFftDn5UfarzIVROGPm0vHXpWWDgBXD9jO
         YGmQ==
X-Gm-Message-State: AOAM532s4tHwwVz6DsP2XBH9BL2buA5Vhk5Ml+x8AC5PbMqiznTuP/ws
        INIbkoQoE9OcB4NjxpaKSvlKdxam7lE=
X-Google-Smtp-Source: ABdhPJyfYtbRF5b8CBDm3yPwTP0j1ztzfdrzk+Xrh7VqAD2ZOb3QQ+rsFTeq/8OkJxrWjdAqAmbm8g==
X-Received: by 2002:a1c:2d0b:: with SMTP id t11mr3141343wmt.109.1612364683500;
        Wed, 03 Feb 2021 07:04:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id r17sm4051704wro.46.2021.02.03.07.04.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 07:04:43 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Lillian Grassin-Drake <ligrassi@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org (open list:GENERIC INCLUDE/ASM HEADER FILES)
Subject: [PATCH v6 06/16] x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
Date:   Wed,  3 Feb 2021 15:04:25 +0000
Message-Id: <20210203150435.27941-7-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210203150435.27941-1-wei.liu@kernel.org>
References: <20210203150435.27941-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

We will need the partition ID for executing some hypercalls later.

Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v6:
1. Use u64 status.

v3:
1. Make hv_get_partition_id static.
2. Change code structure a bit.
---
 arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |  2 ++
 include/asm-generic/hyperv-tlfs.h |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6f4cb40e53fe..5b90a7290177 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -26,6 +26,9 @@
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 
+u64 hv_current_partition_id = ~0ull;
+EXPORT_SYMBOL_GPL(hv_current_partition_id);
+
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
@@ -331,6 +334,24 @@ static struct syscore_ops hv_syscore_ops = {
 	.resume		= hv_resume,
 };
 
+static void __init hv_get_partition_id(void)
+{
+	struct hv_get_partition_id *output_page;
+	u64 status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page);
+	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS) {
+		/* No point in proceeding if this failed */
+		pr_err("Failed to get partition ID: %lld\n", status);
+		BUG();
+	}
+	hv_current_partition_id = output_page->partition_id;
+	local_irq_restore(flags);
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -426,6 +447,11 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
+	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
+		hv_get_partition_id();
+
+	BUG_ON(hv_root_partition && hv_current_partition_id == ~0ull);
+
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 62d9390f1ddf..67f5d35a73d3 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -78,6 +78,8 @@ extern void *hv_hypercall_pg;
 extern void  __percpu  **hyperv_pcpu_input_arg;
 extern void  __percpu  **hyperv_pcpu_output_arg;
 
+extern u64 hv_current_partition_id;
+
 static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
 {
 	u64 input_address = input ? virt_to_phys(input) : 0;
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index e6903589a82a..87b1a79b19eb 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -141,6 +141,7 @@ struct ms_hyperv_tsc_page {
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_SPACE_EX	0x0013
 #define HVCALL_FLUSH_VIRTUAL_ADDRESS_LIST_EX	0x0014
 #define HVCALL_SEND_IPI_EX			0x0015
+#define HVCALL_GET_PARTITION_ID			0x0046
 #define HVCALL_GET_VP_REGISTERS			0x0050
 #define HVCALL_SET_VP_REGISTERS			0x0051
 #define HVCALL_POST_MESSAGE			0x005c
@@ -407,6 +408,11 @@ struct hv_tlb_flush_ex {
 	u64 gva_list[];
 } __packed;
 
+/* HvGetPartitionId hypercall (output only) */
+struct hv_get_partition_id {
+	u64 partition_id;
+} __packed;
+
 /* HvRetargetDeviceInterrupt hypercall */
 union hv_msi_entry {
 	u64 as_uint64;
-- 
2.20.1

