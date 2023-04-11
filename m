Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 461626DD228
	for <lists+linux-arch@lfdr.de>; Tue, 11 Apr 2023 07:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjDKFzk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 11 Apr 2023 01:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjDKFzi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 11 Apr 2023 01:55:38 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E32B3E6A;
        Mon, 10 Apr 2023 22:55:37 -0700 (PDT)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 11C622174E4C;
        Mon, 10 Apr 2023 22:55:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 11C622174E4C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1681192536;
        bh=sYN20W6hPtwdUe2Zl//cBVNvF4+/oIZeshaAhbV6svU=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=idzwUv6Gsdkg0wnyQqpq5lQkOeM6LIXE5fuooJdMtIHc+LywW6HD5zD3UO4eknCiq
         v+/jYfSZQZb34Coj6puOwdMHmRyFkhm35IT4ASF9xJbKdsdd2d82VeJG95k1REsFpW
         ropd9J62LPnJs9RMsXECXs+SZJGiOqm+E+25n7MU=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, arnd@arndb.de, tiala@microsoft.com,
        mikelley@microsoft.com, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-arch@vger.kernel.org,
        jgross@suse.com, mat.jonczyk@o2.pl
Subject: [PATCH v5 1/5] x86/init: Make get/set_rtc_noop() public
Date:   Mon, 10 Apr 2023 22:55:28 -0700
Message-Id: <1681192532-15460-2-git-send-email-ssengar@linux.microsoft.com>
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

Make get/set_rtc_noop() to be public so that they can be used
in other modules as well.

Co-developed-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Tianyu Lan <tiala@microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Reviewed-by: Wei Liu <wei.liu@kernel.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 arch/x86/include/asm/x86_init.h | 2 ++
 arch/x86/kernel/x86_init.c      | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index acc20ae4079d..88085f369ff6 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -330,5 +330,7 @@ extern void x86_init_uint_noop(unsigned int unused);
 extern bool bool_x86_init_noop(void);
 extern void x86_op_int_noop(int cpu);
 extern bool x86_pnpbios_disabled(void);
+extern int set_rtc_noop(const struct timespec64 *now);
+extern void get_rtc_noop(struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index 95be3831df73..d82f4fa2f1bf 100644
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

