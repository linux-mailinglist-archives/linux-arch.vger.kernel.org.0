Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9B323DEBC
	for <lists+linux-arch@lfdr.de>; Thu,  6 Aug 2020 19:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbgHFR3M (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 6 Aug 2020 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729894AbgHFRAf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 6 Aug 2020 13:00:35 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89F17C0A8884;
        Thu,  6 Aug 2020 07:10:49 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k3gbU-00AXNn-TC; Thu, 06 Aug 2020 14:10:45 +0000
Date:   Thu, 6 Aug 2020 15:10:44 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [git pull] regset work
Message-ID: <20200806141044.GP1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	regset API changes.  Regularize copy_regset_{to,from}_user() callers,
switch to saner calling conventions for ->get(), kill user_regset_copyout().
->put() side of things will have to wait for the next cycle, unfortunately.
The series had been posted (l-k, linux-arch) and sat in -next for weeks.
The balance is about -1KLoC and replacements for ->get() instances are a lot
saner.

	Two trivial conflicts - one in arch/x86/include/asm/fpu/xstate.h
(obvious merge), another in arch/x86/kernel/fpu/xstate.c (the variant from
this branch is the right one).

The following changes since commit b3a9e3b9622ae10064826dccb4f7a52bd88c7407:

  Linux 5.8-rc1 (2020-06-14 12:45:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.regset

for you to fetch changes up to ce327e1c54119179066d6f3573a28001febc9265:

  regset: kill user_regset_copyout{,_zero}() (2020-07-27 14:31:13 -0400)

----------------------------------------------------------------
Al Viro (42):
      x86: copy_fpstate_to_sigframe(): have fpregs_soft_get() use kernel buffer
      x86: kill dump_fpu()
      [ia64] sanitize elf_access_gpreg()
      [ia64] teach elf_access_reg() to handle the missing range (r16..r31)
      [ia64] regularize do_gpregs_[gs]et()
      [ia64] access_uarea(): stop bothering with gpregs_[gs]et()
      [ia64] access_uarea(): don't bother with fpregs_[gs]et()
      sparc64: switch genregs32_get() to use of get_from_target()
      sparc32: get rid of odd callers of copy_regset_to_user()
      sparc64: get rid of odd callers of copy_regset_to_user()
      arm64: take fetching compat reg out of pt_regs into a new helper
      arm64: get rid of copy_regset_to_user() in compat_ptrace_read_user()
      arm64: sanitize compat_ptrace_write_user()
      sparc32: get rid of odd callers of copy_regset_from_user()
      sparc64: get rid of odd callers of copy_regset_from_user()
      introduction of regset ->get() wrappers, switching ELF coredumps to those
      Merge branches 'regset.x86', 'regset.ia64', 'regset.sparc' and 'regset.arm64' into work.regset
      copy_regset_to_user(): do all copyout at once.
      regset: new method and helpers for it
      x86: switch to ->regset_get()
      powerpc: switch to ->regset_get()
      s390: switch to ->regset_get()
      sparc: switch to ->regset_get()
      mips: switch to ->regset_get()
      arm64: switch to ->regset_get()
      sh: convert to ->regset_get()
      arm: switch to ->regset_get()
      arc: switch to ->regset_get()
      ia64: switch to ->regset_get()
      c6x: switch to ->regset_get()
      riscv: switch to ->regset_get()
      openrisc: switch to ->regset_get()
      h8300: switch to ->regset_get()
      hexagon: switch to ->regset_get()
      nios2: switch to ->regset_get()
      nds32: switch to ->regset_get()
      parisc: switch to ->regset_get()
      xtensa: switch to ->regset_get()
      csky: switch to ->regset_get()
      regset: kill ->get()
      regset(): kill ->get_size()
      regset: kill user_regset_copyout{,_zero}()

 arch/arc/kernel/ptrace.c                    | 148 +++----
 arch/arm/kernel/ptrace.c                    |  52 +--
 arch/arm64/kernel/ptrace.c                  | 303 +++++---------
 arch/c6x/kernel/ptrace.c                    |  11 +-
 arch/csky/kernel/ptrace.c                   |  24 +-
 arch/h8300/kernel/ptrace.c                  |  17 +-
 arch/hexagon/kernel/ptrace.c                |  62 +--
 arch/ia64/kernel/ptrace.c                   | 396 +++++++------------
 arch/mips/kernel/ptrace.c                   | 204 +++-------
 arch/nds32/kernel/ptrace.c                  |   9 +-
 arch/nios2/kernel/ptrace.c                  |  51 +--
 arch/openrisc/kernel/ptrace.c               |  26 +-
 arch/parisc/kernel/ptrace.c                 |  84 +---
 arch/powerpc/kernel/ptrace/ptrace-altivec.c |  37 +-
 arch/powerpc/kernel/ptrace/ptrace-decl.h    |  44 +--
 arch/powerpc/kernel/ptrace/ptrace-novsx.c   |   5 +-
 arch/powerpc/kernel/ptrace/ptrace-spe.c     |  16 +-
 arch/powerpc/kernel/ptrace/ptrace-tm.c      | 152 +++----
 arch/powerpc/kernel/ptrace/ptrace-view.c    | 185 ++++-----
 arch/powerpc/kernel/ptrace/ptrace-vsx.c     |  13 +-
 arch/riscv/kernel/ptrace.c                  |  33 +-
 arch/s390/kernel/ptrace.c                   | 199 +++-------
 arch/sh/kernel/process_32.c                 |   5 +-
 arch/sh/kernel/ptrace_32.c                  |  48 +--
 arch/sparc/kernel/ptrace_32.c               | 269 +++++++------
 arch/sparc/kernel/ptrace_64.c               | 591 ++++++++++++++--------------
 arch/x86/include/asm/fpu/internal.h         |   1 -
 arch/x86/include/asm/fpu/regset.h           |   4 +-
 arch/x86/include/asm/fpu/xstate.h           |   4 +-
 arch/x86/kernel/fpu/regset.c                |  55 +--
 arch/x86/kernel/fpu/signal.c                |  13 +-
 arch/x86/kernel/fpu/xstate.c                | 164 ++------
 arch/x86/kernel/ptrace.c                    |  75 ++--
 arch/x86/kernel/tls.c                       |  32 +-
 arch/x86/kernel/tls.h                       |   2 +-
 arch/x86/math-emu/fpu_entry.c               |  19 +-
 arch/xtensa/kernel/ptrace.c                 |  16 +-
 fs/binfmt_elf.c                             |  54 ++-
 include/linux/regset.h                      | 218 +++-------
 kernel/Makefile                             |   2 +-
 kernel/regset.c                             |  76 ++++
 41 files changed, 1370 insertions(+), 2349 deletions(-)
 create mode 100644 kernel/regset.c
