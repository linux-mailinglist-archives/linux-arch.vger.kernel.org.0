Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06CA318D1D8
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 15:55:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbgCTOzm (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 10:55:42 -0400
Received: from foss.arm.com ([217.140.110.172]:50598 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbgCTOzm (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:55:42 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 63F2DFEC;
        Fri, 20 Mar 2020 07:55:41 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6F3C83F792;
        Fri, 20 Mar 2020 07:55:38 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: [PATCH v5 18/26] arm64: vdso32: Code clean up
Date:   Fri, 20 Mar 2020 14:53:43 +0000
Message-Id: <20200320145351.32292-19-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200320145351.32292-1-vincenzo.frascino@arm.com>
References: <20200320145351.32292-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The compat vdso library had some checks that are not anymore relevant.

Remove the unused code from the compat vDSO library.

Note: This patch is preparatory for a future one that will introduce
asm/vdso/processor.h on arm64.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/lkml/20200317122220.30393-19-vincenzo.frascino@arm.com
---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  8 --------
 arch/arm64/kernel/vdso32/vgettimeofday.c          | 12 ------------
 2 files changed, 20 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
index 81b0c394f1d8..401df2bcd741 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -76,10 +76,6 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 	register long ret asm ("r0");
 	register long nr asm("r7") = __NR_compat_clock_getres_time64;
 
-	/* The checks below are required for ABI consistency with arm */
-	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
-		return -EINVAL;
-
 	asm volatile(
 	"       swi #0\n"
 	: "=r" (ret)
@@ -97,10 +93,6 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 	register long ret asm ("r0");
 	register long nr asm("r7") = __NR_compat_clock_getres;
 
-	/* The checks below are required for ABI consistency with arm */
-	if ((_clkid >= MAX_CLOCKS) && (_ts == NULL))
-		return -EINVAL;
-
 	asm volatile(
 	"       swi #0\n"
 	: "=r" (ret)
diff --git a/arch/arm64/kernel/vdso32/vgettimeofday.c b/arch/arm64/kernel/vdso32/vgettimeofday.c
index 54fc1c2ce93f..ddbad47efaa4 100644
--- a/arch/arm64/kernel/vdso32/vgettimeofday.c
+++ b/arch/arm64/kernel/vdso32/vgettimeofday.c
@@ -11,20 +11,12 @@
 int __vdso_clock_gettime(clockid_t clock,
 			 struct old_timespec32 *ts)
 {
-	/* The checks below are required for ABI consistency with arm */
-	if ((u32)ts >= TASK_SIZE_32)
-		return -EFAULT;
-
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
 int __vdso_clock_gettime64(clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
-	/* The checks below are required for ABI consistency with arm */
-	if ((u32)ts >= TASK_SIZE_32)
-		return -EFAULT;
-
 	return __cvdso_clock_gettime(clock, ts);
 }
 
@@ -37,10 +29,6 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 int __vdso_clock_getres(clockid_t clock_id,
 			struct old_timespec32 *res)
 {
-	/* The checks below are required for ABI consistency with arm */
-	if ((u32)res >= TASK_SIZE_32)
-		return -EFAULT;
-
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
-- 
2.25.1

