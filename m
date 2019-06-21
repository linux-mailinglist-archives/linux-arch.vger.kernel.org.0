Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCD74E4F2
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfFUJx6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:53:58 -0400
Received: from foss.arm.com ([217.140.110.172]:55724 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726603AbfFUJx6 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:58 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AA03142F;
        Fri, 21 Jun 2019 02:53:57 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D592A3F246;
        Fri, 21 Jun 2019 02:53:54 -0700 (PDT)
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
Subject: [PATCH v7 18/25] arm: Add clock_gettime64 entry point
Date:   Fri, 21 Jun 2019 10:52:45 +0100
Message-Id: <20190621095252.32307-19-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190621095252.32307-1-vincenzo.frascino@arm.com>
References: <20190621095252.32307-1-vincenzo.frascino@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

With the release of Linux 5.1 has been added a new syscall,
clock_gettime64, that provided a 64 bit time value for a specified
clock_ID to make the kernel Y2038 safe on 32 bit architectures.

Update the arm specific vDSO library accordingly with what it has
been done for the kernel syscall exposing the clock_gettime64 entry
point.

Cc: Russell King <linux@armlinux.org.uk>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm/vdso/vdso.lds.S      | 1 +
 arch/arm/vdso/vgettimeofday.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 1d81e8c3acf6..05581140fd12 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -83,6 +83,7 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+		__vdso_clock_gettime64;
 	local: *;
 	};
 }
diff --git a/arch/arm/vdso/vgettimeofday.c b/arch/arm/vdso/vgettimeofday.c
index d3330c0c1147..0742a0bb4763 100644
--- a/arch/arm/vdso/vgettimeofday.c
+++ b/arch/arm/vdso/vgettimeofday.c
@@ -26,6 +26,12 @@ int __vdso_clock_gettime(clockid_t clock,
 	return __cvdso_clock_gettime32(clock, ts);
 }
 
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
 int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
 			struct timezone *tz)
 {
-- 
2.21.0

