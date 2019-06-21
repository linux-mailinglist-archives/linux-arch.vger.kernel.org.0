Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE874E4B0
	for <lists+linux-arch@lfdr.de>; Fri, 21 Jun 2019 11:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbfFUJxJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 21 Jun 2019 05:53:09 -0400
Received: from foss.arm.com ([217.140.110.172]:55088 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726218AbfFUJxI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 21 Jun 2019 05:53:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CE7C142F;
        Fri, 21 Jun 2019 02:53:07 -0700 (PDT)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4001F3F246;
        Fri, 21 Jun 2019 02:53:04 -0700 (PDT)
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
Subject: [PATCH v7 00/25] Unify vDSOs across more architectures
Date:   Fri, 21 Jun 2019 10:52:27 +0100
Message-Id: <20190621095252.32307-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

vDSO (virtual dynamic shared object) is a mechanism that the Linux
kernel provides as an alternative to system calls to reduce where
possible the costs in terms of cycles.
This is possible because certain syscalls like gettimeofday() do
not write any data and return one or more values that are stored
in the kernel, which makes relatively safe calling them directly
as a library function.

Even if the mechanism is pretty much standard, every architecture
in the last few years ended up implementing their own vDSO library
in the architectural code.

The purpose of this patch-set is to identify the commonalities in
between the architectures and try to consolidate the common code
paths, starting with gettimeofday().

This implementation contains the following design choices:
 * Every architecture defines the arch specific code in an header in
   "asm/vdso/".
 * The generic implementation includes the arch specific one and lives
   in "lib/vdso".
 * The arch specific code for gettimeofday lives in
   "<arch path>/vdso/gettimeofday.c" and includes the generic code only.
 * The generic implementation of update_vsyscall and update_vsyscall_tz
   lives in kernel/vdso and provide the bindings that can be implemented
   by each architecture.
 * Each architecture provides its implementation of the bindings in
   "asm/vdso/vsyscall.h".
 * This approach allows to consolidate the common code in a single place
   with the benefit of avoiding code duplication.

This implementation contains the portings to the common library for: arm64,
compat mode for arm64, arm, mips, x86_64, x32, compat mode for x86_64 and
i386.

The mips porting has been tested on qemu for mips32el. A configuration to
repeat the tests can be found at [4].

The x86_64 porting has been tested on an Intel Xeon 5120T based machine
running Ubuntu 18.04 and using the Ubuntu provided defconfig.

The i386 porting has been tested on qemu using the i386_defconfig
configuration.

Last but not least from this porting arm64, compat arm64, arm and mips gain
the support for:
 * CLOCK_BOOTTIME that can be useful in certain scenarios since it keeps
   track of the time during sleep as well.
 * CLOCK_TAI that is like CLOCK_REALTIME, but uses the International
   Atomic Time (TAI) reference instead of UTC to avoid jumping on leap
   second updates.
for both clock_gettime and clock_getres.

The porting has been validated using the vdsotest test-suite [1] extended
to cover all the clock ids [2].

A new test has been added to the linux kselftest in order to validate the
newly added library.

The porting has been benchmarked and the performance results are
provided as part of this cover letter.

To simplify the testing, a copy of the patchset on top of a recent linux
tree can be found at [3] and [4].

The v7 of this patchseries has been rebased on [5].

[1] https://github.com/nathanlynch/vdsotest
[2] https://github.com/fvincenzo/vdsotest
[3] git://linux-arm.org/linux-vf.git vdso/v7
[4] git://linux-arm.org/linux-vf.git vdso-mips/v7
[5] git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git hyperv-next

Changes:
--------
v7:
  - Rebased on [5] (5.2-rc3).
  - Added performance numbers for arm64 provided by Shijith Thotton.
  - Aimed at 1:1 replacement for pre-exisiting vDSO libraries.
  - Provided separate patches for newly added API.
  - Addressed review comments.
v6:
  - Rebased on 5.2-rc2.
  - Added performance numbers.
  - Removed vdso_types.h.
  - Unified update_vsyscall and update_vsyscall_tz.
  - Reworked the kselftest included in this patchset.
  - Addressed review comments.
v5:
  - Rebased on 5.0-rc7.
  - Added x86_64, compat mode for x86_64 and i386 portings.
  - Extended vDSO kselftest.
  - Addressed review comments.
v4:
  - Rebased on 5.0-rc2.
  - Addressed review comments.
  - Disabled compat vdso on arm64 when the kernel is compiled with
    clang.
v3:
  - Ported the latest fixes and optimizations done on the x86
    architecture to the generic library.
  - Addressed review comments.
  - Improved the documentation of the interfaces.
  - Changed the HAVE_ARCH_TIMER config option to a more generic
    HAVE_HW_COUNTER.
v2:
  - Added -ffixed-x18 to arm64
  - Repleced occurrences of timeval and timespec
  - Modified datapage.h to be compliant with y2038 on all the architectures
  - Removed __u_vdso type

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Salyzyn <salyzyn@android.com>
Cc: Peter Collingbourne <pcc@google.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Huw Davies <huw@codeweavers.com>
Cc: Shijith Thotton <sthotton@marvell.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Tested-by: Shijith Thotton <sthotton@marvell.com>
Tested-by: Andre Przywara <andre.przywara@arm.com>

Performance Numbers: Linux 5.2.0-rc2 - Xeon Gold 5120T
======================================================

Unified vDSO:
-------------

clock-gettime-monotonic: syscall: 342 nsec/call
clock-gettime-monotonic:    libc: 25 nsec/call
clock-gettime-monotonic:    vdso: 24 nsec/call
clock-getres-monotonic: syscall: 296 nsec/call
clock-getres-monotonic:    libc: 296 nsec/call
clock-getres-monotonic:    vdso: 3 nsec/call
clock-gettime-monotonic-coarse: syscall: 294 nsec/call
clock-gettime-monotonic-coarse:    libc: 5 nsec/call
clock-gettime-monotonic-coarse:    vdso: 5 nsec/call
clock-getres-monotonic-coarse: syscall: 295 nsec/call
clock-getres-monotonic-coarse:    libc: 292 nsec/call
clock-getres-monotonic-coarse:    vdso: 5 nsec/call
clock-gettime-monotonic-raw: syscall: 343 nsec/call
clock-gettime-monotonic-raw:    libc: 25 nsec/call
clock-gettime-monotonic-raw:    vdso: 23 nsec/call
clock-getres-monotonic-raw: syscall: 290 nsec/call
clock-getres-monotonic-raw:    libc: 290 nsec/call
clock-getres-monotonic-raw:    vdso: 4 nsec/call
clock-gettime-tai: syscall: 332 nsec/call
clock-gettime-tai:    libc: 24 nsec/call
clock-gettime-tai:    vdso: 23 nsec/call
clock-getres-tai: syscall: 288 nsec/call
clock-getres-tai:    libc: 288 nsec/call
clock-getres-tai:    vdso: 3 nsec/call
clock-gettime-boottime: syscall: 342 nsec/call
clock-gettime-boottime:    libc: 24 nsec/call
clock-gettime-boottime:    vdso: 23 nsec/call
clock-getres-boottime: syscall: 284 nsec/call
clock-getres-boottime:    libc: 291 nsec/call
clock-getres-boottime:    vdso: 3 nsec/call
clock-gettime-realtime: syscall: 337 nsec/call
clock-gettime-realtime:    libc: 24 nsec/call
clock-gettime-realtime:    vdso: 23 nsec/call
clock-getres-realtime: syscall: 287 nsec/call
clock-getres-realtime:    libc: 284 nsec/call
clock-getres-realtime:    vdso: 3 nsec/call
clock-gettime-realtime-coarse: syscall: 307 nsec/call
clock-gettime-realtime-coarse:    libc: 4 nsec/call
clock-gettime-realtime-coarse:    vdso: 4 nsec/call
clock-getres-realtime-coarse: syscall: 294 nsec/call
clock-getres-realtime-coarse:    libc: 291 nsec/call
clock-getres-realtime-coarse:    vdso: 4 nsec/call
getcpu: syscall: 246 nsec/call
getcpu:    libc: 14 nsec/call
getcpu:    vdso: 11 nsec/call
gettimeofday: syscall: 293 nsec/call
gettimeofday:    libc: 26 nsec/call
gettimeofday:    vdso: 25 nsec/call

Stock Kernel:
-------------

clock-gettime-monotonic: syscall: 338 nsec/call
clock-gettime-monotonic:    libc: 24 nsec/call
clock-gettime-monotonic:    vdso: 23 nsec/call
clock-getres-monotonic: syscall: 291 nsec/call
clock-getres-monotonic:    libc: 304 nsec/call
clock-getres-monotonic:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-monotonic-coarse: syscall: 297 nsec/call
clock-gettime-monotonic-coarse:    libc: 5 nsec/call
clock-gettime-monotonic-coarse:    vdso: 4 nsec/call
clock-getres-monotonic-coarse: syscall: 281 nsec/call
clock-getres-monotonic-coarse:    libc: 286 nsec/call
clock-getres-monotonic-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-monotonic-raw: syscall: 336 nsec/call
clock-gettime-monotonic-raw:    libc: 340 nsec/call
clock-gettime-monotonic-raw:    vdso: 346 nsec/call
clock-getres-monotonic-raw: syscall: 297 nsec/call
clock-getres-monotonic-raw:    libc: 301 nsec/call
clock-getres-monotonic-raw:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-tai: syscall: 351 nsec/call
clock-gettime-tai:    libc: 24 nsec/call
clock-gettime-tai:    vdso: 23 nsec/call
clock-getres-tai: syscall: 298 nsec/call
clock-getres-tai:    libc: 290 nsec/call
clock-getres-tai:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-boottime: syscall: 342 nsec/call
clock-gettime-boottime:    libc: 347 nsec/call
clock-gettime-boottime:    vdso: 355 nsec/call
clock-getres-boottime: syscall: 296 nsec/call
clock-getres-boottime:    libc: 295 nsec/call
clock-getres-boottime:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-realtime: syscall: 346 nsec/call
clock-gettime-realtime:    libc: 24 nsec/call
clock-gettime-realtime:    vdso: 22 nsec/call
clock-getres-realtime: syscall: 295 nsec/call
clock-getres-realtime:    libc: 291 nsec/call
clock-getres-realtime:    vdso: not tested
Note: vDSO version of clock_getres not found
clock-gettime-realtime-coarse: syscall: 292 nsec/call
clock-gettime-realtime-coarse:    libc: 5 nsec/call
clock-gettime-realtime-coarse:    vdso: 4 nsec/call
clock-getres-realtime-coarse: syscall: 300 nsec/call
clock-getres-realtime-coarse:    libc: 301 nsec/call
clock-getres-realtime-coarse:    vdso: not tested
Note: vDSO version of clock_getres not found
getcpu: syscall: 252 nsec/call
getcpu:    libc: 14 nsec/call
getcpu:    vdso: 11 nsec/call
gettimeofday: syscall: 293 nsec/call
gettimeofday:    libc: 24 nsec/call
gettimeofday:    vdso: 25 nsec/call

Performance Numbers: Linux 5.2.0-rc2 - ThunderX2 (arm64)
========================================================

Provided by: Shijith Thotton <sthotton@marvell.com>

Unified vDSO:
-------------

clock-gettime-monotonic: syscall: 346 nsec/call
clock-gettime-monotonic:    libc: 38 nsec/call
clock-gettime-monotonic:    vdso: 36 nsec/call
clock-getres-monotonic: syscall: 262 nsec/call
clock-getres-monotonic:    libc: 6 nsec/call
clock-getres-monotonic:    vdso: 5 nsec/call
clock-gettime-monotonic-coarse: syscall: 296 nsec/call
clock-gettime-monotonic-coarse:    libc: 39 nsec/call
clock-gettime-monotonic-coarse:    vdso: 38 nsec/call
clock-getres-monotonic-coarse: syscall: 260 nsec/call
clock-getres-monotonic-coarse:    libc: 8 nsec/call
clock-getres-monotonic-coarse:    vdso: 5 nsec/call
clock-gettime-monotonic-raw: syscall: 345 nsec/call
clock-gettime-monotonic-raw:    libc: 35 nsec/call
clock-gettime-monotonic-raw:    vdso: 34 nsec/call
clock-getres-monotonic-raw: syscall: 261 nsec/call
clock-getres-monotonic-raw:    libc: 7 nsec/call
clock-getres-monotonic-raw:    vdso: 5 nsec/call
clock-gettime-tai: syscall: 357 nsec/call
clock-gettime-tai:    libc: 38 nsec/call
clock-gettime-tai:    vdso: 36 nsec/call
clock-getres-tai: syscall: 257 nsec/call
clock-getres-tai:    libc: 7 nsec/call
clock-getres-tai:    vdso: 5 nsec/call
clock-gettime-boottime: syscall: 356 nsec/call
clock-gettime-boottime:    libc: 38 nsec/call
clock-gettime-boottime:    vdso: 36 nsec/call
clock-getres-boottime: syscall: 257 nsec/call
clock-getres-boottime:    libc: 6 nsec/call
clock-getres-boottime:    vdso: 5 nsec/call
clock-gettime-realtime: syscall: 345 nsec/call
clock-gettime-realtime:    libc: 38 nsec/call
clock-gettime-realtime:    vdso: 36 nsec/call
clock-getres-realtime: syscall: 257 nsec/call
clock-getres-realtime:    libc: 7 nsec/call
clock-getres-realtime:    vdso: 5 nsec/call
clock-gettime-realtime-coarse: syscall: 295 nsec/call
clock-gettime-realtime-coarse:    libc: 39 nsec/call
clock-gettime-realtime-coarse:    vdso: 38 nsec/call
clock-getres-realtime-coarse: syscall: 260 nsec/call
clock-getres-realtime-coarse:    libc: 8 nsec/call
clock-getres-realtime-coarse:    vdso: 5 nsec/call
getcpu: syscall: 244 nsec/call
getcpu:    libc: 247 nsec/call
getcpu:    vdso: not tested
Note: vDSO version of getcpu not found
gettimeofday: syscall: 383 nsec/call
gettimeofday:    libc: 39 nsec/call
gettimeofday:    vdso: 35 nsec/call

Stock Kernel:
-------------

clock-gettime-monotonic: syscall: 344 nsec/call
clock-gettime-monotonic:    libc: 74 nsec/call
clock-gettime-monotonic:    vdso: 73 nsec/call
clock-getres-monotonic: syscall: 258 nsec/call
clock-getres-monotonic:    libc: 6 nsec/call
clock-getres-monotonic:    vdso: 4 nsec/call
clock-gettime-monotonic-coarse: syscall: 300 nsec/call
clock-gettime-monotonic-coarse:    libc: 36 nsec/call
clock-gettime-monotonic-coarse:    vdso: 34 nsec/call
clock-getres-monotonic-coarse: syscall: 261 nsec/call
clock-getres-monotonic-coarse:    libc: 6 nsec/call
clock-getres-monotonic-coarse:    vdso: 4 nsec/call
clock-gettime-monotonic-raw: syscall: 346 nsec/call
clock-gettime-monotonic-raw:    libc: 74 nsec/call
clock-gettime-monotonic-raw:    vdso: 72 nsec/call
clock-getres-monotonic-raw: syscall: 254 nsec/call
clock-getres-monotonic-raw:    libc: 6 nsec/call
clock-getres-monotonic-raw:    vdso: 4 nsec/call
clock-gettime-tai: syscall: 345 nsec/call
clock-gettime-tai:    libc: 361 nsec/call
clock-gettime-tai:    vdso: 359 nsec/call
clock-getres-tai: syscall: 259 nsec/call
clock-getres-tai:    libc: 262 nsec/call
clock-getres-tai:    vdso: 258 nsec/call
clock-gettime-boottime: syscall: 353 nsec/call
clock-gettime-boottime:    libc: 365 nsec/call
clock-gettime-boottime:    vdso: 362 nsec/call
clock-getres-boottime: syscall: 260 nsec/call
clock-getres-boottime:    libc: 267 nsec/call
clock-getres-boottime:    vdso: 259 nsec/call
clock-gettime-realtime: syscall: 344 nsec/call
clock-gettime-realtime:    libc: 73 nsec/call
clock-gettime-realtime:    vdso: 72 nsec/call
clock-getres-realtime: syscall: 255 nsec/call
clock-getres-realtime:    libc: 7 nsec/call
clock-getres-realtime:    vdso: 4 nsec/call
clock-gettime-realtime-coarse: syscall: 296 nsec/call
clock-gettime-realtime-coarse:    libc: 35 nsec/call
clock-gettime-realtime-coarse:    vdso: 33 nsec/call
clock-getres-realtime-coarse: syscall: 258 nsec/call
clock-getres-realtime-coarse:    libc: 6 nsec/call
clock-getres-realtime-coarse:    vdso: 4 nsec/call
getcpu: syscall: 237 nsec/call
getcpu:    libc: 242 nsec/call
getcpu:    vdso: not tested
Note: vDSO version of getcpu not found
gettimeofday: syscall: 378 nsec/call
gettimeofday:    libc: 73 nsec/call
gettimeofday:    vdso: 70 nsec/call

Peter Collingbourne (1):
  arm64: Build vDSO with -ffixed-x18

Vincenzo Frascino (24):
  kernel: Standardize vdso_datapage
  kernel: Define gettimeofday vdso common code
  kernel: Unify update_vsyscall implementation
  arm64: Substitute gettimeofday with C implementation
  arm64: compat: Add missing syscall numbers
  arm64: compat: Expose signal related structures
  arm64: compat: Generate asm offsets for signals
  lib: vdso: Add compat support
  arm64: compat: Add vDSO
  arm64: Refactor vDSO code
  arm64: compat: vDSO setup for compat layer
  arm64: elf: vDSO code page discovery
  arm64: compat: Get sigreturn trampolines from vDSO
  arm64: Add vDSO compat support
  arm: Add support for generic vDSO
  arm: Add clock_getres entry point
  arm: Add clock_gettime64 entry point
  mips: Add support for generic vDSO
  mips: Add clock_getres entry point
  mips: Add clock_gettime64 entry point
  x86: Add support for generic vDSO
  x86: Add clock_getres entry point
  x86: Add clock_gettime64 entry point
  kselftest: Extend vDSO selftest

 arch/arm/Kconfig                              |   3 +
 arch/arm/include/asm/vdso/gettimeofday.h      |  94 +++++
 arch/arm/include/asm/vdso/vsyscall.h          |  71 ++++
 arch/arm/include/asm/vdso_datapage.h          |  29 +-
 arch/arm/kernel/vdso.c                        |  87 +----
 arch/arm/vdso/Makefile                        |  13 +-
 arch/arm/vdso/note.c                          |  15 +
 arch/arm/vdso/vdso.lds.S                      |   2 +
 arch/arm/vdso/vgettimeofday.c                 | 256 +------------
 arch/arm64/Kconfig                            |   3 +
 arch/arm64/Makefile                           |  23 +-
 arch/arm64/include/asm/elf.h                  |  14 +
 arch/arm64/include/asm/signal32.h             |  46 +++
 arch/arm64/include/asm/unistd.h               |   5 +
 arch/arm64/include/asm/vdso.h                 |   3 +
 arch/arm64/include/asm/vdso/compat_barrier.h  |  51 +++
 .../include/asm/vdso/compat_gettimeofday.h    | 110 ++++++
 arch/arm64/include/asm/vdso/gettimeofday.h    |  86 +++++
 arch/arm64/include/asm/vdso/vsyscall.h        |  53 +++
 arch/arm64/include/asm/vdso_datapage.h        |  48 ---
 arch/arm64/kernel/Makefile                    |   6 +-
 arch/arm64/kernel/asm-offsets.c               |  39 +-
 arch/arm64/kernel/signal32.c                  |  72 ++--
 arch/arm64/kernel/vdso.c                      | 356 ++++++++++++------
 arch/arm64/kernel/vdso/Makefile               |  34 +-
 arch/arm64/kernel/vdso/gettimeofday.S         | 334 ----------------
 arch/arm64/kernel/vdso/vgettimeofday.c        |  28 ++
 arch/arm64/kernel/vdso32/.gitignore           |   2 +
 arch/arm64/kernel/vdso32/Makefile             | 186 +++++++++
 arch/arm64/kernel/vdso32/note.c               |  15 +
 arch/arm64/kernel/vdso32/sigreturn.S          |  62 +++
 arch/arm64/kernel/vdso32/vdso.S               |  19 +
 arch/arm64/kernel/vdso32/vdso.lds.S           |  82 ++++
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  59 +++
 arch/mips/Kconfig                             |   2 +
 arch/mips/include/asm/vdso.h                  |  78 +---
 arch/mips/include/asm/vdso/gettimeofday.h     | 177 +++++++++
 arch/mips/{ => include/asm}/vdso/vdso.h       |   6 +-
 arch/mips/include/asm/vdso/vsyscall.h         |  43 +++
 arch/mips/kernel/vdso.c                       |  37 +-
 arch/mips/vdso/Makefile                       |  27 +-
 arch/mips/vdso/elf.S                          |   2 +-
 arch/mips/vdso/sigreturn.S                    |   2 +-
 arch/mips/vdso/vdso.lds.S                     |   4 +
 arch/mips/vdso/vgettimeofday.c                |  58 +++
 arch/x86/Kconfig                              |   3 +
 arch/x86/entry/vdso/Makefile                  |   9 +
 arch/x86/entry/vdso/vclock_gettime.c          | 249 +++---------
 arch/x86/entry/vdso/vdso.lds.S                |   2 +
 arch/x86/entry/vdso/vdso32/vdso32.lds.S       |   2 +
 arch/x86/entry/vdso/vdsox32.lds.S             |   1 +
 arch/x86/entry/vsyscall/Makefile              |   2 -
 arch/x86/entry/vsyscall/vsyscall_gtod.c       |  83 ----
 arch/x86/include/asm/pvclock.h                |   2 +-
 arch/x86/include/asm/vdso/gettimeofday.h      | 205 ++++++++++
 arch/x86/include/asm/vdso/vsyscall.h          |  44 +++
 arch/x86/include/asm/vgtod.h                  |  75 +---
 arch/x86/include/asm/vvar.h                   |   7 +-
 arch/x86/kernel/pvclock.c                     |   1 +
 include/asm-generic/vdso/vsyscall.h           |  56 +++
 include/linux/hrtimer.h                       |  15 +-
 include/linux/hrtimer_defs.h                  |  25 ++
 include/linux/timekeeper_internal.h           |   9 +
 include/vdso/datapage.h                       |  93 +++++
 include/vdso/helpers.h                        |  56 +++
 include/vdso/vsyscall.h                       |  11 +
 kernel/Makefile                               |   1 +
 kernel/vdso/Makefile                          |   2 +
 kernel/vdso/vsyscall.c                        | 131 +++++++
 lib/Kconfig                                   |   5 +
 lib/vdso/Kconfig                              |  36 ++
 lib/vdso/Makefile                             |  22 ++
 lib/vdso/gettimeofday.c                       | 231 ++++++++++++
 tools/testing/selftests/vDSO/Makefile         |   2 +
 tools/testing/selftests/vDSO/vdso_config.h    |  90 +++++
 tools/testing/selftests/vDSO/vdso_full_test.c | 244 ++++++++++++
 76 files changed, 3044 insertions(+), 1412 deletions(-)
 create mode 100644 arch/arm/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm/include/asm/vdso/vsyscall.h
 create mode 100644 arch/arm/vdso/note.c
 create mode 100644 arch/arm64/include/asm/vdso/compat_barrier.h
 create mode 100644 arch/arm64/include/asm/vdso/compat_gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/arm64/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/arm64/include/asm/vdso_datapage.h
 delete mode 100644 arch/arm64/kernel/vdso/gettimeofday.S
 create mode 100644 arch/arm64/kernel/vdso/vgettimeofday.c
 create mode 100644 arch/arm64/kernel/vdso32/.gitignore
 create mode 100644 arch/arm64/kernel/vdso32/Makefile
 create mode 100644 arch/arm64/kernel/vdso32/note.c
 create mode 100644 arch/arm64/kernel/vdso32/sigreturn.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.S
 create mode 100644 arch/arm64/kernel/vdso32/vdso.lds.S
 create mode 100644 arch/arm64/kernel/vdso32/vgettimeofday.c
 create mode 100644 arch/mips/include/asm/vdso/gettimeofday.h
 rename arch/mips/{ => include/asm}/vdso/vdso.h (89%)
 create mode 100644 arch/mips/include/asm/vdso/vsyscall.h
 create mode 100644 arch/mips/vdso/vgettimeofday.c
 delete mode 100644 arch/x86/entry/vsyscall/vsyscall_gtod.c
 create mode 100644 arch/x86/include/asm/vdso/gettimeofday.h
 create mode 100644 arch/x86/include/asm/vdso/vsyscall.h
 create mode 100644 include/asm-generic/vdso/vsyscall.h
 create mode 100644 include/linux/hrtimer_defs.h
 create mode 100644 include/vdso/datapage.h
 create mode 100644 include/vdso/helpers.h
 create mode 100644 include/vdso/vsyscall.h
 create mode 100644 kernel/vdso/Makefile
 create mode 100644 kernel/vdso/vsyscall.c
 create mode 100644 lib/vdso/Kconfig
 create mode 100644 lib/vdso/Makefile
 create mode 100644 lib/vdso/gettimeofday.c
 create mode 100644 tools/testing/selftests/vDSO/vdso_config.h
 create mode 100644 tools/testing/selftests/vDSO/vdso_full_test.c

-- 
2.21.0

