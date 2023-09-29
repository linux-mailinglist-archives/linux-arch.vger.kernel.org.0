Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06E5E7B3966
	for <lists+linux-arch@lfdr.de>; Fri, 29 Sep 2023 20:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjI2SCM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Sep 2023 14:02:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjI2SCG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2023 14:02:06 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7224ECC3;
        Fri, 29 Sep 2023 11:01:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7B99420B74C4;
        Fri, 29 Sep 2023 11:01:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7B99420B74C4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696010516;
        bh=/7m+y8jCPpzPX/lKoISXVPs2wgZhEYzypUg762MOLQ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pSsvhPR7/qyaL67JMveYeSAuUeHhFMzs9Vf1cjwydXBUyiRjs+AnatVUCokAYomRA
         Eqljn3TmtoPzmJkEz46RKZ+DEnp4k2DoOp1dLUZunEjSbukuLwjE3DeRpJh2ACvFjl
         Jj1giraKEJfWvBwafjRmYxqEQaC38ALuDr6FAKYg=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     patches@lists.linux.dev, mikelley@microsoft.com, kys@microsoft.com,
        wei.liu@kernel.org, gregkh@linuxfoundation.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH v4 02/15] mshyperv: Introduce hv_get_hypervisor_version function
Date:   Fri, 29 Sep 2023 11:01:28 -0700
Message-Id: <1696010501-24584-3-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

x86_64 and arm64 implementations to get the hypervisor version
information. Store these in hv_hypervisor_version_info structure to
simplify parsing the fields.

Replace the existing parsing when printing the version numbers at boot.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Acked-by: Wei Liu <wei.liu@kernel.org>
---
 arch/arm64/hyperv/mshyperv.c      | 23 +++++++++++++-------
 arch/x86/kernel/cpu/mshyperv.c    | 36 +++++++++++++++++++------------
 include/asm-generic/hyperv-tlfs.h | 23 ++++++++++++++++++++
 include/asm-generic/mshyperv.h    |  2 ++
 4 files changed, 62 insertions(+), 22 deletions(-)

diff --git a/arch/arm64/hyperv/mshyperv.c b/arch/arm64/hyperv/mshyperv.c
index f1b8a04ee9f2..53bdd3bc81ac 100644
--- a/arch/arm64/hyperv/mshyperv.c
+++ b/arch/arm64/hyperv/mshyperv.c
@@ -19,10 +19,19 @@
 
 static bool hyperv_initialized;
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
+{
+	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION,
+			 (struct hv_get_vp_registers_output *)info);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
+
 static int __init hyperv_init(void)
 {
-	struct hv_get_vp_registers_output	result;
-	u32	a, b, c, d;
+	struct hv_get_vp_registers_output result;
+	union hv_hypervisor_version_info version;
 	u64	guest_id;
 	int	ret;
 
@@ -55,13 +64,11 @@ static int __init hyperv_init(void)
 		ms_hyperv.misc_features);
 
 	/* Get information about the Hyper-V host version */
-	hv_get_vpreg_128(HV_REGISTER_HYPERVISOR_VERSION, &result);
-	a = result.as32.a;
-	b = result.as32.b;
-	c = result.as32.c;
-	d = result.as32.d;
+	hv_get_hypervisor_version(&version);
 	pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
-		b >> 16, b & 0xFFFF, a,	d & 0xFFFFFF, c, d >> 24);
+		version.major_version, version.minor_version,
+		version.build_number, version.service_number,
+		version.service_pack, version.service_branch);
 
 	ret = hv_common_init();
 	if (ret)
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d85a8e2a10c9..9b898b65a013 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -347,13 +347,26 @@ static void __init reduced_hw_init(void)
 	x86_init.irqs.pre_vector_init	= x86_init_noop;
 }
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info)
+{
+	unsigned int hv_max_functions;
+
+	hv_max_functions = cpuid_eax(HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS);
+	if (hv_max_functions < HYPERV_CPUID_VERSION) {
+		pr_err("%s: Could not detect Hyper-V version\n", __func__);
+		return -ENODEV;
+	}
+
+	cpuid(HYPERV_CPUID_VERSION, &info->eax, &info->ebx, &info->ecx, &info->edx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(hv_get_hypervisor_version);
+
 static void __init ms_hyperv_init_platform(void)
 {
 	int hv_max_functions_eax;
-	int hv_host_info_eax;
-	int hv_host_info_ebx;
-	int hv_host_info_ecx;
-	int hv_host_info_edx;
+	union hv_hypervisor_version_info version;
 
 #ifdef CONFIG_PARAVIRT
 	pv_info.name = "Hyper-V";
@@ -407,16 +420,11 @@ static void __init ms_hyperv_init_platform(void)
 	/*
 	 * Extract host information.
 	 */
-	if (hv_max_functions_eax >= HYPERV_CPUID_VERSION) {
-		hv_host_info_eax = cpuid_eax(HYPERV_CPUID_VERSION);
-		hv_host_info_ebx = cpuid_ebx(HYPERV_CPUID_VERSION);
-		hv_host_info_ecx = cpuid_ecx(HYPERV_CPUID_VERSION);
-		hv_host_info_edx = cpuid_edx(HYPERV_CPUID_VERSION);
-
-		pr_info("Hyper-V: Host Build %d.%d.%d.%d-%d-%d\n",
-			hv_host_info_ebx >> 16, hv_host_info_ebx & 0xFFFF,
-			hv_host_info_eax, hv_host_info_edx & 0xFFFFFF,
-			hv_host_info_ecx, hv_host_info_edx >> 24);
+	if (hv_get_hypervisor_version(&version) == 0) {
+		pr_info("Hyper-V Host Build:%d-%d.%d-%d-%d.%d\n",
+			version.build_number, version.major_version,
+			version.minor_version, version.service_pack,
+			version.service_branch, version.service_number);
 	}
 
 	if (ms_hyperv.features & HV_ACCESS_FREQUENCY_MSRS &&
diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
index fdac4a1714ec..f63b3704d89e 100644
--- a/include/asm-generic/hyperv-tlfs.h
+++ b/include/asm-generic/hyperv-tlfs.h
@@ -787,6 +787,29 @@ struct hv_input_unmap_device_interrupt {
 #define HV_SOURCE_SHADOW_NONE               0x0
 #define HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE   0x1
 
+/*
+ * Version info reported by hypervisor
+ */
+union hv_hypervisor_version_info {
+	struct {
+		u32 build_number;
+
+		u32 minor_version : 16;
+		u32 major_version : 16;
+
+		u32 service_pack;
+
+		u32 service_number : 24;
+		u32 service_branch : 8;
+	};
+	struct {
+		u32 eax;
+		u32 ebx;
+		u32 ecx;
+		u32 edx;
+	};
+};
+
 /*
  * The whole argument should fit in a page to be able to pass to the hypervisor
  * in one hypercall.
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 56f4a447a178..9f2c06c9d5d1 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -161,6 +161,8 @@ static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 	}
 }
 
+int hv_get_hypervisor_version(union hv_hypervisor_version_info *info);
+
 void hv_setup_vmbus_handler(void (*handler)(void));
 void hv_remove_vmbus_handler(void);
 void hv_setup_stimer0_handler(void (*handler)(void));
-- 
2.25.1

