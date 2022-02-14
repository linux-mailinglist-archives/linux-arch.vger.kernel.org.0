Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A959C4B56DD
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 17:38:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356561AbiBNQha (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 11:37:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356433AbiBNQhG (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 11:37:06 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E11B85D;
        Mon, 14 Feb 2022 08:36:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C24B6CE19D9;
        Mon, 14 Feb 2022 16:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC36C340EF;
        Mon, 14 Feb 2022 16:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644856602;
        bh=reX3vVg+fu1kjAfrF+7GPz/swHfDQzZQ+k3OND5IY/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHdbggh11BS3osb40rsaIx+cXAkHVb2R0IuywaHPk8G/3hyIBrFrNboxJqken5wPd
         tuy1saO+tDqDe2v8W9Kr1/Y65+KLtFoiEO1CIQJH7HqQSTRqwZDHIUU87Df0TDMYAh
         fmpJGSxKQW2ffoxbQW5MEi6rF5DLBeke/TtNycsBXDRAAeIYwg6XaCmWRuaMiY+xCg
         EkVms+SYJhAhI0w8CnMZNsH4zhsm9cvQ6wjLyFiHRdEvM6xrye5arI+O8NM+hfceJA
         1KW7cdAANdnxQ+1Ff9Mi1pkGeTrHHSTQTPe0iKq5znH+H6pJJcAzmWw1/TDhlgeSrb
         eikdMJEUKLknA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, linux-arch@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, arnd@arndb.de,
        linux-kernel@vger.kernel.org
Cc:     linux@armlinux.org.uk, will@kernel.org, guoren@kernel.org,
        bcain@codeaurora.org, geert@linux-m68k.org, monstr@monstr.eu,
        tsbogend@alpha.franken.de, nickhu@andestech.com,
        green.hu@gmail.com, dinguyen@kernel.org, shorne@gmail.com,
        deller@gmx.de, mpe@ellerman.id.au, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com, hca@linux.ibm.com,
        dalias@libc.org, davem@davemloft.net, richard@nod.at,
        x86@kernel.org, jcmvbkbc@gmail.com, ebiederm@xmission.com,
        akpm@linux-foundation.org, ardb@kernel.org,
        linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        openrisc@lists.librecores.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        linux-xtensa@linux-xtensa.org
Subject: [PATCH 05/14] uaccess: add generic __{get,put}_kernel_nofault
Date:   Mon, 14 Feb 2022 17:34:43 +0100
Message-Id: <20220214163452.1568807-6-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220214163452.1568807-1-arnd@kernel.org>
References: <20220214163452.1568807-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

All architectures that don't provide __{get,put}_kernel_nofault() yet
can implement this on top of __{get,put}_user.

Add a generic version that lets everything use the normal
copy_{from,to}_kernel_nofault() code based on these, removing the last
use of get_fs()/set_fs() from architecture-independent code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/uaccess.h      |   2 -
 arch/arm64/include/asm/uaccess.h    |   2 -
 arch/m68k/include/asm/uaccess.h     |   2 -
 arch/mips/include/asm/uaccess.h     |   2 -
 arch/parisc/include/asm/uaccess.h   |   1 -
 arch/powerpc/include/asm/uaccess.h  |   2 -
 arch/riscv/include/asm/uaccess.h    |   2 -
 arch/s390/include/asm/uaccess.h     |   2 -
 arch/sparc/include/asm/uaccess_64.h |   2 -
 arch/um/include/asm/uaccess.h       |   2 -
 arch/x86/include/asm/uaccess.h      |   2 -
 include/asm-generic/uaccess.h       |   2 -
 include/linux/uaccess.h             |  19 +++++
 mm/maccess.c                        | 108 ----------------------------
 14 files changed, 19 insertions(+), 131 deletions(-)

diff --git a/arch/arm/include/asm/uaccess.h b/arch/arm/include/asm/uaccess.h
index 32dbfd81f42a..d20d78c34b94 100644
--- a/arch/arm/include/asm/uaccess.h
+++ b/arch/arm/include/asm/uaccess.h
@@ -476,8 +476,6 @@ do {									\
 	: "r" (x), "i" (-EFAULT)				\
 	: "cc")
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	const type *__pk_ptr = (src);					\
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 3a5ff5e20586..2e20879fe3cf 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -26,8 +26,6 @@
 #include <asm/memory.h>
 #include <asm/extable.h>
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 /*
  * Test whether a block of memory is a valid user space address.
  * Returns 1 if the range is valid, 0 otherwise.
diff --git a/arch/m68k/include/asm/uaccess.h b/arch/m68k/include/asm/uaccess.h
index ba670523885c..79617c0b2f91 100644
--- a/arch/m68k/include/asm/uaccess.h
+++ b/arch/m68k/include/asm/uaccess.h
@@ -390,8 +390,6 @@ raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 #define INLINE_COPY_FROM_USER
 #define INLINE_COPY_TO_USER
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	type *__gk_dst = (type *)(dst);					\
diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index f8f74f9f5883..db9a8e002b62 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -296,8 +296,6 @@ struct __large_struct { unsigned long buf[100]; };
 	(val) = __gu_tmp.t;						\
 }
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	int __gu_err;							\
diff --git a/arch/parisc/include/asm/uaccess.h b/arch/parisc/include/asm/uaccess.h
index ebf8a845b017..0925bbd6db67 100644
--- a/arch/parisc/include/asm/uaccess.h
+++ b/arch/parisc/include/asm/uaccess.h
@@ -95,7 +95,6 @@ struct exception_table_entry {
 	(val) = (__force __typeof__(*(ptr))) __gu_val;	\
 }
 
-#define HAVE_GET_KERNEL_NOFAULT
 #define __get_kernel_nofault(dst, src, type, err_label)	\
 {							\
 	type __z;					\
diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 63316100080c..a0032c2e7550 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -467,8 +467,6 @@ do {									\
 		unsafe_put_user(*(u8*)(_src + _i), (u8 __user *)(_dst + _i), e); \
 } while (0)
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 	__get_user_size_goto(*((type *)(dst)),				\
 		(__force type __user *)(src), sizeof(type), err_label)
diff --git a/arch/riscv/include/asm/uaccess.h b/arch/riscv/include/asm/uaccess.h
index c701a5e57a2b..4407b9e48d2c 100644
--- a/arch/riscv/include/asm/uaccess.h
+++ b/arch/riscv/include/asm/uaccess.h
@@ -346,8 +346,6 @@ unsigned long __must_check clear_user(void __user *to, unsigned long n)
 		__clear_user(to, n) : n;
 }
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	long __kr_err;							\
diff --git a/arch/s390/include/asm/uaccess.h b/arch/s390/include/asm/uaccess.h
index d74e26b48604..29332edf46f0 100644
--- a/arch/s390/include/asm/uaccess.h
+++ b/arch/s390/include/asm/uaccess.h
@@ -282,8 +282,6 @@ static inline unsigned long __must_check clear_user(void __user *to, unsigned lo
 int copy_to_user_real(void __user *dest, void *src, unsigned long count);
 void *s390_kernel_write(void *dst, const void *src, size_t size);
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 int __noreturn __put_kernel_bad(void);
 
 #define __put_kernel_asm(val, to, insn)					\
diff --git a/arch/sparc/include/asm/uaccess_64.h b/arch/sparc/include/asm/uaccess_64.h
index b283798315b1..5c12fb46bc61 100644
--- a/arch/sparc/include/asm/uaccess_64.h
+++ b/arch/sparc/include/asm/uaccess_64.h
@@ -210,8 +210,6 @@ __asm__ __volatile__(							\
 	       : "=r" (ret), "=r" (x) : "r" (__m(addr)),		\
 		 "i" (-EFAULT))
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #define __get_user_nocheck(data, addr, size, type) ({			     \
 	register int __gu_ret;						     \
 	register unsigned long __gu_val;				     \
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 17d18cfd82a5..1ecfc96bcc50 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -44,8 +44,6 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
 }
 
 /* no pagefaults for kernel addresses in um */
-#define HAVE_GET_KERNEL_NOFAULT 1
-
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 do {									\
 	*((type *)dst) = get_unaligned((type *)(src));			\
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 6956a63291b6..c6d9dc42724d 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -510,8 +510,6 @@ do {									\
 	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
 } while (0)
 
-#define HAVE_GET_KERNEL_NOFAULT
-
 #ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
 #define __get_kernel_nofault(dst, src, type, err_label)			\
 	__get_user_size(*((type *)(dst)), (__force type __user *)(src),	\
diff --git a/include/asm-generic/uaccess.h b/include/asm-generic/uaccess.h
index 10ffa8b5c117..0870fa11a7c5 100644
--- a/include/asm-generic/uaccess.h
+++ b/include/asm-generic/uaccess.h
@@ -77,8 +77,6 @@ do {									\
 		goto err_label;						\
 } while (0)
 
-#define HAVE_GET_KERNEL_NOFAULT 1
-
 static inline __must_check unsigned long
 raw_copy_from_user(void *to, const void __user * from, unsigned long n)
 {
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index ac0394087f7d..67e9bc94dc40 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -368,6 +368,25 @@ long strncpy_from_user_nofault(char *dst, const void __user *unsafe_addr,
 		long count);
 long strnlen_user_nofault(const void __user *unsafe_addr, long count);
 
+#ifndef __get_kernel_nofault
+#define __get_kernel_nofault(dst, src, type, label)	\
+do {							\
+	type __user *p = (type __force __user *)(src);	\
+	type data;					\
+	if (__get_user(data, p))			\
+		goto label;				\
+	*(type *)dst = data;				\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, label)	\
+do {							\
+	type __user *p = (type __force __user *)(dst);	\
+	type data = *(type *)src;			\
+	if (__put_user(data, p))			\
+		goto label;				\
+} while (0)
+#endif
+
 /**
  * get_kernel_nofault(): safely attempt to read from a location
  * @val: read into this variable
diff --git a/mm/maccess.c b/mm/maccess.c
index d3f1a1f0b1c1..cbd1b3959af2 100644
--- a/mm/maccess.c
+++ b/mm/maccess.c
@@ -12,8 +12,6 @@ bool __weak copy_from_kernel_nofault_allowed(const void *unsafe_src,
 	return true;
 }
 
-#ifdef HAVE_GET_KERNEL_NOFAULT
-
 #define copy_from_kernel_nofault_loop(dst, src, len, type, err_label)	\
 	while (len >= sizeof(type)) {					\
 		__get_kernel_nofault(dst, src, type, err_label);		\
@@ -102,112 +100,6 @@ long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
 	dst[-1] = '\0';
 	return -EFAULT;
 }
-#else /* HAVE_GET_KERNEL_NOFAULT */
-/**
- * copy_from_kernel_nofault(): safely attempt to read from kernel-space
- * @dst: pointer to the buffer that shall take the data
- * @src: address to read from
- * @size: size of the data chunk
- *
- * Safely read from kernel address @src to the buffer at @dst.  If a kernel
- * fault happens, handle that and return -EFAULT.  If @src is not a valid kernel
- * address, return -ERANGE.
- *
- * We ensure that the copy_from_user is executed in atomic context so that
- * do_page_fault() doesn't attempt to take mmap_lock.  This makes
- * copy_from_kernel_nofault() suitable for use within regions where the caller
- * already holds mmap_lock, or other locks which nest inside mmap_lock.
- */
-long copy_from_kernel_nofault(void *dst, const void *src, size_t size)
-{
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	if (!copy_from_kernel_nofault_allowed(src, size))
-		return -ERANGE;
-
-	set_fs(KERNEL_DS);
-	pagefault_disable();
-	ret = __copy_from_user_inatomic(dst, (__force const void __user *)src,
-			size);
-	pagefault_enable();
-	set_fs(old_fs);
-
-	if (ret)
-		return -EFAULT;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(copy_from_kernel_nofault);
-
-/**
- * copy_to_kernel_nofault(): safely attempt to write to a location
- * @dst: address to write to
- * @src: pointer to the data that shall be written
- * @size: size of the data chunk
- *
- * Safely write to address @dst from the buffer at @src.  If a kernel fault
- * happens, handle that and return -EFAULT.
- */
-long copy_to_kernel_nofault(void *dst, const void *src, size_t size)
-{
-	long ret;
-	mm_segment_t old_fs = get_fs();
-
-	set_fs(KERNEL_DS);
-	pagefault_disable();
-	ret = __copy_to_user_inatomic((__force void __user *)dst, src, size);
-	pagefault_enable();
-	set_fs(old_fs);
-
-	if (ret)
-		return -EFAULT;
-	return 0;
-}
-
-/**
- * strncpy_from_kernel_nofault: - Copy a NUL terminated string from unsafe
- *				 address.
- * @dst:   Destination address, in kernel space.  This buffer must be at
- *         least @count bytes long.
- * @unsafe_addr: Unsafe address.
- * @count: Maximum number of bytes to copy, including the trailing NUL.
- *
- * Copies a NUL-terminated string from unsafe address to kernel buffer.
- *
- * On success, returns the length of the string INCLUDING the trailing NUL.
- *
- * If access fails, returns -EFAULT (some data may have been copied and the
- * trailing NUL added).  If @unsafe_addr is not a valid kernel address, return
- * -ERANGE.
- *
- * If @count is smaller than the length of the string, copies @count-1 bytes,
- * sets the last byte of @dst buffer to NUL and returns @count.
- */
-long strncpy_from_kernel_nofault(char *dst, const void *unsafe_addr, long count)
-{
-	mm_segment_t old_fs = get_fs();
-	const void *src = unsafe_addr;
-	long ret;
-
-	if (unlikely(count <= 0))
-		return 0;
-	if (!copy_from_kernel_nofault_allowed(unsafe_addr, count))
-		return -ERANGE;
-
-	set_fs(KERNEL_DS);
-	pagefault_disable();
-
-	do {
-		ret = __get_user(*dst++, (const char __user __force *)src++);
-	} while (dst[-1] && ret == 0 && src - unsafe_addr < count);
-
-	dst[-1] = '\0';
-	pagefault_enable();
-	set_fs(old_fs);
-
-	return ret ? -EFAULT : src - unsafe_addr;
-}
-#endif /* HAVE_GET_KERNEL_NOFAULT */
 
 /**
  * copy_from_user_nofault(): safely attempt to read from a user-space location
-- 
2.29.2

