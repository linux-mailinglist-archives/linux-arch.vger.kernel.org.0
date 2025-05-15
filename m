Return-Path: <linux-arch+bounces-11942-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B109FAB86D7
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 14:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BAC2A02E43
	for <lists+linux-arch@lfdr.de>; Thu, 15 May 2025 12:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156BF29AB1C;
	Thu, 15 May 2025 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fp0lHU6m"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3029AB19;
	Thu, 15 May 2025 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747313212; cv=none; b=DRzDi3M+JE3hoMHR6cGrwnycQtqGQsUKsUZyhD0yMn8kZshrpdnVUlS9yKZRg4EXmAz41ZXnsbDZ6oz8BBimo8rdukMxn2L7PH0xG+FSY1iLkj291rdOyYSZHrx4hcjzXveU74UEcWbe/rbwWfYbqA4zfBsHAatYr08eCIjs1H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747313212; c=relaxed/simple;
	bh=H074XjrmWtzSuFHce5jj8Mm94I4RRwp0SASD9hzDHoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=npY1GQ5u6xw6MPVdcRD4dV2wOauGYMMNepcu4HCk8uo/zhK4AxfFr+OWDugACWE5Dy9LBs/xN+dlKwtjHY8F4f9QYDEFeChQV5QcXcqUtWIOkCVhiL0mjGDOprbcNangFfN8odfIwopnOwVOI9FNSvJ20qJQszId/nzIzKpCs88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fp0lHU6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07BA8C4CEEB;
	Thu, 15 May 2025 12:46:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747313211;
	bh=H074XjrmWtzSuFHce5jj8Mm94I4RRwp0SASD9hzDHoo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fp0lHU6mslI28nKFzBjVJ7bmcge2DWW00i22Ygg0Bj2ydbT/x6ND337sOLWEyCpQS
	 dNHIMS5fLQb0hQX4/iFfUzbwvbU3DvuxJFa3VWCmf3hl+euMYJarWVRgFXra9heSQp
	 hDjq/T0HMM+bgTJ7vmrrgPqgNA3jxWhH7riNH0qbe/eX41/VSZCiBM6HSPSBQYo+ET
	 9kwuzUsVw8z6xsftMFkYTkeTEzeW7RxWHyfE+VPnhS8NQh6Yje3fauzEMr26CzpOAd
	 0am/wDMZOf0U5iwLiaSUUffBMD5FfWffmgvWtf+L+qa0iTItiL7DMua4XpPypjykz3
	 BT6MdCZ8oIBBw==
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	linux-arch@vger.kernel.org
Subject: [PATCH 01/15] bugs/core: Extend __WARN_FLAGS() with the 'cond_str' parameter
Date: Thu, 15 May 2025 14:46:30 +0200
Message-ID: <20250515124644.2958810-2-mingo@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250515124644.2958810-1-mingo@kernel.org>
References: <20250515124644.2958810-1-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Push the new parameter down into every architecture that defines __WARN_FLAGS():

  arm64
  loongarch
  parisc
  powerpc
  riscv
  s390
  sh
  x86

Don't pass anything substantial down yet, just propagate the
new parameter with empty strings, without generating it or
using it.

( The string is never NULL, so it can be concatenated at the
  preprocessor level. )

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: <linux-arch@vger.kernel.org>
---
 arch/arm64/include/asm/bug.h     | 2 +-
 arch/loongarch/include/asm/bug.h | 2 +-
 arch/parisc/include/asm/bug.h    | 4 ++--
 arch/powerpc/include/asm/bug.h   | 2 +-
 arch/riscv/include/asm/bug.h     | 2 +-
 arch/s390/include/asm/bug.h      | 2 +-
 arch/sh/include/asm/bug.h        | 2 +-
 arch/x86/include/asm/bug.h       | 2 +-
 include/asm-generic/bug.h        | 7 ++++---
 9 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/bug.h b/arch/arm64/include/asm/bug.h
index 28be048db3f6..bceeaec21fb9 100644
--- a/arch/arm64/include/asm/bug.h
+++ b/arch/arm64/include/asm/bug.h
@@ -19,7 +19,7 @@
 	unreachable();					\
 } while (0)
 
-#define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(cond_str, flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
 
 #define HAVE_ARCH_BUG
 
diff --git a/arch/loongarch/include/asm/bug.h b/arch/loongarch/include/asm/bug.h
index f6f254f2c5db..51c2cb98d728 100644
--- a/arch/loongarch/include/asm/bug.h
+++ b/arch/loongarch/include/asm/bug.h
@@ -42,7 +42,7 @@
 	asm_inline volatile (__stringify(ASM_BUG_FLAGS(flags))		\
 			     extra);
 
-#define __WARN_FLAGS(flags)					\
+#define __WARN_FLAGS(cond_str, flags)				\
 do {								\
 	instrumentation_begin();				\
 	__BUG_FLAGS(BUGFLAG_WARNING|(flags), ANNOTATE_REACHABLE(10001b));\
diff --git a/arch/parisc/include/asm/bug.h b/arch/parisc/include/asm/bug.h
index 833555f74ffa..1a87cf80ec3c 100644
--- a/arch/parisc/include/asm/bug.h
+++ b/arch/parisc/include/asm/bug.h
@@ -50,7 +50,7 @@
 #endif
 
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-#define __WARN_FLAGS(flags)						\
+#define __WARN_FLAGS(cond_str, flags)					\
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
@@ -66,7 +66,7 @@
 			     "i" (sizeof(struct bug_entry)) );		\
 	} while(0)
 #else
-#define __WARN_FLAGS(flags)						\
+#define __WARN_FLAGS(cond_str, flags)					\
 	do {								\
 		asm volatile("\n"					\
 			     "1:\t" PARISC_BUG_BREAK_ASM "\n"		\
diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 1db485aacbd9..34d39ec79720 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -72,7 +72,7 @@
 } while (0)
 #define HAVE_ARCH_BUG
 
-#define __WARN_FLAGS(flags) BUG_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags))
+#define __WARN_FLAGS(cond_str, flags) BUG_ENTRY("twi 31, 0, 0", BUGFLAG_WARNING | (flags))
 
 #ifdef CONFIG_PPC64
 #define BUG_ON(x) do {						\
diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
index 1aaea81fb141..b22ee4d2c882 100644
--- a/arch/riscv/include/asm/bug.h
+++ b/arch/riscv/include/asm/bug.h
@@ -76,7 +76,7 @@ do {								\
 	unreachable();						\
 } while (0)
 
-#define __WARN_FLAGS(flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
+#define __WARN_FLAGS(cond_str, flags) __BUG_FLAGS(BUGFLAG_WARNING|(flags))
 
 #define HAVE_ARCH_BUG
 
diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
index c500d45fb465..ef3e495ec1e3 100644
--- a/arch/s390/include/asm/bug.h
+++ b/arch/s390/include/asm/bug.h
@@ -46,7 +46,7 @@
 	unreachable();					\
 } while (0)
 
-#define __WARN_FLAGS(flags) do {			\
+#define __WARN_FLAGS(cond_str, flags) do {		\
 	__EMIT_BUG(BUGFLAG_WARNING|(flags));		\
 } while (0)
 
diff --git a/arch/sh/include/asm/bug.h b/arch/sh/include/asm/bug.h
index 05a485c4fabc..834c621ab249 100644
--- a/arch/sh/include/asm/bug.h
+++ b/arch/sh/include/asm/bug.h
@@ -52,7 +52,7 @@ do {							\
 	unreachable();					\
 } while (0)
 
-#define __WARN_FLAGS(flags)				\
+#define __WARN_FLAGS(cond_str, flags)			\
 do {							\
 	__asm__ __volatile__ (				\
 		"1:\t.short %O0\n"			\
diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
index f0e9acf72547..413b86b876d9 100644
--- a/arch/x86/include/asm/bug.h
+++ b/arch/x86/include/asm/bug.h
@@ -92,7 +92,7 @@ do {								\
  * were to trigger, we'd rather wreck the machine in an attempt to get the
  * message out than not know about it.
  */
-#define __WARN_FLAGS(flags)					\
+#define __WARN_FLAGS(cond_str, flags)				\
 do {								\
 	__auto_type __flags = BUGFLAG_WARNING|(flags);		\
 	instrumentation_begin();				\
diff --git a/include/asm-generic/bug.h b/include/asm-generic/bug.h
index 387720933973..af76e4a04b16 100644
--- a/include/asm-generic/bug.h
+++ b/include/asm-generic/bug.h
@@ -100,17 +100,18 @@ extern __printf(1, 2) void __warn_printk(const char *fmt, ...);
 		instrumentation_end();					\
 	} while (0)
 #else
-#define __WARN()		__WARN_FLAGS(BUGFLAG_TAINT(TAINT_WARN))
+#define __WARN()		__WARN_FLAGS("", BUGFLAG_TAINT(TAINT_WARN))
 #define __WARN_printf(taint, arg...) do {				\
 		instrumentation_begin();				\
 		__warn_printk(arg);					\
-		__WARN_FLAGS(BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
+		__WARN_FLAGS("", BUGFLAG_NO_CUT_HERE | BUGFLAG_TAINT(taint));\
 		instrumentation_end();					\
 	} while (0)
 #define WARN_ON_ONCE(condition) ({				\
 	int __ret_warn_on = !!(condition);			\
 	if (unlikely(__ret_warn_on))				\
-		__WARN_FLAGS(BUGFLAG_ONCE |			\
+		__WARN_FLAGS("",				\
+			     BUGFLAG_ONCE |			\
 			     BUGFLAG_TAINT(TAINT_WARN));	\
 	unlikely(__ret_warn_on);				\
 })
-- 
2.45.2


