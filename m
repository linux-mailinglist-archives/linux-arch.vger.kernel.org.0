Return-Path: <linux-arch+bounces-4118-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA138B91D1
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D44711F21E65
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9AC168B0C;
	Wed,  1 May 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aW6xdmzw"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF83B168AEC;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604493; cv=none; b=gnJKW8sH2PySUD66dtHR7W+4aLXqcv47WqQeDEq4zk6Ksl3w+oM8UNcvKReg4/ptIg5q1RTOa0RFp67eFp1OoRfe658qNJnO9ngcLtjJEhE0aWCRFXuddTNZk4OR/EXBm4a4lH88YGEo4oNaXbyjjof7MyDEb9x2gcOrS6Z2igI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604493; c=relaxed/simple;
	bh=225e9ZrZUo35qiu06QPAPMUsNmM/XjwmxVyvd0jYw/w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZPwVoTZZcN9p4DHJKy3xU4iexufohRc6lJhvfRF7lhYT+ZsLYStNAWj8x/xQCoFLebMuR/7aPuxU+j5BEcQXvWzPUexPk3xb39qKfYMEgrkZuqQrPnoni0hOcrM18ER6QPoBAVIj/W/UHOwYVZcRW41dDnz54/jc2mC1g1X5HJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aW6xdmzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F534C4AF54;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=225e9ZrZUo35qiu06QPAPMUsNmM/XjwmxVyvd0jYw/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aW6xdmzw+K9cnrAtCo3noevENO5U0fkbybYY/UG7BhPW577IP7aufNJRTbTtMF6kP
	 IpGrc+z2gPPwy1MUtxwFVwzfkh8KNfCqU7g+D5yXJ9hf+vhd7f5gi3ZZ70p5V09Nfl
	 fYZK5UCMfbNRfu5Cab6uaz8D3g8Wf7MO9DUD54N8SIiQhYiW0WM+/Y1uLJaK2/7m05
	 3pLr8wBSv6mV6PI5iK5ONHxInz09CrEOPRKXPS2Mo7gTAQJLBF6nojWdDau/HIPndq
	 zpGvOVyprRXvXtQzxqXwGnkNDVJi5GHGvaKWXEfRFw2H0Z+RovEE28ZANSFKQEmozc
	 SH+3pQ9XMv+rA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D6CB7CE28A3; Wed,  1 May 2024 16:01:31 -0700 (PDT)
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: elver@google.com,
	akpm@linux-foundation.org,
	tglx@linutronix.de,
	peterz@infradead.org,
	dianders@chromium.org,
	pmladek@suse.com,
	arnd@arndb.de,
	torvalds@linux-foundation.org,
	kernel-team@meta.com,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Vineet Gupta <vgupta@kernel.org>,
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	Palmer Dabbelt <palmer@rivosinc.com>,
	linux-snps-arc@lists.infradead.org
Subject: [PATCH v2 cmpxchg 10/13] ARC: Emulate one-byte cmpxchg
Date: Wed,  1 May 2024 16:01:27 -0700
Message-Id: <20240501230130.1111603-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
References: <b67e79d4-06cb-4a45-a906-b9e0fbae22c5@paulmck-laptop>
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

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Vineet Gupta <vgupta@kernel.org>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Palmer Dabbelt <palmer@rivosinc.com>
Cc: <linux-snps-arc@lists.infradead.org>
---
 arch/arc/Kconfig               |  1 +
 arch/arc/include/asm/cmpxchg.h | 33 ++++++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
index 99d2845f3feb9..5bf6137f0fd47 100644
--- a/arch/arc/Kconfig
+++ b/arch/arc/Kconfig
@@ -14,6 +14,7 @@ config ARC
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_SUPPORTS_ATOMIC_RMW if ARC_HAS_LLSC
 	select ARCH_32BIT_OFF_T
 	select BUILDTIME_TABLE_SORT
diff --git a/arch/arc/include/asm/cmpxchg.h b/arch/arc/include/asm/cmpxchg.h
index e138fde067dea..2102ce076f28b 100644
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
@@ -65,16 +69,27 @@
 	__typeof__(*(ptr)) _prev_;					\
 	unsigned long __flags;						\
 									\
-	BUILD_BUG_ON(sizeof(_p_) != 4);					\
+	switch(sizeof((_p_))) {						\
+	case 1:								\
+		__flags = cmpxchg_emu_u8((volatile u8 *)_p_, (uintptr_t)_o_, (uintptr_t)_n_);	\
+		_prev_ = (__typeof__(*(ptr)))__flags;			\
+		break;							\
+		break;							\
+	case 4:								\
+		/*							\
+		 * spin lock/unlock provide the needed smp_mb()		\
+		 * before/after						\
+		 */							\
+		atomic_ops_lock(__flags);				\
+		_prev_ = *_p_;						\
+		if (_prev_ == _o_)					\
+			*_p_ = _n_;					\
+		atomic_ops_unlock(__flags);				\
+		break;							\
+	default:							\
+		BUILD_BUG();						\
+	}								\
 									\
-	/*								\
-	 * spin lock/unlock provide the needed smp_mb() before/after	\
-	 */								\
-	atomic_ops_lock(__flags);					\
-	_prev_ = *_p_;							\
-	if (_prev_ == _o_)						\
-		*_p_ = _n_;						\
-	atomic_ops_unlock(__flags);					\
 	_prev_;								\
 })
 
-- 
2.40.1


