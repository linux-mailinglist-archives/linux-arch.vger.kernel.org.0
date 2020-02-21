Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2C56168643
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 19:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729455AbgBUSTJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 13:19:09 -0500
Received: from foss.arm.com ([217.140.110.172]:45370 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbgBUSTF (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 13:19:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E125101E;
        Fri, 21 Feb 2020 10:19:05 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE73D3F6CF;
        Fri, 21 Feb 2020 10:19:03 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        m.szyprowski@samsung.com, Mark.Rutland@arm.com, maz@kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH v2 3/3] clocksource: Fix arm_arch_timer clockmode when vDSO disabled
Date:   Fri, 21 Feb 2020 18:18:49 +0000
Message-Id: <20200221181849.40351-4-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200221181849.40351-1-vincenzo.frascino@arm.com>
References: <20200221181849.40351-1-vincenzo.frascino@arm.com>
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

Set vdso_default to VDSO_CLOCKMODE_ARCH_DEFAULT to address the issue.

Fixes: 5e3c6a312a09 ("ARM/arm64: vdso: Use common vdso clock mode storage")
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 drivers/clocksource/arm_arch_timer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index ee2420d56f67..eadc99973fe1 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -69,7 +69,7 @@ static enum arch_timer_ppi_nr arch_timer_uses_ppi = ARCH_TIMER_VIRT_PPI;
 static bool arch_timer_c3stop;
 static bool arch_timer_mem_use_virtual;
 static bool arch_counter_suspend_stop;
-static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCHTIMER;
+static enum vdso_clock_mode vdso_default = VDSO_CLOCKMODE_ARCH_DEFAULT;
 
 static cpumask_t evtstrm_available = CPU_MASK_NONE;
 static bool evtstrm_enable = IS_ENABLED(CONFIG_ARM_ARCH_TIMER_EVTSTREAM);
-- 
2.25.0

