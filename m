Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440047B3964
	for <lists+linux-arch@lfdr.de>; Fri, 29 Sep 2023 20:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233580AbjI2SCL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 29 Sep 2023 14:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233842AbjI2SCF (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 29 Sep 2023 14:02:05 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA8B3CC5;
        Fri, 29 Sep 2023 11:01:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B34DE20B74C7;
        Fri, 29 Sep 2023 11:01:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B34DE20B74C7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1696010516;
        bh=mZwLSbCtRB1ZVGaw+v19Hz/DrAEqrivEKsuObnviiIg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O0XGRVMMXkFI3fCV0Bztc7nO0xVF4U46C3syNqi/O1mdSlpp0Ho3tb1cBuMOBrzSk
         3kcyWVa98z6DNGGSkUWgTuRvoZ/0RpN7nXHteHIlX4ehvvOJ86OH1mxsyRXFUgryFu
         DntgIgf4DPROf0Lx/YNIjmwKqvpn3H7Zq/ktvWuM=
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
Subject: [PATCH v4 04/15] asm-generic/mshyperv: Introduce hv_recommend_using_aeoi()
Date:   Fri, 29 Sep 2023 11:01:30 -0700
Message-Id: <1696010501-24584-5-git-send-email-nunodasneves@linux.microsoft.com>
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

Factor out logic for determining if we should set the auto eoi flag in SINT
register.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
---
 drivers/hv/hv.c                | 12 +-----------
 include/asm-generic/mshyperv.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index 5ea104c61fa7..d7869205dcbe 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -315,17 +315,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 
 	shared_sint.vector = vmbus_interrupt;
 	shared_sint.masked = false;
-
-	/*
-	 * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
-	 * it doesn't provide a recommendation flag and AEOI must be disabled.
-	 */
-#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
-	shared_sint.auto_eoi =
-			!(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
-#else
-	shared_sint.auto_eoi = 0;
-#endif
+	shared_sint.auto_eoi = hv_recommend_using_aeoi();
 	hv_set_register(HV_MSR_SINT0 + VMBUS_MESSAGE_SINT,
 			shared_sint.as_uint64);
 
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index 8cc7b0e316d7..3e715aa114da 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -82,6 +82,19 @@ extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 bool hv_isolation_type_snp(void);
 bool hv_isolation_type_tdx(void);
 
+/*
+ * On architectures where Hyper-V doesn't support AEOI (e.g., ARM64),
+ * it doesn't provide a recommendation flag and AEOI must be disabled.
+ */
+static inline bool hv_recommend_using_aeoi(void)
+{
+#ifdef HV_DEPRECATING_AEOI_RECOMMENDED
+	return !(ms_hyperv.hints & HV_DEPRECATING_AEOI_RECOMMENDED);
+#else
+	return false;
+#endif
+}
+
 /* Helper functions that provide a consistent pattern for checking Hyper-V hypercall status. */
 static inline int hv_result(u64 status)
 {
-- 
2.25.1

