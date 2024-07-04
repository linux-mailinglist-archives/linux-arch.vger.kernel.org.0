Return-Path: <linux-arch+bounces-5258-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 971D49278D0
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 16:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8C521C238B0
	for <lists+linux-arch@lfdr.de>; Thu,  4 Jul 2024 14:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341001B140F;
	Thu,  4 Jul 2024 14:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YfktrOqH"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D311B1201;
	Thu,  4 Jul 2024 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720103884; cv=none; b=tBnFpCN6P85hSam9xdcFgOuXIbFxFan8ovIb+mR6LpXOS3gVHvXJ5Enc2srBEa0jYbX+ocixDllbfZzyyn0TYSgSV2Cw0ipeR3vh4ARg0v6ys7azHsy8FJhpEB8U1yT9d27QpPHtsxZ+zx4/NJZ3oRXlFaWcU0cZVmZLXgoLALw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720103884; c=relaxed/simple;
	bh=qMy/ikxpHS3hjhTlTaba5eVga/lQ/MRQyAUcrByidBQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIG55fGRk+tHH2EhbrNLXI2ixnspRcXKoarJQaDAvbPQo9teqqtBUdZ2dBwb/5TWL+9WM0gDx3UDbPGcLqY93BhRbfxRWQq8XGjgtVSKmM974KyiOTiGDb43T6WFpdOLFLuFb++f40B+GUntPJFVmRBEcKuYfetaft3Ir/CckXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YfktrOqH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8157CC4AF0B;
	Thu,  4 Jul 2024 14:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720103883;
	bh=qMy/ikxpHS3hjhTlTaba5eVga/lQ/MRQyAUcrByidBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfktrOqHQKOoLgbuL1wu59/ZRO17ByQ3slKns4BMf97AF811z6gAmANnhO2R4IBDR
	 CHfjyDWO7wduo7no+fonxCRFOl143NLma4TRWxLcbdL8TgM3ybDqXkdosGWrtxIBHY
	 1ofM8jd6CTEy3eZXRxbpTdWXxyHgzmBIoySeEfrxcd56OSBCEWd7sCyd6J7t1pOKf6
	 YxxQs0TTdRwdo4hjNBrrP0u1+DYs/fHrAWtYEGglM4R+6lS3Jp/qflLPPshD/NcaHf
	 /GherjlZ+FlkR5M0CKlMWtNUzGciTRwiIwvoUrw0AS4Zem4bPPTAqyl0Tzwj3NTs0z
	 Eo4tt06vJ0lmg==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-arch@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Vineet Gupta <vgupta@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Brian Cain <bcain@quicinc.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Christian Brauner <brauner@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-openrisc@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 11/17] arm64: rework compat syscall macros
Date: Thu,  4 Jul 2024 16:36:05 +0200
Message-Id: <20240704143611.2979589-12-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704143611.2979589-1-arnd@kernel.org>
References: <20240704143611.2979589-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The generated asm/unistd_compat_32.h header file now contains
macros that can be used directly in the vdso and the signal
trampolines, so remove the duplicate definitions.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/seccomp.h               | 10 +++++-----
 arch/arm64/include/asm/unistd.h                | 15 ---------------
 .../include/asm/vdso/compat_gettimeofday.h     | 12 ++++++------
 arch/arm64/kernel/signal32.c                   |  2 +-
 arch/arm64/kernel/sigreturn32.S                | 18 +++++++++---------
 5 files changed, 21 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/include/asm/seccomp.h b/arch/arm64/include/asm/seccomp.h
index c83ca2c8b936..b83975555314 100644
--- a/arch/arm64/include/asm/seccomp.h
+++ b/arch/arm64/include/asm/seccomp.h
@@ -8,13 +8,13 @@
 #ifndef _ASM_SECCOMP_H
 #define _ASM_SECCOMP_H
 
-#include <asm/unistd.h>
+#include <asm/unistd_compat_32.h>
 
 #ifdef CONFIG_COMPAT
-#define __NR_seccomp_read_32		__NR_compat_read
-#define __NR_seccomp_write_32		__NR_compat_write
-#define __NR_seccomp_exit_32		__NR_compat_exit
-#define __NR_seccomp_sigreturn_32	__NR_compat_rt_sigreturn
+#define __NR_seccomp_read_32		__NR_compat32_read
+#define __NR_seccomp_write_32		__NR_compat32_write
+#define __NR_seccomp_exit_32		__NR_compat32_exit
+#define __NR_seccomp_sigreturn_32	__NR_compat32_rt_sigreturn
 #endif /* CONFIG_COMPAT */
 
 #include <asm-generic/seccomp.h>
diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index fdd16052f9bc..80618c9bbcd8 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -16,21 +16,6 @@
 #define __ARCH_WANT_SYS_FORK
 #define __ARCH_WANT_SYS_VFORK
 
-/*
- * Compat syscall numbers used by the AArch64 kernel.
- */
-#define __NR_compat_restart_syscall	0
-#define __NR_compat_exit		1
-#define __NR_compat_read		3
-#define __NR_compat_write		4
-#define __NR_compat_gettimeofday	78
-#define __NR_compat_sigreturn		119
-#define __NR_compat_rt_sigreturn	173
-#define __NR_compat_clock_gettime	263
-#define __NR_compat_clock_getres	264
-#define __NR_compat_clock_gettime64	403
-#define __NR_compat_clock_getres_time64	406
-
 /*
  * The following SVCs are ARM private.
  */
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index ecb6fd4c3c64..778c1202bbbf 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -8,7 +8,7 @@
 #ifndef __ASSEMBLY__
 
 #include <asm/barrier.h>
-#include <asm/unistd.h>
+#include <asm/unistd_compat_32.h>
 #include <asm/errno.h>
 
 #include <asm/vdso/compat_barrier.h>
@@ -24,7 +24,7 @@ int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 	register struct timezone *tz asm("r1") = _tz;
 	register struct __kernel_old_timeval *tv asm("r0") = _tv;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_gettimeofday;
+	register long nr asm("r7") = __NR_compat32_gettimeofday;
 
 	asm volatile(
 	"	swi #0\n"
@@ -41,7 +41,7 @@ long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	register struct __kernel_timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_clock_gettime64;
+	register long nr asm("r7") = __NR_compat32_clock_gettime64;
 
 	asm volatile(
 	"	swi #0\n"
@@ -58,7 +58,7 @@ long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 	register struct old_timespec32 *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_clock_gettime;
+	register long nr asm("r7") = __NR_compat32_clock_gettime;
 
 	asm volatile(
 	"	swi #0\n"
@@ -75,7 +75,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	register struct __kernel_timespec *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_clock_getres_time64;
+	register long nr asm("r7") = __NR_compat32_clock_getres_time64;
 
 	asm volatile(
 	"       swi #0\n"
@@ -92,7 +92,7 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 	register struct old_timespec32 *ts asm("r1") = _ts;
 	register clockid_t clkid asm("r0") = _clkid;
 	register long ret asm ("r0");
-	register long nr asm("r7") = __NR_compat_clock_getres;
+	register long nr asm("r7") = __NR_compat32_clock_getres;
 
 	asm volatile(
 	"       swi #0\n"
diff --git a/arch/arm64/kernel/signal32.c b/arch/arm64/kernel/signal32.c
index bbd542704730..50b74cc5c64d 100644
--- a/arch/arm64/kernel/signal32.c
+++ b/arch/arm64/kernel/signal32.c
@@ -451,7 +451,7 @@ int compat_setup_frame(int usig, struct ksignal *ksig, sigset_t *set,
 
 void compat_setup_restart_syscall(struct pt_regs *regs)
 {
-       regs->regs[7] = __NR_compat_restart_syscall;
+       regs->regs[7] = __NR_compat32_restart_syscall;
 }
 
 /*
diff --git a/arch/arm64/kernel/sigreturn32.S b/arch/arm64/kernel/sigreturn32.S
index ccbd4aab4ba4..6f486b95b413 100644
--- a/arch/arm64/kernel/sigreturn32.S
+++ b/arch/arm64/kernel/sigreturn32.S
@@ -13,7 +13,7 @@
  * need two 16-bit instructions.
  */
 
-#include <asm/unistd.h>
+#include <asm/unistd_compat_32.h>
 
 	.section .rodata
 	.globl __aarch32_sigret_code_start
@@ -22,26 +22,26 @@ __aarch32_sigret_code_start:
 	/*
 	 * ARM Code
 	 */
-	.byte	__NR_compat_sigreturn, 0x70, 0xa0, 0xe3		// mov	r7, #__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0x00, 0x00, 0xef		// svc	#__NR_compat_sigreturn
+	.byte	__NR_compat32_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat32_sigreturn
+	.byte	__NR_compat32_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat32_sigreturn
 
 	/*
 	 * Thumb code
 	 */
-	.byte	__NR_compat_sigreturn, 0x27			// svc	#__NR_compat_sigreturn
-	.byte	__NR_compat_sigreturn, 0xdf			// mov	r7, #__NR_compat_sigreturn
+	.byte	__NR_compat32_sigreturn, 0x27			// svc	#__NR_compat32_sigreturn
+	.byte	__NR_compat32_sigreturn, 0xdf			// mov	r7, #__NR_compat32_sigreturn
 
 	/*
 	 * ARM code
 	 */
-	.byte	__NR_compat_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat_rt_sigreturn
+	.byte	__NR_compat32_rt_sigreturn, 0x70, 0xa0, 0xe3	// mov	r7, #__NR_compat32_rt_sigreturn
+	.byte	__NR_compat32_rt_sigreturn, 0x00, 0x00, 0xef	// svc	#__NR_compat32_rt_sigreturn
 
 	/*
 	 * Thumb code
 	 */
-	.byte	__NR_compat_rt_sigreturn, 0x27			// svc	#__NR_compat_rt_sigreturn
-	.byte	__NR_compat_rt_sigreturn, 0xdf			// mov	r7, #__NR_compat_rt_sigreturn
+	.byte	__NR_compat32_rt_sigreturn, 0x27		// svc	#__NR_compat32_rt_sigreturn
+	.byte	__NR_compat32_rt_sigreturn, 0xdf		// mov	r7, #__NR_compat32_rt_sigreturn
 
         .globl __aarch32_sigret_code_end
 __aarch32_sigret_code_end:
-- 
2.39.2


