Return-Path: <linux-arch+bounces-4844-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBDE79047BC
	for <lists+linux-arch@lfdr.de>; Wed, 12 Jun 2024 01:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F54B28543F
	for <lists+linux-arch@lfdr.de>; Tue, 11 Jun 2024 23:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE295156228;
	Tue, 11 Jun 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="yK9v3CVa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E37D80607;
	Tue, 11 Jun 2024 23:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718149239; cv=none; b=SAHBI3Zj44vctibCOco/Xo6JQBnbUrro0pQE8gstOujKZJis3zDCu9ztDYw3gzwtrJnxi5dYsEdUZx6hXeCz/1Xqo/r+AU011g3pQ28AWC1YLHdJJdwC/2H9wLxjKHPpSgf7swxqdFNLYWcOczvpKei/s6T9q0XsQSffYZpEz5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718149239; c=relaxed/simple;
	bh=oZxDtzuHx8MBn0zVasvckJQ+JL28AlSKL3Zy74R6B6M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cxz3NpwzqSZLQYQBUDeO5FAuz/8C3abTmBS2qYDEtTh+IzdCzoNQcRVQpyZ7GCFkXf/ALyOhyh74a8COxqUITUxLJVigRX/WjQNyCzLfKwftGdCgO60b7homcFVDzJNrupxk5hQFcltr8+8dJEYztmIOvRU50w7ANU9Zs4zqgWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=yK9v3CVa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1653C2BD10;
	Tue, 11 Jun 2024 23:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718149238;
	bh=oZxDtzuHx8MBn0zVasvckJQ+JL28AlSKL3Zy74R6B6M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yK9v3CVaOW5j0gxxlSFLSyktayjK11TnqSusPYQalAa25PHpvBzqDPd9hG4a9zjcr
	 JDzccQxGdu1KlCNCn+ZqHtLy8BY3tTY6xSFw7sWgSebdJ7umjJD/hfhaYKfKeiP/If
	 FADNpbJ4/extbKVXjGqgzLao1JekKktjSCzPbxqc=
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Peter Anvin <hpa@zytor.com>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	the arch/x86 maintainers <x86@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-arch <linux-arch@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 6/7 v2] arm64: start using 'asm goto' for put_user() when available
Date: Tue, 11 Jun 2024 16:40:33 -0700
Message-ID: <20240611234033.717058-1-torvalds@linux-foundation.org>
X-Mailer: git-send-email 2.45.1.209.gc6f12300df
In-Reply-To: <CAHk-=wg4mwfbUQwEVDhEsA9MxZKTdTyOKTQa7n8M68_6fxo5Aw@mail.gmail.com>
References: <CAHk-=wg4mwfbUQwEVDhEsA9MxZKTdTyOKTQa7n8M68_6fxo5Aw@mail.gmail.com>
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

Unlike get_user(), there's no need to worry about old compilers.  All
supported compilers support the regular non-output 'asm goto', as
pointed out by Nathan Chancellor.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

This is the fixed version that actually uses "asm goto" for put_user()
because it doesn't accidentally disable it by using the old CONFIG
option that no longer exists. 

 arch/arm64/include/asm/asm-extable.h |  3 ++
 arch/arm64/include/asm/uaccess.h     | 70 ++++++++++++++--------------
 2 files changed, 39 insertions(+), 34 deletions(-)

diff --git a/arch/arm64/include/asm/asm-extable.h b/arch/arm64/include/asm/asm-extable.h
index 980d1dd8e1a3..b8a5861dc7b7 100644
--- a/arch/arm64/include/asm/asm-extable.h
+++ b/arch/arm64/include/asm/asm-extable.h
@@ -112,6 +112,9 @@
 #define _ASM_EXTABLE_KACCESS_ERR(insn, fixup, err)			\
 	_ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, err, wzr)
 
+#define _ASM_EXTABLE_KACCESS(insn, fixup)				\
+	_ASM_EXTABLE_KACCESS_ERR_ZERO(insn, fixup, wzr, wzr)
+
 #define _ASM_EXTABLE_LOAD_UNALIGNED_ZEROPAD(insn, fixup, data, addr)		\
 	__DEFINE_ASM_GPR_NUMS							\
 	__ASM_EXTABLE_RAW(#insn, #fixup,					\
diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 23c2edf517ed..6d4b16acc880 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -294,29 +294,28 @@ do {									\
 	} while (0);							\
 } while (0)
 
-#define __put_mem_asm(store, reg, x, addr, err, type)			\
-	asm volatile(							\
-	"1:	" store "	" reg "1, [%2]\n"			\
+#define __put_mem_asm(store, reg, x, addr, label, type)			\
+	asm goto(							\
+	"1:	" store "	" reg "0, [%1]\n"			\
 	"2:\n"								\
-	_ASM_EXTABLE_##type##ACCESS_ERR(1b, 2b, %w0)			\
-	: "+r" (err)							\
-	: "rZ" (x), "r" (addr))
+	_ASM_EXTABLE_##type##ACCESS(1b, %l2)				\
+	: : "rZ" (x), "r" (addr) : : label)
 
-#define __raw_put_mem(str, x, ptr, err, type)					\
+#define __raw_put_mem(str, x, ptr, label, type)					\
 do {										\
 	__typeof__(*(ptr)) __pu_val = (x);					\
 	switch (sizeof(*(ptr))) {						\
 	case 1:									\
-		__put_mem_asm(str "b", "%w", __pu_val, (ptr), (err), type);	\
+		__put_mem_asm(str "b", "%w", __pu_val, (ptr), label, type);	\
 		break;								\
 	case 2:									\
-		__put_mem_asm(str "h", "%w", __pu_val, (ptr), (err), type);	\
+		__put_mem_asm(str "h", "%w", __pu_val, (ptr), label, type);	\
 		break;								\
 	case 4:									\
-		__put_mem_asm(str, "%w", __pu_val, (ptr), (err), type);		\
+		__put_mem_asm(str, "%w", __pu_val, (ptr), label, type);		\
 		break;								\
 	case 8:									\
-		__put_mem_asm(str, "%x", __pu_val, (ptr), (err), type);		\
+		__put_mem_asm(str, "%x", __pu_val, (ptr), label, type);		\
 		break;								\
 	default:								\
 		BUILD_BUG();							\
@@ -328,25 +327,34 @@ do {										\
  * uaccess_ttbr0_disable(). As `x` and `ptr` could contain blocking functions,
  * we must evaluate these outside of the critical section.
  */
-#define __raw_put_user(x, ptr, err)					\
+#define __raw_put_user(x, ptr, label)					\
 do {									\
+	__label__ __rpu_failed;						\
 	__typeof__(*(ptr)) __user *__rpu_ptr = (ptr);			\
 	__typeof__(*(ptr)) __rpu_val = (x);				\
 	__chk_user_ptr(__rpu_ptr);					\
 									\
-	uaccess_ttbr0_enable();						\
-	__raw_put_mem("sttr", __rpu_val, __rpu_ptr, err, U);		\
-	uaccess_ttbr0_disable();					\
+	do {								\
+		uaccess_ttbr0_enable();					\
+		__raw_put_mem("sttr", __rpu_val, __rpu_ptr, __rpu_failed, U);	\
+		uaccess_ttbr0_disable();				\
+		break;							\
+	__rpu_failed:							\
+		uaccess_ttbr0_disable();				\
+		goto label;						\
+	} while (0);							\
 } while (0)
 
 #define __put_user_error(x, ptr, err)					\
 do {									\
+	__label__ __pu_failed;						\
 	__typeof__(*(ptr)) __user *__p = (ptr);				\
 	might_fault();							\
 	if (access_ok(__p, sizeof(*__p))) {				\
 		__p = uaccess_mask_ptr(__p);				\
-		__raw_put_user((x), __p, (err));			\
+		__raw_put_user((x), __p, __pu_failed);			\
 	} else	{							\
+	__pu_failed:							\
 		(err) = -EFAULT;					\
 	}								\
 } while (0)
@@ -369,15 +377,18 @@ do {									\
 do {									\
 	__typeof__(dst) __pkn_dst = (dst);				\
 	__typeof__(src) __pkn_src = (src);				\
-	int __pkn_err = 0;						\
 									\
-	__mte_enable_tco_async();					\
-	__raw_put_mem("str", *((type *)(__pkn_src)),			\
-		      (__force type *)(__pkn_dst), __pkn_err, K);	\
-	__mte_disable_tco_async();					\
-									\
-	if (unlikely(__pkn_err))					\
+	do {								\
+		__label__ __pkn_err;					\
+		__mte_enable_tco_async();				\
+		__raw_put_mem("str", *((type *)(__pkn_src)),		\
+			      (__force type *)(__pkn_dst), __pkn_err, K);	\
+		__mte_disable_tco_async();				\
+		break;							\
+	__pkn_err:							\
+		__mte_disable_tco_async();				\
 		goto err_label;						\
+	} while (0);							\
 } while(0)
 
 extern unsigned long __must_check __arch_copy_from_user(void *to, const void __user *from, unsigned long n);
@@ -411,17 +422,8 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	uaccess_ttbr0_disable()
-
-/*
- * The arm64 inline asms should learn abut asm goto, and we should
- * teach user_access_begin() about address masking.
- */
-#define unsafe_put_user(x, ptr, label)	do {				\
-	int __upu_err = 0;						\
-	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), __upu_err, U);	\
-	if (__upu_err) goto label;				\
-} while (0)
-
+#define unsafe_put_user(x, ptr, label) \
+	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), label, U)
 #define unsafe_get_user(x, ptr, label) \
 	__raw_get_mem("ldtr", x, uaccess_mask_ptr(ptr), label, U)
 
-- 
2.45.1.209.gc6f12300df


