Return-Path: <linux-arch+bounces-5554-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2A39390EE
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 16:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8332EB2085C
	for <lists+linux-arch@lfdr.de>; Mon, 22 Jul 2024 14:48:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0815916D9A5;
	Mon, 22 Jul 2024 14:48:34 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D324D16B74D;
	Mon, 22 Jul 2024 14:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659713; cv=none; b=nuSNmWOK3JjoczE2Q8UJi6SAvFL6mcJYbFanP3ePWq7qFM95pQyn4feDUrpoTMieBd1BecMSsCrvwLIr6j0Shs71B5yp89llqD0RLfJ44EuTLljWqvvDvb1kZ0cP+iNZ6e+MpHsNBPapNDric0aAivA9ZDjvdE7K70cIHiqHN5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659713; c=relaxed/simple;
	bh=cuzDDnA3GBV7pB5L/CiGYs8DablqcIWcQ3YQbmqoty0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pK1xQscqyWJl3VI3DkKq4JXosTwD3Y6dGceqBUKwMgZcrkoaiQsDeNhu/g4zENEvdcYhwUimUa3TLmMRIlVOMYqzty5felWo5nSj3mEh3s+TvaL7g0B42anhKGDQ4Wt96aYybKhxiusVRZlspFEKVTtydedifX5sUgS0hkVUzAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0280C116B1;
	Mon, 22 Jul 2024 14:48:30 +0000 (UTC)
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
Subject: [GIT PULL] LoongArch changes for v6.11
Date: Mon, 22 Jul 2024 22:48:22 +0800
Message-ID: <20240722144822.4040791-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The following changes since commit 0c3836482481200ead7b416ca80c68a29cfdaabd:

  Linux 6.10 (2024-07-14 15:43:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.11

for you to fetch changes up to 998b17d4440b8559a8bf4926e86f493101995519:

  LoongArch: Make the users of larch_insn_gen_break() constant (2024-07-20 22:41:07 +0800)

----------------------------------------------------------------
LoongArch changes for v6.11

1, Define __ARCH_WANT_NEW_STAT in unistd.h;
2, Always enumerate MADT and setup logical-physical CPU mapping;
3, Add irq_work support via self IPIs;
4, Add RANDOMIZE_KSTACK_OFFSET support;
5, Add ARCH_HAS_PTE_DEVMAP support;
6, Add ARCH_HAS_DEBUG_VM_PGTABLE support;
7, Add writecombine support for DMW-based ioremap();
8, Add architectural preparation for CPUFreq;
9, Add ACPI standard hardware register based S3 support;
10, Add support for relocating the kernel with RELR relocation;
11, Some bug fixes and other small changes.

----------------------------------------------------------------
Huacai Chen (10):
      Merge tag 'asm-generic-6.11' into loongarch-next
      LoongArch: Define __ARCH_WANT_NEW_STAT in unistd.h
      LoongArch: Always enumerate MADT and setup logical-physical CPU mapping
      LoongArch: Add irq_work support via self IPIs
      LoongArch: Add ARCH_HAS_PTE_DEVMAP support
      LoongArch: Add ARCH_HAS_DEBUG_VM_PGTABLE support
      LoongArch: Add writecombine support for DMW-based ioremap()
      LoongArch: Add architectural preparation for CPUFreq
      LoongArch: Automatically disable KASLR for hibernation
      LoongArch: Use correct API to map cmdline in relocate_kernel()

Jiaxun Yang (1):
      LoongArch: Add ACPI standard hardware register based S3 support

Jinjie Ruan (1):
      LoongArch: Add RANDOMIZE_KSTACK_OFFSET support

Oleg Nesterov (1):
      LoongArch: Make the users of larch_insn_gen_break() constant

Tiezhu Yang (1):
      LoongArch: Check TIF_LOAD_WATCH to enable user space watchpoint

WANG Rui (1):
      LoongArch: Use rustc option -Zdirect-access-external-data

Xi Ruoyao (2):
      LoongArch: Remove a redundant checking in relocator
      LoongArch: Add support for relocating the kernel with RELR relocation

 .../debug/debug-vm-pgtable/arch-support.txt        |  2 +-
 arch/loongarch/Kconfig                             |  5 +++
 arch/loongarch/Makefile                            |  3 +-
 arch/loongarch/include/asm/addrspace.h             |  4 ++
 arch/loongarch/include/asm/asmmacro.h              |  1 +
 arch/loongarch/include/asm/hardirq.h               |  3 +-
 arch/loongarch/include/asm/inst.h                  |  3 ++
 arch/loongarch/include/asm/io.h                    | 10 ++++-
 arch/loongarch/include/asm/irq_work.h              | 10 +++++
 arch/loongarch/include/asm/loongarch.h             | 13 +++++-
 arch/loongarch/include/asm/pgtable-bits.h          |  6 ++-
 arch/loongarch/include/asm/pgtable.h               | 19 ++++++++
 arch/loongarch/include/asm/setup.h                 |  5 +++
 arch/loongarch/include/asm/smp.h                   |  2 +
 arch/loongarch/include/asm/stackframe.h            | 11 +++++
 arch/loongarch/include/asm/unistd.h                |  1 +
 arch/loongarch/include/asm/uprobes.h               |  4 +-
 arch/loongarch/kernel/Makefile.syscalls            |  3 +-
 arch/loongarch/kernel/acpi.c                       | 22 ++++++---
 arch/loongarch/kernel/head.S                       | 11 +----
 arch/loongarch/kernel/hw_breakpoint.c              |  2 +-
 arch/loongarch/kernel/kprobes.c                    |  4 +-
 arch/loongarch/kernel/paravirt.c                   |  6 +++
 arch/loongarch/kernel/ptrace.c                     |  3 ++
 arch/loongarch/kernel/relocate.c                   | 52 ++++++++++++++++++++--
 arch/loongarch/kernel/setup.c                      |  4 +-
 arch/loongarch/kernel/smp.c                        | 21 +++++++--
 arch/loongarch/kernel/syscall.c                    | 22 ++++++++-
 arch/loongarch/kernel/vmlinux.lds.S                |  8 ++++
 arch/loongarch/power/platform.c                    | 37 ++++++++++++---
 arch/loongarch/power/suspend_asm.S                 |  8 +---
 drivers/firmware/efi/libstub/loongarch.c           |  2 +
 32 files changed, 256 insertions(+), 51 deletions(-)
 create mode 100644 arch/loongarch/include/asm/irq_work.h

