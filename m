Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F356C0E1C
	for <lists+linux-arch@lfdr.de>; Mon, 20 Mar 2023 11:04:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229902AbjCTKEe (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 20 Mar 2023 06:04:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCTKE3 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 20 Mar 2023 06:04:29 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 390F5CC14;
        Mon, 20 Mar 2023 03:03:57 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0F75E20FAED7;
        Mon, 20 Mar 2023 03:03:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0F75E20FAED7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1679306623;
        bh=rnTbUjR9n2/4s9Jdr0rdLVFg2m8YA/nI+pUJy8tCLnQ=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hTbzzy28fIdvCV1TThZYkkPtL4PH3HXlp1i9HCpN6+eOdBCZSkfz478fWdv5Ld1Qe
         wVxY3g0ylwClQww6J3hgtwoSZ2vGgDyF0TKob/jRlXtdhtQPmyyeGYfhqto4A6Xd2A
         HSBS0f3jlgMJMKttkOJv7/cXbzBjUAGMGicsotAQ=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v3 3/5] x86/hyperv: Make hv_get_nmi_reason public
Date:   Mon, 20 Mar 2023 03:03:36 -0700
Message-Id: <1679306618-31484-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
References: <1679306618-31484-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Move hv_get_nmi_reason to .h file so it can be used in other
modules as well.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/include/asm/mshyperv.h | 5 +++++
 arch/x86/kernel/cpu/mshyperv.c  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
index 4c4c0ec3b62e..35b16b177035 100644
--- a/arch/x86/include/asm/mshyperv.h
+++ b/arch/x86/include/asm/mshyperv.h
@@ -181,6 +181,11 @@ static inline struct hv_vp_assist_page *hv_get_vp_assist_page(unsigned int cpu)
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
index f1197366a97d..61363ce0b335 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -250,11 +250,6 @@ static uint32_t  __init ms_hyperv_platform(void)
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

