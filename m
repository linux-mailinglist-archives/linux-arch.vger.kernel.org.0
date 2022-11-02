Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97B16616433
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 15:00:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbiKBOAh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 10:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbiKBOA3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 10:00:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C6C92BE3C;
        Wed,  2 Nov 2022 07:00:27 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id C243E205DA23;
        Wed,  2 Nov 2022 07:00:23 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C243E205DA23
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667397627;
        bh=/YZWZdxfDMb1xs+CDsX06JFCs/GpFoJjAs73k7p3+Og=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bn4BiivzKpICql1DRkRPma0jcs03pY5eWa72Q75lZYcmUzMKxNnrN1Rz9LCbjk6Ae
         fxKefwazsuKiKUnqlk5w//DLflNt93gCkhdM8hr/iuep0lQcoqFj9lCsULefELjRcc
         +gRd5NcFanIWF01Q0+Q4BjJj68klyDug7NZdU01I=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 1/6] mshv: Add support for detecting nested hypervisor
Date:   Wed,  2 Nov 2022 14:00:12 +0000
Message-Id: <8f7173a7454f0a87d9bc0afccf9857851a804901.1667394408.git.jinankjain@microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667394408.git.jinankjain@microsoft.com>
References: <cover.1667394408.git.jinankjain@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
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
 arch/x86/kernel/cpu/mshyperv.c     | 7 +++++++
 include/asm-generic/mshyperv.h     | 2 ++
 3 files changed, 12 insertions(+)

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
 
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 831613959a92..2555535f5237 100644
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
+		pr_info("Hyper-V: Linux running on a nested hypervisor\n");
+	}
+
 	/*
 	 * Extract host information.
 	 */
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index bfb9eb9d7215..49d2e9274379 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -115,6 +115,8 @@ static inline u64 hv_generate_guest_id(u64 kernel_version)
 	return guest_id;
 }
 
+extern bool hv_nested;
+
 /* Free the message slot and signal end-of-message if required */
 static inline void vmbus_signal_eom(struct hv_message *msg, u32 old_msg_type)
 {
-- 
2.25.1

