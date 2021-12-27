Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E66B747FBFB
	for <lists+linux-arch@lfdr.de>; Mon, 27 Dec 2021 11:53:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232788AbhL0KxG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 27 Dec 2021 05:53:06 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:35186 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232508AbhL0KxG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 27 Dec 2021 05:53:06 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 388A472C8B0;
        Mon, 27 Dec 2021 13:53:04 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 1F4F87CCA1A; Mon, 27 Dec 2021 13:53:04 +0300 (MSK)
Date:   Mon, 27 Dec 2021 13:53:04 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] uapi: fix asm/shmbuf.h userspace compilation errors
Message-ID: <20211227105303.GA25101@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1=-Q=gVRyk+PwqxTeTPXa4yrmqWKG7SyZng2d7bcbG=g@mail.gmail.com>
 <CAK8P3a1_QLguZ6XEGC9TdGUmF0R3bKaU2EiJ6m+Gf=KpYnmqqw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Userspace cannot compile <asm/shmbuf.h> due to some missing type
definitions.  For example, compiling it for x86_64 fails with the
following diagnostics:

  HDRTEST usr/include/asm/shmbuf.h
In file included from ./usr/include/asm/shmbuf.h:6,
                 from <command-line>:
./usr/include/asm-generic/shmbuf.h:26:33: error: field 'shm_perm' has incomplete type
   26 |         struct ipc64_perm       shm_perm;       /* operation perms */
      |                                 ^~~~~~~~
./usr/include/asm-generic/shmbuf.h:27:9: error: unknown type name 'size_t'
   27 |         size_t                  shm_segsz;      /* size of segment (bytes) */
      |         ^~~~~~
./usr/include/asm-generic/shmbuf.h:40:9: error: unknown type name '__kernel_pid_t'
   40 |         __kernel_pid_t          shm_cpid;       /* pid of creator */
      |         ^~~~~~~~~~~~~~
./usr/include/asm-generic/shmbuf.h:41:9: error: unknown type name '__kernel_pid_t'
   41 |         __kernel_pid_t          shm_lpid;       /* pid of last operator */
      |         ^~~~~~~~~~~~~~

Replace size_t with __kernel_size_t and include <asm/ipcbuf.h> to make
asm/shmbuf.h self-contained, also add it to the compile-test coverage.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

This was submitted almost 5 years ago [1] and acked by Arnd, so I was
under impression that it was applied among others of this kind, but,
apparently, it's still relevant.

v2: squash two patches into a single patch, update commit message,
remove usr/include/Makefile exception for asm/shmbuf.h.

[1] https://lore.kernel.org/lkml/20170302004607.GE27132@altlinux.org/T/#u

 arch/mips/include/uapi/asm/shmbuf.h    | 6 ++++--
 arch/parisc/include/uapi/asm/shmbuf.h  | 1 +
 arch/powerpc/include/uapi/asm/shmbuf.h | 4 +++-
 arch/sparc/include/uapi/asm/shmbuf.h   | 4 +++-
 arch/x86/include/uapi/asm/shmbuf.h     | 4 +++-
 arch/xtensa/include/uapi/asm/shmbuf.h  | 4 +++-
 include/uapi/asm-generic/shmbuf.h      | 3 ++-
 usr/include/Makefile                   | 1 -
 8 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/uapi/asm/shmbuf.h b/arch/mips/include/uapi/asm/shmbuf.h
index 680bb95b2240..cfddd497e6a8 100644
--- a/arch/mips/include/uapi/asm/shmbuf.h
+++ b/arch/mips/include/uapi/asm/shmbuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_SHMBUF_H
 #define _ASM_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * The shmid64_ds structure for the MIPS architecture.
  * Note extra padding because this structure is passed back and forth
@@ -16,7 +18,7 @@
 #ifdef __mips64
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	long			shm_atime;	/* last attach time */
 	long			shm_dtime;	/* last detach time */
 	long			shm_ctime;	/* last change time */
@@ -29,7 +31,7 @@ struct shmid64_ds {
 #else
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	unsigned long		shm_atime;	/* last attach time */
 	unsigned long		shm_dtime;	/* last detach time */
 	unsigned long		shm_ctime;	/* last change time */
diff --git a/arch/parisc/include/uapi/asm/shmbuf.h b/arch/parisc/include/uapi/asm/shmbuf.h
index 5da3089be65e..4b1d6c0b1216 100644
--- a/arch/parisc/include/uapi/asm/shmbuf.h
+++ b/arch/parisc/include/uapi/asm/shmbuf.h
@@ -3,6 +3,7 @@
 #define _PARISC_SHMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /* 
  * The shmid64_ds structure for parisc architecture.
diff --git a/arch/powerpc/include/uapi/asm/shmbuf.h b/arch/powerpc/include/uapi/asm/shmbuf.h
index 00422b2f3c63..8a274dbf7b20 100644
--- a/arch/powerpc/include/uapi/asm/shmbuf.h
+++ b/arch/powerpc/include/uapi/asm/shmbuf.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_POWERPC_SHMBUF_H
 #define _ASM_POWERPC_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /*
  * This program is free software; you can redistribute it and/or
  * modify it under the terms of the GNU General Public License
@@ -34,7 +36,7 @@ struct shmid64_ds {
 	unsigned long		shm_ctime;	/* last change time */
 	unsigned long		__unused4;
 #endif
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/sparc/include/uapi/asm/shmbuf.h b/arch/sparc/include/uapi/asm/shmbuf.h
index a5d7d8d681c4..1b10b3c91d1b 100644
--- a/arch/sparc/include/uapi/asm/shmbuf.h
+++ b/arch/sparc/include/uapi/asm/shmbuf.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_SHMBUF_H
 #define _SPARC_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+
 /* 
  * The shmid64_ds structure for sparc architecture.
  * Note extra padding because this structure is passed back and forth
@@ -25,7 +27,7 @@ struct shmid64_ds {
 	unsigned long		shm_ctime_high;
 	unsigned long		shm_ctime;	/* last change time */
 #endif
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_pid_t		shm_cpid;	/* pid of creator */
 	__kernel_pid_t		shm_lpid;	/* pid of last operator */
 	unsigned long		shm_nattch;	/* no. of current attaches */
diff --git a/arch/x86/include/uapi/asm/shmbuf.h b/arch/x86/include/uapi/asm/shmbuf.h
index fce18eaa070c..3e61a65d8512 100644
--- a/arch/x86/include/uapi/asm/shmbuf.h
+++ b/arch/x86/include/uapi/asm/shmbuf.h
@@ -13,9 +13,11 @@
  * from other 32-bit architectures.
  */
 
+#include <asm/ipcbuf.h>
+
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	__kernel_long_t		shm_atime;	/* last attach time */
 	__kernel_long_t		shm_dtime;	/* last detach time */
 	__kernel_long_t		shm_ctime;	/* last change time */
diff --git a/arch/xtensa/include/uapi/asm/shmbuf.h b/arch/xtensa/include/uapi/asm/shmbuf.h
index 554a57a6a90f..a54411e1ec2a 100644
--- a/arch/xtensa/include/uapi/asm/shmbuf.h
+++ b/arch/xtensa/include/uapi/asm/shmbuf.h
@@ -20,9 +20,11 @@
 #ifndef _XTENSA_SHMBUF_H
 #define _XTENSA_SHMBUF_H
 
+#include <asm/ipcbuf.h>
+
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 	unsigned long		shm_atime;	/* last attach time */
 	unsigned long		shm_atime_high;
 	unsigned long		shm_dtime;	/* last detach time */
diff --git a/include/uapi/asm-generic/shmbuf.h b/include/uapi/asm-generic/shmbuf.h
index 2bab955e0fed..dc16f82be778 100644
--- a/include/uapi/asm-generic/shmbuf.h
+++ b/include/uapi/asm-generic/shmbuf.h
@@ -3,6 +3,7 @@
 #define __ASM_GENERIC_SHMBUF_H
 
 #include <asm/bitsperlong.h>
+#include <asm/ipcbuf.h>
 
 /*
  * The shmid64_ds structure for x86 architecture.
@@ -24,7 +25,7 @@
 
 struct shmid64_ds {
 	struct ipc64_perm	shm_perm;	/* operation perms */
-	size_t			shm_segsz;	/* size of segment (bytes) */
+	__kernel_size_t		shm_segsz;	/* size of segment (bytes) */
 #if __BITS_PER_LONG == 64
 	long			shm_atime;	/* last attach time */
 	long			shm_dtime;	/* last detach time */
diff --git a/usr/include/Makefile b/usr/include/Makefile
index 1c2ae1368079..129d13e71691 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -20,7 +20,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-no-header-test += asm/shmbuf.h
 no-header-test += asm/signal.h
 no-header-test += asm/ucontext.h
 no-header-test += drm/vmwgfx_drm.h

-- 
ldv
