Return-Path: <linux-arch+bounces-13038-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4172B1A752
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5AA3B622DC3
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B9E28643C;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GROEzo0L"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536B3285CBF;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=e85DJyzkeYD7b5zZHcjjeIL5QOZ5hqofXDqn6yVw9N+tWSTboR63yxLjn+auMlcrOXl19i29l6DGGc6o9wGjq08KZ9Zqb7ivVl6r279z/pyVpj6rftLfRcrdGc4V71M19TI0SgBE6sGeYACJqd+wArpHz0kgaBXftdrENDlGTng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=VbqzFFZFobB7kkMuGpRYRdOZTcP62BCCuXda9NlZ/Xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=okE88FTbhAOWj6tn0Murd8FMn6/2P9fJMcFv7cyTsoA1KKZDSfWMA7Kk6mK2mEtd4xHrdzX9H2Wn0DHtECIoyjr3+YxS1+vKu5D2XFbFOEaSwtUICij/tF7DmPwXvD9yEJaIibCdz0u6OmaZqRXKosUFTfVg12+p+URoJzqvcHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GROEzo0L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C3EC4CEF7;
	Mon,  4 Aug 2025 16:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325857;
	bh=VbqzFFZFobB7kkMuGpRYRdOZTcP62BCCuXda9NlZ/Xk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GROEzo0Lk1ZsfeiO0JcyeztscMMNwzmm9+gJ1U/EYaNzg4Y1I9YztXPW4KVquUcK5
	 W1K5xmL/UiItHuLKr7g7rVctCPykcFOWlbjwT/5GKF4IR51MZgfwEqS7sU43da6u8g
	 reQLveK36NSdF1lZOl6oCtDuIGJJLu+fUI30lmFxJfQ+8ZRKDBZhwM3u0epPf8Aups
	 YbSGTxe9YC4kSDibdvDhM9woUdKWTVutzTqXCwPcCu0R/bYFliwQt3Y30D0OcRNc1L
	 VrFaejLOI8CKjQUVofmE1a2gjth5Cd5PXSHYoS6bdeeUlAe5H/iZRgF3cNlXedvEDY
	 YrD4mtIeYiNEQ==
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
Subject: [PATCH 02/17] bitops: Add __attribute_const__ to generic ffs()-family implementations
Date: Mon,  4 Aug 2025 09:43:58 -0700
Message-Id: <20250804164417.1612371-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7306; i=kees@kernel.org; h=from:subject; bh=VbqzFFZFobB7kkMuGpRYRdOZTcP62BCCuXda9NlZ/Xk=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHod3ax3aZ7G1tNvmkOGJx9qa4vfF3JjywveGBNjO+ X/n4OtlHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABPZsICR4cE598PfnU503XBf /ub6WsFMhYK5i9d8+uG5at3nr/ULGW8wMpzpCr5noSqbsj3Ev6bHTCzs+tI3exR3iLkwvJ8tVl3 LzgwA
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

Add missing __attribute_const__ annotations to generic implementations of
ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
functions that always return the same result for the same input with no
side effects, making them eligible for compiler optimization.

Build tested with x86_64 defconfig using GCC 14.2.0, which should validate
the implementations when used by ARM, ARM64, LoongArch, Microblaze,
NIOS2, and SPARC32 architectures.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 include/asm-generic/bitops/__ffs.h         | 2 +-
 include/asm-generic/bitops/__fls.h         | 2 +-
 include/asm-generic/bitops/builtin-__ffs.h | 2 +-
 include/asm-generic/bitops/builtin-__fls.h | 2 +-
 include/asm-generic/bitops/builtin-fls.h   | 2 +-
 include/asm-generic/bitops/ffs.h           | 2 +-
 include/asm-generic/bitops/fls.h           | 2 +-
 include/asm-generic/bitops/fls64.h         | 4 ++--
 include/linux/bitops.h                     | 2 +-
 lib/clz_ctz.c                              | 8 ++++----
 10 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/include/asm-generic/bitops/__ffs.h b/include/asm-generic/bitops/__ffs.h
index 2d08c750c8a7..3a899c626fdc 100644
--- a/include/asm-generic/bitops/__ffs.h
+++ b/include/asm-generic/bitops/__ffs.h
@@ -10,7 +10,7 @@
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned int generic___ffs(unsigned long word)
+static __always_inline __attribute_const__ unsigned int generic___ffs(unsigned long word)
 {
 	unsigned int num = 0;
 
diff --git a/include/asm-generic/bitops/__fls.h b/include/asm-generic/bitops/__fls.h
index e974ec932ec1..35f33780ca6c 100644
--- a/include/asm-generic/bitops/__fls.h
+++ b/include/asm-generic/bitops/__fls.h
@@ -10,7 +10,7 @@
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned int generic___fls(unsigned long word)
+static __always_inline __attribute_const__ unsigned int generic___fls(unsigned long word)
 {
 	unsigned int num = BITS_PER_LONG - 1;
 
diff --git a/include/asm-generic/bitops/builtin-__ffs.h b/include/asm-generic/bitops/builtin-__ffs.h
index cf4b3d33bf96..d3c3f567045d 100644
--- a/include/asm-generic/bitops/builtin-__ffs.h
+++ b/include/asm-generic/bitops/builtin-__ffs.h
@@ -8,7 +8,7 @@
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned int __ffs(unsigned long word)
+static __always_inline __attribute_const__ unsigned int __ffs(unsigned long word)
 {
 	return __builtin_ctzl(word);
 }
diff --git a/include/asm-generic/bitops/builtin-__fls.h b/include/asm-generic/bitops/builtin-__fls.h
index 6d72fc8a5259..7770c4f1bfcd 100644
--- a/include/asm-generic/bitops/builtin-__fls.h
+++ b/include/asm-generic/bitops/builtin-__fls.h
@@ -8,7 +8,7 @@
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static __always_inline unsigned int __fls(unsigned long word)
+static __always_inline __attribute_const__ unsigned int __fls(unsigned long word)
 {
 	return (sizeof(word) * 8) - 1 - __builtin_clzl(word);
 }
diff --git a/include/asm-generic/bitops/builtin-fls.h b/include/asm-generic/bitops/builtin-fls.h
index c8455cc28841..be707da8c7cd 100644
--- a/include/asm-generic/bitops/builtin-fls.h
+++ b/include/asm-generic/bitops/builtin-fls.h
@@ -9,7 +9,7 @@
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static __always_inline int fls(unsigned int x)
+static __always_inline __attribute_const__ int fls(unsigned int x)
 {
 	return x ? sizeof(x) * 8 - __builtin_clz(x) : 0;
 }
diff --git a/include/asm-generic/bitops/ffs.h b/include/asm-generic/bitops/ffs.h
index 4c43f242daeb..5ff2b7fbda6d 100644
--- a/include/asm-generic/bitops/ffs.h
+++ b/include/asm-generic/bitops/ffs.h
@@ -10,7 +10,7 @@
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from ffz (man ffs).
  */
-static inline int generic_ffs(int x)
+static inline __attribute_const__ int generic_ffs(int x)
 {
 	int r = 1;
 
diff --git a/include/asm-generic/bitops/fls.h b/include/asm-generic/bitops/fls.h
index 26f3ce1dd6e4..8eed3437edb9 100644
--- a/include/asm-generic/bitops/fls.h
+++ b/include/asm-generic/bitops/fls.h
@@ -10,7 +10,7 @@
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
 
-static __always_inline int generic_fls(unsigned int x)
+static __always_inline __attribute_const__ int generic_fls(unsigned int x)
 {
 	int r = 32;
 
diff --git a/include/asm-generic/bitops/fls64.h b/include/asm-generic/bitops/fls64.h
index 866f2b2304ff..b5f58dd261a3 100644
--- a/include/asm-generic/bitops/fls64.h
+++ b/include/asm-generic/bitops/fls64.h
@@ -16,7 +16,7 @@
  * at position 64.
  */
 #if BITS_PER_LONG == 32
-static __always_inline int fls64(__u64 x)
+static __always_inline __attribute_const__ int fls64(__u64 x)
 {
 	__u32 h = x >> 32;
 	if (h)
@@ -24,7 +24,7 @@ static __always_inline int fls64(__u64 x)
 	return fls(x);
 }
 #elif BITS_PER_LONG == 64
-static __always_inline int fls64(__u64 x)
+static __always_inline __attribute_const__ int fls64(__u64 x)
 {
 	if (x == 0)
 		return 0;
diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 9be2d50da09a..ea7898cc5903 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -267,7 +267,7 @@ static inline int parity8(u8 val)
  * The result is not defined if no bits are set, so check that @word
  * is non-zero before calling this.
  */
-static inline unsigned int __ffs64(u64 word)
+static inline __attribute_const__ unsigned int __ffs64(u64 word)
 {
 #if BITS_PER_LONG == 32
 	if (((u32)word) == 0UL)
diff --git a/lib/clz_ctz.c b/lib/clz_ctz.c
index fb8c0c5c2bd2..8778ec44bf63 100644
--- a/lib/clz_ctz.c
+++ b/lib/clz_ctz.c
@@ -15,28 +15,28 @@
 #include <linux/kernel.h>
 
 int __weak __ctzsi2(int val);
-int __weak __ctzsi2(int val)
+int __weak __attribute_const__ __ctzsi2(int val)
 {
 	return __ffs(val);
 }
 EXPORT_SYMBOL(__ctzsi2);
 
 int __weak __clzsi2(int val);
-int __weak __clzsi2(int val)
+int __weak __attribute_const__ __clzsi2(int val)
 {
 	return 32 - fls(val);
 }
 EXPORT_SYMBOL(__clzsi2);
 
 int __weak __clzdi2(u64 val);
-int __weak __clzdi2(u64 val)
+int __weak __attribute_const__ __clzdi2(u64 val)
 {
 	return 64 - fls64(val);
 }
 EXPORT_SYMBOL(__clzdi2);
 
 int __weak __ctzdi2(u64 val);
-int __weak __ctzdi2(u64 val)
+int __weak __attribute_const__ __ctzdi2(u64 val)
 {
 	return __ffs64(val);
 }
-- 
2.34.1


