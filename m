Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EB4F4B0334
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231433AbiBJCRv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:17:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBJCRv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:17:51 -0500
Received: from condef-09.nifty.com (condef-09.nifty.com [202.248.20.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E67A22B18;
        Wed,  9 Feb 2022 18:17:52 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-09.nifty.com with ESMTP id 21A2CFEP025231;
        Thu, 10 Feb 2022 11:12:15 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVH0030193;
        Thu, 10 Feb 2022 11:11:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVH0030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459093;
        bh=mLWWEi1eNL+fE8D/ke2cTxgfWwEUC2jo0gGhItPyzZk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ds6XXxftljXHuqTMlRT1Xup0SdU7zZCfpwYKwAEeY0PCITuVRMN3uRLt3A0/M1X1V
         Kv/L25kt8Lgh57bvHWdwb540wDHT8ym9lLcIJg6YPRcr+SOjwuRkr8Uy99hRtIiLht
         OlsFVFAUusy99HPpj14K3KdnDP8JCBW2m6gB6VZ+Qmn1nboVgQL3F9n4/jyvs1AKqx
         XN+5LK2eLbhd0uMudNOThT2aTXuW8DKWOkRQDgbu1eQXluCgReX6MkGBGpSAo+udBI
         eldyuhbJqmMD4ljK0KmYWTtcfF+KGlCoIMC7F8sPJ5LBQKcimmoh+zPdXV9wUj+0ab
         fDo7I9CufRdHA==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 3/6] android/binder.h: add linux/android/binder(fs).h to UAPI compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:26 +0900
Message-Id: <20220210021129.3386083-4-masahiroy@kernel.org>
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

linux/android/binder.h and linux/android/binderfs.h are currently
excluded from the UAPI compile-test because of the errors like follows:

    HDRTEST usr/include/linux/android/binder.h
  In file included from <command-line>:
  ./usr/include/linux/android/binder.h:291:9: error: unknown type name ‘pid_t’
    291 |         pid_t           sender_pid;
        |         ^~~~~
  ./usr/include/linux/android/binder.h:292:9: error: unknown type name ‘uid_t’
    292 |         uid_t           sender_euid;
        |         ^~~~~

The errors can be fixed by replacing {pid,uid}_t with __kernel_{pid,uid}_t.

Then, remove the no-header-test entries from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/uapi/linux/android/binder.h | 4 ++--
 usr/include/Makefile                | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/android/binder.h b/include/uapi/linux/android/binder.h
index 3246f2c74696..11157fae8a8e 100644
--- a/include/uapi/linux/android/binder.h
+++ b/include/uapi/linux/android/binder.h
@@ -288,8 +288,8 @@ struct binder_transaction_data {
 
 	/* General information about the transaction. */
 	__u32	        flags;
-	pid_t		sender_pid;
-	uid_t		sender_euid;
+	__kernel_pid_t	sender_pid;
+	__kernel_uid_t	sender_euid;
 	binder_size_t	data_size;	/* number of bytes of data */
 	binder_size_t	offsets_size;	/* number of bytes of offsets */
 
diff --git a/usr/include/Makefile b/usr/include/Makefile
index b0b6cc455930..717c7d4c89bb 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -26,8 +26,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 no-header-test += asm/ucontext.h
 no-header-test += drm/vmwgfx_drm.h
 no-header-test += linux/am437x-vpfe.h
-no-header-test += linux/android/binder.h
-no-header-test += linux/android/binderfs.h
 no-header-test += linux/coda.h
 no-header-test += linux/cyclades.h
 no-header-test += linux/errqueue.h
-- 
2.32.0

