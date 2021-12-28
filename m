Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F82480B01
	for <lists+linux-arch@lfdr.de>; Tue, 28 Dec 2021 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235428AbhL1Pyc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Dec 2021 10:54:32 -0500
Received: from vmicros1.altlinux.org ([194.107.17.57]:57512 "EHLO
        vmicros1.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235314AbhL1Pyb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Dec 2021 10:54:31 -0500
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
        by vmicros1.altlinux.org (Postfix) with ESMTP id 3E40872C8B0;
        Tue, 28 Dec 2021 18:54:30 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
        id 287C57CCA1F; Tue, 28 Dec 2021 18:54:30 +0300 (MSK)
Date:   Tue, 28 Dec 2021 18:54:30 +0300
From:   "Dmitry V. Levin" <ldv@altlinux.org>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] uapi: fix asm/signal.h userspace compilation errors
Message-ID: <20211228155429.GA11957@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170302001853.GA27097@altlinux.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Userspace cannot compile <asm/signal.h> due to missing type definitions.
For example, compiling it for x86_64 fails with the following diagnostics
when the exception for asm/signal.h is removed from usr/include/Makefile:

$ make usr CONFIG_HEADERS_INSTALL=y CONFIG_UAPI_HEADER_TEST=y
...
  HDRTEST usr/include/asm/signal.h
In file included from <command-line>:
./usr/include/asm/signal.h:103:9: error: unknown type name 'size_t'
  103 |         size_t ss_size;
      |         ^~~~~~

Replace size_t with __kernel_size_t to make asm/signal.h self-contained,
also add it to the compile-test coverage.

Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

This was submitted almost 5 years ago, so I was under impression that
it was applied among others of this kind, but, apparently, it's still
relevant.

v3: update commit message, remove usr/include/Makefile exception for
asm/signal.h.

 arch/alpha/include/uapi/asm/signal.h   | 2 +-
 arch/arm/include/uapi/asm/signal.h     | 2 +-
 arch/h8300/include/uapi/asm/signal.h   | 2 +-
 arch/ia64/include/uapi/asm/signal.h    | 2 +-
 arch/m68k/include/uapi/asm/signal.h    | 2 +-
 arch/mips/include/uapi/asm/signal.h    | 2 +-
 arch/parisc/include/uapi/asm/signal.h  | 2 +-
 arch/powerpc/include/uapi/asm/signal.h | 2 +-
 arch/s390/include/uapi/asm/signal.h    | 2 +-
 arch/sparc/include/uapi/asm/signal.h   | 2 +-
 arch/x86/include/uapi/asm/signal.h     | 2 +-
 arch/xtensa/include/uapi/asm/signal.h  | 2 +-
 include/uapi/asm-generic/signal.h      | 2 +-
 usr/include/Makefile                   | 1 -
 14 files changed, 13 insertions(+), 14 deletions(-)

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
index 0189f326aac5..5c776e1f2cbd 100644
--- a/arch/s390/include/uapi/asm/signal.h
+++ b/arch/s390/include/uapi/asm/signal.h
@@ -108,7 +108,7 @@ struct sigaction {
 typedef struct sigaltstack {
         void __user *ss_sp;
         int ss_flags;
-        size_t ss_size;
+        __kernel_size_t ss_size;
 } stack_t;
 
 
diff --git a/arch/sparc/include/uapi/asm/signal.h b/arch/sparc/include/uapi/asm/signal.h
index 53758d53ac0e..d3faa3bfce3d 100644
--- a/arch/sparc/include/uapi/asm/signal.h
+++ b/arch/sparc/include/uapi/asm/signal.h
@@ -171,7 +171,7 @@ struct __old_sigaction {
 typedef struct sigaltstack {
 	void			__user *ss_sp;
 	int			ss_flags;
-	size_t			ss_size;
+	__kernel_size_t			ss_size;
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
index 129d13e71691..8ac2c33a59e7 100644
--- a/usr/include/Makefile
+++ b/usr/include/Makefile
@@ -20,7 +20,6 @@ override c_flags = $(UAPI_CFLAGS) -Wp,-MMD,$(depfile) -I$(objtree)/usr/include
 # Please consider to fix the header first.
 #
 # Sorted alphabetically.
-no-header-test += asm/signal.h
 no-header-test += asm/ucontext.h
 no-header-test += drm/vmwgfx_drm.h
 no-header-test += linux/am437x-vpfe.h


-- 
ldv
