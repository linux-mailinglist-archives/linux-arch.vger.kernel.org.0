Return-Path: <linux-arch+bounces-4812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2CAF902A33
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6C431C210E6
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 037191509AE;
	Mon, 10 Jun 2024 20:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WcEqUO5L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA051509A7;
	Mon, 10 Jun 2024 20:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052534; cv=none; b=p23o2ypytSC9brFK+JDLnQfAQMcXyBzrJrtH3qZqMIXY6X3iRF+TYqIBbF78xK1DWN3jLrUJaiwSGmSeLxgPDxeqrK47nVGReVspGWTpYQ3L32rwE84Xl8IO7QgewIPj+BRQoK1/UfbC0uUIkQZR1LuRICBIusK/xfn1Lq0PKlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052534; c=relaxed/simple;
	bh=KAQJIaOfP+WEGVQXzV2TNQP3Of4y7BukbXhKYFCQjeY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DnkIPo6br/NuHJrpbPK3wkCLdVgX/e7qyJwH7CodtCJTPy+URDTpTlC0WzIUQ9aprKMkXuz4yrBInxlWY6gqm0pXFK6gx6cR9X/CrOZHRIQuz7UbBhgd6woHuM/yc5z42TvQpj+ufZCcBNLeOuxU3KcTLUWvx1WJ+lKkhrusqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WcEqUO5L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DAA0C32789;
	Mon, 10 Jun 2024 20:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052534;
	bh=KAQJIaOfP+WEGVQXzV2TNQP3Of4y7BukbXhKYFCQjeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WcEqUO5Lpe6OHFnwpQMXyUdoGKQHdTYR2rlVNODqpnaJNG/fEglmr5ZPYmRTFPxyB
	 S/0CvQksrc3pBlx1FM6hLWMsrRO3S64HMU37Zt+XxM3ilNXSME55wL01uTt4M4aSYC
	 4U9DhTQFdC+7o4TjhgQaMhKS4U0LEYWKIJsZ5BZ8=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5/7] arm64: start using 'asm goto' for get_user() when available
Date: Mon, 10 Jun 2024 13:48:19 -0700
Message-ID: <20240610204821.230388-6-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <20240610204821.230388-1-torvalds@linux-foundation.org>
References: <20240610204821.230388-1-torvalds@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This generates noticeably better code with compilers that support it,
since we don't need to test the error register etc, the exception just
jumps to the error handling directly.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/arm64/include/asm/uaccess.h | 113 ++++++++++++++++++++++++-------
 arch/arm64/kernel/mte.c          |  12 ++--
 2 files changed, 95 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 14be5000c5a0..23c2edf517ed 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -184,29 +184,40 @@ static inline void __user *__uaccess_mask_ptr(const void __user *ptr)
  * The "__xxx_error" versions set the third argument to -EFAULT if an error
  * occurs, and leave it unchanged on success.
  */
-#define __get_mem_asm(load, reg, x, addr, err, type)			\
+#ifdef CONFIG_CC_HAS_ASM_GOTO_OUTPUT
+#define __get_mem_asm(load, reg, x, addr, label, type)			\
+	asm_goto_output(						\
+	"1:	" load "	" reg "0, [%1]\n"			\
+	_ASM_EXTABLE_##type##ACCESS_ERR(1b, %l2, %w0)			\
+	: "=r" (x)							\
+	: "r" (addr) : : label)
+#else
+#define __get_mem_asm(load, reg, x, addr, label, type) do {		\
+	int __gma_err = 0;						\
 	asm volatile(							\
 	"1:	" load "	" reg "1, [%2]\n"			\
 	"2:\n"								\
 	_ASM_EXTABLE_##type##ACCESS_ERR_ZERO(1b, 2b, %w0, %w1)		\
-	: "+r" (err), "=r" (x)						\
-	: "r" (addr))
+	: "+r" (__gma_err), "=r" (x)					\
+	: "r" (addr));							\
+	if (__gma_err) goto label; } while (0)
+#endif
 
-#define __raw_get_mem(ldr, x, ptr, err, type)					\
+#define __raw_get_mem(ldr, x, ptr, label, type)					\
 do {										\
 	unsigned long __gu_val;							\
 	switch (sizeof(*(ptr))) {						\
 	case 1:									\
-		__get_mem_asm(ldr "b", "%w", __gu_val, (ptr), (err), type);	\
+		__get_mem_asm(ldr "b", "%w", __gu_val, (ptr), label, type);	\
 		break;								\
 	case 2:									\
-		__get_mem_asm(ldr "h", "%w", __gu_val, (ptr), (err), type);	\
+		__get_mem_asm(ldr "h", "%w", __gu_val, (ptr), label, type);	\
 		break;								\
 	case 4:									\
-		__get_mem_asm(ldr, "%w", __gu_val, (ptr), (err), type);		\
+		__get_mem_asm(ldr, "%w", __gu_val, (ptr), label, type);		\
 		break;								\
 	case 8:									\
-		__get_mem_asm(ldr, "%x",  __gu_val, (ptr), (err), type);	\
+		__get_mem_asm(ldr, "%x",  __gu_val, (ptr), label, type);	\
 		break;								\
 	default:								\
 		BUILD_BUG();							\
@@ -219,27 +230,34 @@ do {										\
  * uaccess_ttbr0_disable(). As `x` and `ptr` could contain blocking functions,
  * we must evaluate these outside of the critical section.
  */
-#define __raw_get_user(x, ptr, err)					\
+#define __raw_get_user(x, ptr, label)					\
 do {									\
 	__typeof__(*(ptr)) __user *__rgu_ptr = (ptr);			\
 	__typeof__(x) __rgu_val;					\
 	__chk_user_ptr(ptr);						\
-									\
-	uaccess_ttbr0_enable();						\
-	__raw_get_mem("ldtr", __rgu_val, __rgu_ptr, err, U);		\
-	uaccess_ttbr0_disable();					\
-									\
-	(x) = __rgu_val;						\
+	do {								\
+		__label__ __rgu_failed;					\
+		uaccess_ttbr0_enable();					\
+		__raw_get_mem("ldtr", __rgu_val, __rgu_ptr, __rgu_failed, U);	\
+		uaccess_ttbr0_disable();				\
+		(x) = __rgu_val;					\
+		break;							\
+	__rgu_failed:							\
+		uaccess_ttbr0_disable();				\
+		goto label;						\
+	} while (0);							\
 } while (0)
 
 #define __get_user_error(x, ptr, err)					\
 do {									\
+	__label__ __gu_failed;						\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_get_user((x), __p, (err));			\
+		__raw_get_user((x), __p, __gu_failed);			\
 	} else {							\
+	__gu_failed:							\
 		(x) = (__force __typeof__(x))0; (err) = -EFAULT;	\
 	}								\
 } while (0)
@@ -262,15 +280,18 @@ do {									\
 do {									\
 	__typeof__(dst) __gkn_dst = (dst);				\
 	__typeof__(src) __gkn_src = (src);				\
-	int __gkn_err = 0;						\
+	do { 								\
+		__label__ __gkn_label;					\
 									\
-	__mte_enable_tco_async();					\
-	__raw_get_mem("ldr", *((type *)(__gkn_dst)),			\
-		      (__force type *)(__gkn_src), __gkn_err, K);	\
-	__mte_disable_tco_async();					\
-									\
-	if (unlikely(__gkn_err))					\
+		__mte_enable_tco_async();				\
+		__raw_get_mem("ldr", *((type *)(__gkn_dst)),		\
+		      (__force type *)(__gkn_src), __gkn_label, K);	\
+		__mte_disable_tco_async();				\
+		break;							\
+	__gkn_label:							\
+		__mte_disable_tco_async();				\
 		goto err_label;						\
+	} while (0);							\
 } while (0)
 
 #define __put_mem_asm(store, reg, x, addr, err, type)			\
@@ -381,6 +402,52 @@ extern unsigned long __must_check __arch_copy_to_user(void __user *to, const voi
 	__actu_ret;							\
 })
 
+static __must_check __always_inline bool user_access_begin(const void __user *ptr, size_t len)
+{
+	if (unlikely(!access_ok(ptr,len)))
+		return 0;
+	uaccess_ttbr0_enable();
+	return 1;
+}
+#define user_access_begin(a,b)	user_access_begin(a,b)
+#define user_access_end()	uaccess_ttbr0_disable()
+
+/*
+ * The arm64 inline asms should learn abut asm goto, and we should
+ * teach user_access_begin() about address masking.
+ */
+#define unsafe_put_user(x, ptr, label)	do {				\
+	int __upu_err = 0;						\
+	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), __upu_err, U);	\
+	if (__upu_err) goto label;				\
+} while (0)
+
+#define unsafe_get_user(x, ptr, label) \
+	__raw_get_mem("ldtr", x, uaccess_mask_ptr(ptr), label, U)
+
+/*
+ * We want the unsafe accessors to always be inlined and use
+ * the error labels - thus the macro games.
+ */
+#define unsafe_copy_loop(dst, src, len, type, label)				\
+	while (len >= sizeof(type)) {						\
+		unsafe_put_user(*(type *)(src),(type __user *)(dst),label);	\
+		dst += sizeof(type);						\
+		src += sizeof(type);						\
+		len -= sizeof(type);						\
+	}
+
+#define unsafe_copy_to_user(_dst,_src,_len,label)			\
+do {									\
+	char __user *__ucu_dst = (_dst);				\
+	const char *__ucu_src = (_src);					\
+	size_t __ucu_len = (_len);					\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u64, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u32, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u16, label);	\
+	unsafe_copy_loop(__ucu_dst, __ucu_src, __ucu_len, u8, label);	\
+} while (0)
+
 #define INLINE_COPY_TO_USER
 #define INLINE_COPY_FROM_USER
 
diff --git a/arch/arm64/kernel/mte.c b/arch/arm64/kernel/mte.c
index dcdcccd40891..6174671be7c1 100644
--- a/arch/arm64/kernel/mte.c
+++ b/arch/arm64/kernel/mte.c
@@ -582,12 +582,9 @@ subsys_initcall(register_mte_tcf_preferred_sysctl);
 size_t mte_probe_user_range(const char __user *uaddr, size_t size)
 {
 	const char __user *end = uaddr + size;
-	int err = 0;
 	char val;
 
-	__raw_get_user(val, uaddr, err);
-	if (err)
-		return size;
+	__raw_get_user(val, uaddr, efault);
 
 	uaddr = PTR_ALIGN(uaddr, MTE_GRANULE_SIZE);
 	while (uaddr < end) {
@@ -595,12 +592,13 @@ size_t mte_probe_user_range(const char __user *uaddr, size_t size)
 		 * A read is sufficient for mte, the caller should have probed
 		 * for the pte write permission if required.
 		 */
-		__raw_get_user(val, uaddr, err);
-		if (err)
-			return end - uaddr;
+		__raw_get_user(val, uaddr, efault);
 		uaddr += MTE_GRANULE_SIZE;
 	}
 	(void)val;
 
 	return 0;
+
+efault:
+	return end - uaddr;
 }
-- 
2.45.1.209.gc6f12300df


