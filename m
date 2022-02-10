Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F6C4B033C
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiBJCUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiBJCUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:20:39 -0500
Received: from condef-10.nifty.com (condef-10.nifty.com [202.248.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71C922B3E;
        Wed,  9 Feb 2022 18:20:41 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-10.nifty.com with ESMTP id 21A2CEu3020648;
        Thu, 10 Feb 2022 11:12:14 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVH2030193;
        Thu, 10 Feb 2022 11:11:34 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVH2030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459095;
        bh=m1Mtw5y9Bf5RZ4MURQ8EIMvDxV6oJIXKhKHtyEcMzzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g+DVott1MKQy6T+LFYOgJdyjdMWeO97ujnib1/2R0WZJ3bNPShbKlpuSOBvKD3Rds
         lt7CA6dxwg8YmMSpbEbZMAr+VSAxv1ClNWq0tHVtC2YkjPsCBtKGVJL9Th9yxUXb0C
         V5Z+ZBxUhJiZwruT4QnGCUPwe8HzrJ9ra4MX1gSYOaWnRwvKxEAup+uBi9TpKeKdwT
         6T/y3UGNwmnzpILF7WtCXpEj1icQzG8/nc1IX4U8lLPuy3BPM09rfr5iT7kDpNHRFG
         HWu6tnyRw1rue/SGk1f0r1hqiQgYSvOg5mv6ydkwNFTszQGZRwtZawpr/opRvi/g52
         nQ43x+rpRiH4g==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 5/6] kexec.h: add linux/kexec.h to UAPI compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:28 +0900
Message-Id: <20220210021129.3386083-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210021129.3386083-1-masahiroy@kernel.org>
References: <20220210021129.3386083-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

linux/kexec.h is currently excluded from the UAPI compile-test because
of the errors like follows:

    HDRTEST usr/include/linux/kexec.h
  In file included from <command-line>:
  ./usr/include/linux/kexec.h:56:9: error: unknown type name ‘size_t’
     56 |         size_t bufsz;
        |         ^~~~~~
  ./usr/include/linux/kexec.h:58:9: error: unknown type name ‘size_t’
     58 |         size_t memsz;
        |         ^~~~~~

The errors can be fixed by replacing size_t with __kernel_size_t.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/kexec.h | 4 ++--
 usr/include/Makefile       | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/kexec.h b/include/uapi/linux/kexec.h
index 778dc191c265..fb7e2ef60825 100644
--- a/include/uapi/linux/kexec.h
+++ b/include/uapi/linux/kexec.h
@@ -54,9 +54,9 @@
  */
 struct kexec_segment {
 	const void *buf;
-	size_t bufsz;
+	__kernel_size_t bufsz;
 	const void *mem;
-	size_t memsz;
+	__kernel_size_t memsz;
 };
 
 #endif /* __KERNEL__ */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 9e35d022fd88..48bb789099d5 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -31,7 +31,6 @@ no-header-test += linux/cyclades.h
 no-header-test += linux/errqueue.h
 no-header-test += linux/hdlc/ioctl.h
 no-header-test += linux/ivtv.h
-no-header-test += linux/kexec.h
 no-header-test += linux/matroxfb.h
 no-header-test += linux/omap3isp.h
 no-header-test += linux/omapfb.h
-- 
2.32.0

