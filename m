Return-Path: <linux-arch+bounces-13053-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67959B1A7EE
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 18:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70DD2623A93
	for <lists+linux-arch@lfdr.de>; Mon,  4 Aug 2025 16:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46FEB288C0C;
	Mon,  4 Aug 2025 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kp6LgWva"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C541A2868BA;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754325858; cv=none; b=jskxbW4EETT7B5Ly1v7ZFIfj9mfAQ70/pghqB1kLuIfO002GLRkQMWwaPEhW+MuPyvq8dswd7hwKvoYZHYAvhlct8duViImGvUmbQAYjZ7izOI7VBStdHwY11Jm1siQ5fmkyFs0VKZ4ySTv5vylG7msyBE8oz/ToXHypesrEwxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754325858; c=relaxed/simple;
	bh=qBtLAFX1ElqeAeYMLqY5b/htKgZsKDyJ9FsgsyXOP0Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hnuHrLZJHN3ubnUO02x9oIZIHZ7DXoV8fbf05NJWAf7rzZiFUq2djQbqlplb1G3kC27pjSq0B65FIMy3mB3xNe2kyobZq7qeA8or9Bx91USEPbIXaf9fmo5MraMnFCXjoKWdLAubFl472ZTC5i5okbbl5J30zLp8FGQKbh91zys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kp6LgWva; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0DBC4AF10;
	Mon,  4 Aug 2025 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754325858;
	bh=qBtLAFX1ElqeAeYMLqY5b/htKgZsKDyJ9FsgsyXOP0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kp6LgWvaC+JEEdzd/Dg6N32Ddbu8okhan2FNusfuPzb/+mtKpY00kgSWLtUB4lxZ1
	 agtCgKlv4oPcKNTUENwcnN6oQnfWaK/BRy+DAFo22YYX44R2rTwP1fiKy6SCrbsb29
	 EoH8nLBo3UHb53nqW0BCFrF5MIJ1VL7X8xHr0PRPBwAGzOPvBlVtBYlONnhLX0NU/R
	 cK2lZhvuTQErOUUkr8caoNuFPryzEl5+oaCkyeDKm5zxVDNUriO3vJeouVSjaZvAln
	 bH9HkpexT8y9oby0emLBvnqwbpd3PL7GU/mNyh1h70wfClsRQO3uTF05s6DLQjTWLl
	 ZFTlkXCUPL+YA==
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
Subject: [PATCH 16/17] sparc: Add __attribute_const__ to ffs()-family implementations
Date: Mon,  4 Aug 2025 09:44:12 -0700
Message-Id: <20250804164417.1612371-16-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250804163910.work.929-kees@kernel.org>
References: <20250804163910.work.929-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=kees@kernel.org; h=from:subject; bh=qBtLAFX1ElqeAeYMLqY5b/htKgZsKDyJ9FsgsyXOP0Y=; b=owGbwMvMwCVmps19z/KJym7G02pJDBkTHsdU/+bmO7Fhxa1ih00tOXKbpp0476zeIfi8Yf2pN V/3MW9O6yhlYRDjYpAVU2QJsnOPc/F42x7uPlcRZg4rE8gQBi5OAZiI0H2G/5UJfWucumQV/e+3 bQ+5Mrn3SsqlxOfneU8K1R0s3fBtqwkjw+5N+nqci535gz/LNFgwPl81b+K/bhn9NKvtdwS9tVa L8AMA
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

Add missing __attribute_const__ annotations to sparc64's implementations
of ffs(), __ffs(), fls(), and __fls() functions. These are pure
mathematical functions that always return the same result for the
same input with no side effects, making them eligible for compiler
optimization.

Build tested ARCH=sparc defconfig with GCC sparc64-linux-gnu 14.2.0.

Link: https://github.com/KSPP/linux/issues/364 [1]
Signed-off-by: Kees Cook <kees@kernel.org>
---
 arch/sparc/include/asm/bitops_64.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/include/asm/bitops_64.h b/arch/sparc/include/asm/bitops_64.h
index 005a8ae858f1..2c7d33b3ec2e 100644
--- a/arch/sparc/include/asm/bitops_64.h
+++ b/arch/sparc/include/asm/bitops_64.h
@@ -23,8 +23,8 @@ void set_bit(unsigned long nr, volatile unsigned long *addr);
 void clear_bit(unsigned long nr, volatile unsigned long *addr);
 void change_bit(unsigned long nr, volatile unsigned long *addr);
 
-int fls(unsigned int word);
-int __fls(unsigned long word);
+int __attribute_const__ fls(unsigned int word);
+int __attribute_const__ __fls(unsigned long word);
 
 #include <asm-generic/bitops/non-atomic.h>
 
@@ -32,8 +32,8 @@ int __fls(unsigned long word);
 
 #ifdef __KERNEL__
 
-int ffs(int x);
-unsigned long __ffs(unsigned long);
+int __attribute_const__ ffs(int x);
+unsigned long __attribute_const__ __ffs(unsigned long);
 
 #include <asm-generic/bitops/ffz.h>
 #include <asm-generic/bitops/sched.h>
-- 
2.34.1


