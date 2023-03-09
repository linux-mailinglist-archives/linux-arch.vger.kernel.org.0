Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C3B6B2CF5
	for <lists+linux-arch@lfdr.de>; Thu,  9 Mar 2023 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230420AbjCISgS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 9 Mar 2023 13:36:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCISgR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 9 Mar 2023 13:36:17 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E8792F31DD;
        Thu,  9 Mar 2023 10:36:15 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 374F9205763C;
        Thu,  9 Mar 2023 10:36:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 374F9205763C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1678386975;
        bh=HEFALoi9GtrnV/+AEmVgFak9Hc5DbS5w6Z4ATnF7ZGM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kdxuCp/Xzlo4eJt8QdKHkAD7iv0BUfJRDD/G7RC0/p5W/0B2WhmJj0XFxLrSEjTyM
         CdqvMQlH/lEGYimgomSpjEkMFGOOfbQBWHBrQ2Jj6XWmZXvKTiW5MTXrdZ1Qq9FSVS
         b2dgQmuDHblncw4kxmFsYwaJi4lBBu0/Ep8gj/Fo=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [PATCH v2 1/2] x86/init: Make get/set_rtc_noop() public
Date:   Thu,  9 Mar 2023 10:35:56 -0800
Message-Id: <1678386957-18016-2-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
References: <1678386957-18016-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Make get/set_rtc_noop() to be public so that they can be used
in other modules as well.

Co-developed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index c1c8c581759d..d8fb3a1639e9 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -326,5 +326,7 @@ extern void x86_init_uint_noop(unsigned int unused);
 extern bool bool_x86_init_noop(void);
 extern void x86_op_int_noop(int cpu);
 extern bool x86_pnpbios_disabled(void);
+extern int set_rtc_noop(const struct timespec64 *now);
+extern void get_rtc_noop(struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ef80d361b463..d93aeffec19b 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -33,8 +33,8 @@ static int __init iommu_init_noop(void) { return 0; }
 static void iommu_shutdown_noop(void) { }
 bool __init bool_x86_init_noop(void) { return false; }
 void x86_op_int_noop(int cpu) { }
-static __init int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
-static __init void get_rtc_noop(struct timespec64 *now) { }
+int set_rtc_noop(const struct timespec64 *now) { return -EINVAL; }
+void get_rtc_noop(struct timespec64 *now) { }
 
 static __initconst const struct of_device_id of_cmos_match[] = {
 	{ .compatible = "motorola,mc146818" },
-- 
2.34.1

