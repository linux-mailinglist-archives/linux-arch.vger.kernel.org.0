Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8495D49098A
	for <lists+linux-arch@lfdr.de>; Mon, 17 Jan 2022 14:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbiAQN2K (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Jan 2022 08:28:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233841AbiAQN2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Jan 2022 08:28:10 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCAB5C061574;
        Mon, 17 Jan 2022 05:28:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CC540CE13A5;
        Mon, 17 Jan 2022 13:28:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC87C36AE7;
        Mon, 17 Jan 2022 13:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642426085;
        bh=BtG7I84GvB/Sz35ndvv2QPjfdM9pekvFOFAZuOIgw9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghT0ducj8wxuhb3IMBgYpurbShrG1FYBjGCA8UPHzsGxWXafgT4FDlFIOipDvU48K
         ViCgE1mDk87dtIZTI8lsPbl4NfC9yFi6buvAu1qZVwYsEwAazgj6KNWnUE8pV5oxiH
         tKpLm13mWhiiXtQrA/OurFtfw8so+Zfqw4m7JeWYtyKGo+0JEJHONkdsQeG69aBGgf
         0vw8bvp42Ke7ZAsJSlLV+5MsljtFD+HrRS7Oi07x5v1iVat0RmX5tM5Bl4124jl04t
         DV1LA/+Hg9zGc236HzzpULRvh5gkWUxAxWaWe4B/csXJfDUro6KtAeIx/w8bqcM3IX
         SXyyOkzeRArZg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org, Michal Simek <monstr@monstr.eu>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>, ebiederm@xmission.com,
        viro@zeniv.linux.org.uk, torvalds@linux-foundation.org,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] microblaze: remove CONFIG_SET_FS
Date:   Mon, 17 Jan 2022 14:27:03 +0100
Message-Id: <20220117132757.1881981-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
References: <CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

I picked microblaze as one of the architectures that still
use set_fs() and converted it not to.

Link: https://lore.kernel.org/lkml/CAK8P3a22ntk5fTuk6xjh1pyS-eVbGo7zDQSVkn2VG1xgp01D9g@mail.gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is an old patch I found after Christoph asked about
conversions for the remaining architectures. I have no idea
about the state of this patch, but there is a reasonable
chance that it works.
---
 arch/microblaze/Kconfig                   |  1 -
 arch/microblaze/include/asm/thread_info.h |  6 ---
 arch/microblaze/include/asm/uaccess.h     | 56 ++++++++++-------------
 arch/microblaze/kernel/asm-offsets.c      |  1 -
 4 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..1fb1cec087b7 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -42,7 +42,6 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
 	select SPARSE_IRQ
-	select SET_FS
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
 
diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index 44f5ca331862..a0ddd2a36fb9 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -56,17 +56,12 @@ struct cpu_context {
 	__u32	fsr;
 };
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 struct thread_info {
 	struct task_struct	*task; /* main task structure */
 	unsigned long		flags; /* low level flags */
 	unsigned long		status; /* thread-synchronous flags */
 	__u32			cpu; /* current CPU */
 	__s32			preempt_count; /* 0 => preemptable,< 0 => BUG*/
-	mm_segment_t		addr_limit; /* thread address space */
 
 	struct cpu_context	cpu_context;
 };
@@ -80,7 +75,6 @@ struct thread_info {
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index d2a8ef9f8978..346fe4618b27 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -16,45 +16,20 @@
 #include <asm/extable.h>
 #include <linux/string.h>
 
-/*
- * On Microblaze the fs value is actually the top of the corresponding
- * address space.
- *
- * The fs value determines whether argument validity checking should be
- * performed or not. If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- *
- * For non-MMU arch like Microblaze, KERNEL_DS and USER_DS is equal.
- */
-# define MAKE_MM_SEG(s)       ((mm_segment_t) { (s) })
-
-#  define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
-#  define USER_DS	MAKE_MM_SEG(TASK_SIZE - 1)
-
-# define get_fs()	(current_thread_info()->addr_limit)
-# define set_fs(val)	(current_thread_info()->addr_limit = (val))
-# define user_addr_max() get_fs().seg
-
-# define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
-
 static inline int access_ok(const void __user *addr, unsigned long size)
 {
 	if (!size)
 		goto ok;
 
-	if ((get_fs().seg < ((unsigned long)addr)) ||
-			(get_fs().seg < ((unsigned long)addr + size - 1))) {
-		pr_devel("ACCESS fail at 0x%08x (size 0x%x), seg 0x%08x\n",
-			(__force u32)addr, (u32)size,
-			(u32)get_fs().seg);
+	if ((((unsigned long)addr) > TASK_SIZE) ||
+	    (((unsigned long)addr + size - 1) > TASK_SIZE)) {
+		pr_devel("ACCESS fail at 0x%08x (size 0x%x)",
+			(__force u32)addr, (u32)size);
 		return 0;
 	}
 ok:
-	pr_devel("ACCESS OK at 0x%08x (size 0x%x), seg 0x%08x\n",
-			(__force u32)addr, (u32)size,
-			(u32)get_fs().seg);
+	pr_devel("ACCESS OK at 0x%08x (size 0x%x)\n",
+			(__force u32)addr, (u32)size);
 	return 1;
 }
 
@@ -280,6 +255,25 @@ extern long __user_bad(void);
 	__gu_err;							\
 })
 
+#define __get_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(src);	\
+	type data;					\
+	if (__get_user(data, p))			\
+		goto label;				\
+	*(type *)dst = data;				\
+}
+
+#define __put_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(dst);	\
+	type data = *(type *)src;			\
+	if (__put_user(data, p))			\
+		goto label;				\
+}
+
+#define HAVE_GET_KERNEL_NOFAULT
+
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
diff --git a/arch/microblaze/kernel/asm-offsets.c b/arch/microblaze/kernel/asm-offsets.c
index b77dd188dec4..47ee409508b1 100644
--- a/arch/microblaze/kernel/asm-offsets.c
+++ b/arch/microblaze/kernel/asm-offsets.c
@@ -86,7 +86,6 @@ int main(int argc, char *argv[])
 	/* struct thread_info */
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_ADDR_LIMIT, offsetof(struct thread_info, addr_limit));
 	DEFINE(TI_CPU_CONTEXT, offsetof(struct thread_info, cpu_context));
 	DEFINE(TI_PREEMPT_COUNT, offsetof(struct thread_info, preempt_count));
 	BLANK();
-- 
2.29.2

