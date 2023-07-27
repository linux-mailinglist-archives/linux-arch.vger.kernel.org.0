Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A292765C7D
	for <lists+linux-arch@lfdr.de>; Thu, 27 Jul 2023 21:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjG0TzC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 27 Jul 2023 15:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbjG0Ty7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 27 Jul 2023 15:54:59 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 57A3E30CA;
        Thu, 27 Jul 2023 12:54:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id C58042383ECB;
        Thu, 27 Jul 2023 12:54:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C58042383ECB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690487696;
        bh=74cerE47LViHpGSOEG683htQjcSrM81CVEYVeue49d8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UUTklpCArQXKpCTvY9tpDIQL+I3r4jExFcVxpN5srxuHmYdiVB31RKS6i05a6FdFe
         g0V9JBNV1eD513ONcQ5kT2idJWi3Tn6NrHDYh2IqxfeodBh+7+cHZUZRacShzqBTMK
         u7l29JWMHeFkFQYL6oQv0ZgLmT16RLYFW4+X4+98=
From:   Nuno Das Neves <nunodasneves@linux.microsoft.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-arch@vger.kernel.org
Cc:     mikelley@microsoft.com, kys@microsoft.com, wei.liu@kernel.org,
        haiyangz@microsoft.com, decui@microsoft.com,
        ssengar@linux.microsoft.com, mukeshrathor@microsoft.com,
        stanislav.kinsburskiy@gmail.com, jinankjain@linux.microsoft.com,
        apais@linux.microsoft.com, Tianyu.Lan@microsoft.com,
        vkuznets@redhat.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        will@kernel.org, catalin.marinas@arm.com
Subject: [PATCH 04/15] asm-generic/mshyperv: Introduce hv_recommend_using_aeoi()
Date:   Thu, 27 Jul 2023 12:54:39 -0700
Message-Id: <1690487690-2428-5-git-send-email-nunodasneves@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1690487690-2428-1-git-send-email-nunodasneves@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Factor out logic for determining if we should set the auto eoi flag in SINT
register.

Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
---
 drivers/hv/hv.c                | 12 +-----------
 include/asm-generic/mshyperv.h | 13 +++++++++++++
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/hv/hv.c b/drivers/hv/hv.c
index bffd15ce06f3..a897951634af 100644
--- a/drivers/hv/hv.c
+++ b/drivers/hv/hv.c
@@ -217,17 +217,7 @@ void hv_synic_enable_regs(unsigned int cpu)
 
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
index 447e7ebe67ee..90fcbb95f1ee 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -77,6 +77,19 @@ extern u64 hv_do_hypercall(u64 control, void *inputaddr, void *outputaddr);
 extern u64 hv_do_fast_hypercall8(u16 control, u64 input8);
 extern bool hv_isolation_type_snp(void);
 
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

