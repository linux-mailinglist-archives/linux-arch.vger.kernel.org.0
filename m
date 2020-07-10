Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A74721B744
	for <lists+linux-arch@lfdr.de>; Fri, 10 Jul 2020 15:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727966AbgGJN5a (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 10 Jul 2020 09:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727110AbgGJN5R (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 10 Jul 2020 09:57:17 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844CCC08C5CE;
        Fri, 10 Jul 2020 06:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=7ceUKHsnbKVYctRn8wVbE58wUTyvOYGCEt8OXn6JGi0=; b=YcGenQz4JOiVLYK+UfnUTRU2eI
        C+oqvA4V8KcMj82mR/53cUdHrCNIjS+PW7O3UKaU/8dnsSA+Iwqx9fbb2dTJ6JkqmFVy+skR3C85P
        T8Yb4qSLEZaWADb1BbCa0Cq3Ub0pn+dEOt5bEiY9+gMjtZn32Rqrns/RYZvQffMeWdEaCcjlhkgcW
        TgbHuqbabw8Alk6rR1PXQspKa4Ubk/m3pkiRGDghhpIA8ihnXff4hLDSzRqgOk/8EJkjZO+X/PjOV
        gz/RIZOjonZpM9+Sbl0k8GyQuzeH3vs3Ck0cztDI52pIXkOAQVosLtIV8/euvuHQsP2d12dCSPUAQ
        vp+4k+YQ==;
Received: from [2001:4bb8:188:5f50:c70:4a89:bc61:2] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jttWa-0004gz-7P; Fri, 10 Jul 2020 13:57:12 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Nick Hu <nickhu@andestech.com>, Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/6] uaccess: remove segment_eq
Date:   Fri, 10 Jul 2020 15:57:04 +0200
Message-Id: <20200710135706.537715-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200710135706.537715-1-hch@lst.de>
References: <20200710135706.537715-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

segment_eq is only used to implement uaccess_kernel.  Just open code
uaccess_kernel in the arch uaccess headers and remove one layer of
indirection.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/alpha/include/asm/uaccess.h      | 2 +-
 arch/arc/include/asm/segment.h        | 3 +--
 arch/arm/include/asm/uaccess.h        | 4 ++--
 arch/arm64/include/asm/uaccess.h      | 2 +-
 arch/csky/include/asm/segment.h       | 2 +-
 arch/h8300/include/asm/segment.h      | 2 +-
 arch/ia64/include/asm/uaccess.h       | 2 +-
 arch/m68k/include/asm/segment.h       | 2 +-
 arch/microblaze/include/asm/uaccess.h | 2 +-
 arch/mips/include/asm/uaccess.h       | 2 +-
 arch/nds32/include/asm/uaccess.h      | 2 +-
 arch/nios2/include/asm/uaccess.h      | 2 +-
 arch/openrisc/include/asm/uaccess.h   | 2 +-
 arch/parisc/include/asm/uaccess.h     | 2 +-
 arch/powerpc/include/asm/uaccess.h    | 3 +--
 arch/riscv/include/asm/uaccess.h      | 4 +---
 arch/s390/include/asm/uaccess.h       | 2 +-
 arch/sh/include/asm/segment.h         | 3 +--
 arch/sparc/include/asm/uaccess_32.h   | 2 +-
 arch/sparc/include/asm/uaccess_64.h   | 2 +-
 arch/x86/include/asm/uaccess.h        | 2 +-
 arch/xtensa/include/asm/uaccess.h     | 2 +-
 include/asm-generic/uaccess.h         | 4 ++--
 include/linux/uaccess.h               | 2 --
 24 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/arch/alpha/include/asm/uaccess.h b/arch/alpha/include/asm/uaccess.h
index 1fe2b56cb861fe..1b6f25efa247f0 100644
--- a/arch/alpha/include/asm/uaccess.h
+++ b/arch/alpha/include/asm/uaccess.h
@@ -20,7 +20,7 @@
 #define get_fs()  (current_thread_info()->addr_limit)
 #define set_fs(x) (current_thread_info()->addr_limit = (x))
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 /*
  * Is a address valid? This does a straightforward calculation rather
diff --git a/arch/arc/include/asm/segment.h b/arch/arc/include/asm/segment.h
index 6a2a5be5026de7..871f8ab11bfd02 100644
--- a/arch/arc/include/asm/segment.h
+++ b/arch/arc/include/asm/segment.h
@@ -14,8 +14,7 @@ typedef unsigned long mm_segment_t;
 
 #define KERNEL_DS		MAKE_MM_SEG(0)
 #define USER_DS			MAKE_MM_SEG(TASK_SIZE)
-
-#define segment_eq(a, b)	((a) == (b))
+#define uaccess_kernel()	(get_fs() == KERNEL_DS)
 
 #endif /* __ASSEMBLY__ */
 #endif /* __ASMARC_SEGMENT_H */
diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 98c6b91be4a8ad..b19c9bec1f7a63 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -76,7 +76,7 @@ static inline void set_fs(mm_segment_t fs)
 	modify_domain(DOMAIN_KERNEL, fs ? DOMAIN_CLIENT : DOMAIN_MANAGER);
 }
 
-#define segment_eq(a, b)	((a) == (b))
+#define uaccess_kernel()	(get_fs() == KERNEL_DS)
 
 /* We use 33-bit arithmetic here... */
 #define __range_ok(addr, size) ({ \
@@ -263,7 +263,7 @@ extern int __put_user_8(void *, unsigned long long);
  */
 #define USER_DS			KERNEL_DS
 
-#define segment_eq(a, b)		(1)
+#define uaccess_kernel()	(true)
 #define __addr_ok(addr)		((void)(addr), 1)
 #define __range_ok(addr, size)	((void)(addr), 0)
 #define get_fs()		(KERNEL_DS)
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index bc5c7b09115205..fcb8174de505ea 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -49,7 +49,7 @@ static inline void set_fs(mm_segment_t fs)
 				CONFIG_ARM64_UAO));
 }
 
-#define segment_eq(a, b)	((a) == (b))
+#define uaccess_kernel()	(get_fs() == KERNEL_DS)
 
 /*
  * Test whether a block of memory is a valid user space address.
diff --git a/arch/csky/include/asm/segment.h b/arch/csky/include/asm/segment.h
index db2640d5f57591..79ede9b1a6467f 100644
--- a/arch/csky/include/asm/segment.h
+++ b/arch/csky/include/asm/segment.h
@@ -13,6 +13,6 @@ typedef struct {
 #define USER_DS			((mm_segment_t) { 0x80000000UL })
 #define get_fs()		(current_thread_info()->addr_limit)
 #define set_fs(x)		(current_thread_info()->addr_limit = (x))
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 #endif /* __ASM_CSKY_SEGMENT_H */
diff --git a/arch/h8300/include/asm/segment.h b/arch/h8300/include/asm/segment.h
index a407978f9f9fb8..37950725d9b9c8 100644
--- a/arch/h8300/include/asm/segment.h
+++ b/arch/h8300/include/asm/segment.h
@@ -33,7 +33,7 @@ static inline mm_segment_t get_fs(void)
 	return USER_DS;
 }
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/ia64/include/asm/uaccess.h b/arch/ia64/include/asm/uaccess.h
index 8aa473a4b0f4ef..179243c3dfc702 100644
--- a/arch/ia64/include/asm/uaccess.h
+++ b/arch/ia64/include/asm/uaccess.h
@@ -50,7 +50,7 @@
 #define get_fs()  (current_thread_info()->addr_limit)
 #define set_fs(x) (current_thread_info()->addr_limit = (x))
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 /*
  * When accessing user memory, we need to make sure the entire area really is in
diff --git a/arch/m68k/include/asm/segment.h b/arch/m68k/include/asm/segment.h
index c6686559e9b742..2b5e68a71ef78e 100644
--- a/arch/m68k/include/asm/segment.h
+++ b/arch/m68k/include/asm/segment.h
@@ -52,7 +52,7 @@ static inline void set_fs(mm_segment_t val)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
 #endif
 
-#define segment_eq(a, b) ((a).seg == (b).seg)
+#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 #endif /* __ASSEMBLY__ */
 
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index 6723c56ec3783b..304b04ffea2faf 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -41,7 +41,7 @@
 # define get_fs()	(current_thread_info()->addr_limit)
 # define set_fs(val)	(current_thread_info()->addr_limit = (val))
 
-# define segment_eq(a, b)	((a).seg == (b).seg)
+# define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 #ifndef CONFIG_MMU
 
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 62b298c50905f6..61fc01f177a64b 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -72,7 +72,7 @@ extern u64 __ua_limit;
 #define get_fs()	(current_thread_info()->addr_limit)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
 
 /*
  * eva_kernel_access() - determine whether kernel memory access on an EVA system
diff --git a/arch/nds32/include/asm/uaccess.h b/arch/nds32/include/asm/uaccess.h
index 3a9219f53ee0d8..010ba5f1d7dd6b 100644
--- a/arch/nds32/include/asm/uaccess.h
+++ b/arch/nds32/include/asm/uaccess.h
@@ -44,7 +44,7 @@ static inline void set_fs(mm_segment_t fs)
 	current_thread_info()->addr_limit = fs;
 }
 
-#define segment_eq(a, b)	((a) == (b))
+#define uaccess_kernel()	(get_fs() == KERNEL_DS)
 
 #define __range_ok(addr, size) (size <= get_fs() && addr <= (get_fs() -size))
 
diff --git a/arch/nios2/include/asm/uaccess.h b/arch/nios2/include/asm/uaccess.h
index e83f831a76f939..a741abbed6fbf5 100644
--- a/arch/nios2/include/asm/uaccess.h
+++ b/arch/nios2/include/asm/uaccess.h
@@ -30,7 +30,7 @@
 #define get_fs()		(current_thread_info()->addr_limit)
 #define set_fs(seg)		(current_thread_info()->addr_limit = (seg))
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 
 #define __access_ok(addr, len)			\
 	(((signed long)(((long)get_fs().seg) &	\
diff --git a/arch/openrisc/include/asm/uaccess.h b/arch/openrisc/include/asm/uaccess.h
index 17c24f14615fb5..48b691530d3ed4 100644
--- a/arch/openrisc/include/asm/uaccess.h
+++ b/arch/openrisc/include/asm/uaccess.h
@@ -43,7 +43,7 @@
 #define get_fs()	(current_thread_info()->addr_limit)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
 
-#define segment_eq(a, b)	((a) == (b))
+#define uaccess_kernel()	(get_fs() == KERNEL_DS)
 
 /* Ensure that the range from addr to addr+size is all within the process'
  * address space
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index ebbb9ffe038c76..ed2cd4fb479b0c 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -14,7 +14,7 @@
 #define KERNEL_DS	((mm_segment_t){0})
 #define USER_DS 	((mm_segment_t){1})
 
-#define segment_eq(a, b) ((a).seg == (b).seg)
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 
 #define get_fs()	(current_thread_info()->addr_limit)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 64c04ab0911236..00699903f1efca 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -38,8 +38,7 @@ static inline void set_fs(mm_segment_t fs)
 	set_thread_flag(TIF_FSCHECK);
 }
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
-
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #define user_addr_max()	(get_fs().seg)
 
 #ifdef __powerpc64__
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index 22de922d6ecb2f..f56c66b3f5fe21 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -64,11 +64,9 @@ static inline void set_fs(mm_segment_t fs)
 	current_thread_info()->addr_limit = fs;
 }
 
-#define segment_eq(a, b) ((a).seg == (b).seg)
-
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #define user_addr_max()	(get_fs().seg)
 
-
 /**
  * access_ok: - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index 324438889fe168..f09444d6aeab30 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -32,7 +32,7 @@
 #define USER_DS_SACF	(3)
 
 #define get_fs()        (current->thread.mm_segment)
-#define segment_eq(a,b) (((a) & 2) == ((b) & 2))
+#define uaccess_kernel() ((get_fs() & 2) == KERNEL_DS)
 
 void set_fs(mm_segment_t fs);
 
diff --git a/arch/sh/include/asm/segment.h b/arch/sh/include/asm/segment.h
index 33d1d28057cbfb..02e54a3335d68f 100644
--- a/arch/sh/include/asm/segment.h
+++ b/arch/sh/include/asm/segment.h
@@ -24,8 +24,7 @@ typedef struct {
 #define USER_DS		KERNEL_DS
 #endif
 
-#define segment_eq(a, b) ((a).seg == (b).seg)
-
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 
 #define get_fs()	(current_thread_info()->addr_limit)
 #define set_fs(x)	(current_thread_info()->addr_limit = (x))
diff --git a/arch/sparc/include/asm/uaccess_32.h b/arch/sparc/include/asm/uaccess_32.h
index d6d8413eca835a..0a2d3ebc4bb86d 100644
--- a/arch/sparc/include/asm/uaccess_32.h
+++ b/arch/sparc/include/asm/uaccess_32.h
@@ -28,7 +28,7 @@
 #define get_fs()	(current->thread.current_ds)
 #define set_fs(val)	((current->thread.current_ds) = (val))
 
-#define segment_eq(a, b) ((a).seg == (b).seg)
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 
 /* We have there a nice not-mapped page at PAGE_OFFSET - PAGE_SIZE, so that this test
  * can be fairly lightweight.
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index bf9d330073b235..698cf69f74e998 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -32,7 +32,7 @@
 
 #define get_fs() ((mm_segment_t){(current_thread_info()->current_ds)})
 
-#define segment_eq(a, b)  ((a).seg == (b).seg)
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 
 #define set_fs(val)								\
 do {										\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 18dfa07d3ef0df..dd3261f9f4eaad 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -33,7 +33,7 @@ static inline void set_fs(mm_segment_t fs)
 	set_thread_flag(TIF_FSCHECK);
 }
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #define user_addr_max() (current->thread.addr_limit.seg)
 
 /*
diff --git a/arch/xtensa/include/asm/uaccess.h b/arch/xtensa/include/asm/uaccess.h
index e57f0d0a88d8ba..b9758119feca19 100644
--- a/arch/xtensa/include/asm/uaccess.h
+++ b/arch/xtensa/include/asm/uaccess.h
@@ -35,7 +35,7 @@
 #define get_fs()	(current->thread.current_ds)
 #define set_fs(val)	(current->thread.current_ds = (val))
 
-#define segment_eq(a, b)	((a).seg == (b).seg)
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 
 #define __kernel_ok (uaccess_kernel())
 #define __user_ok(addr, size) \
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index e935318804f8ae..ba68ee4dabfaa7 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -86,8 +86,8 @@ static inline void set_fs(mm_segment_t fs)
 }
 #endif
 
-#ifndef segment_eq
-#define segment_eq(a, b) ((a).seg == (b).seg)
+#ifndef uaccess_kernel
+#define uaccess_kernel() (get_fs().seg == KERNEL_DS.seg)
 #endif
 
 #define access_ok(addr, size) __access_ok((unsigned long)(addr),(size))
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 0a76ddc07d5970..5c62d0c6f15b16 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -6,8 +6,6 @@
 #include <linux/sched.h>
 #include <linux/thread_info.h>
 
-#define uaccess_kernel() segment_eq(get_fs(), KERNEL_DS)
-
 #include <asm/uaccess.h>
 
 /*
-- 
2.26.2

