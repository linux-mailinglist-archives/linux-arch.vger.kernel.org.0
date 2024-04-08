Return-Path: <linux-arch+bounces-3502-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48ADB89CB12
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 19:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 040BB288C36
	for <lists+linux-arch@lfdr.de>; Mon,  8 Apr 2024 17:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1F914532D;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7mkThM0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C8E144D02;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712598587; cv=none; b=BFfKvAlcAZ3PU+VrhXg/miSXDx5L3OmEs0TBaaYkZOpVkQXsaCrdQOhS3a2YQuiO14G05DegegZlJVl9FGSzaTO9ZQU5HsrxL45sBW6k5M5HUdapPnKMR2u66252AoGtwvvmqo+q3fmXCdicSWMSntXdFsPtr5JcTmrwkrGZPdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712598587; c=relaxed/simple;
	bh=C5CpU6dpky4LWKttI7kOlyW29BP4G9a1vbAChlmbviA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tZWtZm6tki6e7cnZGsZ4g1pGooypCYEQ35kpRY3n8LXZ0k+pQUA9E5BV3uEMPP2Z45X8CXscUhPHVU9+R29cIIr+rfrb+x6kAzIDWW9dcP0EznRq2r3yFFA32d3wAKcmvFnZtMI0rZzcHt0RHcna1PBIM7EUa17pEgYJyUwohQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7mkThM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFC6C3278A;
	Mon,  8 Apr 2024 17:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712598587;
	bh=C5CpU6dpky4LWKttI7kOlyW29BP4G9a1vbAChlmbviA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A7mkThM0RImV5o66khbu030tAe3dAuCBOfGyC/Gsufo5lDDRbKEqi703ShDHrgs4W
	 N6vGVkNABpkg96qmyMxOdeLocfsr0Q1MVHw1v5JtkfCQ//ID+fj0zYbnwosa+vKfzo
	 v9DJtG/03ZC85kSHKPZom8p7hG6krmM9y7b6Xr3XbTS2n0FXtBGzdsMx6vynZ8ETsl
	 eUGyXiNaDWemAYweRkAqDKvdrM8/rk5KW4RQzW5idrhitIJgeggHDZ3jTYINu9HpDu
	 9tWbrN+6yXG/DuLg9/zQ87xLf+RqXqHm1fl3WQDF3OosbU164PNBKMkdQYirYC09oJ
	 x59xgkDFCLTJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 5FC5BCE2CE2; Mon,  8 Apr 2024 10:49:46 -0700 (PDT)
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
	Andi Shyti <andi.shyti@linux.intel.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	linux-riscv@lists.infradead.org,
	Palmer Dabbelt <palmer@rivosinc.com>
Subject: [PATCH cmpxchg 14/14] riscv: Emulate one-byte cmpxchg
Date: Mon,  8 Apr 2024 10:49:44 -0700
Message-Id: <20240408174944.907695-14-paulmck@kernel.org>
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

Use the new cmpxchg_emu_u8() to emulate one-byte cmpxchg() on riscv.

[ paulmck: Apply kernel test robot feedback. ]
[ paulmck: Drop two-byte support per Arnd Bergmann feedback. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Tested-by: Yujie Liu <yujie.liu@intel.com>
Cc: Andi Shyti <andi.shyti@linux.intel.com>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: <linux-riscv@lists.infradead.org>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
---
 arch/riscv/Kconfig               |  1 +
 arch/riscv/include/asm/cmpxchg.h | 13 +++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index be09c8836d56b..3bab9c5c0f465 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -44,6 +44,7 @@ config RISCV
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_VDSO_DATA
 	select ARCH_KEEP_MEMBLOCK if ACPI
+	select ARCH_NEED_CMPXCHG_1_EMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
 	select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
 	select ARCH_STACKWALK
diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 2fee65cc84432..abcd5543b861b 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -9,6 +9,7 @@
 #include <linux/bug.h>
 
 #include <asm/fence.h>
+#include <linux/cmpxchg-emu.h>
 
 #define __xchg_relaxed(ptr, new, size)					\
 ({									\
@@ -170,6 +171,9 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, (uintptr_t)__old, (uintptr_t)__new); \
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
@@ -214,6 +218,9 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
@@ -260,6 +267,9 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			RISCV_RELEASE_BARRIER				\
@@ -306,6 +316,9 @@
 	__typeof__(*(ptr)) __ret;					\
 	register unsigned int __rc;					\
 	switch (size) {							\
+	case 1:								\
+		__ret = (__typeof__(*(ptr)))cmpxchg_emu_u8((volatile u8 *)__ptr, __old, __new); \
+		break;							\
 	case 4:								\
 		__asm__ __volatile__ (					\
 			"0:	lr.w %0, %2\n"				\
-- 
2.40.1


