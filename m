Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 530614E4EA
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727129AbfFUJyH (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:54:07 -0400
Received: from foss.arm.com ([217.140.110.172]:55828 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbfFUJyG (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:54:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C2E0214FF;
        Fri, 21 Jun 2019 02:54:05 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 398F73F246;
        Fri, 21 Jun 2019 02:54:03 -0700 (PDT)
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
Subject: [PATCH v7 21/25] mips: Add clock_gettime64 entry point
Date:   Fri, 21 Jun 2019 10:52:48 +0100
Message-Id: <20190621095252.32307-22-vincenzo.frascino@arm.com>
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

Update the mips32 specific vDSO library accordingly with what it has
been done for the kernel syscall exposing the clock_gettime64 entry
point.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/mips/vdso/vdso.lds.S      | 3 +++
 arch/mips/vdso/vgettimeofday.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index ad9f2f2c0c97..da4627430aba 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -96,6 +96,9 @@ VERSION
 		__vdso_clock_gettime;
 		__vdso_gettimeofday;
 		__vdso_clock_getres;
+#if _MIPS_SIM != _MIPS_SIM_ABI64
+		__vdso_clock_gettime64;
+#endif
 #endif
 	local: *;
 	};
diff --git a/arch/mips/vdso/vgettimeofday.c b/arch/mips/vdso/vgettimeofday.c
index 48e1ab32204b..6ebdc37c89fc 100644
--- a/arch/mips/vdso/vgettimeofday.c
+++ b/arch/mips/vdso/vgettimeofday.c
@@ -29,6 +29,12 @@ int __vdso_clock_getres(clockid_t clock_id,
 	return __cvdso_clock_getres_time32(clock_id, res);
 }
 
+int __vdso_clock_gettime64(clockid_t clock,
+			   struct __kernel_timespec *ts)
+{
+	return __cvdso_clock_gettime(clock, ts);
+}
+
 #else
 
 int __vdso_clock_gettime(clockid_t clock,
-- 
2.21.0

