Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 350EA4B033D
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:20:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbiBJCUl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBJCUj (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:20:39 -0500
Received: from condef-05.nifty.com (condef-05.nifty.com [202.248.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B13722B36;
        Wed,  9 Feb 2022 18:20:38 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-05.nifty.com with ESMTP id 21A2CEgX007238;
        Thu, 10 Feb 2022 11:12:14 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVGw030193;
        Thu, 10 Feb 2022 11:11:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVGw030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459092;
        bh=9rlTIDf+U0DYlyosnkaUCepGIAJ7vKKws/NpiQ+PL4I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BX06GH+WTisBdFFp+EltlSA9tkoYjTNeBLO7faiKnMDs7ZLUmIsKRWStl5IhyytnX
         PYJGfycgxdchdg12CxlQoENG8h9dVJFRLEOE5kpRGXBkVRAukfS87erh35xanyWtvQ
         QAQPOPAGSc6IcOr9vHsXKARlCN83342LfRCHcxQy/aiLrLLHDqH3hVEPK9aJmhfYrg
         YhYutTdWp/eMzVoIsD8wVBxf56ihdHWdWwtnSVorxcDXqwVYN50JYWcglod/oWsIsu
         e+W/jMKXF4K6MvXOVnJiMTPdMmVtxXVdvL9UvkMAWi6GHkhSDu1twcEjuCXWdqzpI0
         bI7Zvcnr1SnJw==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 1/6] signal.h: add linux/signal.h and asm/signal.h to UAPI compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:24 +0900
Message-Id: <20220210021129.3386083-2-masahiroy@kernel.org>
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

linux/signal.h and asm/signal.h are currently excluded from the UAPI
compile-test because of the errors like follows:

    HDRTEST usr/include/asm/signal.h
  In file included from <command-line>:
  ./usr/include/asm/signal.h:103:9: error: unknown type name ‘size_t’
    103 |         size_t ss_size;
        |         ^~~~~~

The errors can be fixed by replacing size_t with __kernel_size_t.

Then, remove the no-header-test entries from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/alpha/include/uapi/asm/signal.h   | 2 +-
 arch/arm/include/uapi/asm/signal.h     | 2 +-
 arch/h8300/include/uapi/asm/signal.h   | 2 +-
 arch/ia64/include/uapi/asm/signal.h    | 2 +-
 arch/m68k/include/uapi/asm/signal.h    | 2 +-
 arch/mips/include/uapi/asm/signal.h    | 2 +-
 arch/parisc/include/uapi/asm/signal.h  | 2 +-
 arch/powerpc/include/uapi/asm/signal.h | 2 +-
 arch/s390/include/uapi/asm/signal.h    | 2 +-
 arch/sparc/include/uapi/asm/signal.h   | 3 ++-
 arch/x86/include/uapi/asm/signal.h     | 2 +-
 arch/xtensa/include/uapi/asm/signal.h  | 2 +-
 include/uapi/asm-generic/signal.h      | 2 +-
 usr/include/Makefile                   | 2 --
 14 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/alpha/include/uapi/asm/signal.h b/arch/alpha/include/uapi/asm/signal.h
index a69dd8d080a8..1413075f7616 100644
--- a/arch/alpha/include/uapi/asm/signal.h
+++ b/arch/alpha/include/uapi/asm/signal.h
@@ -100,7 +100,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 /* sigstack(2) is deprecated, and will be withdrawn in a future version
diff --git a/arch/arm/include/uapi/asm/signal.h b/arch/arm/include/uapi/asm/signal.h
index c9a3ea1d8d41..9e2178420db2 100644
--- a/arch/arm/include/uapi/asm/signal.h
+++ b/arch/arm/include/uapi/asm/signal.h
@@ -93,7 +93,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/h8300/include/uapi/asm/signal.h b/arch/h8300/include/uapi/asm/signal.h
index 2cd0dce2b6a6..1165481f80f6 100644
--- a/arch/h8300/include/uapi/asm/signal.h
+++ b/arch/h8300/include/uapi/asm/signal.h
@@ -85,7 +85,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/ia64/include/uapi/asm/signal.h b/arch/ia64/include/uapi/asm/signal.h
index 38166a88e4c9..63d574e802a2 100644
--- a/arch/ia64/include/uapi/asm/signal.h
+++ b/arch/ia64/include/uapi/asm/signal.h
@@ -90,7 +90,7 @@ struct siginfo;
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/m68k/include/uapi/asm/signal.h b/arch/m68k/include/uapi/asm/signal.h
index 4619291df601..80f520b9b10b 100644
--- a/arch/m68k/include/uapi/asm/signal.h
+++ b/arch/m68k/include/uapi/asm/signal.h
@@ -83,7 +83,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* _UAPI_M68K_SIGNAL_H */
diff --git a/arch/mips/include/uapi/asm/signal.h b/arch/mips/include/uapi/asm/signal.h
index e6c78a15cb2f..94a00f82e373 100644
--- a/arch/mips/include/uapi/asm/signal.h
+++ b/arch/mips/include/uapi/asm/signal.h
@@ -100,7 +100,7 @@ struct sigaction {
 /* IRIX compatible stack_t  */
 typedef struct sigaltstack {
 	void __user *ss_sp;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 	int ss_flags;
 } stack_t;
 
diff --git a/arch/parisc/include/uapi/asm/signal.h b/arch/parisc/include/uapi/asm/signal.h
index e5a2657477ac..8e4895c5ea5d 100644
--- a/arch/parisc/include/uapi/asm/signal.h
+++ b/arch/parisc/include/uapi/asm/signal.h
@@ -67,7 +67,7 @@ struct siginfo;
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* !__ASSEMBLY */
diff --git a/arch/powerpc/include/uapi/asm/signal.h b/arch/powerpc/include/uapi/asm/signal.h
index 04873dd311c2..37d41d87c45b 100644
--- a/arch/powerpc/include/uapi/asm/signal.h
+++ b/arch/powerpc/include/uapi/asm/signal.h
@@ -86,7 +86,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/s390/include/uapi/asm/signal.h b/arch/s390/include/uapi/asm/signal.h
index 0189f326aac5..e74d6ba1bd3b 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -108,7 +108,7 @@ struct sigaction {
 typedef struct sigaltstack {
         void __user *ss_sp;
         int ss_flags;
-        size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index 53758d53ac0e..d395af9b46d2 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -2,6 +2,7 @@
 #ifndef _UAPI__SPARC_SIGNAL_H
 #define _UAPI__SPARC_SIGNAL_H
 
+#include <asm/posix_types.h>
 #include <asm/sigcontext.h>
 #include <linux/compiler.h>
 
@@ -171,7 +172,7 @@ struct __old_sigaction {
 typedef struct sigaltstack {
 	void			__user *ss_sp;
 	int			ss_flags;
-	size_t			ss_size;
+	__kernel_size_t		ss_size;
 } stack_t;
 
 
diff --git a/arch/x86/include/uapi/asm/signal.h b/arch/x86/include/uapi/asm/signal.h
index 164a22a72984..777c3a0f4e23 100644
--- a/arch/x86/include/uapi/asm/signal.h
+++ b/arch/x86/include/uapi/asm/signal.h
@@ -104,7 +104,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/xtensa/include/uapi/asm/signal.h b/arch/xtensa/include/uapi/asm/signal.h
index 79ddabaa4e5d..b8c824dd4b74 100644
--- a/arch/xtensa/include/uapi/asm/signal.h
+++ b/arch/xtensa/include/uapi/asm/signal.h
@@ -103,7 +103,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif	/* __ASSEMBLY__ */
diff --git a/include/uapi/asm-generic/signal.h b/include/uapi/asm-generic/signal.h
index f634822906e4..0eb69dc8e572 100644
--- a/include/uapi/asm-generic/signal.h
+++ b/include/uapi/asm-generic/signal.h
@@ -85,7 +85,7 @@ struct sigaction {
 typedef struct sigaltstack {
 	void __user *ss_sp;
 	int ss_flags;
-	size_t ss_size;
+	__kernel_size_t ss_size;
 } stack_t;
 
 #endif /* __ASSEMBLY__ */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 8dbd1d8a245f..e7230a5a402a 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -24,7 +24,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 #
 # Sorted alphabetically.
 no-header-test += asm/shmbuf.h
-no-header-test += asm/signal.h
 no-header-test += asm/ucontext.h
 no-header-test += drm/vmwgfx_drm.h
 no-header-test += linux/am437x-vpfe.h
@@ -44,7 +43,6 @@ no-header-test += linux/patchkey.h
 no-header-test += linux/phonet.h
 no-header-test += linux/reiserfs_xattr.h
 no-header-test += linux/sctp.h
-no-header-test += linux/signal.h
 no-header-test += linux/sysctl.h
 no-header-test += linux/usb/audio.h
 no-header-test += linux/v4l2-mediabus.h
-- 
2.32.0

