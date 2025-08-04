Return-Path: <linux-arch+bounces-13040-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 944F5B1A771
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43F76188CCDB
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C9286D7B;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNX2f+uk"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572E228640E;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=DHWx4yoot/jRfXqiz7Unh4IgWxChzOhcsc/PgCMAI8eEjJ6nTjNAwjFzF8PMBDIc7pqnk6QCIUR1zDMpd8f17UlbwxsxStxuJx59vso4pNeTtZhu6XmtGYrgUbJCJWZaIssV2oJzs+Yjsf0X9YiQDAw7gzlVc30+1JQrlZWrDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=adGs1kuuk4zPQI9OS9eVOvJux65kSL76tPiJyL+ncj8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qUyhuWnX/nP4K0C4p1aY1PYWWyxT/0y2OBxvXGR6uX9WZJbmezkpiXoCXGYJD84N14fXwFJUufjEJbhr7lS5fXd3mZnzj+r9AqQGNcJq/GNILQ4y2Iw4H/pP8HXNa41Fmlr8wvSAV42gjNluiEV6CaOeL06ElvQZ0z+3SRra5Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNX2f+uk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E879C4CEFF;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=adGs1kuuk4zPQI9OS9eVOvJux65kSL76tPiJyL+ncj8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZNX2f+ukbjZ1j6eu9fz/+prTtT0vGsnjndcPXpFpG7P0Ia1Ril8Zf05ioP7FLpyo+
	 Mm2+aQHENVj0SHKpUPkPNDfgX5KBmrxkUcMnELWwkSRO5YI2iFCS8V36kFAf3sXzwz
	 zIvsdeC0pDzY9IKgCqH+xjQqPw2s+/XGMq9xJey9eoC5Sun/SfxY85adcWU/9qVD5I
	 Eh9+V8XR+/ZCwx0FSYMbTtEWnpevQ2WhcEQ/mvJoIbxn3Y2oVc+jESY8sptZ+6Y1E7
	 hXKnvnLGQgbuK3ouTYEW2vnpMJujCrVf4XcvM08Nb1q67D1mup4HnPed6XG6GGawWY
	 izdWDqT9JS+RA==
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
Subject: [PATCH 04/17] x86: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:00 -0700
Message-Id: <20250804164417.1612371-4-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3280; i=kees@kernel.org; h=from:subject; bh=adGs1kuuk4zPQI9OS9eVOvJux65kSL76tPiJyL+ncj8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkdcn9HKVsXGsIr7AKdfgqSU+aeIrz0tzpYr9wkum fXBvsyko5SFQYyLQVZMkSXIzj3OxeNte7j7XEWYOaxMIEMYuDgF4CbnMTJ099c09f3590OhLee3 kxnL/7s7bxwLjPFLUap6/mJdAGsII8MONcmt6pUnOeTOCVhKzbgjGJmr7T41n6lg2nSB8PZMR24 A
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

Add missing __attribute_const__ annotations to x86's implementations of
variable__ffs(), variable_ffz(), __fls(), variable_ffs(), and fls() functions.
These are pure mathematical functions that always return the same result for the same
input with no side effects, making them eligible for compiler optimization.

Build tested ARCH=x86_64 defconfig with GCC gcc 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/x86/include/asm/bitops.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/bitops.h b/arch/x86/include/asm/bitops.h
index eebbc8889e70..a835f891164d 100644
--- a/arch/x86/include/asm/bitops.h
+++ b/arch/x86/include/asm/bitops.h
@@ -246,7 +246,7 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
 					  variable_test_bit(nr, addr);
 }
 
-static __always_inline unsigned long variable__ffs(unsigned long word)
+static __always_inline __attribute_const__ unsigned long variable__ffs(unsigned long word)
 {
 	asm("tzcnt %1,%0"
 		: "=r" (word)
@@ -265,7 +265,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 	 (unsigned long)__builtin_ctzl(word) :	\
 	 variable__ffs(word))
 
-static __always_inline unsigned long variable_ffz(unsigned long word)
+static __always_inline __attribute_const__ unsigned long variable_ffz(unsigned long word)
 {
 	return variable__ffs(~word);
 }
@@ -287,7 +287,7 @@ static __always_inline unsigned long variable_ffz(unsigned long word)
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned long __fls(unsigned long word)
+static __always_inline __attribute_const__ unsigned long __fls(unsigned long word)
 {
 	if (__builtin_constant_p(word))
 		return BITS_PER_LONG - 1 - __builtin_clzl(word);
@@ -301,7 +301,7 @@ static __always_inline unsigned long __fls(unsigned long word)
 #undef ADDR
 
 #ifdef __KERNEL__
-static __always_inline int variable_ffs(int x)
+static __always_inline __attribute_const__ int variable_ffs(int x)
 {
 	int r;
 
@@ -355,7 +355,7 @@ static __always_inline int variable_ffs(int x)
  * set bit if value is nonzero. The last (most significant) bit is
  * at position 32.
  */
-static __always_inline int fls(unsigned int x)
+static __always_inline __attribute_const__ int fls(unsigned int x)
 {
 	int r;
 
@@ -400,7 +400,7 @@ static __always_inline int fls(unsigned int x)
  * at position 64.
  */
 #ifdef CONFIG_X86_64
-static __always_inline int fls64(__u64 x)
+static __always_inline __attribute_const__ int fls64(__u64 x)
 {
 	int bitpos = -1;
 
-- 
2.34.1


