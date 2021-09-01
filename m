Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B470E3FE372
	for <lists+linux-arch@lfdr.de>; Wed,  1 Sep 2021 21:53:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237813AbhIATyt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Sep 2021 15:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:34138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237319AbhIATyt (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 1 Sep 2021 15:54:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B0AC60F3A;
        Wed,  1 Sep 2021 19:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630526032;
        bh=rfB/OZJ7E1Hj9VqBxmUsABsSJk4KkSB/8hCzlAcGzRA=;
        h=From:Date:Subject:To:Cc:From;
        b=Z1xDWnU+zobUzHPtpALjRb6XEZaxozK2v/0c4xp57zbv6QM4J/oRJWbqt6euvnOQ7
         bAss8exMDL3KIT4nK0xezZJabx+RfJL6dgvAtzScxCN+3/dDpMZ7yFZgHVKbSBCdua
         e86ifdZUCh0EkAczMpdlE4X9f+7DuidaiVKhw9P4KiI+0rb2H8O1LR0tRLSIIrXjdI
         WMD3aUMvacBKkMNaEVNOuhM+K+z21jfQ9mZ0dZCSDrFOJENyDh9aje6iXR4RUON9OC
         bA2lpTYS4XFaFQzInlFE1n0OQIvYOtkNxsibnkJDUooy24UcvxcoQbwCBe38+LW5+U
         B/f1nbHh6Snlg==
Received: by mail-wr1-f49.google.com with SMTP id n5so1308533wro.12;
        Wed, 01 Sep 2021 12:53:52 -0700 (PDT)
X-Gm-Message-State: AOAM533jPfpVCcqYSPL2J8KF4oJqDLAQi+EFKmzxh9wzLpIdl3ejoAVF
        XEjk9dpz2phu6N2DQtAYh21LSFCyHF5jgUsdmJ4=
X-Google-Smtp-Source: ABdhPJxrJeKlyrk+RR3EOknpylVmjIXq7+0/9+LvXgnHCmLOmZGJwjR4OstNXD05J6lCidfCaBvIILLmyvYWDjsVQHM=
X-Received: by 2002:adf:b781:: with SMTP id s1mr1181579wre.165.1630526030743;
 Wed, 01 Sep 2021 12:53:50 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Wed, 1 Sep 2021 19:53:34 +0000
X-Gmail-Original-Message-ID: <CAK8P3a0cc_d-NTemhNJzeSHgAwLcc31JB1AF61VDUH7FCTVDRg@mail.gmail.com>
Message-ID: <CAK8P3a0cc_d-NTemhNJzeSHgAwLcc31JB1AF61VDUH7FCTVDRg@mail.gmail.com>
Subject: [GIT PULL] asm-generic changes for 5.15
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 2734d6c1b1a089fb593ef6a23d4b70903526fe0c:

  Linux 5.14-rc2 (2021-07-18 14:13:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git
tags/asm-generic-5.15

for you to fetch changes up to 8f76f9c46952659dd925c21c3f62a0d05a3f3e71:

  bitops/non-atomic: make @nr unsigned to avoid any DIV (2021-08-14
13:07:42 +0200)

----------------------------------------------------------------
asm-generic changes for 5.15

The main content for 5.15 is a series that cleans up the handling of
strncpy_from_user() and strnlen_user(), removing a lot of slightly
incorrect versions of these in favor of the lib/strn*.c helpers
that implement these correctly and more efficiently.

The only architectures that retain a private version now are
mips, ia64, um and parisc. I had offered to convert those at all,
but Thomas Bogendoerfer wanted to keep the mips version for the
moment until he had a chance to do regression testing.

The branch also contains two patches for bitops and for ffs().

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Arnd Bergmann (10):
      asm-generic/uaccess.h: remove __strncpy_from_user/__strnlen_user
      h8300: remove stale strncpy_from_user
      hexagon: use generic strncpy/strnlen from_user
      arc: use generic strncpy/strnlen from_user
      csky: use generic strncpy/strnlen from_user
      microblaze: use generic strncpy/strnlen from_user
      asm-generic: uaccess: remove inline strncpy_from_user/strnlen_user
      asm-generic: remove extra strn{cpy_from,len}_user declarations
      asm-generic: reverse GENERIC_{STRNCPY_FROM,STRNLEN}_USER symbols
      Merge branch 'asm-generic-uaccess-7' of
git://git.kernel.org/.../arnd/asm-generic into asm-generic

Geert Uytterhoeven (1):
      asm-generic: ffs: Drop bogus reference to ffz location

Heiko Carstens (1):
      s390: use generic strncpy/strnlen from_user

Vineet Gupta (1):
      bitops/non-atomic: make @nr unsigned to avoid any DIV

 arch/alpha/Kconfig                        |   2 -
 arch/arc/include/asm/uaccess.h            |  72 -----------------
 arch/arc/mm/extable.c                     |  12 ---
 arch/arm/Kconfig                          |   2 -
 arch/arm64/Kconfig                        |   2 -
 arch/csky/include/asm/uaccess.h           |   6 --
 arch/csky/lib/usercopy.c                  | 102 ------------------------
 arch/h8300/kernel/h8300_ksyms.c           |   2 -
 arch/h8300/lib/Makefile                   |   2 +-
 arch/h8300/lib/strncpy.S                  |  35 ---------
 arch/hexagon/include/asm/uaccess.h        |  31 --------
 arch/hexagon/kernel/hexagon_ksyms.c       |   1 -
 arch/hexagon/mm/Makefile                  |   2 +-
 arch/hexagon/mm/strnlen_user.S            | 126 ------------------------------
 arch/ia64/Kconfig                         |   2 +
 arch/m68k/Kconfig                         |   2 -
 arch/microblaze/include/asm/uaccess.h     |  21 +----
 arch/microblaze/kernel/microblaze_ksyms.c |   1 -
 arch/microblaze/lib/uaccess_old.S         |  90 ---------------------
 arch/mips/Kconfig                         |   2 +
 arch/nds32/Kconfig                        |   2 -
 arch/nios2/Kconfig                        |   2 -
 arch/openrisc/Kconfig                     |   2 -
 arch/parisc/Kconfig                       |   2 +-
 arch/powerpc/Kconfig                      |   2 -
 arch/riscv/Kconfig                        |   2 -
 arch/s390/include/asm/uaccess.h           |  18 +----
 arch/s390/lib/uaccess.c                   |  52 ------------
 arch/sh/Kconfig                           |   2 -
 arch/sparc/Kconfig                        |   2 -
 arch/um/Kconfig                           |   2 +
 arch/um/include/asm/uaccess.h             |   5 +-
 arch/um/kernel/skas/uaccess.c             |  14 +++-
 arch/x86/Kconfig                          |   2 -
 arch/xtensa/Kconfig                       |   3 +-
 arch/xtensa/include/asm/uaccess.h         |   3 +-
 arch/xtensa/kernel/xtensa_ksyms.c         |   2 +-
 include/asm-generic/bitops/builtin-ffs.h  |   2 +-
 include/asm-generic/bitops/ffs.h          |   2 +-
 include/asm-generic/bitops/non-atomic.h   |  14 ++--
 include/asm-generic/uaccess.h             |  53 +++----------
 lib/Kconfig                               |  10 ++-
 42 files changed, 56 insertions(+), 657 deletions(-)
 delete mode 100644 arch/h8300/lib/strncpy.S
 delete mode 100644 arch/hexagon/mm/strnlen_user.S
