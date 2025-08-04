Return-Path: <linux-arch+bounces-13049-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 762ADB1A7B5
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7DE622E6E
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24582882DD;
	Mon,  4 Aug 2025 16:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uoz8nJLp"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE22868A1;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=JWF/7nUhbcgxaJFefvdtfdqCczAGDMSNGG/RPgAGmF6V+ijZACHlAs1AD4pMyPadUghDemJRkVO3AwUHdhdiI7AGxcNZVV8btk/fGiD8Cr7foeA8zNbLQHutORIddQM/flMGbecTCZNrHRauKHRB3zHnQyB3H8a4zg9S4puNl/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=WqXHH+IfirIk9LkIKK7Nl4nbWfgsz7d0eW6zTgrbVtU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QviPmisWNfPMiN0a74SkoQgyNRka86nc/b2vShwiYXfM0gI3qxsHwSvZone4zcsBq0iHBUDfLRjx7kJ7dQ5uUxJNyRW0FLApUP6fKHtfslt0hTLJ2CS6jsoiti8Ef0ll25YDpTcRngB2A/ePSjn1XHorwBpNkj0Ary0P7CfQv7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uoz8nJLp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FE0C116C6;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=WqXHH+IfirIk9LkIKK7Nl4nbWfgsz7d0eW6zTgrbVtU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uoz8nJLpEg7RJxFDS0SaUDuM3JC3++G29Vs6O3SIq0AlyDw/PtKWwF1Ek74YZtizN
	 ekkMeDZWxmiNkJ5aPmGW7zltBAJVWret0M3QxnUJdR3SxNof1VjZ4TmJar71HRDHcq
	 B+zcU7Vys78NH8p6reQ5SGIWBT2pUfK39dgXZLf/Ay+nfJf8ARpm2byEo1d/BEtLra
	 cRvm5KLXsLdsqhKT3FSA6mH91RMS9AEoSb+vpfE2AY0ZiMOdTviO7cCLtBrLdWkl3F
	 1gHFyE6a5/HGEDwdrlrj5ZEst307NwD/hZQKvss84KcsXukQxuTCU7N4W3s7jh1DJ+
	 UJV5giwhSkI8g==
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
Subject: [PATCH 10/17] openrisc: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:06 -0700
Message-Id: <20250804164417.1612371-10-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2965; i=kees@kernel.org; h=from:subject; bh=WqXHH+IfirIk9LkIKK7Nl4nbWfgsz7d0eW6zTgrbVtU=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkflff/nrZrjf/rkzv6m+Qd3bffrennIcv+d+/X3C wSz1gr/6ShlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiImC7DP/OJ8fypE74U3uRN eLGrj6P1bbxeg8jxiBUOnz7942gyYmH473XulIbBzg0OV94+C85feW9dXFGt1vywDWGtj4yvTa+ O4gMA
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

Add missing __attribute_const__ annotations to OpenRISC's implementations of
ffs(), __ffs(), fls(), and __fls() functions. These are pure mathematical
functions that always return the same result for the same input with no
side effects, making them eligible for compiler optimization.

Build tested ARCH=openrisc defconfig with GCC or1k-linux 15.1.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/openrisc/include/asm/bitops/__ffs.h | 2 +-
 arch/openrisc/include/asm/bitops/__fls.h | 2 +-
 arch/openrisc/include/asm/bitops/ffs.h   | 2 +-
 arch/openrisc/include/asm/bitops/fls.h   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/openrisc/include/asm/bitops/__ffs.h b/arch/openrisc/include/asm/bitops/__ffs.h
index 1e224b616fdf..4827b66530b2 100644
--- a/arch/openrisc/include/asm/bitops/__ffs.h
+++ b/arch/openrisc/include/asm/bitops/__ffs.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_OPENRISC_HAVE_INST_FF1
 
-static inline unsigned long __ffs(unsigned long x)
+static inline __attribute_const__ unsigned long __ffs(unsigned long x)
 {
 	int ret;
 
diff --git a/arch/openrisc/include/asm/bitops/__fls.h b/arch/openrisc/include/asm/bitops/__fls.h
index 9658446ad141..637cc76fe4b7 100644
--- a/arch/openrisc/include/asm/bitops/__fls.h
+++ b/arch/openrisc/include/asm/bitops/__fls.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_OPENRISC_HAVE_INST_FL1
 
-static inline unsigned long __fls(unsigned long x)
+static inline __attribute_const__ unsigned long __fls(unsigned long x)
 {
 	int ret;
 
diff --git a/arch/openrisc/include/asm/bitops/ffs.h b/arch/openrisc/include/asm/bitops/ffs.h
index b4c835d6bc84..536a60ab9cc3 100644
--- a/arch/openrisc/include/asm/bitops/ffs.h
+++ b/arch/openrisc/include/asm/bitops/ffs.h
@@ -10,7 +10,7 @@
 
 #ifdef CONFIG_OPENRISC_HAVE_INST_FF1
 
-static inline int ffs(int x)
+static inline __attribute_const__ int ffs(int x)
 {
 	int ret;
 
diff --git a/arch/openrisc/include/asm/bitops/fls.h b/arch/openrisc/include/asm/bitops/fls.h
index 6b77f6556fb9..77da7639bb3e 100644
--- a/arch/openrisc/include/asm/bitops/fls.h
+++ b/arch/openrisc/include/asm/bitops/fls.h
@@ -11,7 +11,7 @@
 
 #ifdef CONFIG_OPENRISC_HAVE_INST_FL1
 
-static inline int fls(unsigned int x)
+static inline __attribute_const__ int fls(unsigned int x)
 {
 	int ret;
 
-- 
2.34.1


