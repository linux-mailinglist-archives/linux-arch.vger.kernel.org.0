Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E743D23B8
	for <lists+linux-arch@lfdr.de>; Thu, 22 Jul 2021 14:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhGVMIy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 22 Jul 2021 08:08:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33226 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232029AbhGVMIw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 22 Jul 2021 08:08:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2C5061370;
        Thu, 22 Jul 2021 12:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626958167;
        bh=XPhpdi27QaAvcGbuFvwNEkCwvX3l5IQMstM8g6NJxdY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=USR3dk0Q8tG5ik9xAyJYZrNv8LbCR+3r7vdnwRLGKKoOLXR8P4ECDNPHiwwRi2Mov
         i6qrDRkPYkuPOI8yo7LVTNpZo7Yd3YzOxYsnbsnnsBTPxNP4R6rN7USAoHqIdpuxB7
         I1Wqwa7z4JFt4i7Y1hCnoOHN7AWeBrZsc0OXvbH+JbXz1Zhge1X8+P/RVU5lW+Najz
         MI4I2Vp+8VqC8OWI990QG7sZmflfV5Der3f0kDAU9dzin+MvvApEYr/aXtnZHznBwp
         P7sLZATtdORXSI/Yswi4H2b8hOpd4seSyPqxAaU+17PNUdIvIYE07dlMPgAsknxhjH
         kSyR9u43pih9A==
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
Subject: [PATCH v3 6/9] microblaze: use generic strncpy/strnlen from_user
Date:   Thu, 22 Jul 2021 14:48:11 +0200
Message-Id: <20210722124814.778059-7-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210722124814.778059-1-arnd@kernel.org>
References: <20210722124814.778059-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Remove the microblaze implemenation of strncpy/strnlen and instead use
the generic versions.  The microblaze version is fairly slow because it
always does byte accesses even for aligned data, and it lacks a checks
for user_addr_max().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/Kconfig                   |  2 +
 arch/microblaze/include/asm/uaccess.h     | 19 +----
 arch/microblaze/kernel/microblaze_ksyms.c |  3 -
 arch/microblaze/lib/uaccess_old.S         | 90 -----------------------
 4 files changed, 4 insertions(+), 110 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 14a67a42fcae..10dfa7b4feff 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -21,6 +21,8 @@ config MICROBLAZE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_PCI_IOMAP
 	select GENERIC_SCHED_CLOCK
+	select GENERIC_STRNCPY_FROM_USER
+	select GENERIC_STRNLEN_USER
 	select HAVE_ARCH_HASH
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index c44b59470e45..bbe39fe00461 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -296,28 +296,13 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 /*
  * Copy a null terminated string from userspace.
  */
-extern int __strncpy_user(char *to, const char __user *from, int len);
-
-static inline long
-strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	if (!access_ok(src, 1))
-		return -EFAULT;
-	return __strncpy_user(dst, src, count);
-}
+extern long strncpy_from_user(char *dst, const char __user *src, long count);
 
 /*
  * Return the size of a string (including the ending 0)
  *
  * Return 0 on exception, a value greater than N if too long
  */
-extern int __strnlen_user(const char __user *sstr, int len);
-
-static inline long strnlen_user(const char __user *src, long n)
-{
-	if (!access_ok(src, 1))
-		return 0;
-	return __strnlen_user(src, n);
-}
+extern long strnlen_user(const char __user *sstr, int len);
 
 #endif /* _ASM_MICROBLAZE_UACCESS_H */
diff --git a/arch/microblaze/kernel/microblaze_ksyms.c b/arch/microblaze/kernel/microblaze_ksyms.c
index 303aaf13573b..14e0f2100c41 100644
--- a/arch/microblaze/kernel/microblaze_ksyms.c
+++ b/arch/microblaze/kernel/microblaze_ksyms.c
@@ -25,9 +25,6 @@ EXPORT_SYMBOL(_mcount);
 /*
  * Assembly functions that may be used (directly or indirectly) by modules
  */
-EXPORT_SYMBOL(__copy_tofrom_user);
-EXPORT_SYMBOL(__strncpy_user);
-
 #ifdef CONFIG_OPT_LIB_ASM
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
diff --git a/arch/microblaze/lib/uaccess_old.S b/arch/microblaze/lib/uaccess_old.S
index eca290090038..dd5f3bfbc2c5 100644
--- a/arch/microblaze/lib/uaccess_old.S
+++ b/arch/microblaze/lib/uaccess_old.S
@@ -12,96 +12,6 @@
 #include <linux/linkage.h>
 #include <asm/page.h>
 
-/*
- * int __strncpy_user(char *to, char *from, int len);
- *
- * Returns:
- *  -EFAULT  for an exception
- *  len      if we hit the buffer limit
- *  bytes copied
- */
-
-	.text
-.globl __strncpy_user;
-.type  __strncpy_user, @function
-.align 4;
-__strncpy_user:
-
-	/*
-	 * r5 - to
-	 * r6 - from
-	 * r7 - len
-	 * r3 - temp count
-	 * r4 - temp val
-	 */
-	beqid	r7,3f
-	addik	r3,r7,0		/* temp_count = len */
-1:
-	lbu	r4,r6,r0
-	beqid	r4,2f
-	sb	r4,r5,r0
-
-	addik	r5,r5,1
-	addik	r6,r6,1		/* delay slot */
-
-	addik	r3,r3,-1
-	bnei	r3,1b		/* break on len */
-2:
-	rsubk	r3,r3,r7	/* temp_count = len - temp_count */
-3:
-	rtsd	r15,8
-	nop
-	.size   __strncpy_user, . - __strncpy_user
-
-	.section	.fixup, "ax"
-	.align	2
-4:
-	brid	3b
-	addik	r3,r0, -EFAULT
-
-	.section	__ex_table, "a"
-	.word	1b,4b
-
-/*
- * int __strnlen_user(char __user *str, int maxlen);
- *
- * Returns:
- *  0 on error
- *  maxlen + 1  if no NUL byte found within maxlen bytes
- *  size of the string (including NUL byte)
- */
-
-	.text
-.globl __strnlen_user;
-.type  __strnlen_user, @function
-.align 4;
-__strnlen_user:
-	beqid	r6,3f
-	addik	r3,r6,0
-1:
-	lbu	r4,r5,r0
-	beqid	r4,2f		/* break on NUL */
-	addik	r3,r3,-1	/* delay slot */
-
-	bneid	r3,1b
-	addik	r5,r5,1		/* delay slot */
-
-	addik	r3,r3,-1	/* for break on len */
-2:
-	rsubk	r3,r3,r6
-3:
-	rtsd	r15,8
-	nop
-	.size   __strnlen_user, . - __strnlen_user
-
-	.section	.fixup,"ax"
-4:
-	brid	3b
-	addk	r3,r0,r0
-
-	.section	__ex_table,"a"
-	.word	1b,4b
-
 /* Loop unrolling for __copy_tofrom_user */
 #define COPY(offset)	\
 1:	lwi	r4 , r6, 0x0000 + offset;	\
-- 
2.29.2

