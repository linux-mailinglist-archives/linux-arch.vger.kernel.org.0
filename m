Return-Path: <linux-arch+bounces-15342-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA8BCB63C4
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 15:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E849303B2C1
	for <lists+linux-arch@lfdr.de>; Thu, 11 Dec 2025 14:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9D9256C6D;
	Thu, 11 Dec 2025 14:43:00 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91A5275B0F;
	Thu, 11 Dec 2025 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464180; cv=none; b=OV17hMWvYH6IesanJDx/EaqIBR21L3o/6ZxwtJuLuVRRS2fm2bosMaIbzbPIOwXy2JH2RkIi+qSrmE7N2nX3LS9bXTxyzNL3+djMtTTE3YNIu7BSFLT4Sx6x//9q8BWvmAfcoKMZ4en09Jra8Kh+mVLS2aMw50/mfaejFCYBEAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464180; c=relaxed/simple;
	bh=VY9EjX2PJsbDTAqmYEZVlNCobfg+kabT2DMzb63a5co=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WKyBjZwN84+x2ptW4dCaOPo97vr6wjoTiN1NxVCp3I6ZQ04o2/3qb8b0omZIWTgIPhdiCj6NYxjPPravG22hKOoSWF0Ox/sExDji0Z2LZPAzU85yh8qK0jXXzFlp/l1D81FjF2N42SqubfHoYdHOaQ568dZMzAHnqIl69TVpuyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.219])
	by gateway (Coremail) with SMTP id _____8Cxbb9n2DppQVotAA--.31007S3;
	Thu, 11 Dec 2025 22:42:47 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.219])
	by front1 (Coremail) with SMTP id qMiowJBxD8JW2Dppmi1IAQ--.1472S2;
	Thu, 11 Dec 2025 22:42:41 +0800 (CST)
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
Subject: [GIT PULL] LoongArch changes for v6.19
Date: Thu, 11 Dec 2025 22:42:19 +0800
Message-ID: <20251211144219.2282231-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowJBxD8JW2Dppmi1IAQ--.1472S2
X-CM-SenderInfo: hfkh0x5xdftxo6or00hjvr0hdfq/
X-Coremail-Antispam: 1Uk129KBj93XoWxtF45ur4DWr17Ar47XFWUAwc_yoWxGw1fpF
	9xZrnrJF48Grn3Awnrt3s8ur1DAryxGr12q3WayFy8CF47ZryUZr1kJr97XFyUt395JrW0
	qr1rG34aqF4kJwbCm3ZEXasCq-sJn29KB7ZKAUJUUUUx529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUB2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
	AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1I6r4UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUcbAwUUUUU

The following changes since commit 7d0a66e4bb9081d75c82ec4957c50034cb0ea449:

  Linux 6.18 (2025-11-30 14:42:10 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.19

for you to fetch changes up to be77cf43d2fd6eca150594e997e40ca7df90f251:

  LoongArch: Adjust default config files for 32BIT/64BIT (2025-12-08 18:09:17 +0800)

----------------------------------------------------------------
LoongArch changes for v6.19

1, Add basic LoongArch32 support;
2, Select HAVE_ARCH_BITREVERSE in Kconfig;
3, Fix build and boot for CONFIG_RANDSTRUCT;
4, Correct the calculation logic of thread_count;
5, Some bug fixes and other small changes.

Note: Build infrastructures of LoongArch32 are not enabled yet, because
we need to adjust irqchip drivers and wait for GNU toolchain be upstream
first.

----------------------------------------------------------------
Huacai Chen (16):
      LoongArch: Fix build errors for CONFIG_RANDSTRUCT
      LoongArch: Fix arch_dup_task_struct() for CONFIG_RANDSTRUCT
      LoongArch: Add new PCI ID for pci_fixup_vgadev()
      LoongArch: Add atomic operations for 32BIT/64BIT
      LoongArch: Add adaptive CSR accessors for 32BIT/64BIT
      LoongArch: Adjust common macro definitions for 32BIT/64BIT
      LoongArch: Adjust boot & setup for 32BIT/64BIT
      LoongArch: Adjust memory management for 32BIT/64BIT
      LoongArch: Adjust process management for 32BIT/64BIT
      LoongArch: Adjust time routines for 32BIT/64BIT
      LoongArch: Adjust module loader for 32BIT/64BIT
      LoongArch: Adjust system call for 32BIT/64BIT
      LoongArch: Adjust user accessors for 32BIT/64BIT
      LoongArch: Adjust misc routines for 32BIT/64BIT
      LoongArch: Adjust VDSO/VSYSCALL for 32BIT/64BIT
      LoongArch: Adjust default config files for 32BIT/64BIT

Qiang Ma (1):
      LoongArch: Correct the calculation logic of thread_count

Song Gao (1):
      LoongArch: Add and use some macros for AVEC

Tiezhu Yang (1):
      LoongArch: Use unsigned long for _end and _text

Xi Ruoyao (2):
      LoongArch: Select HAVE_ARCH_BITREVERSE in Kconfig
      LoongArch: Simplify __arch_bitrev32() implementation

Yuli Wang (1):
      LoongArch: Use __pmd()/__pte() for swap entry conversions

 arch/loongarch/Kconfig                             |    5 +
 arch/loongarch/Makefile                            |    7 +-
 arch/loongarch/configs/loongson32_defconfig        | 1105 ++++++++++++++++++++
 .../{loongson3_defconfig => loongson64_defconfig}  |    7 +-
 arch/loongarch/include/asm/Kbuild                  |    1 +
 arch/loongarch/include/asm/addrspace.h             |   15 +-
 arch/loongarch/include/asm/asm.h                   |   77 +-
 arch/loongarch/include/asm/asmmacro.h              |  118 ++-
 arch/loongarch/include/asm/atomic-amo.h            |  206 ++++
 arch/loongarch/include/asm/atomic-llsc.h           |  100 ++
 arch/loongarch/include/asm/atomic.h                |  197 +---
 arch/loongarch/include/asm/bitops.h                |   11 +
 arch/loongarch/include/asm/bitrev.h                |    2 +-
 arch/loongarch/include/asm/checksum.h              |    4 +
 arch/loongarch/include/asm/cmpxchg.h               |   48 +-
 arch/loongarch/include/asm/cpu-features.h          |    3 -
 arch/loongarch/include/asm/dmi.h                   |    2 +-
 arch/loongarch/include/asm/elf.h                   |   31 +
 arch/loongarch/include/asm/inst.h                  |   12 +-
 arch/loongarch/include/asm/irq.h                   |   12 +
 arch/loongarch/include/asm/jump_label.h            |   12 +-
 arch/loongarch/include/asm/local.h                 |   37 +
 arch/loongarch/include/asm/loongarch.h             |  102 +-
 arch/loongarch/include/asm/module.h                |   11 +
 arch/loongarch/include/asm/page.h                  |    2 +-
 arch/loongarch/include/asm/percpu.h                |   44 +-
 arch/loongarch/include/asm/pgtable-bits.h          |   36 +-
 arch/loongarch/include/asm/pgtable.h               |   79 +-
 arch/loongarch/include/asm/stackframe.h            |   34 +-
 arch/loongarch/include/asm/string.h                |    2 +
 arch/loongarch/include/asm/timex.h                 |   33 +-
 arch/loongarch/include/asm/uaccess.h               |   63 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h     |    4 +
 arch/loongarch/include/uapi/asm/Kbuild             |    1 +
 arch/loongarch/include/uapi/asm/ptrace.h           |   10 +
 arch/loongarch/include/uapi/asm/unistd.h           |    6 +
 arch/loongarch/kernel/Makefile.syscalls            |    1 +
 arch/loongarch/kernel/cpu-probe.c                  |   13 +-
 arch/loongarch/kernel/efi-header.S                 |    4 +
 arch/loongarch/kernel/efi.c                        |    4 +-
 arch/loongarch/kernel/entry.S                      |   22 +-
 arch/loongarch/kernel/env.c                        |    5 +-
 arch/loongarch/kernel/fpu.S                        |  111 ++
 arch/loongarch/kernel/head.S                       |   39 +-
 arch/loongarch/kernel/module-sections.c            |    1 +
 arch/loongarch/kernel/module.c                     |  204 +++-
 arch/loongarch/kernel/proc.c                       |   10 +-
 arch/loongarch/kernel/process.c                    |   11 +-
 arch/loongarch/kernel/ptrace.c                     |    5 +
 arch/loongarch/kernel/relocate.c                   |   13 +-
 arch/loongarch/kernel/setup.c                      |    8 +-
 arch/loongarch/kernel/switch.S                     |   28 +-
 arch/loongarch/kernel/syscall.c                    |   15 +-
 arch/loongarch/kernel/time.c                       |   31 +-
 arch/loongarch/kernel/traps.c                      |   15 +-
 arch/loongarch/kernel/unaligned.c                  |   30 +-
 arch/loongarch/kvm/vcpu.c                          |    5 +-
 arch/loongarch/lib/bswapdi.c                       |   13 +
 arch/loongarch/lib/bswapsi.c                       |   13 +
 arch/loongarch/lib/clear_user.S                    |   22 +-
 arch/loongarch/lib/copy_user.S                     |   28 +-
 arch/loongarch/lib/dump_tlb.c                      |   14 +-
 arch/loongarch/lib/unaligned.S                     |   72 +-
 arch/loongarch/mm/init.c                           |    4 +-
 arch/loongarch/mm/page.S                           |  118 +--
 arch/loongarch/mm/tlb.c                            |   12 +-
 arch/loongarch/mm/tlbex.S                          |  322 ++++--
 arch/loongarch/pci/pci.c                           |    2 +
 arch/loongarch/power/hibernate.c                   |    6 +-
 arch/loongarch/power/platform.c                    |    4 +-
 arch/loongarch/power/suspend.c                     |   24 +-
 arch/loongarch/power/suspend_asm.S                 |   72 +-
 arch/loongarch/vdso/Makefile                       |    7 +-
 arch/loongarch/vdso/vdso.lds.S                     |    4 +-
 arch/loongarch/vdso/vgetcpu.c                      |    8 +
 drivers/firmware/efi/libstub/loongarch.c           |    8 +-
 drivers/irqchip/irq-loongarch-avec.c               |    5 +-
 77 files changed, 3001 insertions(+), 771 deletions(-)
 create mode 100644 arch/loongarch/configs/loongson32_defconfig
 rename arch/loongarch/configs/{loongson3_defconfig => loongson64_defconfig} (99%)
 create mode 100644 arch/loongarch/include/asm/atomic-amo.h
 create mode 100644 arch/loongarch/include/asm/atomic-llsc.h
 create mode 100644 arch/loongarch/lib/bswapdi.c
 create mode 100644 arch/loongarch/lib/bswapsi.c


