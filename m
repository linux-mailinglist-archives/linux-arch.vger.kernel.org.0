Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669AB381398
	for <lists+linux-arch@lfdr.de>; Sat, 15 May 2021 00:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhENWMV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 May 2021 18:12:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:43190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233838AbhENWMS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 14 May 2021 18:12:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 70A936145B;
        Fri, 14 May 2021 22:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621030266;
        bh=VrxpV/PlyT0N3FVgNX+0ElK7BNcTmlFqFdqTpIbA/vc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r6EVJRjLyTEsZ77Ez7LlKQO8neT5nJpKu+LyZeS00HAbC1xyg9Z61/7wXc+8J2w0y
         zIJ+7i4QsmAULSF+tE8NhM2K9mTBa7iUi6e4NGc5edP4Y+eTC3HFEdLNblooGh2+Us
         AJOfFVkyoOhCXhWgI/phpYCs43WsyReCjgQ1BO7rdJmfRdVNmOktH5LHVL2JbgZvaQ
         rkZNeZi+hYtl37vhAjg3sUg7OnOrgfXQ0XVTMfwOIbLmMjV4QbslD8S+NSH6yf0x0z
         cvmbwsShRh/hT1MJZFdon/TXfHhrPMxuTeRQAndnej2AiGRl7NwR8CabX6tXwgyPx/
         5DMTe6Pe7gmMg==
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
Subject: [PATCH 4/5] asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
Date:   Sat, 15 May 2021 00:09:41 +0200
Message-Id: <20210514220942.879805-5-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514220942.879805-1-arnd@kernel.org>
References: <20210514220942.879805-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Consolidate the asm-generic implementation with the library version
that is used everywhere else.

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
index 372e4e69c43a..8e5241598007 100644
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
index a8ad8eb76120..ada7a2918c05 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -55,8 +55,8 @@ config RISCV
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
index c03889cc904c..83a48f430951 100644
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
 
+extern long strncpy_from_user(char *dst, const char __user *src, long count);
+extern long strnlen_user(const char __user *src, long n);
+
 #endif /* __ASM_GENERIC_UACCESS_H */
-- 
2.29.2

