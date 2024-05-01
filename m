Return-Path: <linux-arch+bounces-4121-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2FD8B91D5
	for <lists+linux-arch@lfdr.de>; Thu,  2 May 2024 01:01:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 115051F21EEF
	for <lists+linux-arch@lfdr.de>; Wed,  1 May 2024 23:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BCAB168B16;
	Wed,  1 May 2024 23:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dkWvtQ6I"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F208D168AEE;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714604493; cv=none; b=F3EJAG2MJqDhE68IcXYIYxH8IFQbOMLg6rCGfn/bZATs+rksJqRBoqg971iyLmXq1FtJnuzjmPwP8CQEWgG4UQpW3XRhqqMc74wda7+HP6kg8Cg+7zIrsw5QyJ9QkBxvpUnxe8ztWnI6ihc2e1CABi+Hwuj3/XrEFxc8AfAfpLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714604493; c=relaxed/simple;
	bh=WKYKHYI+0R9pnBOWkWIHPz6LwRVJ8kFwJ9YA0/qhV2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V3q8zQEmnvfAaflKN4vRdalhuRr4zHYSrvI6X6G97j4Fwx6aUlIudmfKcUMMqYqUCmAiGcERsGg/Q3eRIhMOU+kYczVmmuvgkWdHSk8x8a/1x+nBBgqf0xVceEFDorWjrXfoEcMUQJatz2H+vrjFFNCzPxJ59RNrqCF8uEvJCbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dkWvtQ6I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98781C4AF53;
	Wed,  1 May 2024 23:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714604492;
	bh=WKYKHYI+0R9pnBOWkWIHPz6LwRVJ8kFwJ9YA0/qhV2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dkWvtQ6ImaDQCpaRW/GM9Kxzl0aMNvM9bdSFLU8tjP3IWqGR94n9mzXRMHpo/vVOg
	 mRUw4scDFHfgYIlsKRdUSg6sInyTZ5IaA9+LDGZUtQev4+wh4bkZ7zPARSE3KsOIwh
	 fN0WTi/qhrENELvVALKC3tNx1KI/JlCvBW268k8W+O5v1UbuLrOoySYEpEExLn0+iP
	 4a6kepf53caGhWEzeqvAaAH+azO6u6lF45KeQ/BcJzJsbKnkdTGoaW2uaS0oDpGrBb
	 J6AJFvndPWBPuOFmc2GFTGW4wZks5AWHN+kPL9lsT8tPCs5aWon5m62Qh6k8zrv5T7
	 nAMNrZzVCuA2w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id D9D84CE28A8; Wed,  1 May 2024 16:01:31 -0700 (PDT)
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
	Yujie Liu <yujie.liu@intel.com>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH v2 cmpxchg 11/13] csky: Emulate one-byte cmpxchg
Date: Wed,  1 May 2024 16:01:28 -0700
Message-Id: <20240501230130.1111603-11-paulmck@kernel.org>
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

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on csky.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]

Co-developed-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Yujie Liu <yujie.liu@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Cc: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-csky@vger.kernel.org>
---
 arch/csky/Kconfig               |  1 +
 arch/csky/include/asm/cmpxchg.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index d3ac36751ad1f..5479707eb5d10 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -37,6 +37,7 @@ config CSKY
 	select ARCH_INLINE_SPIN_UNLOCK_BH if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQ if !PREEMPTION
 	select ARCH_INLINE_SPIN_UNLOCK_IRQRESTORE if !PREEMPTION
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_WANT_FRAME_POINTERS if !CPU_CK610 && $(cc-option,-mbacktrace)
 	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 	select COMMON_CLK
diff --git a/arch/csky/include/asm/cmpxchg.h b/arch/csky/include/asm/cmpxchg.h
index 916043b845f14..db6dda47184e4 100644
--- a/arch/csky/include/asm/cmpxchg.h
+++ b/arch/csky/include/asm/cmpxchg.h
@@ -6,6 +6,7 @@
 #ifdef CONFIG_SMP
 #include <linux/bug.h>
 #include <asm/barrier.h>
+#include <linux/cmpxchg-emu.h>
 
 #define __xchg_relaxed(new, ptr, size)				\
 ({								\
@@ -61,6 +62,9 @@
 	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
+	case 1:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
@@ -91,6 +95,9 @@
 	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
+	case 1:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		"1:	ldex.w		%0, (%3) \n"		\
@@ -122,6 +129,9 @@
 	__typeof__(old) __old = (old);				\
 	__typeof__(*(ptr)) __ret;				\
 	switch (size) {						\
+	case 1:							\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;						\
 	case 4:							\
 		asm volatile (					\
 		RELEASE_FENCE					\
-- 
2.40.1


