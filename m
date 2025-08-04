Return-Path: <linux-arch+bounces-13052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1835AB1A7D6
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BE7B1891EF1
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73DE0288C23;
	Mon,  4 Aug 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWE8VRfr"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619A2868B3;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=ZcENIBUokdGV6JjwuMUnTu5SxGFteoC2baXeldKGJ3aQicDrN6/cxowq+VUqbIypcPgYEfabVjQMCcJV3nB0vJSD60ug4HXx/EH8XP+t46qWOe/ZcHZ2b1x1scrIJPOkXnDVHY1XykH+LFEsPGyMPQhqIgZJmZr1Opa+4b7Vh5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=nxTQvOzC/JSvvXmGiwbBm389+tS3ydnEWu5ZjeE7uO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MOGhH3147IfkxE9+wl9CH+R5msxaVxVOjMenm0eMgtmGJjEZpIJjja2tX8GfcDeOUVc5f4tMnE77V6mS8zc6ooimMCbxX1FU/tP67XdGlThuof+hsHf5jzRy7mKxceQcpnLzGibQ4JGjZva2afTJCVW52bxaf5Q3MI0dqhePF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWE8VRfr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B6F4C16AAE;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=nxTQvOzC/JSvvXmGiwbBm389+tS3ydnEWu5ZjeE7uO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iWE8VRfr3OxYP3UO+d3IFdSlRFDUjVi2yt4abZfHzx8WHNZlmjZv+iW6tbZ1hMSed
	 GMUdeyWXa93Rj3Q0kqxys9JnrtcHbS7zYtwpkZQRdwxgfGOKtH22uDHP/aPOYqk0zt
	 gx8OrUhDzIOeYz/3ozZ66IT6SxVrbTOHmxAgWe1j9r7DVA49oSHPmCapszzzdVlvT5
	 0rVKK5k/1PP3orjyxoddlYJAHhNu+cSVguk1WJNaR/vlpIK6zkQ5yksGOZcLTjvx5d
	 +wES39FcF9VH0Zhaow4jkVDyWjetCNzprRgTQ6VOL3WnhLNsY4nqYgtVeNxI1xrh5K
	 6EfQRLAP2s92A==
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
Subject: [PATCH 08/17] hexagon: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:04 -0700
Message-Id: <20250804164417.1612371-8-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2819; i=kees@kernel.org; h=from:subject; bh=nxTQvOzC/JSvvXmGiwbBm389+tS3ydnEWu5ZjeE7uO8=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHkdOvim1XYmPabvy37zFTXdO+twPi7p8b1vSfFm/q OnG5olrO0pZGMS4GGTFFFmC7NzjXDzetoe7z1WEmcPKBDKEgYtTACZiJ8/wv6jRWDiHOXGy6K77 d0Jm7Hwj/e9RpO9Ez+OX9qfOXmB1yp7hr+z2vC+XouyPGE0/r/25u2hG61q+7x8rzLzfsxpPfBd xmwEA
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

Add missing __attribute_const__ annotations to Hexagon's implementations
of fls(), ffs(), __ffs(), __fls(), and ffz() functions. These are
pure mathematical functions that always return the same result for
the same input with no side effects, making them eligible for compiler
optimization.

Build tested ARCH=hexagon defconfig with Clang 21.0.0git (LLVM=1).

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/hexagon/include/asm/bitops.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/hexagon/include/asm/bitops.h b/arch/hexagon/include/asm/bitops.h
index 160d8f37fa1a..b23cb13833af 100644
--- a/arch/hexagon/include/asm/bitops.h
+++ b/arch/hexagon/include/asm/bitops.h
@@ -200,7 +200,7 @@ arch_test_bit_acquire(unsigned long nr, const volatile unsigned long *addr)
  *
  * Undefined if no zero exists, so code should check against ~0UL first.
  */
-static inline long ffz(int x)
+static inline long __attribute_const__ ffz(int x)
 {
 	int r;
 
@@ -217,7 +217,7 @@ static inline long ffz(int x)
  * This is defined the same way as ffs.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(unsigned int x)
+static inline __attribute_const__ int fls(unsigned int x)
 {
 	int r;
 
@@ -238,7 +238,7 @@ static inline int fls(unsigned int x)
  * the libc and compiler builtin ffs routines, therefore
  * differs in spirit from the above ffz (man ffs).
  */
-static inline int ffs(int x)
+static inline __attribute_const__ int ffs(int x)
 {
 	int r;
 
@@ -260,7 +260,7 @@ static inline int ffs(int x)
  * bits_per_long assumed to be 32
  * numbering starts at 0 I think (instead of 1 like ffs)
  */
-static inline unsigned long __ffs(unsigned long word)
+static inline __attribute_const__ unsigned long __ffs(unsigned long word)
 {
 	int num;
 
@@ -278,7 +278,7 @@ static inline unsigned long __ffs(unsigned long word)
  * Undefined if no set bit exists, so code should check against 0 first.
  * bits_per_long assumed to be 32
  */
-static inline unsigned long __fls(unsigned long word)
+static inline __attribute_const__ unsigned long __fls(unsigned long word)
 {
 	int num;
 
-- 
2.34.1


