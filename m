Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33A5D16863C
	for <lists+linux-arch@lfdr.de>; Fri, 21 Feb 2020 19:19:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgBUSTA (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Feb 2020 13:19:00 -0500
Received: from foss.arm.com ([217.140.110.172]:45326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgBUSTA (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Feb 2020 13:19:00 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1314D30E;
        Fri, 21 Feb 2020 10:19:00 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E8163F6CF;
        Fri, 21 Feb 2020 10:18:58 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com,
        linux@armlinux.org.uk, tglx@linutronix.de, luto@kernel.org,
        m.szyprowski@samsung.com, Mark.Rutland@arm.com, maz@kernel.org,
        vincenzo.frascino@arm.com
Subject: [PATCH v2 0/3] Fix arm_arch_timer clockmode when vDSO disabled
Date:   Fri, 21 Feb 2020 18:18:46 +0000
Message-Id: <20200221181849.40351-1-vincenzo.frascino@arm.com>
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

This patch series addresses the issue defining a default arch clockmode
for arm and arm64 and using it to initialize the arm_arch_timer.

Changes:
--------
v2:
  - Addressed Marc Zyngier comments.
  - Rebased on 5.6-rc2.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (3):
  arm: clocksource: Add VDSO default clockmode
  arm64: clocksource: Add VDSO default clockmode
  clocksource: Fix arm_arch_timer clockmode when vDSO disabled

 arch/arm/Kconfig                     |  1 +
 arch/arm/include/asm/clocksource.h   | 10 ++++++++++
 arch/arm64/include/asm/clocksource.h |  1 +
 drivers/clocksource/arm_arch_timer.c |  2 +-
 4 files changed, 13 insertions(+), 1 deletion(-)

-- 
2.25.0

