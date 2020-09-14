Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 430DE268A39
	for <lists+linux-arch@lfdr.de>; Mon, 14 Sep 2020 13:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726087AbgINLjD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Sep 2020 07:39:03 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35465 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgINL2T (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Sep 2020 07:28:19 -0400
Received: by mail-wm1-f67.google.com with SMTP id y15so10878835wmi.0;
        Mon, 14 Sep 2020 04:28:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E5gZOMWCKMKk580URxqoyALVdSaE1aGhUW3u1REOZ5I=;
        b=BAHxS0o4OZM0oSO1wdCh0WLt0MEpSJ6IZ0/KCekxDnWWm2wX66klMlx+KItPPg2u+C
         fRCSBdS63aNnWO3E2nVLiqMlZ7JU4CBqsVYkuCSMx9NnPR5YXvedmLb5kpYwrCLYapS6
         109MpxtClbqnvKhcyhPogj8wMVBjOcHSPDlSnWuhv06ALng8y1HhVCtqjgWJpP8YZ7eB
         L3yP3VOIiPZcJbU6dPW8Y3+CXkymCRLf1oBzcgcmmYWt/72KHX5zl17qVvVoMPphZkHu
         Lk+ncwPCnlWor6A2wjzfbKmknIv4BlDQCRJybm+EPQBRuCwrLMFYtITAODMMgUNABDF5
         9okw==
X-Gm-Message-State: AOAM5339BSYGu//WVGq+JGqw4XVdfJSSJEAjea+YSEUlCrTmfU1XWadr
        FbkZRMhzFizPAsE+/VRwvYc7pTmG9EY=
X-Google-Smtp-Source: ABdhPJyLH9akdmKsMw9n3pT4HKtXuSpu5lR8A6RNMOd9JnBbyvoEOL+Sr6ZvZFG4SHsB3dL2Fye3xg==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr15239917wmi.56.1600082896796;
        Mon, 14 Sep 2020 04:28:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id s12sm12024606wmd.20.2020.09.14.04.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:28:16 -0700 (PDT)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nudasnev@microsoft.com>,
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
Subject: [PATCH RFC v1 07/18] x86/hyperv: extract partition ID from Microsoft Hypervisor if necessary
Date:   Mon, 14 Sep 2020 11:27:51 +0000
Message-Id: <20200914112802.80611-8-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200914112802.80611-1-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
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
index ebba4be4185d..0eec1ed32023 100644
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
 
@@ -345,6 +348,26 @@ static struct syscore_ops hv_syscore_ops = {
 	.resume		= hv_resume,
 };
 
+void __init hv_get_partition_id(void)
+{
+	struct hv_get_partition_id *output_page;
+	int status;
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
@@ -440,6 +463,9 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
+	if (hv_root_partition)
+		hv_get_partition_id();
+
 	return;
 
 remove_cpuhp_state:
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index f5c62140f28d..4039302e0ae9 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -65,6 +65,8 @@ extern void *hv_hypercall_pg;
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

