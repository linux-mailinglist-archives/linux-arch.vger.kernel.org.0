Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8FA4E4EE
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFUJyE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:54:04 -0400
Received: from foss.arm.com ([217.140.110.172]:55790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727129AbfFUJyD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:54:03 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02DA614F6;
        Fri, 21 Jun 2019 02:54:03 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D9923F246;
        Fri, 21 Jun 2019 02:54:00 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Salyzyn <salyzyn@android.com>,
        Peter Collingbourne <pcc@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Huw Davies <huw@codeweavers.com>,
        Shijith Thotton <sthotton@marvell.com>,
        Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH v7 20/25] mips: Add clock_getres entry point
Date:   Fri, 21 Jun 2019 10:52:47 +0100
Message-Id: <20190621095252.32307-21-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The generic vDSO library provides an implementation of clock_getres()
that can be leveraged by each architecture.

Add clock_getres() entry point on mips.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/include/asm/vdso/gettimeofday.h | 26 +++++++++++++++++++++++
 arch/mips/vdso/vdso.lds.S                 |  1 +
 arch/mips/vdso/vgettimeofday.c            | 12 +++++++++++
 3 files changed, 39 insertions(+)

diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/asm/vdso/gettimeofday.h
index aa20865b288b..c59fe08b0347 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -22,6 +22,8 @@
 #include <asm/unistd.h>
 #include <asm/vdso.h>
 
+#define VDSO_HAS_CLOCK_GETRES		1
+
 #ifdef CONFIG_MIPS_CLOCK_VSYSCALL
 
 static __always_inline long gettimeofday_fallback(
@@ -79,6 +81,30 @@ static __always_inline long clock_gettime_fallback(
 	return error ? -ret : ret;
 }
 
+static __always_inline int clock_getres_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	register struct __kernel_timespec *ts asm("a1") = _ts;
+	register clockid_t clkid asm("a0") = _clkid;
+	register long ret asm("v0");
+#if _MIPS_SIM == _MIPS_SIM_ABI64
+	register long nr asm("v0") = __NR_clock_getres;
+#else
+	register long nr asm("v0") = __NR_clock_getres_time64;
+#endif
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
 #ifdef CONFIG_CSRC_R4K
 
 static __always_inline u64 read_r4k_count(void)
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 94d90c440590..ad9f2f2c0c97 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -95,6 +95,7 @@ VERSION
 	global:
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
+		__vdso_clock_getres;
 #endif
 	local: *;
 	};
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 1c46dace041e..48e1ab32204b 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -23,6 +23,12 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 	return __cvdso_gettimeofday(tv, tz);
 }
 
+int __vdso_clock_getres(clockid_t clock_id,
+			struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock_id, res);
+}
+
 #else
 
 int __vdso_clock_gettime(clockid_t clock,
@@ -37,4 +43,10 @@ int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 	return __cvdso_gettimeofday(tv, tz);
 }
 
+int __vdso_clock_getres(clockid_t clock_id,
+			struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock_id, res);
+}
+
 #endif
-- 
2.21.0

