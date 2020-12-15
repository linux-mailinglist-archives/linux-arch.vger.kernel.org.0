Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89EC22DB067
	for <lists+linux-arch@lfdr.de>; Tue, 15 Dec 2020 16:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbgLOPqJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 15 Dec 2020 10:46:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:39528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730362AbgLOPqD (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 15 Dec 2020 10:46:03 -0500
X-Gm-Message-State: AOAM5318oAPDTF/GCiDb3odXnzac/zHvTRHDLh/MrhcSkQNVMA2+drqX
        P2mvKb+fsiUbgCMpZykzIs+S5DGtQAm32dMr4Qw=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608047122;
        bh=QTh0dq0IKFJzZGoUOlijvtl8SwB6Ay5nsOGTMDFuA8A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=aLNGzGQjYnozrLteVLOWmR3aD9em5FFmBRYRgy8KjYBRSaqjFHjKllTUMUOCqgSgn
         fC7HfOcxv/AVrjYBqRHfZD4vsCOKxH4BH7BLuBlDBQQWX8Hl6hf5ArR6CMeuSdhRla
         mn0PhHTslWB+gJy1zLH0dsv4feZLbtRjyeoiv27c2rIalGKtWMgj5EFeYLEsDPnpGW
         vIs2AzLRdXuKiS7tT9xzHvNoIgdTh61dI4tvfV9xMj7etXIp/NTz/lcMsGiAQSI6Ar
         WovXuSjYYAzFYEVL44lTZ/2h05HFkTQKI5fSjdelyHn7or0Wv7bU6wDTr9iWZ9I9dZ
         4d4LLbGSCedLg==
X-Google-Smtp-Source: ABdhPJwFTJvtUZ6mYAY0JSTT1KEoinXr0++GrxUHrZqL6jjwSOuCW6Bm388Bw7fbGiRUDwIFWjFxGITYg5ksFVzib/U=
X-Received: by 2002:a05:6830:2413:: with SMTP id j19mr14954543ots.251.1608047121854;
 Tue, 15 Dec 2020 07:45:21 -0800 (PST)
MIME-Version: 1.0
References: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0b0u9NQ1unjQfwBJovahQYNgNj1ROLGR+TzZWKnzQgzQ@mail.gmail.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Tue, 15 Dec 2020 16:45:05 +0100
X-Gmail-Original-Message-ID: <CAK8P3a237baPabD-Z=A46Wo0D0brL7am3cbQO7ot4r+nFt62Vg@mail.gmail.com>
Message-ID: <CAK8P3a237baPabD-Z=A46Wo0D0brL7am3cbQO7ot4r+nFt62Vg@mail.gmail.com>
Subject: [GIT PULL 2/3] asm-generic: mmu-context cleanup
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
tags/asm-generic-mmu-context-5.11

for you to fetch changes up to c3634425ff9454510876a26e9e9738788bb88abd:

  h8300: Fix generic mmu_context build (2020-11-16 16:53:52 +0100)

----------------------------------------------------------------
asm-generic: mmu-context cleanup

This is a cleanup series from Nicholas Piggin, preparing for
later changes. The asm/mmu_context.h header are generalized
and common code moved to asm-gneneric/mmu_context.h.

This saves a bit of code and makes it easier to change in
the future.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

----------------------------------------------------------------
Geert Uytterhoeven (1):
      m68k: mmu_context: Fix Sun-3 build

Nicholas Piggin (24):
      asm-generic: add generic MMU versions of mmu context functions
      alpha: use asm-generic/mmu_context.h for no-op implementations
      arc: use asm-generic/mmu_context.h for no-op implementations
      arm: use asm-generic/mmu_context.h for no-op implementations
      arm64: use asm-generic/mmu_context.h for no-op implementations
      csky: use asm-generic/mmu_context.h for no-op implementations
      hexagon: use asm-generic/mmu_context.h for no-op implementations
      ia64: use asm-generic/mmu_context.h for no-op implementations
      m68k: use asm-generic/mmu_context.h for no-op implementations
      microblaze: use asm-generic/mmu_context.h for no-op implementations
      mips: use asm-generic/mmu_context.h for no-op implementations
      nds32: use asm-generic/mmu_context.h for no-op implementations
      nios2: use asm-generic/mmu_context.h for no-op implementations
      openrisc: use asm-generic/mmu_context.h for no-op implementations
      parisc: use asm-generic/mmu_context.h for no-op implementations
      powerpc: use asm-generic/mmu_context.h for no-op implementations
      riscv: use asm-generic/mmu_context.h for no-op implementations
      s390: use asm-generic/mmu_context.h for no-op implementations
      sh: use asm-generic/mmu_context.h for no-op implementations
      sparc: use asm-generic/mmu_context.h for no-op implementations
      um: use asm-generic/mmu_context.h for no-op implementations
      x86: use asm-generic/mmu_context.h for no-op implementations
      xtensa: use asm-generic/mmu_context.h for no-op implementations
      h8300: Fix generic mmu_context build

 arch/alpha/include/asm/mmu_context.h         | 12 ++----
 arch/arc/include/asm/mmu_context.h           | 17 ++++----
 arch/arm/include/asm/mmu_context.h           | 26 ++-----------
 arch/arm64/include/asm/mmu_context.h         |  8 ++--
 arch/c6x/include/asm/mmu_context.h           |  6 +++
 arch/csky/include/asm/mmu_context.h          |  8 ++--
 arch/h8300/include/asm/mmu_context.h         |  6 +++
 arch/hexagon/include/asm/mmu_context.h       | 33 +++-------------
 arch/ia64/include/asm/mmu_context.h          | 17 ++------
 arch/m68k/include/asm/mmu_context.h          | 38 +++++-------------
 arch/microblaze/include/asm/mmu_context.h    |  2 +-
 arch/microblaze/include/asm/mmu_context_mm.h |  8 ++--
 arch/microblaze/include/asm/processor.h      |  3 --
 arch/mips/include/asm/mmu_context.h          | 11 ++----
 arch/nds32/include/asm/mmu_context.h         | 10 +----
 arch/nios2/include/asm/mmu_context.h         | 21 ++--------
 arch/openrisc/include/asm/mmu_context.h      |  8 ++--
 arch/parisc/include/asm/mmu_context.h        | 12 +++---
 arch/powerpc/include/asm/mmu_context.h       | 13 ++++---
 arch/riscv/include/asm/mmu_context.h         | 22 +----------
 arch/s390/include/asm/mmu_context.h          |  9 ++---
 arch/sh/include/asm/mmu_context.h            |  7 ++--
 arch/sh/include/asm/mmu_context_32.h         |  9 -----
 arch/sparc/include/asm/mmu_context_32.h      | 10 ++---
 arch/sparc/include/asm/mmu_context_64.h      | 10 ++---
 arch/um/include/asm/mmu_context.h            | 12 +++---
 arch/x86/include/asm/mmu_context.h           |  6 +++
 arch/xtensa/include/asm/mmu_context.h        | 11 ++----
 arch/xtensa/include/asm/nommu_context.h      | 26 +------------
 include/asm-generic/mmu_context.h            | 58 +++++++++++++++++++++-------
 include/asm-generic/nommu_context.h          | 19 +++++++++
 31 files changed, 182 insertions(+), 276 deletions(-)
 create mode 100644 arch/c6x/include/asm/mmu_context.h
 create mode 100644 arch/h8300/include/asm/mmu_context.h
 create mode 100644 include/asm-generic/nommu_context.h
