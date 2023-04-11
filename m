Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05B3C6DD22A
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 07:55:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjDKFzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 01:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjDKFzj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 01:55:39 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E43AB10D4;
        Mon, 10 Apr 2023 22:55:37 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 455842174E4F;
        Mon, 10 Apr 2023 22:55:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 455842174E4F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681192536;
        bh=lolaL0ucqGcng5SGGnPtcnPytbtw0ZL9CTqusc/YQDI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=BXwvquHtBr6Re8VjeCHtAyVRWvmmFwNiveyrm2zQJqsemISfeG9+UPHF350niuhS/
         4fx3fnGARBS21c3ZDSpcszDb9XMSfV+Dc+sjTTIm+zOf/6Q0DrW4vsWhxF+vGgAZL9
         8ZSDdYOrapI72yk4H1xW8wyx4oJevCuGoyMgXBkQ=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: [PATCH v5 3/5] x86/hyperv: Make hv_get_nmi_reason public
Date:   Mon, 10 Apr 2023 22:55:30 -0700
Message-Id: <1681192532-15460-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
References: <1681192532-15460-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-17.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move hv_get_nmi_reason to .h file so it can be used in other
modules as well.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 5 +++++
 arch/x86/kernel/cpu/mshyperv.c  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index e3cef98a0142..71ed240ef66d 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -189,6 +189,11 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
 	return hv_vp_assist_page[cpu];
 }
 
+static inline unsigned char hv_get_nmi_reason(void)
+{
+	return 0;
+}
+
 void __init hyperv_init(void);
 void hyperv_setup_mmu_ops(void);
 void set_hv_tscchange_cb(void (*cb)(void));
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 315fc358e584..5ee02af57dac 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -249,11 +249,6 @@ static uint32_t  __init ms_hyperv_platform(void)
 	return HYPERV_CPUID_VENDOR_AND_MAX_FUNCTIONS;
 }
 
-static unsigned char hv_get_nmi_reason(void)
-{
-	return 0;
-}
-
 #ifdef CONFIG_X86_LOCAL_APIC
 /*
  * Prior to WS2016 Debug-VM sends NMIs to all CPUs which makes
-- 
2.34.1

