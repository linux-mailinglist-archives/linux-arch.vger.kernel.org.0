Return-Path: <linux-arch+bounces-6440-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFEF695A471
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 20:10:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37061B21291
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0A601B3B14;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mi8hKXWv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 780F41B2EEF;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263813; cv=none; b=pQ404HRjvn7XPOVGRNCXrqyMydY8YYl/DwPyzj4WGbAEuLzRSoVyCXGR98j9Bt5zOMrDYMeoRGMhmKW2AIVwNwpOqyQpAx0/EfCfeJychBDZJnq2xkqV438I84j/KDrK+hgyx8JL2xA5e61scBCHIMF3fCIG25b9/G+ru8GssAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263813; c=relaxed/simple;
	bh=SsfSYlvMJfbrFJhxWSLRoEWcjcncMnxVxwE9E1US2+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UnOTh7F8Bqsip4OX7ZDEshZpHogMYS7OUW6T+ENVVAQZIvts+qn3uQ1rawaE9etvjh9NbZ72GgUEVF1pk/c8RaR1moCATbZD/ZA4UjQX5kEieWQ566iaLDZy9LXaWHSV6DplKF0FexHuehNNrFjbsqVT2zZRndGUguVFpJuGv9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mi8hKXWv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26FEAC4AF09;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263813;
	bh=SsfSYlvMJfbrFJhxWSLRoEWcjcncMnxVxwE9E1US2+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mi8hKXWvAOjmdqCKmwwPBuyC/Bi6ih8OGQOxWRnoREf7UzDrED43aPxGGpuM65Q5e
	 PCujx8KWqnrkuVLpxYriJVGOqPZ+8wfc3GdKh4jIn2YtEOi+ah6HZl/kvRWfs3/cxI
	 idoK/rTHjBnwoapgNadhElunGQsTA8pLce86C5iLsNwUVfi4fCH6NaW2Vfnx/mHEIE
	 cmiiHDwaROmnKcVr1+YfAxefVzg/g+yks0Nk+iPy8f9EKHEgWWdUdODMpX6OEg78wF
	 BUK/jBh39c9QkUWK1AmQKaSFN1luClo/Xm40/YUORWOazweQe1W69LGIhbiUJIBYZn
	 5JPMRv+hEjM3g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B99BDCE160F; Wed, 21 Aug 2024 11:10:12 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	elver@google.com
Cc: akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	torvalds@linux-foundation.org,
	arnd@arndb.de,
	geert@linux-m68k.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Yujie Liu <yujie.liu@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH v2 cmpxchg 1/3] xtensa: Emulate one-byte cmpxchg
Date: Wed, 21 Aug 2024 11:10:09 -0700
Message-Id: <20240821181011.2604152-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <04a6010c-536d-4906-bf7c-b2335a2f54b0@paulmck-laptop>
References: <04a6010c-536d-4906-bf7c-b2335a2f54b0@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on xtensa.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
[ Apply Geert Uytterhoeven feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
---
 arch/xtensa/Kconfig               | 1 +
 arch/xtensa/include/asm/cmpxchg.h | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/arch/xtensa/Kconfig b/arch/xtensa/Kconfig
index f200a4ec044e6..d3db28f2f8110 100644
--- a/arch/xtensa/Kconfig
+++ b/arch/xtensa/Kconfig
@@ -14,6 +14,7 @@ config XTENSA
 	select ARCH_HAS_DMA_SET_UNCACHED if MMU
 	select ARCH_HAS_STRNCPY_FROM_USER if !KASAN
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/xtensa/include/asm/cmpxchg.h b/arch/xtensa/include/asm/cmpxchg.h
index 675a11ea8de76..95e33a913962d 100644
--- a/arch/xtensa/include/asm/cmpxchg.h
+++ b/arch/xtensa/include/asm/cmpxchg.h
@@ -15,6 +15,7 @@
 
 #include <linux/bits.h>
 #include <linux/stringify.h>
+#include <linux/cmpxchg-emu.h>
 
 /*
  * cmpxchg
@@ -74,6 +75,7 @@ static __inline__ unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
+	case 1:  return cmpxchg_emu_u8(ptr, old, new);
 	case 4:  return __cmpxchg_u32(ptr, old, new);
 	default: __cmpxchg_called_with_bad_pointer();
 		 return old;
-- 
2.40.1


