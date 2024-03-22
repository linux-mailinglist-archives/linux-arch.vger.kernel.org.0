Return-Path: <linux-arch+bounces-3105-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C94886DE5
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 14:56:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA4121F21F5E
	for <lists+linux-arch@lfdr.de>; Fri, 22 Mar 2024 13:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D400345BFC;
	Fri, 22 Mar 2024 13:56:37 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F5320DDB;
	Fri, 22 Mar 2024 13:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711115797; cv=none; b=VZ7HfOtrfpZZyExDsV5u8dIBAs7RAixa1kdSqOesGUbTD8FWY1mM9KOtlettH9nX5VIJZa6DfmWirhpHXAq6Xggorude4tJOiRo4mPBMZevPK5+wb5bSQXzy9kIAsTUzMykFuCp0PkpipYbpUu37xk2J17W59zCHwdwaOPNCTkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711115797; c=relaxed/simple;
	bh=Ejq6XsWxRwejHf2Ip37awA8RsMAYWh0XyVNSy+WBD60=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9r9kDgka+I5AilzmCrBel/cheQJgMDHlHbi2xSeC2G/h7+R79g3ZfcGR8nO6VzjqKJWAUyMV2DU9AbmhvACtO+TMU4i9Mj9y/YUwIeZ5d7LkP1wDfhXJsnT3aa8B/jhbDujSq+GN/kKnfPwiRdoQHrRpRRhTtqGJu6RytlI6+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC550C433C7;
	Fri, 22 Mar 2024 13:56:34 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.9
Date: Fri, 22 Mar 2024 21:56:19 +0800
Message-ID: <20240322135619.1423490-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit e8f897f4afef0031fe618a8e94127a0934896aba:

  Linux 6.8 (2024-03-10 13:38:09 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.9

for you to fetch changes up to fea1c949f6ca5059e12de00d0483645debc5b206:

  LoongArch/crypto: Clean up useless assignment operations (2024-03-19 15:50:34 +0800)

----------------------------------------------------------------
LoongArch changes for v6.9

1, Add objtool support for LoongArch;
2, Add ORC stack unwinder support for LoongArch;
3, Add kernel livepatching support for LoongArch;
4, Select ARCH_HAS_CURRENT_STACK_POINTER in Kconfig;
5, Select HAVE_ARCH_USERFAULTFD_MINOR in Kconfig;
6, Some bug fixes and other small changes.

Note: There are conflicts in arch/loongarch/Kconfig and arch/loongarch/
Makefile but can be simply fixed by adjusting context.

----------------------------------------------------------------
Huacai Chen (5):
      LoongArch: Select ARCH_HAS_CURRENT_STACK_POINTER in Kconfig
      LoongArch: Select HAVE_ARCH_USERFAULTFD_MINOR in Kconfig
      LoongArch: Change __my_cpu_offset definition to avoid mis-optimization
      LoongArch: Remove superfluous flush_dcache_page() definition
      LoongArch: Define the __io_aw() hook as mmiowb()

Jinyang He (1):
      LoongArch: Add kernel livepatching support

Max Kellermann (1):
      LoongArch: Move {dmw,tlb}_virt_to_page() definition to page.h

Tiezhu Yang (7):
      objtool/LoongArch: Enable objtool to be built
      objtool/LoongArch: Implement instruction decoder
      objtool/x86: Separate arch-specific and generic parts
      objtool/LoongArch: Enable orc to be built
      objtool: Check local label in add_dead_ends()
      objtool: Check local label in read_unwind_hints()
      LoongArch: Add ORC stack unwinder support

Yuli Wang (1):
      LoongArch/crypto: Clean up useless assignment operations

 arch/loongarch/Kconfig                             |   8 +
 arch/loongarch/Kconfig.debug                       |  11 +
 arch/loongarch/Makefile                            |  23 +-
 arch/loongarch/crypto/crc32-loongarch.c            |   2 -
 arch/loongarch/include/asm/Kbuild                  |   3 +
 arch/loongarch/include/asm/bug.h                   |   1 +
 arch/loongarch/include/asm/cacheflush.h            |   3 -
 arch/loongarch/include/asm/exception.h             |   2 +
 arch/loongarch/include/asm/io.h                    |   2 +
 arch/loongarch/include/asm/module.h                |   7 +
 arch/loongarch/include/asm/orc_header.h            |  18 +
 arch/loongarch/include/asm/orc_lookup.h            |  31 ++
 arch/loongarch/include/asm/orc_types.h             |  58 +++
 arch/loongarch/include/asm/page.h                  |   3 +
 arch/loongarch/include/asm/percpu.h                |   7 +-
 arch/loongarch/include/asm/pgtable.h               |   3 -
 arch/loongarch/include/asm/qspinlock.h             |  18 -
 arch/loongarch/include/asm/stackframe.h            |   3 +
 arch/loongarch/include/asm/thread_info.h           |   2 +
 arch/loongarch/include/asm/unwind.h                |  20 +-
 arch/loongarch/include/asm/unwind_hints.h          |  28 ++
 arch/loongarch/kernel/Makefile                     |   4 +
 arch/loongarch/kernel/entry.S                      |   5 +
 arch/loongarch/kernel/fpu.S                        |   7 +
 arch/loongarch/kernel/genex.S                      |   6 +
 arch/loongarch/kernel/lbt.S                        |   3 +
 arch/loongarch/kernel/mcount_dyn.S                 |   6 +
 arch/loongarch/kernel/module.c                     |  22 +-
 arch/loongarch/kernel/relocate_kernel.S            |   7 +-
 arch/loongarch/kernel/rethook_trampoline.S         |   1 +
 arch/loongarch/kernel/setup.c                      |   2 +
 arch/loongarch/kernel/stacktrace.c                 |  41 ++
 arch/loongarch/kernel/traps.c                      |  42 +-
 arch/loongarch/kernel/unwind_orc.c                 | 528 +++++++++++++++++++++
 arch/loongarch/kernel/vmlinux.lds.S                |   3 +
 arch/loongarch/kvm/switch.S                        |   9 +-
 arch/loongarch/lib/clear_user.S                    |   3 +
 arch/loongarch/lib/copy_user.S                     |   3 +
 arch/loongarch/lib/memcpy.S                        |   3 +
 arch/loongarch/lib/memset.S                        |   3 +
 arch/loongarch/mm/tlb.c                            |  27 +-
 arch/loongarch/mm/tlbex.S                          |   9 +
 arch/loongarch/vdso/Makefile                       |   1 +
 include/linux/compiler.h                           |   9 +
 scripts/Makefile                                   |   7 +-
 tools/arch/loongarch/include/asm/inst.h            | 161 +++++++
 tools/arch/loongarch/include/asm/orc_types.h       |  58 +++
 tools/include/linux/bitops.h                       |  11 +
 tools/objtool/Makefile                             |   4 +
 tools/objtool/arch/loongarch/Build                 |   3 +
 tools/objtool/arch/loongarch/decode.c              | 356 ++++++++++++++
 .../objtool/arch/loongarch/include/arch/cfi_regs.h |  22 +
 tools/objtool/arch/loongarch/include/arch/elf.h    |  30 ++
 .../objtool/arch/loongarch/include/arch/special.h  |  33 ++
 tools/objtool/arch/loongarch/orc.c                 | 171 +++++++
 tools/objtool/arch/loongarch/special.c             |  15 +
 tools/objtool/arch/x86/Build                       |   1 +
 tools/objtool/arch/x86/orc.c                       | 188 ++++++++
 tools/objtool/check.c                              |  52 +-
 tools/objtool/include/objtool/elf.h                |   1 +
 tools/objtool/include/objtool/orc.h                |  14 +
 tools/objtool/orc_dump.c                           |  69 +--
 tools/objtool/orc_gen.c                            | 113 +----
 63 files changed, 2040 insertions(+), 266 deletions(-)
 create mode 100644 arch/loongarch/include/asm/orc_header.h
 create mode 100644 arch/loongarch/include/asm/orc_lookup.h
 create mode 100644 arch/loongarch/include/asm/orc_types.h
 delete mode 100644 arch/loongarch/include/asm/qspinlock.h
 create mode 100644 arch/loongarch/include/asm/unwind_hints.h
 create mode 100644 arch/loongarch/kernel/unwind_orc.c
 create mode 100644 tools/arch/loongarch/include/asm/inst.h
 create mode 100644 tools/arch/loongarch/include/asm/orc_types.h
 create mode 100644 tools/objtool/arch/loongarch/Build
 create mode 100644 tools/objtool/arch/loongarch/decode.c
 create mode 100644 tools/objtool/arch/loongarch/include/arch/cfi_regs.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/elf.h
 create mode 100644 tools/objtool/arch/loongarch/include/arch/special.h
 create mode 100644 tools/objtool/arch/loongarch/orc.c
 create mode 100644 tools/objtool/arch/loongarch/special.c
 create mode 100644 tools/objtool/arch/x86/orc.c
 create mode 100644 tools/objtool/include/objtool/orc.h

