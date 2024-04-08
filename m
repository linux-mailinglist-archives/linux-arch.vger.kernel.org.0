Return-Path: <linux-arch+bounces-3490-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE8289CB01
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:49:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 079F21F21C7D
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FBC01442E3;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB88town"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1112143C60;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598586; cv=none; b=uBA6xwwPRjReHcpLRRiQQqTKCIDj9cSw1clX7PBFWofVOpi18HQMAlI0mPlamKSnFsuz3z0VAWhz3G3raqmlZvHBxoniuKZJ2XQyPc2fdR/taCHArmS4gnkmwYWDnbMoku3hHSdvGB1JUUeWFPoM5gpb1SQv7s0X2UYfIUopk9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598586; c=relaxed/simple;
	bh=Gwo0L9nG/Bxq+TZGLagGgn6iVboBxYsc87SIRn3872E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=U5aCpvwRe06hdzej7rWVwvpTbz5Hu3ute8f0ZxyzIL2v7EZcq83EmxzS91MVTwJ9sdTuAQfpG0uFqHX9+v6Xjsx7RT7CzaUQbCYl1ksRs8G1ygnF+JHJKbZo0GSWlcpmCl9jjIQ1R9W7nE/goW0SCwDnWJA07eHyRELLmNk+YsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB88town; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9314FC433C7;
	Mon,  8 Apr 2024 17:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598586;
	bh=Gwo0L9nG/Bxq+TZGLagGgn6iVboBxYsc87SIRn3872E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XB88townwR3nTkF3wwLRNNTI3bWzv3R8mJLqWogW7orO+P69ny6C50Mu91ylsi0GR
	 C4WxdDFA+bRvdwv2quUXT6A/tPuNyLXBLkswA7tKo/pn9GTU3dYLZ5WdYuj4NfHYgw
	 7I6XDUiyq+p/3chjgxHeT1J2iVYvibujmF+NsOAlWI6ipTq87wMIG3VLsO3c+7g8rR
	 rLNupaGTzAsWIl/ixFHtFt3v2AFASbE52lj634A4xczcYWkENw/pQ5fxFYm1QllUXj
	 yYG+qWlV6VC5dl9AyeiX4so8+TVih08Bv7JaNUo6zPoX5acjCZKI2GY1LqI3KrZ37J
	 VIQJTpyZlNt+A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3DAA8CE008B; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	torvalds@linux-foundation.org,
	Arnd Bergmann <arnd@arndb.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH cmpxchg 02/14] sparc32: make the first argument of __cmpxchg_u64() volatile u64 *
Date: Mon,  8 Apr 2024 10:49:32 -0700
Message-Id: <20240408174944.907695-2-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
References: <7b3646e0-667c-48e2-8f09-e493c43c30cb@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Al Viro <viro@zeniv.linux.org.uk>

... to match all cmpxchg variants.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 arch/sparc/include/asm/cmpxchg_32.h | 2 +-
 arch/sparc/lib/atomic32.c           | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/include/asm/cmpxchg_32.h b/arch/sparc/include/asm/cmpxchg_32.h
index 2a05cb236480c..05d5f86a56dc2 100644
--- a/arch/sparc/include/asm/cmpxchg_32.h
+++ b/arch/sparc/include/asm/cmpxchg_32.h
@@ -63,7 +63,7 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new_, int size)
 			(unsigned long)_n_, sizeof(*(ptr)));		\
 })
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new);
+u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new);
 #define arch_cmpxchg64(ptr, old, new)	__cmpxchg_u64(ptr, old, new)
 
 #include <asm-generic/cmpxchg-local.h>
diff --git a/arch/sparc/lib/atomic32.c b/arch/sparc/lib/atomic32.c
index d90d756123d81..e15affbbb5238 100644
--- a/arch/sparc/lib/atomic32.c
+++ b/arch/sparc/lib/atomic32.c
@@ -173,7 +173,7 @@ u32 __cmpxchg_u32(volatile u32 *ptr, u32 old, u32 new)
 }
 EXPORT_SYMBOL(__cmpxchg_u32);
 
-u64 __cmpxchg_u64(u64 *ptr, u64 old, u64 new)
+u64 __cmpxchg_u64(volatile u64 *ptr, u64 old, u64 new)
 {
 	unsigned long flags;
 	u64 prev;
-- 
2.40.1


