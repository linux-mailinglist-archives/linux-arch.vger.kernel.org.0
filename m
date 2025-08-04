Return-Path: <linux-arch+bounces-13044-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF96AB1A7AC
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249F0623164
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 774532877DB;
	Mon,  4 Aug 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFYJDn3i"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E12728688A;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=ZgN/ypstbjJoQpIDVTzwGNfqLJbRuNFHpePBERd5QcqdJ8RHmIkSKdLph0axEVYa0O1Bpk7n5ZClAP5dYrsRVDeGbVAo0RgfspBUK7RtsXvSwc1fcOfBcsFEc4r4NJ9iaXiggUn2dJnmxNv079861pA9UNsV+a0Eoiok9juN1SM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=752sQmjr+WkEQIQTz2YsThA0XswYRbPSJznITLPZ8n0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eRebaopn9sBpBuZzl2GUmhDvbabDJ9D+37myaZUWW+XSkdD1+InCO77+WvEyqZe+X0dleZuuAgPYPgLcSCn3KVwylTKQjTOuL0+Fa652arQGxsOVPA6QBr7F+YwyJz3SYWQN3oKUMV5cxB06z5wERK0cQ4wDqauKisZa4eEHjCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFYJDn3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41AB4C113CF;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=752sQmjr+WkEQIQTz2YsThA0XswYRbPSJznITLPZ8n0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DFYJDn3iT6d1HFBeZ+4JC6ama4tupJDc2NxZKYp8ACnJ1iL3GmdJ4nU9J6Gxpz6zV
	 ggkLZE5g33xSNghuW+/4AldAgkpmoHzVtp05Mm0Tk77p9FwqmOTo5KhNYbg7IGPo42
	 Zaxz1NYG/MDOHO+D0u6LkCfsfIaxlPUFpaI3es/IGEblVRHWsEmsmx5qlouLXGxOO/
	 jZURCEO+cG1tK5otFXKDXMarJRlXurVor/Uk6n4hK/Tfhs4SPDSIBIKjGx1Re9Gru2
	 RayDn4/9xO/y4REx1nhEGhNAedTHIr/vlsv5X97wp/q8FQQMD03LxVviKNDFWQcU2I
	 jhO6Ld2SN/XqA==
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
Subject: [PATCH 07/17] alpha: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:03 -0700
Message-Id: <20250804164417.1612371-7-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3242; i=kees@kernel.org; h=from:subject; bh=752sQmjr+WkEQIQTz2YsThA0XswYRbPSJznITLPZ8n0=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkeW55xweCLlqOjVdbHHOVIuePb3nVd3fpROS5YTs nc5WMrUUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMJEFFxkZZtwvav769fajq9di vywovGGe9+SBsdj3hDVaNi73rnRVSzAy/N3mv2O7ocl6bb0KjjvftqjJnWeQndM4JzZ/d2XXEZZ 33AA=
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

Add missing __attribute_const__ annotations to Alpha's implementations
of __ffs(), ffs(), fls64(), __fls(), fls(), and ffz() functions. These
are pure mathematical functions that always return the same result for
the same input with no side effects, making them eligible for compiler
optimization.

Build tested ARCH=alpha defconfig with GCC alpha-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/alpha/include/asm/bitops.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/alpha/include/asm/bitops.h b/arch/alpha/include/asm/bitops.h
index 3e33621922c3..76e4343c090f 100644
--- a/arch/alpha/include/asm/bitops.h
+++ b/arch/alpha/include/asm/bitops.h
@@ -328,7 +328,7 @@ static inline unsigned long ffz_b(unsigned long x)
 	return sum;
 }
 
-static inline unsigned long ffz(unsigned long word)
+static inline unsigned long __attribute_const__ ffz(unsigned long word)
 {
 #if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 	/* Whee.  EV67 can calculate it directly.  */
@@ -348,7 +348,7 @@ static inline unsigned long ffz(unsigned long word)
 /*
  * __ffs = Find First set bit in word.  Undefined if no set bit exists.
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline __attribute_const__ unsigned long __ffs(unsigned long word)
 {
 #if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
 	/* Whee.  EV67 can calculate it directly.  */
@@ -373,7 +373,7 @@ static inline unsigned long __ffs(unsigned long word)
  * differs in spirit from the above __ffs.
  */
 
-static inline int ffs(int word)
+static inline __attribute_const__ int ffs(int word)
 {
 	int result = __ffs(word) + 1;
 	return word ? result : 0;
@@ -383,14 +383,14 @@ static inline int ffs(int word)
  * fls: find last bit set.
  */
 #if defined(CONFIG_ALPHA_EV6) && defined(CONFIG_ALPHA_EV67)
-static inline int fls64(unsigned long word)
+static inline __attribute_const__ int fls64(unsigned long word)
 {
 	return 64 - __kernel_ctlz(word);
 }
 #else
 extern const unsigned char __flsm1_tab[256];
 
-static inline int fls64(unsigned long x)
+static inline __attribute_const__ int fls64(unsigned long x)
 {
 	unsigned long t, a, r;
 
@@ -403,12 +403,12 @@ static inline int fls64(unsigned long x)
 }
 #endif
 
-static inline unsigned long __fls(unsigned long x)
+static inline __attribute_const__ unsigned long __fls(unsigned long x)
 {
 	return fls64(x) - 1;
 }
 
-static inline int fls(unsigned int x)
+static inline __attribute_const__ int fls(unsigned int x)
 {
 	return fls64(x);
 }
-- 
2.34.1


