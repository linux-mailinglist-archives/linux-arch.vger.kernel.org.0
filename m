Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CC93D23C3
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 14:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhGVMJG (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:09:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232072AbhGVMI6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:08:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A342061248;
        Thu, 22 Jul 2021 12:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958173;
        bh=sbFUoNBeqxQyz+PoOvMtvTqFiIliAD9FROV/pedTT4o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HsOLil3/+9VmaYbtHSQRgpLmxFSE3bBBio3nSPGemC+GYEG1bOZAk4AFpp2qCsJ8L
         iSy9J6Krq522LD+k2cVVGxJMx67i1VQqFVs8GL9DJhOT4vPueJ0kCQhD6/tXlIs8oz
         vHfb6tY7nUOeLU2ngNR7QkQRw1M4yHxWgNAOOZKjwcHyjjk5CmSZcaw24EBbc796MD
         Czg56vYWKr4zEzXrUlQbcPErVFIZqbYOo/i19WN0uQbSs58zjWzGYMFCnv8efowCuT
         J0qsO+PiMOqS0q/SKUVcHnBPNWWDCmZiVlKn6k9EhG00thh7YCD+APPA6hXNsz+XsK
         DJwvW+din+56Q==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Brian Cain <bcain@codeaurora.org>,
        Chris Zankel <chris@zankel.net>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Helge Deller <deller@gmx.de>, Jeff Dike <jdike@addtoit.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Michal Simek <monstr@monstr.eu>,
        Richard Weinberger <richard@nod.at>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        uclinux-h8-devel@lists.sourceforge.jp,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v3 7/9] asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
Date:   Thu, 22 Jul 2021 14:48:12 +0200
Message-Id: <20210722124814.778059-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The inline version is used on three NOMMU architectures and is
particularly inefficient when it scans the string one byte at a time
twice. It also lacks a check for user_addr_max(), but this is
probably ok on NOMMU targets.

Consolidate the asm-generic implementation with the library version
that is used everywhere else.  This version is generalized enough to
work efficiently on both MMU and NOMMU targets, and using the
same code everywhere reduces the potential for subtle bugs.

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/h8300/Kconfig            |  2 ++
 arch/m68k/Kconfig             |  4 +--
 arch/riscv/Kconfig            |  4 +--
 include/asm-generic/uaccess.h | 46 ++++++-----------------------------
 4 files changed, 14 insertions(+), 42 deletions(-)

diff --git a/arch/h8300/Kconfig b/arch/h8300/Kconfig
index 3e3e0f16f7e0..53dfd2d47e0e 100644
--- a/arch/h8300/Kconfig
+++ b/arch/h8300/Kconfig
@@ -11,6 +11,8 @@ config H8300
 	select GENERIC_IRQ_SHOW
 	select FRAME_POINTER
 	select GENERIC_CPU_DEVICES
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select MODULES_USE_ELF_RELA
 	select COMMON_CLK
 	select ARCH_WANT_FRAME_POINTERS
diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
index 96989ad46f66..37a65bed6dfa 100644
--- a/arch/m68k/Kconfig
+++ b/arch/m68k/Kconfig
@@ -16,8 +16,8 @@ config M68K
 	select GENERIC_CPU_DEVICES
 	select GENERIC_IOMAP
 	select GENERIC_IRQ_SHOW
-	select GENERIC_STRNCPY_FROM_USER if MMU
-	select GENERIC_STRNLEN_USER if MMU
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select HAVE_AOUT if MMU
 	select HAVE_ASM_MODVERSIONS
 	select HAVE_DEBUG_BUGVERBOSE
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 8fcceb8eda07..47bbbcab91b2 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -56,8 +56,8 @@ config RISCV
 	select GENERIC_PTDUMP if MMU
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_STRNCPY_FROM_USER if MMU
-	select GENERIC_STRNLEN_USER if MMU
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
 	select HANDLE_DOMAIN_IRQ
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 2f8a5d3bbd57..df60871ce2e8 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -119,6 +119,11 @@ static inline void set_fs(mm_segment_t fs)
 #ifndef uaccess_kernel
 #define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #endif
+
+#ifndef user_addr_max
+#define user_addr_max() (uaccess_kernel() ? ~0UL : TASK_SIZE)
+#endif
+
 #endif /* CONFIG_SET_FS */
 
 #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
@@ -243,44 +248,6 @@ static inline int __get_user_fn(size_t size, const void __user *ptr, void *x)
 
 extern int __get_user_bad(void) __attribute__((noreturn));
 
-/*
- * Copy a null terminated string from userspace.
- */
-#ifndef strncpy_from_user
-static inline long
-strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	char *tmp;
-
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
-	strncpy(dst, (const char __force *)src, count);
-	for (tmp = dst; *tmp && count > 0; tmp++, count--)
-		;
-	return (tmp - dst);
-}
-#endif
-
-#ifndef strnlen_user
-/*
- * Return the size of a string (including the ending 0)
- *
- * Return 0 on exception, a value greater than N if too long
- *
- * Unlike strnlen, strnlen_user includes the nul terminator in
- * its returned count. Callers should check for a returned value
- * greater than N as an indication the string is too long.
- */
-static inline long strnlen_user(const char __user *src, long n)
-{
-	if (!access_ok(src, 1))
-		return 0;
-
-	return strnlen(src, n) + 1;
-}
-#endif
-
 /*
  * Zero Userspace
  */
@@ -305,4 +272,7 @@ clear_user(void __user *to, unsigned long n)
 
 #include <asm/extable.h>
 
+long strncpy_from_user(char *dst, const char __user *src, long count);
+long strnlen_user(const char __user *src, long n);
+
 #endif /* __ASM_GENERIC_UACCESS_H */
-- 
2.29.2

