Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804DD27B98
	for <lists+linux-arch@lfdr.de>; Thu, 23 May 2019 13:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729966AbfEWLVa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 May 2019 07:21:30 -0400
Received: from foss.arm.com ([217.140.101.70]:44248 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729430AbfEWLVa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 23 May 2019 07:21:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7B010341;
        Thu, 23 May 2019 04:21:29 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F2DA3F718;
        Thu, 23 May 2019 04:21:26 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     vincenzo.frascino@arm.com,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 0/3] Fix vDSO clock_getres()
Date:   Thu, 23 May 2019 12:21:13 +0100
Message-Id: <20190523112116.19233-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

clock_getres in the vDSO library has to preserve the same behaviour
of posix_get_hrtimer_res().

In particular, posix_get_hrtimer_res() does:
    sec = 0;
    ns = hrtimer_resolution;
and hrtimer_resolution depends on the enablement of the high
resolution timers that can happen either at compile or at run time.

A possible fix is to change the vdso implementation of clock_getres,
keeping a copy of hrtimer_resolution in vdso data and using that
directly [1].

This patchset implements the proposed fix for arm64, powerpc, s390,
nds32 and adds a test to verify that the syscall and the vdso library
implementation of clock_getres return the same values.

Even if these patches are unified by the same topic, there is no
dependency between them, hence they can be merged singularly by each
arch maintainer.

Note: arm64 and nds32 respective fixes have been merged in 5.2-rc1,
hence they have been removed from this series.

[1] https://marc.info/?l=linux-arm-kernel&m=155110381930196&w=2

Changes:
--------
v4:
  - Address review comments.
v3:
  - Rebased on 5.2-rc1.
  - Address review comments.
v2:
  - Rebased on 5.1-rc5.
  - Addressed review comments.

Cc: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (3):
  powerpc: Fix vDSO clock_getres()
  s390: Fix vDSO clock_getres()
  kselftest: Extend vDSO selftest to clock_getres

 arch/powerpc/include/asm/vdso_datapage.h      |   2 +
 arch/powerpc/kernel/asm-offsets.c             |   2 +-
 arch/powerpc/kernel/time.c                    |   1 +
 arch/powerpc/kernel/vdso32/gettimeofday.S     |   7 +-
 arch/powerpc/kernel/vdso64/gettimeofday.S     |   7 +-
 arch/s390/include/asm/vdso.h                  |   1 +
 arch/s390/kernel/asm-offsets.c                |   2 +-
 arch/s390/kernel/time.c                       |   1 +
 arch/s390/kernel/vdso32/clock_getres.S        |  12 +-
 arch/s390/kernel/vdso64/clock_getres.S        |  10 +-
 tools/testing/selftests/vDSO/Makefile         |   2 +
 .../selftests/vDSO/vdso_clock_getres.c        | 124 ++++++++++++++++++
 12 files changed, 155 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_clock_getres.c

-- 
2.21.0

