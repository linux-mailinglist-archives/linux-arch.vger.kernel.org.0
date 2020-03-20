Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C1618D191
	for <lists+linux-arch@lfdr.de>; Fri, 20 Mar 2020 15:54:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCTOyr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Mar 2020 10:54:47 -0400
Received: from foss.arm.com ([217.140.110.172]:49984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgCTOyr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 20 Mar 2020 10:54:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B02CC1FB;
        Fri, 20 Mar 2020 07:54:43 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9DA973F792;
        Fri, 20 Mar 2020 07:54:40 -0700 (PDT)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        linux-mips@vger.kernel.org, x86@kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Paul Burton <paul.burton@mips.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Salyzyn <salyzyn@android.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Collingbourne <pcc@google.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Andrei Vagin <avagin@openvz.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>
Subject: [PATCH v5 00/26] Introduce common headers for vDSO
Date:   Fri, 20 Mar 2020 14:53:25 +0000
Message-Id: <20200320145351.32292-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Back in July last year we started having a problem in building compat
vDSOs on arm64 [1] [2] that was not present when the arm64 porting to
the Unified vDSO was done. In particular when the compat vDSO on such
architecture is built with gcc it generates the warning below:

In file included from ./arch/arm64/include/asm/thread_info.h:17:0,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/arm64/include/asm/preempt.h:5,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/seqlock.h:36,
                 from ./include/linux/time.h:6,
                 from ./lib/vdso/gettimeofday.c:7,
                 from <command-line>:0:
./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer
                to integer of different size [-Wpointer-to-int-cast]
  u64 __addr = (u64)addr & ~__tag_shifted(0xff);
               ^
In file included from ./arch/arm64/include/asm/pgtable-hwdef.h:8:0,
                 from ./arch/arm64/include/asm/processor.h:34,
                 from ./arch/arm64/include/asm/elf.h:118,
                 from ./include/linux/elf.h:5,
                 from ./include/linux/elfnote.h:62,
                 from arch/arm64/kernel/vdso32/note.c:11:
./arch/arm64/include/asm/memory.h: In function ‘__tag_set’:
./arch/arm64/include/asm/memory.h:233:15: warning: cast from pointer
                to integer of different size [-Wpointer-to-int-cast]
  u64 __addr = (u64)addr & ~__tag_shifted(0xff);

The same porting does not build at all when the selected compiler is
clang.

I started an investigation to try to understand better the problem and
after various discussions at Plumbers and Recipes last year the
conclusion was that the vDSO library as it stands it is including more
headers that it needs. In particular, being a user-space library, it
should require only the UAPI and a minimal vDSO kernel interface instead
of all the kernel-related inline functions which are not directly used
and in some cases can have side effects.

To solve the problem, I decided to use the approach below:
  * Extract from include/linux/ the vDSO required kernel interface
    and place it in include/vdso/
  * Make sure that where meaningful the kernel includes "vdso" headers.
  * Limit the vDSO library to include headers coming only from UAPI
    and "vdso" (with 2 exceptions compiler.h for barriers and param.h
    for HZ).
  * Adapt all the architectures that support the unified vDSO library
    to use "vdso" headers.

According to me this approach allows up to exercise a better control on
what the vDSO library can include and to prevent potential issues in
future.

This patch series contains the implementation of the described approach.

The "vdso" headers have been verified on all the architectures that support
unified vDSO using the vdsotest [3] testsuite for what concerns the vDSO part
and randconfig to verify that they are included in the correct places.

To simplify the testing, a copy of the patchset on top of a recent linux
tree can be found at [4].

[1] https://github.com/ClangBuiltLinux/linux/issues/595
[2] https://lore.kernel.org/lkml/20190926151704.GH9689@arrakis.emea.arm.com
[3] https://github.com/nathanlynch/vdsotest
[4] git://linux-arm.org/linux-vf.git common-headers/v5

Changes:
--------
v5:
  - Dropped UINTPTR_MAX check patch.
  - Introduced a new headers cleanup patch.
  - Addressed review comments.
  - Rebased on tip/timers/core.
v4:
  - Dropped vDSO optimization patch for arm64.
  - Introduce a new patch to drop dependency from TASK_SIZE_32 on arm64.
  - Addressed review comments.
  - Rebased on tip/timers/core.
v3:
  - Changed the namespace from common to vdso.
  - Addressed an issue involving parisc modules compilation.
  - Added vdso header for clocksource.h.
  - Addressed review comments.
  - Rebased on tip/timers/core.
v2:
  - Addressed review comments for clang support.
  - Rebased on 5.6-rc4.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Andrei Vagin <avagin@openvz.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Mark Rutland <Mark.Rutland@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (26):
  linux/const.h: Extract common header for vDSO
  linux/bits.h: Extract common header for vDSO
  linux/limits.h: Extract common header for vDSO
  x86:Introduce asm/vdso/clocksource.h
  arm: Introduce asm/vdso/clocksource.h
  arm64: Introduce asm/vdso/clocksource.h
  mips: Introduce asm/vdso/clocksource.h
  linux/clocksource.h: Extract common header for vDSO
  linux/math64.h: Extract common header for vDSO
  linux/time.h: Extract common header for vDSO
  linux/time32.h: Extract common header for vDSO
  linux/time64.h: Extract common header for vDSO
  linux/jiffies.h: Extract common header for vDSO
  linux/ktime.h: Extract common header for vDSO
  common: Introduce processor.h
  scripts: Fix the inclusion order in modpost
  linux/elfnote.h: Replace elf.h with UAPI equivalent
  arm64: vdso32: Code clean up
  arm64: Introduce asm/vdso/processor.h
  arm64: vdso: Include common headers in the vdso library
  arm64: vdso32: Include common headers in the vdso library
  mips: vdso: Enable mips to use common headers
  x86: vdso: Enable x86 to use common headers
  arm: vdso: Enable arm to use common headers
  lib: vdso: Enable common headers
  arm64: vdso32: Enable Clang Compilation

 arch/arm/include/asm/clocksource.h            |  6 +--
 arch/arm/include/asm/cp15.h                   | 20 +---------
 arch/arm/include/asm/processor.h              | 11 +-----
 arch/arm/include/asm/vdso/clocksource.h       |  8 ++++
 arch/arm/include/asm/vdso/cp15.h              | 38 +++++++++++++++++++
 arch/arm/include/asm/vdso/gettimeofday.h      |  4 +-
 arch/arm/include/asm/vdso/processor.h         | 22 +++++++++++
 arch/arm64/include/asm/clocksource.h          |  3 +-
 arch/arm64/include/asm/processor.h            |  7 +---
 arch/arm64/include/asm/vdso/clocksource.h     |  8 ++++
 .../include/asm/vdso/compat_gettimeofday.h    | 10 +----
 arch/arm64/include/asm/vdso/gettimeofday.h    |  1 -
 arch/arm64/include/asm/vdso/processor.h       | 17 +++++++++
 arch/arm64/kernel/vdso/vgettimeofday.c        |  2 -
 arch/arm64/kernel/vdso32/Makefile             | 11 ++++++
 arch/arm64/kernel/vdso32/vgettimeofday.c      | 14 -------
 arch/mips/include/asm/clocksource.h           |  4 +-
 arch/mips/include/asm/processor.h             | 16 +-------
 arch/mips/include/asm/vdso/clocksource.h      |  9 +++++
 arch/mips/include/asm/vdso/gettimeofday.h     |  4 --
 arch/mips/include/asm/vdso/processor.h        | 27 +++++++++++++
 arch/x86/include/asm/clocksource.h            |  5 +--
 arch/x86/include/asm/processor.h              | 12 +-----
 arch/x86/include/asm/vdso/clocksource.h       | 10 +++++
 arch/x86/include/asm/vdso/processor.h         | 23 +++++++++++
 include/linux/bits.h                          |  2 +-
 include/linux/clocksource.h                   | 11 +-----
 include/linux/const.h                         |  5 +--
 include/linux/elfnote.h                       |  2 +-
 include/linux/jiffies.h                       |  4 +-
 include/linux/ktime.h                         |  9 +----
 include/linux/limits.h                        | 13 +------
 include/linux/math64.h                        | 20 +---------
 include/linux/time.h                          |  5 +--
 include/linux/time32.h                        | 14 +------
 include/linux/time64.h                        | 10 +----
 include/vdso/bits.h                           |  9 +++++
 include/vdso/clocksource.h                    | 23 +++++++++++
 include/vdso/const.h                          | 10 +++++
 include/vdso/datapage.h                       | 33 ++++++++++++++--
 include/vdso/jiffies.h                        | 11 ++++++
 include/vdso/ktime.h                          | 16 ++++++++
 include/vdso/limits.h                         | 19 ++++++++++
 include/vdso/math64.h                         | 24 ++++++++++++
 include/vdso/processor.h                      | 14 +++++++
 include/vdso/time.h                           | 12 ++++++
 include/vdso/time32.h                         | 17 +++++++++
 include/vdso/time64.h                         | 14 +++++++
 lib/vdso/gettimeofday.c                       | 22 -----------
 scripts/mod/modpost.c                         |  6 ++-
 50 files changed, 404 insertions(+), 213 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso/clocksource.h
 create mode 100644 arch/arm/include/asm/vdso/cp15.h
 create mode 100644 arch/arm/include/asm/vdso/processor.h
 create mode 100644 arch/arm64/include/asm/vdso/clocksource.h
 create mode 100644 arch/arm64/include/asm/vdso/processor.h
 create mode 100644 arch/mips/include/asm/vdso/clocksource.h
 create mode 100644 arch/mips/include/asm/vdso/processor.h
 create mode 100644 arch/x86/include/asm/vdso/clocksource.h
 create mode 100644 arch/x86/include/asm/vdso/processor.h
 create mode 100644 include/vdso/bits.h
 create mode 100644 include/vdso/clocksource.h
 create mode 100644 include/vdso/const.h
 create mode 100644 include/vdso/jiffies.h
 create mode 100644 include/vdso/ktime.h
 create mode 100644 include/vdso/limits.h
 create mode 100644 include/vdso/math64.h
 create mode 100644 include/vdso/processor.h
 create mode 100644 include/vdso/time.h
 create mode 100644 include/vdso/time32.h
 create mode 100644 include/vdso/time64.h

-- 
2.25.1

