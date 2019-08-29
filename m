Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D607A1843
	for <lists+linux-arch@lfdr.de>; Thu, 29 Aug 2019 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbfH2LUY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 29 Aug 2019 07:20:24 -0400
Received: from foss.arm.com ([217.140.110.172]:42790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728070AbfH2LTN (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 29 Aug 2019 07:19:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B13115AB;
        Thu, 29 Aug 2019 04:19:13 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A109F3F59C;
        Thu, 29 Aug 2019 04:19:11 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Cc:     catalin.marinas@arm.com, will@kernel.org, paul.burton@mips.com,
        tglx@linutronix.de, salyzyn@android.com, 0x7f454c46@gmail.com,
        luto@kernel.org
Subject: [PATCH 3/7] mips: compat: vdso: Use legacy syscalls as fallback
Date:   Thu, 29 Aug 2019 12:18:39 +0100
Message-Id: <20190829111843.41003-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190829111843.41003-1-vincenzo.frascino@arm.com>
References: <20190829111843.41003-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generic VDSO implementation uses the Y2038 safe clock_gettime64() and
clock_getres_time64() syscalls as fallback for 32bit VDSO. This breaks
seccomp setups because these syscalls might be not (yet) allowed.

Implement the 32bit variants which use the legacy syscalls and select the
variant in the core library.

The 64bit time variants are not removed because they are required for the
time64 based vdso accessors.

Cc: Paul Burton <paul.burton@mips.com>
Fixes: 00b26474c2f1 ("lib/vdso: Provide generic VDSO implementation")
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/include/asm/vdso/gettimeofday.h | 45 +++++++++++++++++++++++
 arch/mips/vdso/config-n32-o32-env.c       |  1 +
 2 files changed, 46 insertions(+)

diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index c59fe08b0347..e78462e8ca2e 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -105,6 +105,51 @@ static __always_inline int clock_getres_fallback(
 	return error ? -ret : ret;
 }
 
+#if _MIPS_SIM != _MIPS_SIM_ABI64
+
+#define VDSO_HAS_32BIT_FALLBACK	1
+
+static __always_inline long clock_gettime32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_clock_gettime;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+
+static __always_inline int clock_getres32_fallback(
+					clockid_t _clkid,
+					struct old_timespec32 *_ts)
+{
+	register struct old_timespec32 *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+	register long nr asm("v0") = __NR_clock_getres;
+	register long error asm("a3");
+
+	asm volatile(
+	"       syscall\n"
+	: "=r" (ret), "=r" (error)
+	: "r" (clkid), "r" (ts), "r" (nr)
+	: "$1", "$3", "$8", "$9", "$10", "$11", "$12", "$13",
+	  "$14", "$15", "$24", "$25", "hi", "lo", "memory");
+
+	return error ? -ret : ret;
+}
+#endif
+
 #ifdef CONFIG_CSRC_R4K
 
 static __always_inline u64 read_r4k_count(void)
diff --git a/arch/mips/vdso/config-n32-o32-env.c b/arch/mips/vdso/config-n32-o32-env.c
index 7f8d957abd4a..0011a632aef2 100644
--- a/arch/mips/vdso/config-n32-o32-env.c
+++ b/arch/mips/vdso/config-n32-o32-env.c
@@ -10,6 +10,7 @@
  */
 #undef CONFIG_64BIT
 
+#define BUILD_VDSO32
 #define CONFIG_32BIT 1
 #define CONFIG_GENERIC_ATOMIC64 1
 #define BUILD_VDSO32_64
-- 
2.23.0

