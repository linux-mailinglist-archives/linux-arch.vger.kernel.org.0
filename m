Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE14025F2DF
	for <lists+linux-arch@lfdr.de>; Mon,  7 Sep 2020 07:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726708AbgIGF7F (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Sep 2020 01:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726833AbgIGF6k (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 7 Sep 2020 01:58:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F305AC061574;
        Sun,  6 Sep 2020 22:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m+ZhzJSNyKv4ho4WyRpE+IYeLmm+BOA5yzpJjCDM1ow=; b=XyRUTQyl6EfcfGxglwwBPlkUPZ
        Gcvb9MUcJap7nsGX7p+UnXKOrOIIQHJalyMsK6wL2ePsR5ZW2/YelQbE/3PrQyJUGdLiGy5U3etE2
        B8l15qJ5eyWMfl6RFUvN3EEKONyVS0Lv9FF1Jwc7iY4TFRoEnemb9I6rhM6Lk/PAcP14kK83Dx5UL
        eOFCipeljLlW9vNa+iwVyGBEXfln9sWcKoeq2nrbTpg0YgeZtWlzFFbCZ9DtPAdvPUy2n2P4dQcMh
        L6K5a/4/SpjAOk7dtS5eFYhaQn0M300jIZNTrz/rSeizaQFgdyZGkxzhcYCzvbRTvvy2AvSc1JcJy
        jaKyJJYg==;
Received: from [2001:4bb8:184:af1:e178:97b2:ac6b:4e16] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kFAAm-00036y-Lz; Mon, 07 Sep 2020 05:58:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 8/8] riscv: remove address space overrides using set_fs()
Date:   Mon,  7 Sep 2020 07:58:25 +0200
Message-Id: <20200907055825.1917151-9-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907055825.1917151-1-hch@lst.de>
References: <20200907055825.1917151-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Stop providing the possibility to override the address space using
set_fs() now that there is no need for that any more.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/riscv/Kconfig                   |  1 -
 arch/riscv/include/asm/thread_info.h |  6 ------
 arch/riscv/include/asm/uaccess.h     | 27 +--------------------------
 arch/riscv/kernel/process.c          |  1 -
 4 files changed, 1 insertion(+), 34 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 460e3971a80fde..33dde87218ddab 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -86,7 +86,6 @@ config RISCV
 	select SPARSE_IRQ
 	select SYSCTL_EXCEPTION_TRACE
 	select THREAD_INFO_IN_TASK
-	select SET_FS
 	select UACCESS_MEMCPY if !MMU
 
 config ARCH_MMAP_RND_BITS_MIN
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/thread_info.h
index 464a2bbc97ea33..a390711129de64 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -24,10 +24,6 @@
 #include <asm/processor.h>
 #include <asm/csr.h>
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 /*
  * low level task data that entry.S needs immediate access to
  * - this struct should fit entirely inside of one cache line
@@ -39,7 +35,6 @@ typedef struct {
 struct thread_info {
 	unsigned long		flags;		/* low level flags */
 	int                     preempt_count;  /* 0=>preemptible, <0=>BUG */
-	mm_segment_t		addr_limit;
 	/*
 	 * These stack pointers are overwritten on every system call or
 	 * exception.  SP is also saved to the stack it can be recovered when
@@ -59,7 +54,6 @@ struct thread_info {
 {						\
 	.flags		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 264e52fb62b143..c47e6b35c551f4 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -26,29 +26,6 @@
 #define __disable_user_access()							\
 	__asm__ __volatile__ ("csrc sstatus, %0" : : "r" (SR_SUM) : "memory")
 
-/*
- * The fs value determines whether argument validity checking should be
- * performed or not.  If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- */
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-
-#define KERNEL_DS	MAKE_MM_SEG(~0UL)
-#define USER_DS		MAKE_MM_SEG(TASK_SIZE)
-
-#define get_fs()	(current_thread_info()->addr_limit)
-
-static inline void set_fs(mm_segment_t fs)
-{
-	current_thread_info()->addr_limit = fs;
-}
-
-#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
-#define user_addr_max()	(get_fs().seg)
-
 /**
  * access_ok: - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -76,9 +53,7 @@ static inline void set_fs(mm_segment_t fs)
  */
 static inline int __access_ok(unsigned long addr, unsigned long size)
 {
-	const mm_segment_t fs = get_fs();
-
-	return size <= fs.seg && addr <= fs.seg - size;
+	return size <= TASK_SIZE && addr <= TASK_SIZE - size;
 }
 
 /*
diff --git a/arch/riscv/kernel/process.c b/arch/riscv/kernel/process.c
index 2b97c493427c9e..19225ec65db62f 100644
--- a/arch/riscv/kernel/process.c
+++ b/arch/riscv/kernel/process.c
@@ -84,7 +84,6 @@ void start_thread(struct pt_regs *regs, unsigned long pc,
 	}
 	regs->epc = pc;
 	regs->sp = sp;
-	set_fs(USER_DS);
 }
 
 void flush_thread(void)
-- 
2.28.0

