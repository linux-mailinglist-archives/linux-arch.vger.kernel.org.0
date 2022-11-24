Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6C41637229
	for <lists+linux-arch@lfdr.de>; Thu, 24 Nov 2022 07:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiKXGCY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 24 Nov 2022 01:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiKXGCW (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 24 Nov 2022 01:02:22 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EFD96C7222;
        Wed, 23 Nov 2022 22:02:21 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3F45020B83CB;
        Wed, 23 Nov 2022 22:02:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3F45020B83CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1669269741;
        bh=URaETM0X98/Nxpa8Blvr2XLRxJkzLP12K+95AYQ8A54=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IvuS3BVv9gcJCq5wOI/zb4MGw8kjdnzgEAUhPU2qSSNWs6QRNqNQHwCrayoEYAq2w
         K/QJ8O2wKw3aHU0ah3HNEVblmQwNfT2rgAX9wyKqdWtsykLuibGSV9WMB+Zh6sKMeJ
         zFu1uVOYIdwPsrZW1ni6kYdSyCbOpJ0+EK99Dqlw=
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
Subject: [PATCH v6 1/5] x86/hyperv: Add support for detecting nested hypervisor
Date:   Thu, 24 Nov 2022 06:02:06 +0000
Message-Id: <76e16159610f665c279259672d03c1ce4e52bd62.1669269377.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1669269377.git.jinankjain@linux.microsoft.com>
References: <cover.1669269377.git.jinankjain@linux.microsoft.com>
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

Detect if Linux is running as a nested hypervisor in the root
partition for Microsoft Hypervisor, using flags provided by MSHV.
Expose a new variable hv_nested that is used later for decisions
specific to the nested use case.

Signed-off-by: Jinank Jain <jinankjain@linux.microsoft.com>
---
 arch/x86/include/asm/hyperv-tlfs.h | 3 +++
 arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
 drivers/hv/hv_common.c             | 9 ++++++---
 include/asm-generic/mshyperv.h     | 1 +
 4 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
index 6d9368ea3701..58c03d18c235 100644
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
index ae68298c0dca..52a6f89ccdbd 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -25,17 +25,20 @@
 #include <asm/mshyperv.h>
 
 /*
- * hv_root_partition and ms_hyperv are defined here with other Hyper-V
- * specific globals so they are shared across all architectures and are
+ * hv_root_partition, ms_hyperv and hv_nested are defined here with other
+ * Hyper-V specific globals so they are shared across all architectures and are
  * built only when CONFIG_HYPERV is defined.  But on x86,
  * ms_hyperv_init_platform() is built even when CONFIG_HYPERV is not
- * defined, and it uses these two variables.  So mark them as __weak
+ * defined, and it uses these three variables.  So mark them as __weak
  * here, allowing for an overriding definition in the module containing
  * ms_hyperv_init_platform().
  */
 bool __weak hv_root_partition;
 EXPORT_SYMBOL_GPL(hv_root_partition);
 
+bool __weak hv_nested;
+EXPORT_SYMBOL_GPL(hv_nested);
+
 struct ms_hyperv_info __weak ms_hyperv;
 EXPORT_SYMBOL_GPL(ms_hyperv);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bfb9eb9d7215..5df6e944e6a9 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -164,6 +164,7 @@ extern int vmbus_interrupt;
 extern int vmbus_irq;
 
 extern bool hv_root_partition;
+extern bool hv_nested;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 /*
-- 
2.25.1

