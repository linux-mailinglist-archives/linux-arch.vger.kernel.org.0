Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56A5415C7D1
	for <lists+linux-arch@lfdr.de>; Thu, 13 Feb 2020 17:26:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBMQQo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 13 Feb 2020 11:16:44 -0500
Received: from foss.arm.com ([217.140.110.172]:49662 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725781AbgBMQQo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 13 Feb 2020 11:16:44 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E37E0328;
        Thu, 13 Feb 2020 08:16:42 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 60CE33F6CF;
        Thu, 13 Feb 2020 08:16:40 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        clang-built-linux@googlegroups.com, x86@kernel.org
Cc:     catalin.marinas@arm.com, will.deacon@arm.com, arnd@arndb.de,
        linux@armlinux.org.uk, paul.burton@mips.com, tglx@linutronix.de,
        luto@kernel.org, mingo@redhat.com, bp@alien8.de, sboyd@kernel.org,
        salyzyn@android.com, pcc@google.com, 0x7f454c46@gmail.com,
        ndesaulniers@google.com, avagin@openvz.org
Subject: [PATCH 00/19] Introduce common headers
Date:   Thu, 13 Feb 2020 16:15:55 +0000
Message-Id: <20200213161614.23246-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.25.0
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
    and place it in include/common/
  * Make sure that where meaningful the kernel includes "common"
  * Limit the vDSO library to include headers coming only from UAPI
    and "common" (with 2 exceptions compiler.h for barriers and
    param.h for HZ).
  * Adapt all the architectures that support the unified vDSO library
    to use "common" headers.

According to me this approach allows up to exercise a better control on
what the vDSO library can include and to prevent potential issues in
future.

This patch series contains the implementation of the described approach.

The "common" headers have been verified on all the architectures that support
unified vDSO using the vdsotest [3] testsuite for what concerns the vDSO part
and randconfig to verify that they are included in the correct places.

To simplify the testing, a copy of the patchset on top of a recent linux
tree can be found at [4].

[1] https://github.com/ClangBuiltLinux/linux/issues/595
[2] https://lore.kernel.org/lkml/20190926151704.GH9689@arrakis.emea.arm.com
[3] https://github.com/nathanlynch/vdsotest
[4] git://linux-arm.org/linux-vf.git common-headers/v1

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will.deacon@arm.com>
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
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

Vincenzo Frascino (19):
  linux/const.h: Extract common header for vDSO
  linux/bits.h: Extract common header for vDSO
  linux/limits.h: Extract common header for vDSO
  linux/math64.h: Extract common header for vDSO
  linux/time.h: Extract common header for vDSO
  linux/time32.h: Extract common header for vDSO
  linux/time64.h: Extract common header for vDSO
  linux/jiffies.h: Extract common header for vDSO
  linux/ktime.h: Extract common header for vDSO
  common: Introduce processor.h
  linux/elfnote.h: Replace elf.h with UAPI equivalent
  arm64: Introduce asm/common/processor.h
  arm64: vdso: Include common headers in the vdso library
  arm64: vdso32: Include common headers in the vdso library
  mips: vdso: Enable mips to use common headers
  x86: vdso: Enable x86 to use common headers
  arm: vdso: Enable arm to use common headers
  lib: vdso: Enable common headers
  arm64: vdso32: Enable Clang Compilation

 arch/arm/include/asm/common/cp15.h            | 38 +++++++++++++++++++
 arch/arm/include/asm/common/processor.h       | 22 +++++++++++
 arch/arm/include/asm/cp15.h                   | 20 +---------
 arch/arm/include/asm/processor.h              | 11 +-----
 arch/arm/include/asm/vdso/gettimeofday.h      |  4 +-
 arch/arm64/include/asm/common/processor.h     | 31 +++++++++++++++
 arch/arm64/include/asm/processor.h            | 16 +-------
 .../include/asm/vdso/compat_gettimeofday.h    |  2 +-
 arch/arm64/include/asm/vdso/gettimeofday.h    |  1 -
 arch/arm64/kernel/vdso/vgettimeofday.c        |  2 -
 arch/arm64/kernel/vdso32/Makefile             |  4 +-
 arch/arm64/kernel/vdso32/vgettimeofday.c      |  3 --
 arch/mips/include/asm/common/processor.h      | 27 +++++++++++++
 arch/mips/include/asm/processor.h             | 16 +-------
 arch/mips/include/asm/vdso/gettimeofday.h     |  4 --
 arch/x86/include/asm/common/processor.h       | 23 +++++++++++
 arch/x86/include/asm/processor.h              | 12 +-----
 include/common/bits.h                         |  9 +++++
 include/common/const.h                        | 10 +++++
 include/common/jiffies.h                      | 11 ++++++
 include/common/ktime.h                        | 16 ++++++++
 include/common/limits.h                       | 18 +++++++++
 include/common/math64.h                       | 24 ++++++++++++
 include/common/processor.h                    | 14 +++++++
 include/common/time.h                         | 12 ++++++
 include/common/time32.h                       | 17 +++++++++
 include/common/time64.h                       | 14 +++++++
 include/linux/bits.h                          |  2 +-
 include/linux/const.h                         |  5 +--
 include/linux/elfnote.h                       |  2 +-
 include/linux/jiffies.h                       |  4 +-
 include/linux/ktime.h                         |  9 +----
 include/linux/limits.h                        | 13 +------
 include/linux/math64.h                        | 20 +---------
 include/linux/time.h                          |  5 +--
 include/linux/time32.h                        | 13 +------
 include/linux/time64.h                        | 10 +----
 include/vdso/datapage.h                       | 32 ++++++++++++++--
 lib/vdso/gettimeofday.c                       | 21 ----------
 39 files changed, 337 insertions(+), 180 deletions(-)
 create mode 100644 arch/arm/include/asm/common/cp15.h
 create mode 100644 arch/arm/include/asm/common/processor.h
 create mode 100644 arch/arm64/include/asm/common/processor.h
 create mode 100644 arch/mips/include/asm/common/processor.h
 create mode 100644 arch/x86/include/asm/common/processor.h
 create mode 100644 include/common/bits.h
 create mode 100644 include/common/const.h
 create mode 100644 include/common/jiffies.h
 create mode 100644 include/common/ktime.h
 create mode 100644 include/common/limits.h
 create mode 100644 include/common/math64.h
 create mode 100644 include/common/processor.h
 create mode 100644 include/common/time.h
 create mode 100644 include/common/time32.h
 create mode 100644 include/common/time64.h

-- 
2.25.0

