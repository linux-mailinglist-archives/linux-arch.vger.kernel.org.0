Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A923D23B2
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 14:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232057AbhGVMIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:33074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232031AbhGVMIq (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:08:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2D64A61376;
        Thu, 22 Jul 2021 12:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958161;
        bh=9x/D2B8Ckh9kJKg3NBeTbDgPlisGTuKwHHdZXpMw9jQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AfeS6riJnkQc2D4GLt6Kqrrw2LRawAfLu2rVqZJU0uN7PtqARUEVZtQ60sf5rZvTT
         aSmuwWQaD1/7o+/UzcXjVSuimNjLYSll9JhUOtwUxQ+W8XVgO8xB9c7/ykuS9EUTNM
         uxDMEzwhhqieVob8FLOrQC4PtORDcTAXja4KzwN3tOPprSiS7XWzKvubSI4B9eOq1u
         73m7vLmCAOHLK51W/qVhOXKjRgAYOt5rdoz0Ip3+3sWWkKPUsqYFMrLyejJmr/2U14
         AgNDwnt3niJNGpuiLrhhtalDDP4K7phdFQlukCSDkom4AyjTw7yqX1zimm1d7VtsSe
         YJA+suLjgStEg==
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
        uclinux-h8-devel@lists.sourceforge.jp
Subject: [PATCH v3 5/9] csky: use generic strncpy/strnlen from_user
Date:   Thu, 22 Jul 2021 14:48:10 +0200
Message-Id: <20210722124814.778059-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Remove the csky implemenation of strncpy/strnlen and instead use the
generic versions.  The csky version is fairly slow because it always does
byte accesses even for aligned data, and it lacks a checks for
user_addr_max().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/csky/Kconfig               |   2 +
 arch/csky/include/asm/uaccess.h |   6 --
 arch/csky/lib/usercopy.c        | 108 --------------------------------
 3 files changed, 2 insertions(+), 114 deletions(-)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 2716f6395ba7..5043e221ced4 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -35,6 +35,8 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
diff --git a/arch/csky/include/asm/uaccess.h b/arch/csky/include/asm/uaccess.h
index e17c02a6709f..c40f06ee8d3e 100644
--- a/arch/csky/include/asm/uaccess.h
+++ b/arch/csky/include/asm/uaccess.h
@@ -209,12 +209,6 @@ unsigned long raw_copy_to_user(void *to, const void *from, unsigned long n);
 unsigned long __clear_user(void __user *to, unsigned long n);
 #define __clear_user __clear_user
 
-long strncpy_from_user(char *dst, const char *src, long count);
-#define strncpy_from_user strncpy_from_user
-
-long strnlen_user(const char *s, long n);
-#define strnlen_user strnlen_user
-
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
 
diff --git a/arch/csky/lib/usercopy.c b/arch/csky/lib/usercopy.c
index 938b750d2fb1..3c01c54421ca 100644
--- a/arch/csky/lib/usercopy.c
+++ b/arch/csky/lib/usercopy.c
@@ -142,114 +142,6 @@ unsigned long raw_copy_to_user(void *to, const void *from,
 }
 EXPORT_SYMBOL(raw_copy_to_user);
 
-/*
- * __strncpy_from_user: - Copy a NUL terminated string from userspace,
- * with less checking.
- * @dst:   Destination address, in kernel space.  This buffer must be at
- *         least @count bytes long.
- * @src:   Source address, in user space.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
- *
- * Copies a NUL-terminated string from userspace to kernel space.
- * Caller must check the specified block with access_ok() before calling
- * this function.
- *
- * On success, returns the length of the string (not including the trailing
- * NUL).
- *
- * If access to userspace fails, returns -EFAULT (some data may have been
- * copied).
- *
- * If @count is smaller than the length of the string, copies @count bytes
- * and returns @count.
- */
-long strncpy_from_user(char *dst, const char *src, long count)
-{
-	long res, faultres;
-	int tmp;
-
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
-	__asm__ __volatile__(
-	"       cmpnei  %3, 0           \n"
-	"       bf      4f              \n"
-	"1:     cmpnei  %1, 0          	\n"
-	"       bf      5f              \n"
-	"2:     ldb     %4, (%3, 0)     \n"
-	"       stb     %4, (%2, 0)     \n"
-	"       cmpnei  %4, 0           \n"
-	"       bf      3f              \n"
-	"       addi    %3,  1          \n"
-	"       addi    %2,  1          \n"
-	"       subi    %1,  1          \n"
-	"       br      1b              \n"
-	"3:     subu	%0, %1          \n"
-	"       br      5f              \n"
-	"4:     mov     %0, %5          \n"
-	"       br      5f              \n"
-	".section __ex_table, \"a\"     \n"
-	".align   2                     \n"
-	".long    2b, 4b                \n"
-	".previous                      \n"
-	"5:                             \n"
-	: "=r"(res), "=r"(count), "=r"(dst),
-	  "=r"(src), "=r"(tmp), "=r"(faultres)
-	: "5"(-EFAULT), "0"(count), "1"(count),
-	  "2"(dst), "3"(src)
-	: "memory");
-
-	return res;
-}
-EXPORT_SYMBOL(strncpy_from_user);
-
-/*
- * strnlen_user: - Get the size of a string in user space.
- * @str: The string to measure.
- * @n:   The maximum valid length
- *
- * Get the size of a NUL-terminated string in user space.
- *
- * Returns the size of the string INCLUDING the terminating NUL.
- * On exception, returns 0.
- * If the string is too long, returns a value greater than @n.
- */
-long strnlen_user(const char *s, long n)
-{
-	unsigned long res, tmp;
-
-	if (!access_ok(src, 1))
-		return -EFAULT;
-
-	__asm__ __volatile__(
-	"       cmpnei  %1, 0           \n"
-	"       bf      3f              \n"
-	"1:     cmpnei  %0, 0           \n"
-	"       bf      3f              \n"
-	"2:     ldb     %3, (%1, 0)     \n"
-	"       cmpnei  %3, 0           \n"
-	"       bf      3f              \n"
-	"       subi    %0,  1          \n"
-	"       addi    %1,  1          \n"
-	"       br      1b              \n"
-	"3:     subu    %2, %0          \n"
-	"       addi    %2,  1          \n"
-	"       br      5f              \n"
-	"4:     movi    %0, 0           \n"
-	"       br      5f              \n"
-	".section __ex_table, \"a\"     \n"
-	".align   2                     \n"
-	".long    2b, 4b                \n"
-	".previous                      \n"
-	"5:                             \n"
-	: "=r"(n), "=r"(s), "=r"(res), "=r"(tmp)
-	: "0"(n), "1"(s), "2"(n)
-	: "memory");
-
-	return res;
-}
-EXPORT_SYMBOL(strnlen_user);
-
 /*
  * __clear_user: - Zero a block of memory in user space, with less checking.
  * @to:   Destination address, in user space.
-- 
2.29.2

