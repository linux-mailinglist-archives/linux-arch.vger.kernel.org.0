Return-Path: <linux-arch+bounces-13043-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FDE6B1A764
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 29C964E1BFF
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3E028724B;
	Mon,  4 Aug 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7b8ufEv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837D128642C;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=EuV1dpKVatN99dVwmEeH9+GPLw/QbnAePQTh+C8C6Nw2UtdRAzNmIxM14j10JOij6LCViGpmcTQmLeBaTC/o4bL6d0UB2uKZsnWXl7gj2tjwf7vtFEPqYIhmPSZ0acr+wuWJRo49KPq4+ky1cra+3/62mq8fEPSwD3CdbzkWXGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=guvy9CFz34iD95VNx9U+nwzbEodayv2bp++BoAV7Co8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pqb7tK/tDhRDODqNnKWiGfxaWXJsu+ezfKDKiu3MhJxcLuP0qV235OocI4baDo2cAIlcLYQnYeSYL8YCwBy3y2Dt7gcXhECnRZGBW/H7qhQR+tjyUFtXy9iA0sNbmx6MCGI0qH/+4GPt8S281HRl7y9NQJZSTGFsPCcyTSnjmSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7b8ufEv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B233C116D0;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=guvy9CFz34iD95VNx9U+nwzbEodayv2bp++BoAV7Co8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7b8ufEvWKC7zComlRM7+u4PtyfPEWo/yjTdeYkDlJsbVyvwHAovh35m4D3uuSVye
	 gHJqZVdqWNTwtanGfltzgxGVOtOstQHMiweKxm56tiOvOzLvR44JZYdUL8B5L1htI+
	 DGDKHooxzEKRzUaDUXP7yWLGj/TWeVyVHYMQzEghCsXqPhdeduMIDPn11gl9swH7a+
	 HEINXXtYK9TpmhXZNMHyNCftjjwDDURfQsMuyzWDTs0oBX4SY+zy7mK7Jgke/vDeg3
	 U7w0bqTMAqEajLuIcJFHYSbSneQKkmY/yNhbGerF4hTMOq3OpZ4VDdx/o1lJJPBczx
	 s7evE8jRDh0cw==
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
Subject: [PATCH 06/17] sh: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:02 -0700
Message-Id: <20250804164417.1612371-6-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1828; i=kees@kernel.org; h=from:subject; bh=guvy9CFz34iD95VNx9U+nwzbEodayv2bp++BoAV7Co8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkfmP9t48PLcGkVp7XKfZ3/uTi7Rm+jids/QLcX+v ovoKoOHHaUsDGJcDLJiiixBdu5xLh5v28Pd5yrCzGFlAhnCwMUpABNRZ2T4Z1zh+zj++LvqmA3l LWq5U/2rD36e5VuY8uHfOu9mze9iixn+5z/fPemPk/mc5Lc7HA/9vMSTdJhT49XaZfdm+L/0SFt yjQUA
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

Add missing __attribute_const__ annotations to SH's implementations of
__ffs() and ffz() functions. These are pure mathematical functions that
always return the same result for the same input with no side effects,
making them eligible for compiler optimization.

Build tested ARCH=sh defconfig with GCC sh4-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/sh/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/bitops.h b/arch/sh/include/asm/bitops.h
index 10ceb0d6b5a9..aba3aa96a50e 100644
--- a/arch/sh/include/asm/bitops.h
+++ b/arch/sh/include/asm/bitops.h
@@ -24,7 +24,7 @@
 #include <asm-generic/bitops/non-atomic.h>
 #endif
 
-static inline unsigned long ffz(unsigned long word)
+static inline unsigned long __attribute_const__ ffz(unsigned long word)
 {
 	unsigned long result;
 
@@ -44,7 +44,7 @@ static inline unsigned long ffz(unsigned long word)
  *
  * Undefined if no bit exists, so code should check against 0 first.
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline __attribute_const__ unsigned long __ffs(unsigned long word)
 {
 	unsigned long result;
 
-- 
2.34.1


