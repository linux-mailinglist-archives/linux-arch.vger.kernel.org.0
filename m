Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B9038138F
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 00:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233752AbhENWMF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 18:12:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:42832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233749AbhENWMF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 18:12:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1050861442;
        Fri, 14 May 2021 22:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621030253;
        bh=aUw+r/nEodOPwyLxBnACR72ulITbwIstVbqXf4RRoJE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oYBr8bGKcTRMUOp2zoQGJPX5679NcgVqQDZoScnhBl/RG3Kf9VFROFuxnZ2PYbUQp
         HbMeDK9xehouxSDKBmgv5lyhLy6L8QEuCI09B8k636PJ4PIx+RMZ86BZJ+1SDBOjtI
         w6x/8vaq2LgB/oHRDPceRLy95NS/naosQOIONqbCHDfwcxS1vZmYhqRX8HywJHQy7Z
         oN85ZsVRRgEdcYYERghpTitKtDHkJAUTk4nmz4zUq84KFTvm2HT4FkLgUi4AN1teug
         0D5rRFn5LTD1UcK81AXhl4m0dGa5I4XmVban0KVqOcblgEZp8Xu4oMFybVHbboBLKp
         nqjttqDBqwHiA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Sid Manning <sidneym@codeaurora.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        linux-snps-arc@lists.infradead.org, linux-kernel@vger.kernel.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-riscv@lists.infradead.org, linux-um@lists.infradead.org
Subject: [PATCH 1/5] asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
Date:   Sat, 15 May 2021 00:09:38 +0200
Message-Id: <20210514220942.879805-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514220942.879805-1-arnd@kernel.org>
References: <20210514220942.879805-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

This is a preparation for changing over architectures to the
generic implementation one at a time. As there are no callers
of either __strncpy_from_user() or __strnlen_user(), fold these
into the strncpy_from_user() strnlen_user() functions to make
each implementation independent of the others.

Many of these implementations have known bugs, but the intention
here is to not change behavior at all and stay compatible with
those bugs for the moment.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arc/include/asm/uaccess.h     | 14 ++++++++++----
 arch/hexagon/include/asm/uaccess.h | 22 +++++++++++++---------
 arch/um/include/asm/uaccess.h      |  8 ++++----
 arch/um/kernel/skas/uaccess.c      |  5 ++++-
 include/asm-generic/uaccess.h      | 28 +++++++++++-----------------
 5 files changed, 42 insertions(+), 35 deletions(-)

diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index ea40ec7f6cae..3476348f361e 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -661,6 +661,9 @@ __arc_strncpy_from_user(char *dst, const char __user *src, long count)
 	long res = 0;
 	char val;
 
+	if (!access_ok(src, 1))
+		return -EFAULT;
+
 	if (count == 0)
 		return 0;
 
@@ -693,6 +696,9 @@ static inline long __arc_strnlen_user(const char __user *s, long n)
 	long res, tmp1, cnt;
 	char val;
 
+	if (!access_ok(s, 1))
+		return 0;
+
 	__asm__ __volatile__(
 	"	mov %2, %1			\n"
 	"1:	ldb.ab  %3, [%0, 1]		\n"
@@ -724,8 +730,8 @@ static inline long __arc_strnlen_user(const char __user *s, long n)
 #define INLINE_COPY_FROM_USER
 
 #define __clear_user(d, n)		__arc_clear_user(d, n)
-#define __strncpy_from_user(d, s, n)	__arc_strncpy_from_user(d, s, n)
-#define __strnlen_user(s, n)		__arc_strnlen_user(s, n)
+#define strncpy_from_user(d, s, n)	__arc_strncpy_from_user(d, s, n)
+#define strnlen_user(s, n)		__arc_strnlen_user(s, n)
 #else
 extern unsigned long arc_clear_user_noinline(void __user *to,
 		unsigned long n);
@@ -734,8 +740,8 @@ extern long arc_strncpy_from_user_noinline (char *dst, const char __user *src,
 extern long arc_strnlen_user_noinline(const char __user *src, long n);
 
 #define __clear_user(d, n)		arc_clear_user_noinline(d, n)
-#define __strncpy_from_user(d, s, n)	arc_strncpy_from_user_noinline(d, s, n)
-#define __strnlen_user(s, n)		arc_strnlen_user_noinline(s, n)
+#define strncpy_from_user(d, s, n)	arc_strncpy_from_user_noinline(d, s, n)
+#define strnlen_user(s, n)		arc_strnlen_user_noinline(s, n)
 
 #endif
 
diff --git a/arch/hexagon/include/asm/uaccess.h b/arch/hexagon/include/asm/uaccess.h
index c1019a736ff1..59aa3a50744f 100644
--- a/arch/hexagon/include/asm/uaccess.h
+++ b/arch/hexagon/include/asm/uaccess.h
@@ -57,23 +57,27 @@ unsigned long raw_copy_to_user(void __user *to, const void *from,
 __kernel_size_t __clear_user_hexagon(void __user *dest, unsigned long count);
 #define __clear_user(a, s) __clear_user_hexagon((a), (s))
 
-#define __strncpy_from_user(dst, src, n) hexagon_strncpy_from_user(dst, src, n)
+extern long __strnlen_user(const char __user *src, long n);
 
-/*  get around the ifndef in asm-generic/uaccess.h  */
-#define __strnlen_user __strnlen_user
+static inline strnlen_user(const char __user *src, long n)
+{
+        if (!access_ok(src, 1))
+		return 0;
 
-extern long __strnlen_user(const char __user *src, long n);
+	return __strnlen_user(src, n);
+}
+/*  get around the ifndef in asm-generic/uaccess.h  */
+#define strnlen_user strnlen_user
 
-static inline long hexagon_strncpy_from_user(char *dst, const char __user *src,
-					     long n);
+static inline long strncpy_from_user(char *dst, const char __user *src, long n);
+#define strncpy_from_user strncpy_from_user
 
 #include <asm-generic/uaccess.h>
 
 /*  Todo:  an actual accelerated version of this.  */
-static inline long hexagon_strncpy_from_user(char *dst, const char __user *src,
-					     long n)
+static inline long strncpy_from_user(char *dst, const char __user *src, long n)
 {
-	long res = __strnlen_user(src, n);
+	long res = strnlen_user(src, n);
 
 	if (unlikely(!res))
 		return -EFAULT;
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index fe66d659acad..3bf209f683f8 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -23,16 +23,16 @@
 
 extern unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n);
 extern unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n);
-extern long __strncpy_from_user(char *dst, const char __user *src, long count);
-extern long __strnlen_user(const void __user *str, long len);
+extern long strncpy_from_user(char *dst, const char __user *src, long count);
+extern long strnlen_user(const void __user *str, long len);
 extern unsigned long __clear_user(void __user *mem, unsigned long len);
 static inline int __access_ok(unsigned long addr, unsigned long size);
 
 /* Teach asm-generic/uaccess.h that we have C functions for these. */
 #define __access_ok __access_ok
 #define __clear_user __clear_user
-#define __strnlen_user __strnlen_user
-#define __strncpy_from_user __strncpy_from_user
+#define strnlen_user strnlen_user
+#define strncpy_from_user strncpy_from_user
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index 2dec915abe6f..205679cc4bb7 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -188,11 +188,14 @@ static int strncpy_chunk_from_user(unsigned long from, int len, void *arg)
 	return 0;
 }
 
-long __strncpy_from_user(char *dst, const char __user *src, long count)
+long strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	long n;
 	char *ptr = dst;
 
+	if (!access_ok(src, 1))
+		return -EFAULT;
+
 	if (uaccess_kernel()) {
 		strncpy(dst, (__force void *) src, count);
 		return strnlen(dst, count);
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 4973328f3c6e..c03889cc904c 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -246,11 +246,15 @@ extern int __get_user_bad(void) __attribute__((noreturn));
 /*
  * Copy a null terminated string from userspace.
  */
-#ifndef __strncpy_from_user
+#ifndef strncpy_from_user
 static inline long
-__strncpy_from_user(char *dst, const char __user *src, long count)
+strncpy_from_user(char *dst, const char __user *src, long count)
 {
 	char *tmp;
+
+	if (!access_ok(src, 1))
+		return -EFAULT;
+
 	strncpy(dst, (const char __force *)src, count);
 	for (tmp = dst; *tmp && count > 0; tmp++, count--)
 		;
@@ -258,24 +262,12 @@ __strncpy_from_user(char *dst, const char __user *src, long count)
 }
 #endif
 
-static inline long
-strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	if (!access_ok(src, 1))
-		return -EFAULT;
-	return __strncpy_from_user(dst, src, count);
-}
-
+#ifndef strnlen_user
 /*
  * Return the size of a string (including the ending 0)
  *
  * Return 0 on exception, a value greater than N if too long
- */
-#ifndef __strnlen_user
-#define __strnlen_user(s, n) (strnlen((s), (n)) + 1)
-#endif
-
-/*
+ *
  * Unlike strnlen, strnlen_user includes the nul terminator in
  * its returned count. Callers should check for a returned value
  * greater than N as an indication the string is too long.
@@ -284,8 +276,10 @@ static inline long strnlen_user(const char __user *src, long n)
 {
 	if (!access_ok(src, 1))
 		return 0;
-	return __strnlen_user(src, n);
+
+	return strnlen(src, n) + 1;
 }
+#endif
 
 /*
  * Zero Userspace
-- 
2.29.2

