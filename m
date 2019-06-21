Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 048574E4D9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:54:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727191AbfFUJyM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:54:12 -0400
Received: from foss.arm.com ([217.140.110.172]:55894 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727181AbfFUJyM (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:54:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5CDF3147A;
        Fri, 21 Jun 2019 02:54:11 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C79EE3F246;
        Fri, 21 Jun 2019 02:54:08 -0700 (PDT)
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
Subject: [PATCH v7 23/25] x86: Add clock_getres entry point
Date:   Fri, 21 Jun 2019 10:52:50 +0100
Message-Id: <20190621095252.32307-24-vincenzo.frascino@arm.com>
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

Add clock_getres() entry point on x86.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/x86/entry/vdso/vclock_gettime.c     | 17 ++++++++++++++
 arch/x86/entry/vdso/vdso.lds.S           |  2 ++
 arch/x86/entry/vdso/vdso32/vdso32.lds.S  |  1 +
 arch/x86/include/asm/vdso/gettimeofday.h | 30 ++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/arch/x86/entry/vdso/vclock_gettime.c b/arch/x86/entry/vdso/vclock_gettime.c
index 4a7ef4ca4f52..de9212a4833e 100644
--- a/arch/x86/entry/vdso/vclock_gettime.c
+++ b/arch/x86/entry/vdso/vclock_gettime.c
@@ -36,6 +36,7 @@ time_t time(time_t *t)
 #if defined(CONFIG_X86_64) && !defined(BUILD_VDSO32_64)
 /* both 64-bit and x32 use these */
 extern int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct __kernel_timespec *res);
 
 int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
@@ -44,9 +45,18 @@ int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 int clock_gettime(clockid_t, struct __kernel_timespec *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+int __vdso_clock_getres(clockid_t clock,
+			struct __kernel_timespec *res)
+{
+	return __cvdso_clock_getres(clock, res);
+}
+int clock_getres(clockid_t, struct __kernel_timespec *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
+
 #else
 /* i386 only */
 extern int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts);
+extern int __vdso_clock_getres(clockid_t clock, struct old_timespec32 *res);
 
 int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
@@ -55,4 +65,11 @@ int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 int clock_gettime(clockid_t, struct old_timespec32 *)
 	__attribute__((weak, alias("__vdso_clock_gettime")));
 
+int __vdso_clock_getres(clockid_t clock,
+			struct old_timespec32 *res)
+{
+	return __cvdso_clock_getres_time32(clock, res);
+}
+int clock_getres(clockid_t, struct old_timespec32 *)
+	__attribute__((weak, alias("__vdso_clock_getres")));
 #endif
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index d3a2dce4cfa9..36b644e16272 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -25,6 +25,8 @@ VERSION {
 		__vdso_getcpu;
 		time;
 		__vdso_time;
+		clock_getres;
+		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vdso32/vdso32.lds.S b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
index 422764a81d32..991b26cc855b 100644
--- a/arch/x86/entry/vdso/vdso32/vdso32.lds.S
+++ b/arch/x86/entry/vdso/vdso32/vdso32.lds.S
@@ -26,6 +26,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_time;
+		__vdso_clock_getres;
 	};
 
 	LINUX_2.5 {
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index a274d4fea7a5..df8c8dfadfa7 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -24,6 +24,8 @@
 
 #define VDSO_HAS_TIME 1
 
+#define VDSO_HAS_CLOCK_GETRES 1
+
 #ifdef CONFIG_PARAVIRT_CLOCK
 extern u8 pvclock_page[PAGE_SIZE]
 	__attribute__((visibility("hidden")));
@@ -57,6 +59,17 @@ static __always_inline long gettimeofday_fallback(
 	return ret;
 }
 
+static __always_inline long clock_getres_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	long ret;
+	asm ("syscall" : "=a" (ret), "=m" (*_ts) :
+	     "0" (__NR_clock_getres), "D" (_clkid), "S" (_ts) :
+	     "rcx", "r11");
+	return ret;
+}
+
 #else
 
 static __always_inline long clock_gettime_fallback(
@@ -92,6 +105,23 @@ static __always_inline long gettimeofday_fallback(
 	return ret;
 }
 
+static __always_inline long clock_getres_fallback(
+					clockid_t _clkid,
+					struct __kernel_timespec *_ts)
+{
+	long ret;
+
+	asm (
+		"mov %%ebx, %%edx \n"
+		"mov %[clock], %%ebx \n"
+		"call __kernel_vsyscall \n"
+		"mov %%edx, %%ebx \n"
+		: "=a" (ret), "=m" (*_ts)
+		: "0" (__NR_clock_getres_time64), [clock] "g" (_clkid), "c" (_ts)
+		: "edx");
+	return ret;
+}
+
 #endif
 
 #ifdef CONFIG_PARAVIRT_CLOCK
-- 
2.21.0

