Return-Path: <linux-arch+bounces-4813-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B01C902A35
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 22:50:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 703981C211C4
	for <lists+linux-arch@lfdr.de>; Mon, 10 Jun 2024 20:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07271514F0;
	Mon, 10 Jun 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="tsQpcNeB"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877151514E3;
	Mon, 10 Jun 2024 20:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718052536; cv=none; b=C4L0qbYzRvMY4AxmStQnYUjdGmOc0mt/BV4RyAhFYkBwO8bBZBgECTf5xRZkZivFUA2ud6y/vD/oslZASu3DywVo6ipphX2Ed+PUE0tJweJIWb/WjZ23LahwcemQ3qWRJxPCkiGy4iQfpTJkUmNhZvprcLfUkSwf1KVEihB2UCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718052536; c=relaxed/simple;
	bh=HEom2f9nqPDH+BblCEPQfasllgGSfBKQH1eKuClsvcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n7/zuPPzcRtWhIT0TTc4F10vWihK9YB6ZkSSjaCiu/fiBtoJDuj12GPndkMn2dpiZcwqXoiwocmTEjpT7AJvZfQJqyhEv/qTmKX0vLjTpMuHDqIETNUAjnpTihFtvDqoIdi60uMd+8aW37Y8W54VoaXd8Le0i80Pe7UMG9XY/VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=tsQpcNeB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D708EC4AF48;
	Mon, 10 Jun 2024 20:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1718052536;
	bh=HEom2f9nqPDH+BblCEPQfasllgGSfBKQH1eKuClsvcM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tsQpcNeB57uThZqtmJz2uP7dIDIbOiuBLKtYN1S0h9KofsPY+LiMsarc3KDWA800n
	 vZ87ZsrW9o+P/HKUD3jAGoNbkk6gC8IvyFp9EifHDY3/X+cXSqpq8GA3ooI0lHiMLB
	 lFocJn6d0REtPkDmMazP7SwwKsNdR8Ami0VhulN4=
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
Subject: [PATCH 6/7] arm64: start using 'asm goto' for put_user() when available
Date: Mon, 10 Jun 2024 13:48:20 -0700
Message-ID: <20240610204821.230388-7-torvalds@linux-foundation.org>
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
 arch/arm64/include/asm/uaccess.h | 77 +++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 31 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 23c2edf517ed..4ab3938290ab 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -294,29 +294,41 @@ do {									\
 	} while (0);							\
 } while (0)
 
-#define __put_mem_asm(store, reg, x, addr, err, type)			\
+#ifdef CONFIG_CC_HAS_ASM_GOTO
+#define __put_mem_asm(store, reg, x, addr, label, type)			\
+	asm goto(							\
+	"1:	" store "	" reg "0, [%1]\n"			\
+	"2:\n"								\
+	_ASM_EXTABLE_##type##ACCESS_ZERO(1b, %l2)			\
+	: : "rZ" (x), "r" (addr) : : label)
+#else
+#define __put_mem_asm(store, reg, x, addr, label, type) do {		\
+	int __pma_err = 0;						\
 	asm volatile(							\
 	"1:	" store "	" reg "1, [%2]\n"			\
 	"2:\n"								\
 	_ASM_EXTABLE_##type##ACCESS_ERR(1b, 2b, %w0)			\
-	: "+r" (err)							\
-	: "rZ" (x), "r" (addr))
+	: "+r" (__pma_err)						\
+	: "rZ" (x), "r" (addr));					\
+	if (__pma_err) goto label;					\
+} while (0)
+#endif
 
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
@@ -328,25 +340,34 @@ do {										\
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
@@ -369,15 +390,18 @@ do {									\
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
@@ -411,17 +435,8 @@ static __must_check __always_inline bool user_access_begin(const void __user *pt
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


