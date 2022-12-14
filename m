Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBFD64C3D4
	for <lists+linux-arch@lfdr.de>; Wed, 14 Dec 2022 07:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237315AbiLNGdY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 14 Dec 2022 01:33:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237292AbiLNGdQ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 14 Dec 2022 01:33:16 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 61CC522520;
        Tue, 13 Dec 2022 22:33:15 -0800 (PST)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id E611020B876B;
        Tue, 13 Dec 2022 22:33:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E611020B876B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1670999595;
        bh=wqo8SKjqAvAPfB0JD2Zy4udGVJ0BdIhQjoIMI1f64Wg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T/xMU7jz0GvhafbpTruR4rLGOFRhr2naJpNsxxKiqsG+I66pm7rY9HV1v1rSHiLqU
         L0W3/jfFC9KV5X1GW1bPxgP+sFHrHb0nJqePAWQhFarx/trzPQKDjcxo/dIgSyIQtn
         Sn2q3OKBQgNE5QPXoHzVTpG/IIFoWSp7Eqdo1fIg=
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
Subject: [PATCH v9 1/5] x86/hyperv: Add support for detecting nested hypervisor
Date:   Wed, 14 Dec 2022 06:33:00 +0000
Message-Id: <8e3e7112806e81d2292a66a56fe547162754ecea.1670749201.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1670749201.git.jinankjain@linux.microsoft.com>
References: <cover.1670749201.git.jinankjain@linux.microsoft.com>
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
index 46668e255421..f9b78d4829e3 100644
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
index bfb9eb9d7215..f131027830c3 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -48,6 +48,7 @@ struct ms_hyperv_info {
 	u64 shared_gpa_boundary;
 };
 extern struct ms_hyperv_info ms_hyperv;
+extern bool hv_nested;
 
 extern void * __percpu *hyperv_pcpu_input_arg;
 extern void * __percpu *hyperv_pcpu_output_arg;
-- 
2.25.1

