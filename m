Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0CF2A844C
	for <lists+linux-arch@lfdr.de>; Thu,  5 Nov 2020 17:59:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731735AbgKEQ61 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Nov 2020 11:58:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45980 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730174AbgKEQ60 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Nov 2020 11:58:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id p1so2576341wrf.12;
        Thu, 05 Nov 2020 08:58:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lc9Ih+aBOUIcyg/pc4PzDWU6F5HLqSVXvBtWicqQZLQ=;
        b=AxJIgaj8zcOC1XPNXQ5lLcbVTO4mMH8EsJ0dyCr4Ie3ndV4RDCr1dox+rXHhpCpwfW
         kXurxPH5SrGv0p/m8rRsIlLlRDb5xcV54ZjFlwUcKeKDuQp5fw2Oxlw8uzhkzW8aRjgj
         jEY9LaTo+ABXVlKfgmdL75N5mymCr6W+qYwiPexyoFkw5476oJiVOpQY/+XaHQraLTju
         KodNutYtanxfRg9M1s7/iHOHKecL1rBug5xZlhVqyXd8OvtbitbPL2fI/NjZV6sF9Qk3
         FYEmuX4QjEziTxWhIDFKkgfIfZMhZ0ZVSsgNE1AHu6zxCXFGL9cbFIY0Rnpcz08h7mHe
         qUXw==
X-Gm-Message-State: AOAM531a0apTP3kera/DBGt7q4/C5z1bs3NSo6nVrKKpIUN06YdIqVhA
        6yzJtu1E879kBiUJp7l9HUqw5cZXC0k=
X-Google-Smtp-Source: ABdhPJyOUZNa+lay5gs3PR3kYDl/Kc1uFywqQBMwfD5IqygRpbX5bv8wcV0eQ4KJ/Pt+ROquaQ7fBw==
X-Received: by 2002:adf:c847:: with SMTP id e7mr4091644wrh.346.1604595504429;
        Thu, 05 Nov 2020 08:58:24 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z5sm3350729wrw.87.2020.11.05.08.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:58:24 -0800 (PST)
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
Subject: [PATCH v2 07/17] x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
Date:   Thu,  5 Nov 2020 16:58:04 +0000
Message-Id: <20201105165814.29233-8-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201105165814.29233-1-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
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
 arch/x86/hyperv/hv_init.c         | 26 ++++++++++++++++++++++++++
 arch/x86/include/asm/mshyperv.h   |  2 ++
 include/asm-generic/hyperv-tlfs.h |  6 ++++++
 3 files changed, 34 insertions(+)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 7a2e37f025b0..73b0fb851f76 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -30,6 +30,9 @@
 bool hv_root_partition;
 EXPORT_SYMBOL_GPL(hv_root_partition);
 
+u64 hv_current_partition_id;
+EXPORT_SYMBOL_GPL(hv_current_partition_id);
+
 void *hv_hypercall_pg;
 EXPORT_SYMBOL_GPL(hv_hypercall_pg);
 
@@ -335,6 +338,26 @@ static struct syscore_ops hv_syscore_ops = {
 	.resume		= hv_resume,
 };
 
+void __init hv_get_partition_id(void)
+{
+	struct hv_get_partition_id *output_page;
+	u16 status;
+	unsigned long flags;
+
+	local_irq_save(flags);
+	output_page = *this_cpu_ptr(hyperv_pcpu_output_arg);
+	status = hv_do_hypercall(HVCALL_GET_PARTITION_ID, NULL, output_page) &
+		HV_HYPERCALL_RESULT_MASK;
+	if (status != HV_STATUS_SUCCESS)
+		pr_err("Failed to get partition ID: %d\n", status);
+	else
+		hv_current_partition_id = output_page->partition_id;
+	local_irq_restore(flags);
+
+	/* No point in proceeding if this failed */
+	BUG_ON(status != HV_STATUS_SUCCESS);
+}
+
 /*
  * This function is to be invoked early in the boot sequence after the
  * hypervisor has been detected.
@@ -430,6 +453,9 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
+	if (hv_root_partition)
+		hv_get_partition_id();
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

