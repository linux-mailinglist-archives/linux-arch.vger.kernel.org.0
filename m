Return-Path: <linux-arch+bounces-13042-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D36C3B1A765
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E784188A793
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0686286D77;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKm7fStn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8375128642B;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=M9DHg7BzfmUrF9Cc5XWW58gFWTG6rgnkn3++J1KPJnUryJwVCe5mEroHSC6+QLN0kOFex9WRld4JKnXjRueKHGBclH9+/QQT5PyIHOHdYLtWkxJoGXmNkMkuurYxfRmM8ADrNnjqtQZV+Yur3I4YUsPkMMmqxMWyRn2FIsM6xwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=Blko/RG2lvaODf864DzTpEKxwCgrc6vWtsbWwn+kegM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y8vUr/HuFDQG1BTK4DhYGkbhs7PfAI7GJ+IReLtu9NjanMih9bqPETt/TLUsb2ipByXOaD/FbLLnK/YtfnghgjGQw2XrqAk50L+wwb38pWyOxAdq7yo7YKZFoIXsefB85TE+Aa1hWojnIbFnf2f2jVYVF1pHvn4HaQwEr9GwNcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKm7fStn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38944C4CEFA;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=Blko/RG2lvaODf864DzTpEKxwCgrc6vWtsbWwn+kegM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKm7fStnT2f/O9WTNiGO7vEnfTrtD2BjrdbvAqXYGVLzrvGMKRZpwNljrVdV5Yc7F
	 ms/UkNjaUp45VzaxYml1V2nd8lcIp45AXVOtEcUonr/GGOlwTuoYIbgkvoQhFG/wN6
	 WKZh/vtDzYFHTHdBEIoe7UUh+2ifIrTv4JkUwkgI3r31kXpv/+gCV57tdSm5RVB+/O
	 k/FFqo6u0bVzkLRl1/HE6qUBw2RV4HQjdVjWVDfm2DbICcjzwJ+2AIF2V6qq7UvY2s
	 1GPhzwrTFl0I2J3UaB6SO0WN6XerugMXmpU92vxpkjKRJ1CQhkGFuh0FEX4P7zr0Pl
	 YCvaKu3TYXMJw==
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
Subject: [PATCH 05/17] powerpc: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:01 -0700
Message-Id: <20250804164417.1612371-5-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1894; i=kees@kernel.org; h=from:subject; bh=Blko/RG2lvaODf864DzTpEKxwCgrc6vWtsbWwn+kegM=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkf8q+aJtHjfkMxRZhbRVyTe91hepyc95ULUY4Nmo RcSm190lLIwiHExyIopsgTZuce5eLxtD3efqwgzh5UJZAgDF6cATOTwfUaGT12nXSZdEFMMv1jN WH1s+TYRodUWp2689y1ICF67snCjFiPDy4IrLHkZtyc8f2I0KUiD65L66soy16kWMewJ/B3xN0J 4AA==
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

Add missing __attribute_const__ annotations to PowerPC's implementations of
fls() function. These are pure mathematical functions that always return
the same result for the same input with no side effects, making them eligible
for compiler optimization.

Build tested ARCH=powerpc defconfig with GCC powerpc-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/powerpc/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index 671ecc6711e3..0d0470cd5ac3 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -276,7 +276,7 @@ static inline void arch___clear_bit_unlock(int nr, volatile unsigned long *addr)
  * fls: find last (most-significant) bit set.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static __always_inline int fls(unsigned int x)
+static __always_inline __attribute_const__ int fls(unsigned int x)
 {
 	int lz;
 
@@ -294,7 +294,7 @@ static __always_inline int fls(unsigned int x)
  * 32-bit fls calls.
  */
 #ifdef CONFIG_PPC64
-static __always_inline int fls64(__u64 x)
+static __always_inline __attribute_const__ int fls64(__u64 x)
 {
 	int lz;
 
-- 
2.34.1


