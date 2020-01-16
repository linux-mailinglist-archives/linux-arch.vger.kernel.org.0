Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC5EB13D10E
	for <lists+linux-arch@lfdr.de>; Thu, 16 Jan 2020 01:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgAPAVd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 15 Jan 2020 19:21:33 -0500
Received: from sv2-smtprelay2.synopsys.com ([149.117.73.133]:58922 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729548AbgAPAV2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>);
        Wed, 15 Jan 2020 19:21:28 -0500
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 42F6240710;
        Thu, 16 Jan 2020 00:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1579134087; bh=wTjg8je1GLFPZ7gb9T1YyqXkhQW7LS79Z0CW+YLPek4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fjuLtDAc+7TGwQlPH6Y4Udq1ppw/L/x06mC2vYxOuATS0qne+rdbsV3ToHVQZKx2Q
         3UHSdcurPoY3mLMSg2vchirIJv3o1l7PGHQ5h3T+a5/XG1EXzKHv/tAdNDKyUNfY9R
         lQOeyuEaparXIbFnpR+q3le9V1N/POFcu4lVzZAJrFEPZVpOF/ksDeYSDs3Fz+BbOH
         FyVANWVAamtoxN6rSOfrK0VDK1LxQQbNEm8QVdo2ydRYOMqqt7Kzm36esS3bvNx1vC
         BzfGSvIA53bc911alsgp8HTCEa9DxN6ohXUE1Eb4KLXzWp9LrxcicbcvauwShF5X6/
         ymby6mPIgqjtg==
Received: from vineetg-Latitude-E7450.internal.synopsys.com (vineetg-latitude-e7450.internal.synopsys.com [10.10.161.20])
        by mailhost.synopsys.com (Postfix) with ESMTP id ACE8CA0063;
        Thu, 16 Jan 2020 00:21:26 +0000 (UTC)
From:   Vineet Gupta <Vineet.Gupta1@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: [PATCH v2 2/2] ARC: uaccess: use optimized generic __strnlen_user/__strncpy_from_user
Date:   Wed, 15 Jan 2020 16:21:24 -0800
Message-Id: <20200116002124.17988-3-vgupta@synopsys.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116002124.17988-1-vgupta@synopsys.com>
References: <20200116002124.17988-1-vgupta@synopsys.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The existing ARC variants have 2 issues
 - Use ZOL which may not be present in forthcoming architecture
 - Byte loop based vs. generic version which is word loop based

Signed-off-by: Vineet Gupta <vgupta@synopsys.com>
---
 arch/arc/Kconfig               |  2 +
 arch/arc/include/asm/uaccess.h | 85 ++--------------------------------
 arch/arc/mm/extable.c          | 23 ---------
 3 files changed, 6 insertions(+), 104 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 26108ea785c2..3b074c4d31fb 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -26,6 +26,8 @@ config ARC
 	select GENERIC_PENDING_IRQ if SMP
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
+	select GENERIC_STRNCPY_FROM_USER if MMU
+	select GENERIC_STRNLEN_USER if MMU
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_DEBUG_STACKOVERFLOW
diff --git a/arch/arc/include/asm/uaccess.h b/arch/arc/include/asm/uaccess.h
index ea40ec7f6cae..a3c943993b7b 100644
--- a/arch/arc/include/asm/uaccess.h
+++ b/arch/arc/include/asm/uaccess.h
@@ -52,6 +52,8 @@
 #define __access_ok(addr, sz)	(unlikely(__kernel_ok) || \
 				 likely(__user_ok((addr), (sz))))
 
+#define user_addr_max() 	(uaccess_kernel() ? ~0UL : get_fs())
+
 /*********** Single byte/hword/word copies ******************/
 
 #define __get_user_fn(sz, u, k)					\
@@ -613,7 +615,7 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 	return res;
 }
 
-static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
+static inline unsigned long __clear_user(void __user *to, unsigned long n)
 {
 	long res = n;
 	unsigned char *d_char = to;
@@ -655,89 +657,10 @@ static inline unsigned long __arc_clear_user(void __user *to, unsigned long n)
 	return res;
 }
 
-static inline long
-__arc_strncpy_from_user(char *dst, const char __user *src, long count)
-{
-	long res = 0;
-	char val;
-
-	if (count == 0)
-		return 0;
-
-	__asm__ __volatile__(
-	"	mov	lp_count, %5		\n"
-	"	lp	3f			\n"
-	"1:	ldb.ab  %3, [%2, 1]		\n"
-	"	breq.d	%3, 0, 3f               \n"
-	"	stb.ab  %3, [%1, 1]		\n"
-	"	add	%0, %0, 1	# Num of NON NULL bytes copied	\n"
-	"3:								\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, %4		# sets @res as -EFAULT	\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word   1b, 4b			\n"
-	"	.previous			\n"
-	: "+r"(res), "+r"(dst), "+r"(src), "=r"(val)
-	: "g"(-EFAULT), "r"(count)
-	: "lp_count", "memory");
-
-	return res;
-}
-
-static inline long __arc_strnlen_user(const char __user *s, long n)
-{
-	long res, tmp1, cnt;
-	char val;
-
-	__asm__ __volatile__(
-	"	mov %2, %1			\n"
-	"1:	ldb.ab  %3, [%0, 1]		\n"
-	"	breq.d  %3, 0, 2f		\n"
-	"	sub.f   %2, %2, 1		\n"
-	"	bnz 1b				\n"
-	"	sub %2, %2, 1			\n"
-	"2:	sub %0, %1, %2			\n"
-	"3:	;nop				\n"
-	"	.section .fixup, \"ax\"		\n"
-	"	.align 4			\n"
-	"4:	mov %0, 0			\n"
-	"	j   3b				\n"
-	"	.previous			\n"
-	"	.section __ex_table, \"a\"	\n"
-	"	.align 4			\n"
-	"	.word 1b, 4b			\n"
-	"	.previous			\n"
-	: "=r"(res), "=r"(tmp1), "=r"(cnt), "=r"(val)
-	: "0"(s), "1"(n)
-	: "memory");
-
-	return res;
-}
-
-#ifndef CONFIG_CC_OPTIMIZE_FOR_SIZE
-
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
-#define __clear_user(d, n)		__arc_clear_user(d, n)
-#define __strncpy_from_user(d, s, n)	__arc_strncpy_from_user(d, s, n)
-#define __strnlen_user(s, n)		__arc_strnlen_user(s, n)
-#else
-extern unsigned long arc_clear_user_noinline(void __user *to,
-		unsigned long n);
-extern long arc_strncpy_from_user_noinline (char *dst, const char __user *src,
-		long count);
-extern long arc_strnlen_user_noinline(const char __user *src, long n);
-
-#define __clear_user(d, n)		arc_clear_user_noinline(d, n)
-#define __strncpy_from_user(d, s, n)	arc_strncpy_from_user_noinline(d, s, n)
-#define __strnlen_user(s, n)		arc_strnlen_user_noinline(s, n)
-
-#endif
+#define __clear_user		__clear_user
 
 #include <asm/segment.h>
 #include <asm-generic/uaccess.h>
diff --git a/arch/arc/mm/extable.c b/arch/arc/mm/extable.c
index b06b09ddf924..88fa3a4d4906 100644
--- a/arch/arc/mm/extable.c
+++ b/arch/arc/mm/extable.c
@@ -22,26 +22,3 @@ int fixup_exception(struct pt_regs *regs)
 
 	return 0;
 }
-
-#ifdef CONFIG_CC_OPTIMIZE_FOR_SIZE
-
-unsigned long arc_clear_user_noinline(void __user *to,
-		unsigned long n)
-{
-	return __arc_clear_user(to, n);
-}
-EXPORT_SYMBOL(arc_clear_user_noinline);
-
-long arc_strncpy_from_user_noinline(char *dst, const char __user *src,
-		long count)
-{
-	return __arc_strncpy_from_user(dst, src, count);
-}
-EXPORT_SYMBOL(arc_strncpy_from_user_noinline);
-
-long arc_strnlen_user_noinline(const char __user *src, long n)
-{
-	return __arc_strnlen_user(src, n);
-}
-EXPORT_SYMBOL(arc_strnlen_user_noinline);
-#endif
-- 
2.20.1

