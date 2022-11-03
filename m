Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57065617D69
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 14:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiKCNF2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 09:05:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiKCNFL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 09:05:11 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F358417E32;
        Thu,  3 Nov 2022 06:04:17 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id A0E09205DA2F;
        Thu,  3 Nov 2022 06:04:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0E09205DA2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667480657;
        bh=HLgBEfqnfR/pSo3ZddLSeTCBJ4DSAnSoOy6+9I7tDbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tInIXzvZ5DLoKnJIuYBKNbwTa4rSOgbayfk53bVeJyTmK26j7jjfnGAuzBxv2YiR3
         3bR2rI8U/yG2dnJxzMBLwr9g16xnc4PWetTLiDM7QG3jRbkJ74Y8vyLLuUnPG8a2Li
         Q6dVE3ZkxlJuz+jLcNIFgwtwwh1m1xPSVqTTNfPs=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, anrayabh@linux.microsoft.com,
        mikelley@microsoft.com
Subject: [PATCH v3 1/5] x86/hyperv: Add support for detecting nested hypervisor
Date:   Thu,  3 Nov 2022 13:04:03 +0000
Message-Id: <285b15b90ac6f29ef8ab6b6ececeeef7d7c6f380.1667480257.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667480257.git.jinankjain@linux.microsoft.com>
References: <cover.1667480257.git.jinankjain@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

When Linux runs as a root partition for Microsoft Hypervisor. It is
possible to detect if it is running as nested hypervisor using
hints exposed by mshv. While at it expose a new variable called
hv_nested which can be used later for making decisions specific to
nested use case.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 3 +++
 arch/x86/include/asm/mshyperv.h    | 2 ++
 arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
 drivers/hv/hv_common.c             | 7 +++++--
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 3089ec352743..d9a611565859 100644
--- a/arch/x86/include/asm/hyperv-tlfs.h
+++ b/arch/x86/include/asm/hyperv-tlfs.h
@@ -114,6 +114,9 @@
 /* Recommend using the newer ExProcessorMasks interface */
 #define HV_X64_EX_PROCESSOR_MASKS_RECOMMENDED		BIT(11)
 
+/* Indicates that the hypervisor is nested within a Hyper-V partition. */
+#define HV_X64_HYPERV_NESTED				BIT(12)
+
 /* Recommend using enlightened VMCS */
 #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..3c39923e5969 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -26,6 +26,8 @@ void hyperv_vector_handler(struct pt_regs *regs);
 #if IS_ENABLED(CONFIG_HYPERV)
 extern int hyperv_init_cpuhp;
 
+extern bool hv_nested;
+
 extern void *hv_hypercall_pg;
 
 extern u64 hv_current_partition_id;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..9a4204139490 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -37,6 +37,8 @@
 
 /* Is Linux running as the root partition? */
 bool hv_root_partition;
+/* Is Linux running on nested Microsoft Hypervisor */
+bool hv_nested;
 struct ms_hyperv_info ms_hyperv;
 
 #if IS_ENABLED(CONFIG_HYPERV)
@@ -301,6 +303,11 @@ static void __init ms_hyperv_init_platform(void)
 		pr_info("Hyper-V: running as root partition\n");
 	}
 
+	if (ms_hyperv.hints & HV_X64_HYPERV_NESTED) {
+		hv_nested = true;
+		pr_info("Hyper-V: running on a nested hypervisor\n");
+	}
+
 	/*
 	 * Extract host information.
 	 */
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index ae68298c0dca..dcb336ce374f 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -25,8 +25,8 @@
 #include <asm/mshyperv.h>
 
 /*
- * hv_root_partition and ms_hyperv are defined here with other Hyper-V
- * specific globals so they are shared across all architectures and are
+ * hv_root_partition, ms_hyperv and hv_nested are defined here with other
+ * Hyper-V specific globals so they are shared across all architectures and are
  * built only when CONFIG_HYPERV is defined.  But on x86,
  * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
  * defined, and it uses these two variables.  So mark them as __weak
@@ -36,6 +36,9 @@
 bool __weak hv_root_partition;
 EXPORT_SYMBOL_GPL(hv_root_partition);
 
+bool __weak hv_nested;
+EXPORT_SYMBOL_GPL(hv_nested);
+
 struct ms_hyperv_info __weak ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
-- 
2.25.1

