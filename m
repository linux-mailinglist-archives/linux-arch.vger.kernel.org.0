Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36E0D298C3B
	for <lists+linux-arch@lfdr.de>; Mon, 26 Oct 2020 12:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1773997AbgJZLuJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 26 Oct 2020 07:50:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36476 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1773995AbgJZLuJ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 26 Oct 2020 07:50:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2ABC4101E;
        Mon, 26 Oct 2020 04:50:08 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D913D3F719;
        Mon, 26 Oct 2020 04:50:06 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v4 0/5] kselftest: Extend vDSO tests
Date:   Mon, 26 Oct 2020 11:49:40 +0000
Message-Id: <20201026114945.48532-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This series extends the kselftests for the vDSO library making sure: that
they compile correctly on non x86 platforms, that they can be cross
compiled and introducing new tests that verify the correctness of the
library.

The so extended vDSO kselftests have been verified on all the platforms
supported by the unified vDSO library [1].

The only new patch that this series introduces is the first one, patch 2 and
patch 3 have already been reviewed in past as part of other series [2] [3].

[1] https://lore.kernel.org/lkml/20190621095252.32307-1-vincenzo.frascino@arm.com
[2] https://lore.kernel.org/lkml/20190621095252.32307-26-vincenzo.frascino@arm.com
[3] https://lore.kernel.org/lkml/20190523112116.19233-4-vincenzo.frascino@arm.com

It is possible to build the series using the command below:

make -C tools/testing/selftests/ ARCH=<arch> TARGETS=vDSO CC=<compiler>

A version of the series rebased on 5.10-rc1 to simplify the testing can be found
at [4].

[4] https://git.gitlab.arm.com/linux-arm/linux-vf.git vdso/v4.tests

Changes:
--------
v4:
  - Rebased on 5.10-rc1.
v3:
  - Added correctness test for clock_gettime64.
  - Rebased on 5.7-rc4.
v2:
  - Addressed review comments from Andy.
  - Rebased on 5.7-rc3.

Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (5):
  kselftest: Enable vDSO test on non x86 platforms
  kselftest: Extend vDSO selftest
  kselftest: Extend vDSO selftest to clock_getres
  kselftest: Move test_vdso to the vDSO test suite
  kselftest: Extend vdso correctness test to clock_gettime64

 tools/testing/selftests/Makefile              |   1 +
 tools/testing/selftests/vDSO/Makefile         |  16 +-
 tools/testing/selftests/vDSO/vdso_config.h    |  92 +++++++
 tools/testing/selftests/vDSO/vdso_test_abi.c  | 244 ++++++++++++++++++
 .../selftests/vDSO/vdso_test_clock_getres.c   | 124 +++++++++
 .../vdso_test_correctness.c}                  | 115 ++++++++-
 tools/testing/selftests/x86/Makefile          |   2 +-
 7 files changed, 586 insertions(+), 8 deletions(-)
 create mode 100644 tools/testing/selftests/vDSO/vdso_config.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_abi.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_test_clock_getres.c
 rename tools/testing/selftests/{x86/test_vdso.c => vDSO/vdso_test_correctness.c} (73%)

-- 
2.28.0

