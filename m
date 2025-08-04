Return-Path: <linux-arch+bounces-13050-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F63B1A7F2
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FC21816C8
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A3F288C08;
	Mon,  4 Aug 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ctp3G9Ag"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B539D2868B0;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=bTvMAmIli7cxXu+iEZDSTgeSJcLzmpRKiE075pkQRR0R486LKFARG341abff1tiyW40cn3p+8+PzsIdueinJ5Q7bFMDeOBJAJp76/DCZS0HDvPgETOmV2C+J0tkxxsgnZzJizr43kuburMo0aKvNHxrGZhvCTfmeWEb9zn+ILKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=Lvi+SOjPyvnPy8ciTq59tLtKnNheCboKdQcwuoaKmUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ob0PjwgSqzeb61QQ1YlLNkYJnALCFFMnWYxoloYlmYl5Q2P1+ACNZEe6aXkQDn6mtxu/zrivRFcGq7UsZbJjQNWhw/ityEOlnJSND1Rhvoy2YbIzzJfeNoABlo1fA422tEiX76tKCF/S+bmxXAuuUr5/n4VJuXL2dAvb3z7fEDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ctp3G9Ag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA43C4AF09;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=Lvi+SOjPyvnPy8ciTq59tLtKnNheCboKdQcwuoaKmUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ctp3G9AgiSCKLRp3GaS8h8tJ0qd2GiWi29AWYoW9OphEKR9uxRpx+tVuZ37fpfpsL
	 IIiqsW+BqW+QyimiyTxqwluC3gBj0itLpMcnGvSkUJW+Jtvtu0G8zJm4JEpeAv07ho
	 5p6x/9qjLA5BPlYqTiJ+ItnXGdxvcaVtNEU6C921kzwAdklU0oJOrywzY/43+qATyc
	 qkCMHpUPQU7oHixjqmmc6E/rz2akCtU5V8u3ok+s8qmQdwYEwufDL+M7FaTtHByKcC
	 AuS5qqztdOQXGV87h2P9OWbRhnDlzJPeEZsfRqWu0o2aRbkYyxMYY+FjPb1Q+fYa9A
	 LXmNT4G4CjwRQ==
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
Subject: [PATCH 14/17] s390: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:10 -0700
Message-Id: <20250804164417.1612371-14-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2996; i=kees@kernel.org; h=from:subject; bh=Lvi+SOjPyvnPy8ciTq59tLtKnNheCboKdQcwuoaKmUM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkdP80i3EZa0WqNV8fMHixWbmEZHeZVc662+q3+e/ xLYYFLfUcrCIMbFICumyBJk5x7n4vG2Pdx9riLMHFYmkCEMXJwCMBGxaIa/knsDtxWE2YZe7I7U 3WXadmPtRbMlWjOOFS4Pyt5xp698FyPDCXntuf8OrPNQnv7aqHOTUcK6qfbFbx5JC57KYzE7e+8 jOwA=
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

Add missing __attribute_const__ annotations to S390's implementations of
ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
functions that always return the same result for the same input with no
side effects, making them eligible for compiler optimization.

Build tested ARCH=s390 defconfig with GCC s390x-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/s390/include/asm/bitops.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/s390/include/asm/bitops.h b/arch/s390/include/asm/bitops.h
index a5ca0a947691..fbcc3e1cc776 100644
--- a/arch/s390/include/asm/bitops.h
+++ b/arch/s390/include/asm/bitops.h
@@ -179,7 +179,7 @@ static inline unsigned char __flogr(unsigned long word)
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline __attribute_const__ unsigned long __ffs(unsigned long word)
 {
 	return __flogr(-word & word) ^ (BITS_PER_LONG - 1);
 }
@@ -191,7 +191,7 @@ static inline unsigned long __ffs(unsigned long word)
  * This is defined the same way as the libc and
  * compiler builtin ffs routines (man ffs).
  */
-static inline int ffs(int word)
+static inline __attribute_const__ int ffs(int word)
 {
 	unsigned long mask = 2 * BITS_PER_LONG - 1;
 	unsigned int val = (unsigned int)word;
@@ -205,7 +205,7 @@ static inline int ffs(int word)
  *
  * Undefined if no set bit exists, so code should check against 0 first.
  */
-static inline unsigned long __fls(unsigned long word)
+static inline __attribute_const__ unsigned long __fls(unsigned long word)
 {
 	return __flogr(word) ^ (BITS_PER_LONG - 1);
 }
@@ -221,7 +221,7 @@ static inline unsigned long __fls(unsigned long word)
  * set bit if value is nonzero. The last (most significant) bit is
  * at position 64.
  */
-static inline int fls64(unsigned long word)
+static inline __attribute_const__ int fls64(unsigned long word)
 {
 	unsigned long mask = 2 * BITS_PER_LONG - 1;
 
@@ -235,7 +235,7 @@ static inline int fls64(unsigned long word)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(unsigned int word)
+static inline __attribute_const__ int fls(unsigned int word)
 {
 	return fls64(word);
 }
-- 
2.34.1


