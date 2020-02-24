Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6125416A9BD
	for <lists+linux-arch@lfdr.de>; Mon, 24 Feb 2020 16:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727785AbgBXPQJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 Feb 2020 10:16:09 -0500
Received: from foss.arm.com ([217.140.110.172]:38764 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbgBXPQI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 Feb 2020 10:16:08 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 31D9E1FB;
        Mon, 24 Feb 2020 07:16:08 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A05783F534;
        Mon, 24 Feb 2020 07:16:06 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        m.szyprowski@samsung.com, maz@kernel.org, Mark.Rutland@arm.com,
        vincenzo.frascino@arm.com
Subject: [PATCH v3] clocksource: Fix arm_arch_timer clockmode when vDSO disabled
Date:   Mon, 24 Feb 2020 15:15:52 +0000
Message-Id: <20200224151552.57274-1-vincenzo.frascino@arm.com>
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
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 4 ++++
 1 file changed, 4 insertions(+)

This patch has been rebased and tested on tip/timers/core.

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ee2420d56f67..d53f4c7ccaae 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,11 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
+#ifdef CONFIG_GENERIC_GETTIMEOFDAY
 static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+#else
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_NONE;
+#endif /* CONFIG_GENERIC_GETTIMEOFDAY */
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
-- 
2.25.0

