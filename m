Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 719212FD196
	for <lists+linux-arch@lfdr.de>; Wed, 20 Jan 2021 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731678AbhATM6W (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 20 Jan 2021 07:58:22 -0500
Received: from mail-wm1-f43.google.com ([209.85.128.43]:39362 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733306AbhATMM4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 20 Jan 2021 07:12:56 -0500
Received: by mail-wm1-f43.google.com with SMTP id u14so2629073wmq.4;
        Wed, 20 Jan 2021 04:12:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1iDJ9M4DqawewainPQ04+57YNKdB3IqMR4dCvr0jFDE=;
        b=gfyoV7Xg8EkHBarlpOmk/wQUuISx8w89AD2LzjhFHn0wa7K6i92H7aYXYs38S3eGZX
         rLjYpRMvXXBS6AdtoexFqT1qdVN49y7i9//rOXid9UVouJkeaowx4Q1GpSiyguG8m9QT
         Tc8mX/7njsl+xQMp88fGqO0Bi1uURJBUSY8aJDoF0+TfSODTdN4wIqfTMhl2xf7kKcE4
         r3DvQ6iq50iGZqu/yiqoKdTkeLcx8hhq7SeAvE2qAwwfgZIVu1r5MYVP/AdpjEIzK6FR
         D3KpO1TXq05m/Qd6yJum+D0gkjeYUhVe6q/UpE9HxdstCz6vO7G4FpZK75KMM59LfGRs
         7B9Q==
X-Gm-Message-State: AOAM530Fbfvy5ntpvlRHlVnGGXsM5c/MPKCjM6nvhejP1Txefvm9ncin
        7awCLroj2NXzFQ4yY6F9Or6Y4UYS+T0=
X-Google-Smtp-Source: ABdhPJz1eV/+3dB1z/tfOVI3Y5tzjb2xJHEReHYFHeN2Q5x4o9f+ry5NWib8LVDiOWOUHnp/5QF/WA==
X-Received: by 2002:a1c:ed0e:: with SMTP id l14mr4088722wmh.168.1611144068466;
        Wed, 20 Jan 2021 04:01:08 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id x17sm3747671wro.40.2021.01.20.04.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 04:01:08 -0800 (PST)
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
Subject: [PATCH v5 07/16] x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
Date:   Wed, 20 Jan 2021 12:00:49 +0000
Message-Id: <20210120120058.29138-8-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210120120058.29138-1-wei.liu@kernel.org>
References: <20210120120058.29138-1-wei.liu@kernel.org>
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
v3:
1. Make hv_get_partition_id static.
2. Change code structure a bit.
---
 arch/x86/hyperv/hv_init.c         | 27 +++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |  2 ++
 include/asm-generic/hyperv-tlfs.h |  6 ++++++
 3 files changed, 35 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 6f4cb40e53fe..fc9941bd8653 100644
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
 
@@ -331,6 +334,25 @@ static struct syscore_ops hv_syscore_ops = {
 	.resume		= hv_resume,
 };
 
+static void __init hv_get_partition_id(void)
+{
+	struct hv_get_partition_id *output_page;
+	u16 status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
+		HV_HYPERCALL_RESULT_MASK;
+	if (status != HV_STATUS_SUCCESS) {
+		/* No point in proceeding if this failed */
+		pr_err("Failed to get partition ID: %d\n", status);
+		BUG();
+	}
+	hv_current_partition_id = output_page->partition_id;
+	local_irq_restore(flags);
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -426,6 +448,11 @@ void __init hyperv_init(void)
 
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

