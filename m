Return-Path: <linux-arch+bounces-5994-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D6C948231
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 21:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545811C21C51
	for <lists+linux-arch@lfdr.de>; Mon,  5 Aug 2024 19:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297FB16A952;
	Mon,  5 Aug 2024 19:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZairQtTn"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3F143C6E;
	Mon,  5 Aug 2024 19:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885682; cv=none; b=etHJ7ny2M1oLXSQK15mRc0sk/PymhAMdtSg5wzauAh90hkL55N9J2oXKO7P2Gy9N+3soKSfghKMhoYz979XsA3i1PGD7mLSQz9JaslVLZRjAgwr1JtuzoNe2MyQlx0WAHItR8+TDhCu/kmk8/CZbyJ7xYOwU2MJWHhuNbdQ4xas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885682; c=relaxed/simple;
	bh=SsfSYlvMJfbrFJhxWSLRoEWcjcncMnxVxwE9E1US2+0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=etEP9cbzgFTwfVsRtpxHvfFymJIH3htKu7PusLhoOpjOIt/lLOXSCk2i1KBJXjlqlPqw9EbApNOYi3lakbKKxdDet7sAglMUVVUV4i7P0XDnQYRWGxZ9Hu9bk1E0HMkc5Vj+aHuUqU35ggCvux/mz0hKrVMF2jp5OlGu9m1G6S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZairQtTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C592C32782;
	Mon,  5 Aug 2024 19:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722885681;
	bh=SsfSYlvMJfbrFJhxWSLRoEWcjcncMnxVxwE9E1US2+0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZairQtTnGfrM8IsiBq71qJecW1kAYKoiw1mpOCVFzhcp0z+L0X8x1VjPgRNexVi6f
	 8dNooCLXYg89HV1K9eqYdLHzBidYZwlAOEMNXFkTC7Op4DmGfpDSo5sQPUiEdQif2B
	 oU0qTkenvvqwDkugiHSAdwpzafTmDvT1HKSZxk6Lc9+HOKS2LHmemDLh5aDTX6CbHL
	 z2xTQm1U4txlS4aUH4Y8lBM3vLIpPNptvjafVM+s2ZBPqHl40cnEeKxs9r8ECBnY9F
	 io31MjG/bZkCIt5+AXzgPRQvDlRAO8FsgyPApEDpo/2ET85G4DdXtKSkw08a4OlzIx
	 s0Mj/Zrfo14tQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 49204CE0A6F; Mon,  5 Aug 2024 12:21:21 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	torvalds@linux-foundation.org,
	arnd@arndb.de,
	geert@linux-m68k.org,
	palmer@rivosinc.com,
	mhiramat@kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Yujie Liu <yujie.liu@intel.com>,
	Andi Shyti <andi.shyti@linux.intel.com>
Subject: [PATCH cmpxchg 1/3] xtensa: Emulate one-byte cmpxchg
Date: Mon,  5 Aug 2024 12:21:17 -0700
Message-Id: <20240805192119.56816-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
References: <c1b7f3a2-da50-4dfb-af6f-a1898eaf2b79@paulmck-laptop>
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


