Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2ED761695F
	for <lists+linux-arch@lfdr.de>; Wed,  2 Nov 2022 17:41:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiKBQl3 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 2 Nov 2022 12:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231209AbiKBQk5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 2 Nov 2022 12:40:57 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B72D22ED65;
        Wed,  2 Nov 2022 09:36:12 -0700 (PDT)
Received: from jinankjain-dranzer.zrrkmle5drku1h0apvxbr2u2ee.ix.internal.cloudapp.net (unknown [20.188.121.5])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8C23D20C28BD;
        Wed,  2 Nov 2022 09:36:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8C23D20C28BD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667406972;
        bh=oW+0gwVBEPgjicK1Au5RL8r3QijDOXjFhJUc9gdVX18=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KBNLn/UxImLyYQaCXoVZ1wFrGLXg2bT+PKX6p+TRyOPjFbpW2Y2X2CtVdcMuBk15A
         MVB8xCRUd9jvg23ifU5s1XZ90oLgx04F8+kJ8W845y0FzC/9DVVpixxk4dPo3JRuPN
         5BXeOrwBkoXkV5KOU+w8ICezSIVB5yhutNDKuV8Q=
From:   Jinank Jain <jinankjain@linux.microsoft.com>
To:     jinankjain@microsoft.com
Cc:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, arnd@arndb.de, peterz@infradead.org,
        jpoimboe@kernel.org, jinankjain@linux.microsoft.com,
        seanjc@google.com, kirill.shutemov@linux.intel.com,
        ak@linux.intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH v2 1/5] mshv: Add support for detecting nested hypervisor
Date:   Wed,  2 Nov 2022 16:35:58 +0000
Message-Id: <4200eb3ffd5453cc9c9812b05283f6c2d6a6bef5.1667406350.git.jinankjain@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1667406350.git.jinankjain@linux.microsoft.com>
References: <cover.1667406350.git.jinankjain@linux.microsoft.com>
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
 
diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 61f0c206bff0..29388567eafd 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -190,6 +190,8 @@ static inline void hv_ghcb_terminate(unsigned int set, unsigned int reason) {}
 
 extern bool hv_isolation_type_snp(void);
 
+extern bool hv_nested;
+
 static inline bool hv_is_synic_reg(unsigned int reg)
 {
 	if ((reg >= HV_REGISTER_SCONTROL) &&
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
-- 
2.25.1

