Return-Path: <linux-arch+bounces-13046-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72FF6B1A7D5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7BFD623674
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:45:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA3E2877F8;
	Mon,  4 Aug 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0wr+SOQ"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20F52868A5;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=hZHhWfdicf53krEXfa5vx/4q8+5u04aykxaPQ1v0IfIt7l8LiphzUpX7gyFm4Lf+3PDEBAuYyfW577lzQoS3c5IggiLiVbjJP0QsENJZDsajchwKG9J0Z+ZthHs2IvH6CDE5PCiKf9tyiWwL2qdHHmt22e+y45Xms/dJrAI+aHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=g9NWGXns36jX28IL85SFtHFGu7oIjU0Ua5dSHJdI5kc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Yrq4BqHehPzvsjl8GADa6IFJnusDatPoTW01uJofPfDU93flX6+TBCQR3W7JO68wI+Nk7L2O6nmThT07WvC4Su8fd2MtE5DQPZWLWV2UF61atayrLDMpvHCqgpPAMA5+CTB9KDHS+v3k0TgdypW4C4+uk6L0KlLx/wn2WXUaOeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0wr+SOQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B7BC4AF0C;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=g9NWGXns36jX28IL85SFtHFGu7oIjU0Ua5dSHJdI5kc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o0wr+SOQrJ8Pb1HYn23m4nYGmmpz1RDCR0ieEPGyaoZStf9uxSKkOeJ+ht08w8Btg
	 Mk16Oj5DcqMKz/MiKi8tHWrMk13bxl6FmvWQLkLC9rcpfJZE6u8Pgf6DcugDDacw/n
	 Gt1m4MotOXAbpwe1NUuHL8wW+JPWgcHeXq2UruCVO8Nxp4xDsYHY6mP6CA6UJep8Gi
	 4v4XsgZvc5nHH0fLusjDc2D7xmP4pPA5nbCjn3spw2vXn4Kuax1rC1vilgHcaGL1u5
	 +BXbkvga5yhWQsopUPn8srq6zLvG798XxT0hdKDu652cFd9q5dF1ACGM650jF2MJx2
	 QaBmx5wtzTV7A==
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
Subject: [PATCH 09/17] riscv: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:05 -0700
Message-Id: <20250804164417.1612371-9-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2467; i=kees@kernel.org; h=from:subject; bh=g9NWGXns36jX28IL85SFtHFGu7oIjU0Ua5dSHJdI5kc=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkemZM9qPHqPbYffitvpiduXcnN//Wz59H7Src5ro iuN53c7dZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAEzk8wJGhkbFJarr3qZFnVMK ivFlq+MtkmgR9Xud8jxCoklDa6WcBcNf2d0LPUQOnJ4w6cfNbUl3P7lbnX7u8W9y56Vbs2y2ORi cYgEA
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

Add missing __attribute_const__ annotations to RISC-V's implementations of
variable__ffs(), variable__fls(), and variable_ffs() functions. These are pure
mathematical functions that always return the same result for the same
input with no side effects, making them eligible for compiler optimization.

Build tested ARCH=riscv defconfig with GCC riscv64-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/riscv/include/asm/bitops.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/bitops.h b/arch/riscv/include/asm/bitops.h
index d59310f74c2b..77880677b06e 100644
--- a/arch/riscv/include/asm/bitops.h
+++ b/arch/riscv/include/asm/bitops.h
@@ -45,7 +45,7 @@
 #error "Unexpected BITS_PER_LONG"
 #endif
 
-static __always_inline unsigned long variable__ffs(unsigned long word)
+static __always_inline __attribute_const__ unsigned long variable__ffs(unsigned long word)
 {
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
@@ -74,7 +74,7 @@ static __always_inline unsigned long variable__ffs(unsigned long word)
 	 (unsigned long)__builtin_ctzl(word) :	\
 	 variable__ffs(word))
 
-static __always_inline unsigned long variable__fls(unsigned long word)
+static __always_inline __attribute_const__ unsigned long variable__fls(unsigned long word)
 {
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
@@ -103,7 +103,7 @@ static __always_inline unsigned long variable__fls(unsigned long word)
 	 (unsigned long)(BITS_PER_LONG - 1 - __builtin_clzl(word)) :	\
 	 variable__fls(word))
 
-static __always_inline int variable_ffs(int x)
+static __always_inline __attribute_const__ int variable_ffs(int x)
 {
 	asm goto(ALTERNATIVE("j %l[legacy]", "nop", 0,
 				      RISCV_ISA_EXT_ZBB, 1)
-- 
2.34.1


