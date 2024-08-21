Return-Path: <linux-arch+bounces-6441-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ABF95A472
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 20:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AFA4DB21303
	for <lists+linux-arch@lfdr.de>; Wed, 21 Aug 2024 18:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0EA41B3B15;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0WM9A7x"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7814B1B2EF6;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724263813; cv=none; b=CWaNvZ76+E5sTI9NZTgapeEkqUr31+76AyFSb2iDYrNrjNyr4cf+KGvu0ssA4hJRLX6XhE5wMg9LDJe5AwvlnwdX9RK5HgcOFYlVrBhUQQMq4H0EXl5DH+jRdCs7Mij5/UMWYBoqYGHshctEQedZ3d3ZLazHz8GGU6uC5BK2IQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724263813; c=relaxed/simple;
	bh=A1ZjBdu0p6P+IfhPi1T9QOGeX9FqrNLLWzvUxef5bSI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=C4whzenAtOjp0abX8liVMR40Gv4nsZS8R7aCXMgLkijfJre6AWbZse94ahKSM9CiJ/5clFyqNRfV01vbYXboYMAMPU0YfKK8BUUmP9xx1zPzdG9ZzLL8I9Zood7FA1F8Zn1UWvbv2atSHrgbWz8STvXn/pfOEmaONfdmpSqYw6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0WM9A7x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 245EFC32781;
	Wed, 21 Aug 2024 18:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724263813;
	bh=A1ZjBdu0p6P+IfhPi1T9QOGeX9FqrNLLWzvUxef5bSI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0WM9A7xqkbJ6V3TFxkE1zg7hMdY2wf0H9wXcOs8gMzvp7Iuk1RJaGYFlEKX9cMMl
	 oKaSRU0xlpu16fsdGn7pWF3fdq9tpzBJP6HY2YsyHJ+J7nUezAZ4RvoztGhLCd90up
	 SlOPfEwWr7Pk0kbAoac0W+9e67Z31gHtrscgYABO/J8GJs0bYAR8JjIAzisbAZxK7e
	 nNrRtkP1o+NVzyjbp1uq/MHDi6N7ROLxiKSo9BBMr6KzL9E/pmYcGB1qV2gXw/Hzlt
	 So7DeRzdIHynDMUfXd5FKB0iCyMtSalpOla5cFOAgSlTtnzqNWsiC/J6DruxQewb3S
	 V5PJ5HlxDCI/g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id BCD68CE16C1; Wed, 21 Aug 2024 11:10:12 -0700 (PDT)
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
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-snps-arc@lists.infradead.org,
	Vineet Gupta <vgupta@kernel.org>
Subject: [PATCH v2 cmpxchg 2/3] ARC: Emulate one-byte cmpxchg
Date: Wed, 21 Aug 2024 11:10:10 -0700
Message-Id: <20240821181011.2604152-2-paulmck@kernel.org>
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

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on arc.

[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]
[ paulmck: Apply feedback from Naresh Kamboju. ]
[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Apply feedback from Vineet Gupta. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: <linux-snps-arc@lists.infradead.org>
Acked-by: Vineet Gupta <vgupta@kernel.org>
---
 arch/arc/Kconfig               | 1 +
 arch/arc/include/asm/cmpxchg.h | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index fd0b0a0d4686a..163608fd49d18 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -13,6 +13,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067dea..58045c8983404 100644
--- a/arch/arc/include/asm/cmpxchg.h
+++ b/arch/arc/include/asm/cmpxchg.h
@@ -8,6 +8,7 @@
 
 #include <linux/build_bug.h>
 #include <linux/types.h>
+#include <linux/cmpxchg-emu.h>
 
 #include <asm/barrier.h>
 #include <asm/smp.h>
@@ -46,6 +47,9 @@
 	__typeof__(*(ptr)) _prev_;					\
 									\
 	switch(sizeof((_p_))) {						\
+	case 1:								\
+		_prev_ = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		break;							\
 	case 4:								\
 		_prev_ = __cmpxchg(_p_, _o_, _n_);			\
 		break;							\
@@ -65,8 +69,6 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
-									\
 	/*								\
 	 * spin lock/unlock provide the needed smp_mb() before/after	\
 	 */								\
-- 
2.40.1


