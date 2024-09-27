Return-Path: <linux-arch+bounces-7473-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5120988709
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 16:23:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D55A71C22B4F
	for <lists+linux-arch@lfdr.de>; Fri, 27 Sep 2024 14:23:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57884763F8;
	Fri, 27 Sep 2024 14:23:31 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3614614F12F;
	Fri, 27 Sep 2024 14:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727447011; cv=none; b=dg266FcgnX5Zsa6o5BMEiQthl1vpGn4r78jyFxNGKewLZcClfRVWQsmbCeYDPD/FFZTS6SVwUQTY9YT8Il9jkcz3CsWVSJxHjkWqyQxTOLTRn70qd36W+FEWdWyYXv1cLfqi8hpphSKhl/QvJJP2wA0TqUDDtc7TBHprmE8avGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727447011; c=relaxed/simple;
	bh=vZVcEquTtnYPwFtD+4TH174hT+xLT0cLj3Pdtypzeg8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FVv8urq1bFAhncMfNL+bC8NIJ2tcWpEuJYEfNCiVtxXoBT9Dw2m7+7qB+HED9FmhotcsU9Hyq6LpDENYVS/LQrrr/nk/LXQC57SBqT/2XI1tjRtTIf55QtWmS7JsiktxJXenLNK0R8/6MbotgBU2OUZT78CrDXhy4xdK61m5Mhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAB11C4CEC4;
	Fri, 27 Sep 2024 14:23:28 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch changes for v6.12
Date: Fri, 27 Sep 2024 22:23:20 +0800
Message-ID: <20240927142320.2144898-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 98f7e32f20d28ec452afb208f9cffc08448a2652:

  Linux 6.11 (2024-09-15 16:57:56 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.12

for you to fetch changes up to f339bd3b51dac675fbbc08b861d2371ae3df0c0b:

  Docs/LoongArch: Add advanced extended IRQ model description (2024-09-24 15:32:20 +0800)

----------------------------------------------------------------
LoongArch changes for v6.12

1, Fix objtool about do_syscall() and Clang;
2, Enable generic CPU vulnerabilites support;
3, Enable ACPI BGRT handling;
4, Rework CPU feature probe from CPUCFG/IOCSR;
5, Add ARCH_HAS_SET_MEMORY support;
6, Add ARCH_HAS_SET_DIRECT_MAP support;
7, Improve hardware page table walker;
8, Simplify _percpu_read() and _percpu_write();
9, Add advanced extended IRQ model documentions;
10, Some bug fixes and other small changes.

----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Enable ACPI BGRT handling

Huacai Chen (5):
      Merge tag 'irq-core-2024-09-16' into loongarch-next
      LoongArch: Add ARCH_HAS_SET_MEMORY support
      LoongArch: Add ARCH_HAS_SET_DIRECT_MAP support
      LoongArch: Improve hardware page table walker
      Docs/LoongArch: Add advanced extended IRQ model description

Jiaxun Yang (1):
      LoongArch: Rework CPU feature probe from CPUCFG/IOCSR

Tiezhu Yang (5):
      objtool: Handle frame pointer related instructions
      LoongArch: Enable objtool for Clang
      LoongArch: Set AS_HAS_THIN_ADD_SUB as y if AS_IS_LLVM
      LoongArch: Remove STACK_FRAME_NON_STANDARD(do_syscall)
      LoongArch: Enable generic CPU vulnerabilites support

Uros Bizjak (1):
      LoongArch: Simplify _percpu_read() and _percpu_write()

Wentao Guan (1):
      LoongArch: Fix memleak in pci_acpi_scan_root()

Xi Ruoyao (1):
      LoongArch: Remove posix_types.h include from sigcontext.h

 Documentation/arch/loongarch/irq-chip-model.rst    |  32 +++
 .../zh_CN/arch/loongarch/irq-chip-model.rst        |  32 +++
 arch/loongarch/Kconfig                             |   7 +-
 arch/loongarch/include/asm/atomic.h                |   2 +
 arch/loongarch/include/asm/cpu-features.h          |   2 +
 arch/loongarch/include/asm/cpu.h                   |  30 +--
 arch/loongarch/include/asm/loongarch.h             |   1 +
 arch/loongarch/include/asm/mmu_context.h           |  35 +++-
 arch/loongarch/include/asm/percpu.h                | 124 ++++--------
 arch/loongarch/include/asm/pgtable.h               |  32 ++-
 arch/loongarch/include/asm/set_memory.h            |  21 ++
 arch/loongarch/include/uapi/asm/hwcap.h            |   1 +
 arch/loongarch/include/uapi/asm/sigcontext.h       |   1 -
 arch/loongarch/kernel/acpi.c                       |   4 +
 arch/loongarch/kernel/cpu-probe.c                  | 120 +++++++-----
 arch/loongarch/kernel/proc.c                       |  10 +-
 arch/loongarch/kernel/syscall.c                    |   4 -
 arch/loongarch/mm/Makefile                         |   3 +-
 arch/loongarch/mm/fault.c                          |  41 ++++
 arch/loongarch/mm/pageattr.c                       | 218 +++++++++++++++++++++
 arch/loongarch/pci/acpi.c                          |   1 +
 drivers/acpi/Kconfig                               |   2 +-
 tools/objtool/arch/loongarch/decode.c              |  11 +-
 tools/objtool/check.c                              |  23 ++-
 tools/objtool/include/objtool/elf.h                |   1 +
 25 files changed, 565 insertions(+), 193 deletions(-)
 create mode 100644 arch/loongarch/include/asm/set_memory.h
 create mode 100644 arch/loongarch/mm/pageattr.c

