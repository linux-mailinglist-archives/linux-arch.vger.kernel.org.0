Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88FFF4B0339
	for <lists+linux-arch@lfdr.de>; Thu, 10 Feb 2022 03:19:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiBJCTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Feb 2022 21:19:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiBJCS7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 Feb 2022 21:18:59 -0500
Received: from condef-01.nifty.com (condef-01.nifty.com [202.248.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB7A725CA;
        Wed,  9 Feb 2022 18:19:00 -0800 (PST)
Received: from conuserg-12.nifty.com ([10.126.8.75])by condef-01.nifty.com with ESMTP id 21A2CEFY024863;
        Thu, 10 Feb 2022 11:12:14 +0900
Received: from localhost.localdomain (133-32-232-101.west.xps.vectant.ne.jp [133.32.232.101]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 21A2BVGx030193;
        Thu, 10 Feb 2022 11:11:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 21A2BVGx030193
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1644459093;
        bh=BgrcsyoUOdWLgz4rAIphuCEW51c0c/5R+2Ow60R9bB4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=feNGzLID3LYlOV5n4mKLtXUPF4kgKQ2Abd84X5tlxdFtpKDaiFAVs2xfCcQu8cEDS
         k+4p/Bb6BN8a+1umUvAc6TkLtPggeYWvpayf5A+miDrgOhCB/hRBx+ph1lV8anUzGp
         cwTSRrfsVyUDhmq6inujkOyNMVPCbifK8cLYH/OiMygLh7DzITppkBYKgabDuxXHFM
         kR7BnOAjsO1CGP8TfFpcwq4qWD9cb3BK/Wy960k0eOySl1QQv+RYuTGatFa9g8H21Z
         Vf4rYyrQj8UgKnAn7Omy/MTrV3ZIvvWnXWfqNCPxUzkA/LfLMqqfc5l5/aezzWpTL6
         IacZ41RYUZTMg==
X-Nifty-SrcIP: [133.32.232.101]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH 2/6] shmbuf.h: add asm/shmbuf.h to UAPI compile-test coverage
Date:   Thu, 10 Feb 2022 11:11:25 +0900
Message-Id: <20220210021129.3386083-3-masahiroy@kernel.org>
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

asm/shmbuf.h is currently excluded from the UAPI compile-test because of
the errors like follows:

    HDRTEST usr/include/asm/shmbuf.h
  In file included from ./usr/include/asm/shmbuf.h:6,
                   from <command-line>:
  ./usr/include/asm-generic/shmbuf.h:26:33: error: field ‘shm_perm’ has incomplete type
     26 |         struct ipc64_perm       shm_perm;       /* operation perms */
        |                                 ^~~~~~~~
  ./usr/include/asm-generic/shmbuf.h:27:9: error: unknown type name ‘size_t’
     27 |         size_t                  shm_segsz;      /* size of segment (bytes) */
        |         ^~~~~~
  ./usr/include/asm-generic/shmbuf.h:40:9: error: unknown type name ‘__kernel_pid_t’
     40 |         __kernel_pid_t          shm_cpid;       /* pid of creator */
        |         ^~~~~~~~~~~~~~
  ./usr/include/asm-generic/shmbuf.h:41:9: error: unknown type name ‘__kernel_pid_t’
     41 |         __kernel_pid_t          shm_lpid;       /* pid of last operator */
        |         ^~~~~~~~~~~~~~

The errors can be fixed by replacing size_t with __kernel_size_t and by
including proper headers.

Then, remove the no-header-test entry from user/include/Makefile.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 arch/mips/include/uapi/asm/shmbuf.h    | 7 +++++--
 arch/parisc/include/uapi/asm/shmbuf.h  | 2 ++
 arch/powerpc/include/uapi/asm/shmbuf.h | 5 ++++-
 arch/sparc/include/uapi/asm/shmbuf.h   | 5 ++++-
 arch/x86/include/uapi/asm/shmbuf.h     | 6 +++++-
 arch/xtensa/include/uapi/asm/shmbuf.h  | 5 ++++-
 include/uapi/asm-generic/shmbuf.h      | 4 +++-
 usr/include/Makefile                   | 1 -
 8 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index 680bb95b2240..eb74d304b779 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_SHMBUF_H
 #define _ASM_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
+
 /*
  * The shmid64_ds structure for the MIPS architecture.
  * Note extra padding because this structure is passed back and forth
@@ -16,7 +19,7 @@
 #ifdef __mips64
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	long			shm_atime;	/* last attach time */
 	long			shm_dtime;	/* last detach time */
 	long			shm_ctime;	/* last change time */
@@ -29,7 +32,7 @@ struct shmid64_ds {
 #else
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	unsigned long		shm_atime;	/* last attach time */
 	unsigned long		shm_dtime;	/* last detach time */
 	unsigned long		shm_ctime;	/* last change time */
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index 5da3089be65e..532da742fb56 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -3,6 +3,8 @@
 #define _PARISC_SHMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
 
 /* 
  * The shmid64_ds structure for parisc architecture.
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index 00422b2f3c63..439a3a02ba64 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -2,6 +2,9 @@
 #ifndef _ASM_POWERPC_SHMBUF_H
 #define _ASM_POWERPC_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -34,7 +37,7 @@ struct shmid64_ds {
 	unsigned long		shm_ctime;	/* last change time */
 	unsigned long		__unused4;
 #endif
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index a5d7d8d681c4..ed4f061c7a15 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -2,6 +2,9 @@
 #ifndef _SPARC_SHMBUF_H
 #define _SPARC_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
+
 /* 
  * The shmid64_ds structure for sparc architecture.
  * Note extra padding because this structure is passed back and forth
@@ -25,7 +28,7 @@ struct shmid64_ds {
 	unsigned long		shm_ctime_high;
 	unsigned long		shm_ctime;	/* last change time */
 #endif
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index fce18eaa070c..13775bfdfee2 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -5,6 +5,10 @@
 #if !defined(__x86_64__) || !defined(__ILP32__)
 #include <asm-generic/shmbuf.h>
 #else
+
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
+
 /*
  * The shmid64_ds structure for x86 architecture with x32 ABI.
  *
@@ -15,7 +19,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_long_t		shm_atime;	/* last attach time */
 	__kernel_long_t		shm_dtime;	/* last detach time */
 	__kernel_long_t		shm_ctime;	/* last change time */
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index 554a57a6a90f..bb8bdddae9b5 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -20,9 +20,12 @@
 #ifndef _XTENSA_SHMBUF_H
 #define _XTENSA_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
+
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	unsigned long		shm_atime;	/* last attach time */
 	unsigned long		shm_atime_high;
 	unsigned long		shm_dtime;	/* last detach time */
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2bab955e0fed..2979b6dd2c56 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -3,6 +3,8 @@
 #define __ASM_GENERIC_SHMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
+#include <asm/posix_types.h>
 
 /*
  * The shmid64_ds structure for x86 architecture.
@@ -24,7 +26,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 #if __BITS_PER_LONG == 64
 	long			shm_atime;	/* last attach time */
 	long			shm_dtime;	/* last detach time */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index e7230a5a402a..b0b6cc455930 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -23,7 +23,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-no-header-test += asm/shmbuf.h
 no-header-test += asm/ucontext.h
 no-header-test += drm/vmwgfx_drm.h
 no-header-test += linux/am437x-vpfe.h
-- 
2.32.0

