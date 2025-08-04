Return-Path: <linux-arch+bounces-13041-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DEB03B1A76F
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:44:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DA95188C61E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4CE286D49;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iCRKQ61m"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5734628640F;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=GhTyevFMj2zpFozATSupVwtjrAvxpOwtFfwC2chIGEpZhyJn7Q58mmQsNQj0oLfSGZv1w0MnRwL3tzLx+Hr0hOjAtvHl87Jf/YznJkk97rccinNkrrVG5N9ESHPlccvompnq3WcXtd5RJqqr5TpbBvUcTCipO/V9ouCtWfzbl2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=f1BJyviPYJxx8kFp/yukIUneK3tevM8t3j60E+6mJ1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gqL3s3B+lGI6K/JWN6c9F1vKPDnPxQflsAdlCc4TgG8SXv/ppcmZgA3SD3NdP7T3KVuAgKq5mwpR5hNa/SYzrFPMULAHbG00xj136XAuLVxnyL3KVgRaMVHWZ2cLVh3rFfZ+qgNwCe42uj5ZYxmgj+O3L6wHD4xrcHMD+psEXmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iCRKQ61m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BABC4CEFC;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=f1BJyviPYJxx8kFp/yukIUneK3tevM8t3j60E+6mJ1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCRKQ61mm01MZTvc3CPPe2Ki/UrPAJKulntT266Ebe8TeWDAN/PSv0m32mZuiBkpN
	 lk/deOYVzRLtSp7i6p4G7JOZzGDwuaAryUY11pGGbT30Ubny4bRA9VoK9foPrUhkFy
	 5Kdb9YBAUZfg0XipfrZDkRGYNiY8gnoYygkru433UuRkZYLKddHKgD3V1i3NRUr65E
	 jI3qDVxgAjgs0faGOdEZKxTlRUMVWRKKtbD/zPFJkkQmhZoOks1gC8mF1Wrrb6/rxq
	 Brmye/Z8DZwW8aMN1Lsr/FFUXXIYCbg+wC0d/XKLVlJHJdrQIxU0buKqimdXSNKiTB
	 sP5NLdQ1qXfMw==
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
Subject: [PATCH 03/17] csky: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:43:59 -0700
Message-Id: <20250804164417.1612371-3-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2307; i=kees@kernel.org; h=from:subject; bh=f1BJyviPYJxx8kFp/yukIUneK3tevM8t3j60E+6mJ1Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkf4pKfxelzOuX/uzqPPOxs0l05ZFhCiyao9Jeqci 3ziSXXxjlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgIks2MXIsEItKTpFNdpgi2AC T4VsWqPxkidZFV7pHLJyKvtDK1pbGBmmVyyW697n81XsnYVwT1DQGWaXqglTVk1a8WJH3VlBbyE GAA==
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

Add missing __attribute_const__ annotations to C-SKY's implementations of
ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
functions that always return the same result for the same input with no
side effects, making them eligible for compiler optimization.

Build tested ARCH=csky defconfig with GCC csky-linux 15.1.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/csky/include/asm/bitops.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/csky/include/asm/bitops.h b/arch/csky/include/asm/bitops.h
index 72e1b2aa29a0..80d67eee6e86 100644
--- a/arch/csky/include/asm/bitops.h
+++ b/arch/csky/include/asm/bitops.h
@@ -9,7 +9,7 @@
 /*
  * asm-generic/bitops/ffs.h
  */
-static inline int ffs(int x)
+static inline __attribute_const__ int ffs(int x)
 {
 	if (!x)
 		return 0;
@@ -26,7 +26,7 @@ static inline int ffs(int x)
 /*
  * asm-generic/bitops/__ffs.h
  */
-static __always_inline unsigned long __ffs(unsigned long x)
+static __always_inline __attribute_const__ unsigned long __ffs(unsigned long x)
 {
 	asm volatile (
 		"brev %0\n"
@@ -39,7 +39,7 @@ static __always_inline unsigned long __ffs(unsigned long x)
 /*
  * asm-generic/bitops/fls.h
  */
-static __always_inline int fls(unsigned int x)
+static __always_inline __attribute_const__ int fls(unsigned int x)
 {
 	asm volatile(
 		"ff1 %0\n"
@@ -52,7 +52,7 @@ static __always_inline int fls(unsigned int x)
 /*
  * asm-generic/bitops/__fls.h
  */
-static __always_inline unsigned long __fls(unsigned long x)
+static __always_inline __attribute_const__ unsigned long __fls(unsigned long x)
 {
 	return fls(x) - 1;
 }
-- 
2.34.1


