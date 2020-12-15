Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDCEA2DB06E
	for <lists+linux-arch@lfdr.de>; Tue, 15 Dec 2020 16:49:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgLOPrb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Dec 2020 10:47:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:39794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730391AbgLOPrY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Dec 2020 10:47:24 -0500
X-Gm-Message-State: AOAM531M43S+7WplxnQl4MSDf7E9WpRNCKAawWxJ2qrxRJKixpsjBSET
        DXQyF0fJ2jGYhyd3zqygdeqCtCPXKB0fluDvGoU=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047203;
        bh=w45FprzmZmle903uZV9KAGlz796oOhDl2jyefAKeBD0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=K0lK7q8lik1b1pwOtU2U9VXRdKTgH5FQSr/qeOOtlS56qIGz9c2+5wiLcnMUmsLxP
         7Iwg2ERXh/SpLvawC+Hk/NJGh89ehxJyok+5NAe5aNi58VVVEzE7WSUjWKB9yc1aMD
         TqBXUVBSouA8XNsfyZvAYANwUF4mq97kDTSvmd5b0KgVtpV4VaDkzayS4lmKRdsu/R
         I5Hck+lrApAlAqal2PwYYgCcwNMKu90a34H13KFGA9WRC50B73G3wsP6Zq6j0j0n70
         rBjT2xktYBwYxXCTARBo2P34VviKQsVX7r7c5jzSz0JBQgRfsI4MNScQiCZTuNgNbM
         NY2OeMUBqHPIg==
X-Google-Smtp-Source: ABdhPJyjOQvNJBs2+MEWHlYiyS4fBt+MMmfvSE2j/2a58SeDJjZTOMo2RoPkJjlebWn2t8vBgLKoQGAEWjCiBBSGR3I=
X-Received: by 2002:aca:3b41:: with SMTP id i62mr6683088oia.67.1608047202237;
 Tue, 15 Dec 2020 07:46:42 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Dec 2020 16:46:25 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1epGkg=-YzHZtZTe074XFTVfgBemaNiHZUt_0Y7NJNtA@mail.gmail.com>
Message-ID: <CAK8P3a1epGkg=-YzHZtZTe074XFTVfgBemaNiHZUt_0Y7NJNtA@mail.gmail.com>
Subject: [GIT PULL 3/3] asm-generic: cross-architecture timer cleanup
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 3650b228f83adda7e5ee532e2b90429c03f7b9ec:

  Linux 5.10-rc1 (2020-10-25 15:14:11 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-timers-5.11

for you to fetch changes up to 0774a6ed294b963dc76df2d8342ab86d030759ec:

  timekeeping: default GENERIC_CLOCKEVENTS to enabled (2020-10-30
21:57:07 +0100)

----------------------------------------------------------------
asm-generic: cross-architecture timer cleanup

This cleans up two ancient timer features that were never completed in
the past, CONFIG_GENERIC_CLOCKEVENTS and CONFIG_ARCH_USES_GETTIMEOFFSET.

There was only one user left for the ARCH_USES_GETTIMEOFFSET variant
of clocksource implementations, the ARM EBSA110 platform. Rather than
changing to use modern timekeeping, we remove the platform entirely as
Russell no longer uses his machine and nobody else seems to have one
any more.

The conditional code for using arch_gettimeoffset() is removed as
a result.

For CONFIG_GENERIC_CLOCKEVENTS, there are still a couple of platforms
not using clockevent drivers: parisc, ia64, most of m68k, and one
Arm platform. These all do timer ticks slighly differently, and this
gets cleaned up to the point they at least all call the same helper
function. Instead of most platforms using 'select GENERIC_CLOCKEVENTS'
in Kconfig, the polarity is now reversed, with the few remaining ones
selecting LEGACY_TIMER_TICK instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (15):
      ARM: remove ebsa110 platform
      net: remove am79c961a driver
      timekeeping: remove arch_gettimeoffset
      timekeeping: add CONFIG_LEGACY_TIMER_TICK
      ia64: convert to legacy_timer_tick
      ARM: rpc: use legacy_timer_tick
      parisc: use legacy_timer_tick
      m68k: coldfire: use legacy_timer_tick()
      m68k: split heartbeat out of timer function
      m68k: sun3/sun3c: use legacy_timer_tick
      m68k: m68328: use legacy_timer_tick()
      m68k: change remaining timers to legacy_timer_tick
      m68k: remove timer_interrupt() function
      timekeeping: remove xtime_update
      timekeeping: default GENERIC_CLOCKEVENTS to enabled

 .../features/time/clockevents/arch-support.txt     |   8 +-
 .../time/modern-timekeeping/arch-support.txt       |  33 -
 MAINTAINERS                                        |   8 -
 arch/alpha/Kconfig                                 |   1 -
 arch/arc/Kconfig                                   |   1 -
 arch/arm/Kconfig                                   |  37 +-
 arch/arm/Kconfig.debug                             |   6 +-
 arch/arm/Makefile                                  |   8 -
 arch/arm/configs/ebsa110_defconfig                 |  74 --
 arch/arm/include/asm/mach/time.h                   |   2 -
 arch/arm/kernel/Makefile                           |   6 +-
 arch/arm/kernel/time.c                             |  14 -
 arch/arm/mach-ebsa110/Makefile                     |   8 -
 arch/arm/mach-ebsa110/Makefile.boot                |   5 -
 arch/arm/mach-ebsa110/core.c                       | 323 ---------
 arch/arm/mach-ebsa110/core.h                       |  38 -
 arch/arm/mach-ebsa110/include/mach/entry-macro.S   |  33 -
 arch/arm/mach-ebsa110/include/mach/hardware.h      |  21 -
 arch/arm/mach-ebsa110/include/mach/io.h            |  89 ---
 arch/arm/mach-ebsa110/include/mach/irqs.h          |  17 -
 arch/arm/mach-ebsa110/include/mach/memory.h        |  22 -
 arch/arm/mach-ebsa110/include/mach/uncompress.h    |  41 --
 arch/arm/mach-ebsa110/io.c                         | 440 ------------
 arch/arm/mach-ebsa110/leds.c                       |  71 --
 arch/arm/mach-rpc/time.c                           |   2 +-
 arch/arm64/Kconfig                                 |   1 -
 arch/arm64/Kconfig.platforms                       |   1 -
 arch/c6x/Kconfig                                   |   1 -
 arch/csky/Kconfig                                  |   1 -
 arch/h8300/Kconfig                                 |   1 -
 arch/hexagon/Kconfig                               |   1 -
 arch/ia64/Kconfig                                  |   1 +
 arch/ia64/kernel/time.c                            |  36 +-
 arch/m68k/68000/timers.c                           |   7 +-
 arch/m68k/Kconfig.cpu                              |  37 +-
 arch/m68k/Kconfig.machine                          |  11 +
 arch/m68k/amiga/config.c                           |  11 +-
 arch/m68k/apollo/config.c                          |  11 +-
 arch/m68k/atari/config.c                           |   2 +-
 arch/m68k/atari/time.c                             |   9 +-
 arch/m68k/bvme6000/config.c                        |   9 +-
 arch/m68k/coldfire/Makefile                        |  32 +-
 arch/m68k/coldfire/pit.c                           |   2 +-
 arch/m68k/coldfire/sltimers.c                      |   8 +-
 arch/m68k/coldfire/timers.c                        |   8 +-
 arch/m68k/hp300/time.c                             |   8 +-
 arch/m68k/hp300/time.h                             |   2 +-
 arch/m68k/include/asm/machdep.h                    |  12 +-
 arch/m68k/kernel/setup_mm.c                        |   2 +-
 arch/m68k/kernel/setup_no.c                        |   2 +-
 arch/m68k/kernel/time.c                            |  18 +-
 arch/m68k/mac/config.c                             |   6 +-
 arch/m68k/mac/via.c                                |   8 +-
 arch/m68k/mvme147/config.c                         |   9 +-
 arch/m68k/mvme16x/config.c                         |   9 +-
 arch/m68k/q40/config.c                             |   2 +-
 arch/m68k/q40/q40ints.c                            |  10 +-
 arch/m68k/sun3/config.c                            |   4 +-
 arch/m68k/sun3/sun3ints.c                          |   3 +-
 arch/m68k/sun3x/time.c                             |   5 +-
 arch/m68k/sun3x/time.h                             |   2 +-
 arch/microblaze/Kconfig                            |   1 -
 arch/mips/Kconfig                                  |   1 -
 arch/nds32/Kconfig                                 |   1 -
 arch/nios2/Kconfig                                 |   1 -
 arch/openrisc/Kconfig                              |   1 -
 arch/parisc/Kconfig                                |   2 +-
 arch/parisc/kernel/time.c                          |   9 +-
 arch/powerpc/Kconfig                               |   1 -
 arch/riscv/Kconfig                                 |   1 -
 arch/s390/Kconfig                                  |   1 -
 arch/sh/Kconfig                                    |   1 -
 arch/sparc/Kconfig                                 |   1 -
 arch/um/Kconfig                                    |   1 -
 arch/x86/Kconfig                                   |   1 -
 arch/xtensa/Kconfig                                |   1 -
 drivers/Makefile                                   |   2 -
 drivers/clocksource/Kconfig                        |   2 +-
 drivers/net/ethernet/amd/Kconfig                   |  10 +-
 drivers/net/ethernet/amd/Makefile                  |   1 -
 drivers/net/ethernet/amd/am79c961a.c               | 763 ---------------------
 drivers/net/ethernet/amd/am79c961a.h               | 143 ----
 drivers/watchdog/Kconfig                           |   2 +-
 include/linux/time.h                               |  13 -
 include/linux/timekeeping.h                        |   3 +-
 kernel/time/Kconfig                                |  18 +-
 kernel/time/Makefile                               |   1 +
 kernel/time/clocksource.c                          |   8 -
 kernel/time/tick-legacy.c                          |  37 +
 kernel/time/timekeeping.c                          |  41 +-
 kernel/time/timekeeping.h                          |   1 +
 kernel/trace/Kconfig                               |   2 -
 92 files changed, 218 insertions(+), 2453 deletions(-)
 delete mode 100644
Documentation/features/time/modern-timekeeping/arch-support.txt
 delete mode 100644 arch/arm/configs/ebsa110_defconfig
 delete mode 100644 arch/arm/mach-ebsa110/Makefile
 delete mode 100644 arch/arm/mach-ebsa110/Makefile.boot
 delete mode 100644 arch/arm/mach-ebsa110/core.c
 delete mode 100644 arch/arm/mach-ebsa110/core.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/entry-macro.S
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/hardware.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/io.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/irqs.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/memory.h
 delete mode 100644 arch/arm/mach-ebsa110/include/mach/uncompress.h
 delete mode 100644 arch/arm/mach-ebsa110/io.c
 delete mode 100644 arch/arm/mach-ebsa110/leds.c
 delete mode 100644 drivers/net/ethernet/amd/am79c961a.c
 delete mode 100644 drivers/net/ethernet/amd/am79c961a.h
 create mode 100644 kernel/time/tick-legacy.c
