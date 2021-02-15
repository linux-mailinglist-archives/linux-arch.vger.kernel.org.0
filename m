Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6799531C070
	for <lists+linux-arch@lfdr.de>; Mon, 15 Feb 2021 18:25:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232314AbhBORYw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Feb 2021 12:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbhBORXi (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 15 Feb 2021 12:23:38 -0500
X-Greylist: delayed 1218 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 15 Feb 2021 09:22:56 PST
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66E56C0613D6
        for <linux-arch@vger.kernel.org>; Mon, 15 Feb 2021 09:22:56 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lBhGX-00EJ5M-IB; Mon, 15 Feb 2021 17:02:29 +0000
Date:   Mon, 15 Feb 2021 17:02:29 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: [git pull] saner ELF compat handling
Message-ID: <YCqpJZxNrb7+O8Ns@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

	Sanitizing ELF compat support, especially for triarch architectures:
* X32 handling cleaned up
* MIPS64 uses compat_binfmt_elf.c both for O32 and N32 now
* Kconfig side of things regularized
	Eventually I hope to have compat_binfmt_elf.c killed, with
both native and compat built from fs/binfmt_elf.c, with -DELF_BITS={64,32}
passed by kbuild, but that's a separate story - not included here.
	Sat in -next for the entire cycle, no problems reported...

The following changes since commit 698222457465ce343443be81c5512edda86e5914:

  MIPS: Fix malformed NT_FILE and NT_SIGINFO in 32bit coredumps (2020-12-28 23:26:17 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git work.elf-compat

for you to fetch changes up to e565d89e4aa07e3f20ac5e8757b1da24b5878e69:

  get rid of COMPAT_ELF_EXEC_PAGESIZE (2021-01-06 08:42:51 -0500)

----------------------------------------------------------------
Al Viro (14):
      binfmt_elf: partially sanitize PRSTATUS_SIZE and SET_PR_FPVALID
      elf_prstatus: collect the common part (everything before pr_reg) into a struct
      [amd64] clean PRSTATUS_SIZE/SET_PR_FPVALID up properly
      x32: make X32, !IA32_EMULATION setups able to execute x32 binaries
      Merge remote-tracking branch 'mips/mips-fixes' into work.elf-compat
      mips binfmt_elf*32.c: use elfcore-compat.h
      mips: kill unused definitions in binfmt_elf[on]32.c
      mips: KVM_GUEST makes no sense for 64bit builds...
      mips compat: don't bother with ELF_ET_DYN_BASE
      mips: don't bother with ELF_CORE_EFLAGS
      mips compat: switch to compat_binfmt_elf.c
      Kconfig: regularize selection of CONFIG_BINFMT_ELF
      compat_binfmt_elf: don't bother with undef of ELF_ARCH
      get rid of COMPAT_ELF_EXEC_PAGESIZE

 arch/Kconfig                               |   3 +
 arch/arm64/Kconfig                         |   1 -
 arch/ia64/kernel/crash.c                   |   2 +-
 arch/mips/Kconfig                          |   8 +-
 arch/mips/include/asm/elf.h                |  56 +++++---------
 arch/mips/include/asm/elfcore-compat.h     |  29 ++++++++
 arch/mips/kernel/Makefile                  |   4 +-
 arch/mips/kernel/binfmt_elfn32.c           | 113 ----------------------------
 arch/mips/kernel/binfmt_elfo32.c           | 116 -----------------------------
 arch/mips/kernel/scall64-n64.S             |   2 +-
 arch/parisc/Kconfig                        |   1 -
 arch/powerpc/Kconfig                       |   1 -
 arch/powerpc/platforms/powernv/opal-core.c |   6 +-
 arch/s390/Kconfig                          |   1 -
 arch/s390/kernel/crash_dump.c              |   2 +-
 arch/sparc/Kconfig                         |   1 -
 arch/x86/Kconfig                           |   2 +-
 arch/x86/include/asm/compat.h              |  11 ---
 arch/x86/include/asm/elf.h                 |   2 +-
 arch/x86/include/asm/elfcore-compat.h      |  31 ++++++++
 fs/Kconfig.binfmt                          |   2 +-
 fs/binfmt_elf.c                            |  21 +++---
 fs/binfmt_elf_fdpic.c                      |  22 ++----
 fs/compat_binfmt_elf.c                     |   7 +-
 include/linux/elfcore-compat.h             |  15 +++-
 include/linux/elfcore.h                    |   7 +-
 kernel/kexec_core.c                        |   2 +-
 27 files changed, 129 insertions(+), 339 deletions(-)
 create mode 100644 arch/mips/include/asm/elfcore-compat.h
 delete mode 100644 arch/mips/kernel/binfmt_elfn32.c
 delete mode 100644 arch/mips/kernel/binfmt_elfo32.c
 create mode 100644 arch/x86/include/asm/elfcore-compat.h
