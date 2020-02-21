Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6E12167DE9
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 14:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728398AbgBUNEy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 08:04:54 -0500
Received: from foss.arm.com ([217.140.110.172]:38838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728330AbgBUNEx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 08:04:53 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8903530E;
        Fri, 21 Feb 2020 05:04:53 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 388F73F703;
        Fri, 21 Feb 2020 05:04:52 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        m.szyprowski@samsung.com, vincenzo.frascino@arm.com
Subject: [PATCH] clocksource: Fix arm_arch_timer clockmode when vDSO disabled
Date:   Fri, 21 Feb 2020 13:03:55 +0000
Message-Id: <20200221130355.21373-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The arm_arch_timer requires that VDSO_CLOCKMODE_ARCHTIMER to be
defined to compile correctly. On arm the vDSO can be disabled and when
this is the case the compilation ends prematurely with an error:

 $ make ARCH=arm multi_v7_defconfig
 $ ./scripts/config -d VDSO
 $ make

drivers/clocksource/arm_arch_timer.c:73:44: error:
‘VDSO_CLOCKMODE_ARCHTIMER’ undeclared here (not in a function)
  static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
                                             ^
scripts/Makefile.build:267: recipe for target
'drivers/clocksource/arm_arch_timer.o' failed
make[2]: *** [drivers/clocksource/arm_arch_timer.o] Error 1
make[2]: *** Waiting for unfinished jobs....
scripts/Makefile.build:505: recipe for target 'drivers/clocksource' failed
make[1]: *** [drivers/clocksource] Error 2
make[1]: *** Waiting for unfinished jobs....
Makefile:1683: recipe for target 'drivers' failed
make: *** [drivers] Error 2

Define VDSO_CLOCKMODE_ARCHTIMER as VDSO_CLOCKMODE_NONE when the vDSOs are
not enabled to address the issue.

Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode storage")
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ee2420d56f67..619839221f94 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -49,6 +49,11 @@
 #define CNTV_TVAL	0x38
 #define CNTV_CTL	0x3c
 
+#ifndef CONFIG_GENERIC_GETTIMEOFDAY
+/* The define below is required because on arm the VDSOs can be disabled */
+#define VDSO_CLOCKMODE_ARCHTIMER	VDSO_CLOCKMODE_NONE
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
+
 static unsigned arch_timers_present __initdata;
 
 static void __iomem *arch_counter_base;
-- 
2.25.0

