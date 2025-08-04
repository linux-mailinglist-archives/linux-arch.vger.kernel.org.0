Return-Path: <linux-arch+bounces-13045-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B04B1A7C0
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E969A1893AAB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B422877E3;
	Mon,  4 Aug 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V8su36dz"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1F04286890;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=RZtMYYhjxRW94hPop2LmDjid27X5UQmHg8SLlHc9AoHhaATC1X4ibhiKnNvVpEdq8ZR/VMSQcyWGB2gjusWVDOKnF1q82FZA3rhlutMD1GaNL1j3Wo4LFqPhMGU9FzCg4CeLydKU9irbgnhWOdZrW/DUctGANI2OJ1uaFTiFmpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=3HtYht3o5b53HlW3hmmaVS1l68Fq+Byhwo7/QFnsV8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYk9/D4FRzEWJ64UCDGiWw/aZcYKzwoksaEqSxkGektN7K8DzP13sfv9cllOIKUxnz9mMCosdKgkRKj4FshE8uLCirPAXlyn+4ajbaDmihmIaC24jp3zffTYG/Fn4acJVUFbPLnHkpxgDmBD5mdIHiqwOmytQq/ApsTgH1XcPps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V8su36dz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 557BFC19422;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=3HtYht3o5b53HlW3hmmaVS1l68Fq+Byhwo7/QFnsV8I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V8su36dz8wLeATBiw+fLXUhOrWYvB0J2NFju0ulT3yX9bH3I4brsk1bfIPOwMtl4M
	 eUdlQo6ZAufcuJ508hVz4gfoq3F3K0NaNBhUI39fozig9HtwiVIhUGFAxBVlIHjavx
	 dlf5V9cU0uGCk2uQOYlzN0s30pv/X2w1LMbTVx6rbh/tujJoBv2E/x6rjwgPDf4RAL
	 WgADCxDgFlafZg+p0CJETlCNY4boSlI5JQCzG5Rc0pHbrftG9aN/2N2mn7r2AzIlix
	 US1fliCniVnKsIeSvSJNltImuRoFdZvNSuevHgga/082pXz8xl7Spx/2XIW3pDNRLi
	 Tj/NQpbrTOeCw==
From: Kees Cook <kees@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	llvm@lists.linux.dev,
	linux-hardening@vger.kernel.org
Subject: [PATCH 12/17] mips: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:08 -0700
Message-Id: <20250804164417.1612371-12-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2679; i=kees@kernel.org; h=from:subject; bh=3HtYht3o5b53HlW3hmmaVS1l68Fq+Byhwo7/QFnsV8I=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkd9Czh7JOPuiXLZd7+tXh0+UvAmMXjmUpsPrqFNd emffkyY2FHKwiDGxSArpsgSZOce5+Lxtj3cfa4izBxWJpAhDFycAjCR0IeMDKtMbV93TbymIV3y RUjmeV9k6+Ycm98bV/GzP/x1wf6SQwEjw9LvUaanzu14nd9/YYIdr+mme3uzdviENGY4hmxRS95 ymhcA
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While tracking down a problem where constant expressions used by
BUILD_BUG_ON() suddenly stopped working[1], we found that an added static
initializer was convincing the compiler that it couldn't track the state
of the prior statically initialized value. Tracing this down found that
ffs() was used in the initializer macro, but since it wasn't marked with
__attribute__const__, the compiler had to assume the function might
change variable states as a side-effect (which is not true for ffs(),
which provides deterministic math results).

Add missing __attribute_const__ annotations to MIPS's implementations of
ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
functions that always return the same result for the same input with no
side effects, making them eligible for compiler optimization.

Build tested ARCH=mips defconfig with GCC mipsel-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/mips/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
index 89f73d1a4ea4..42f88452c920 100644
--- a/arch/mips/include/asm/bitops.h
+++ b/arch/mips/include/asm/bitops.h
@@ -327,7 +327,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
  * Return the bit position (0..63) of the most significant 1 bit in a word
  * Returns -1 if no 1 bit exists
  */
-static __always_inline unsigned long __fls(unsigned long word)
+static __always_inline __attribute_const__ unsigned long __fls(unsigned long word)
 {
 	int num;
 
@@ -393,7 +393,7 @@ static __always_inline unsigned long __fls(unsigned long word)
  * Returns 0..SZLONG-1
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __ffs(unsigned long word)
+static __always_inline __attribute_const__ unsigned long __ffs(unsigned long word)
 {
 	return __fls(word & -word);
 }
@@ -405,7 +405,7 @@ static __always_inline unsigned long __ffs(unsigned long word)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(unsigned int x)
+static inline __attribute_const__ int fls(unsigned int x)
 {
 	int r;
 
@@ -458,7 +458,7 @@ static inline int fls(unsigned int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the below ffz (man ffs).
  */
-static inline int ffs(int word)
+static inline __attribute_const__ int ffs(int word)
 {
 	if (!word)
 		return 0;
-- 
2.34.1


