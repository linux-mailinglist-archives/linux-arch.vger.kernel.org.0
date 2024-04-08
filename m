Return-Path: <linux-arch+bounces-3500-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D3EA89CB11
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD9D9288D77
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC51F145325;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uprUfyn1"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B25C1448E8;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=UC70T/kcdxLLt5/JDCVj6OZRniFMZHzmTR8vfsjcbZBHBsNLq4hiSZGO7TpaEqABTq3Ztr5zf/4rwCDtqIe62jBhhRy3H/7ZsdQ4CJHrNMt0Wrvz5qlZ2FkZ9/su/+Ce3u0nMPs67y/TKAys9HNrFIxf/N1upxj7waQDjKbL/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=WKYKHYI+0R9pnBOWkWIHPz6LwRVJ8kFwJ9YA0/qhV2w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fP5ERcRQ0yjJE2Q56vTaMutjIZuXmhe5jQO8C4+ouEYsjtI8r26PnRbCALVGnG90tET6UU7YNO/drLOy2DF6o8AuoBSs46COCzBouyt7EY2eDSPwNJwRZL2tnOrMqECEpdxqW0vVodaqu5x3Kfy3/TjSjVWqWcPLdHCb9Td+VIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uprUfyn1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149AFC4166A;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=WKYKHYI+0R9pnBOWkWIHPz6LwRVJ8kFwJ9YA0/qhV2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uprUfyn1HNN/C/FfKaccPjHjiW9rZEMZ07du2AWZmn3jNcVGXTOphZGqAlBSHzfIp
	 3FY/2a3zYF9th+NXgJ8k0iKX9TB2joR2FBuiLQ3QBeg0PhGaIOEzjwQRomSNaDkf70
	 nl7UHD8uqesvBXSyPGeR4E9+PLa3Zx55HS1h6c0MY6CBJDE7Ex5wwGg36R4XiSdeL7
	 g6ayH+lk38x9CgGoBr8jFHOT0Nl2zkKlDeJGDPkx2xhwh6LXvhFTOHkgp9qOiJw22t
	 JU9i4AaLn0JwLDmZiSTqWsQszkxmm2zApvfO2xCeYcREMPGyrqN6DGkQbgI4RL7coq
	 EU9VblDlNuCFQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 578B5CE2CD4; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
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
	"Paul E. McKenney" <paulmck@kernel.org>,
	Yujie Liu <yujie.liu@intel.com>,
	Guo Ren <guoren@kernel.org>,
	linux-csky@vger.kernel.org
Subject: [PATCH cmpxchg 11/14] csky: Emulate one-byte cmpxchg
Date: Mon,  8 Apr 2024 10:49:41 -0700
Message-Id: <20240408174944.907695-11-paulmck@kernel.org>
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


