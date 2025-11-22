Return-Path: <linux-arch+bounces-15034-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF7EC7C620
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 05:36:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D431534E70D
	for <lists+linux-arch@lfdr.de>; Sat, 22 Nov 2025 04:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E451C5D77;
	Sat, 22 Nov 2025 04:36:53 +0000 (UTC)
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CE381AF;
	Sat, 22 Nov 2025 04:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763786212; cv=none; b=IUnWATJzSsXBX0wDjPRVXhEByMcLxcZ19rNp8N1FVnhQ07F5ddwrmhwnUWUwpMGAB41aThE9ATNMC2+9kETiuw2SAzRaoEUWXGJnjt+W2lTRg1atlLMtpWYAXMR45l6yo2FmuKXdcSzXaIBHnLfjucNfJOSQHW0OgImHPWLx1Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763786212; c=relaxed/simple;
	bh=wGWi0X1zodLG/pY/JPIQlrFC8AXePZkLSrTTn1X2uMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ufiIquNgYsKEIdiW/bPgEKzSzWncnC4SDNxSpjNeJ59ef+Hbn0YdtAc0y/KMSW1G0lSZ3lKOARxMcbAPBU+Y/NAvecg7gH1CuRITCI4KRScFEpgW4drpmiWXSsz5xOvGIPxEJD1ylLIOZXqnYuTGoaZ6ANRwOmfSZMURFgd+wq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63134C4CEF5;
	Sat, 22 Nov 2025 04:36:49 +0000 (UTC)
From: Huacai Chen <chenhuacai@loongson.cn>
To: Arnd Bergmann <arnd@arndb.de>,
	Huacai Chen <chenhuacai@kernel.org>
Cc: loongarch@lists.linux.dev,
	linux-arch@vger.kernel.org,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Guo Ren <guoren@kernel.org>,
	Xuerui Wang <kernel@xen0n.name>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	linux-kernel@vger.kernel.org,
	Huacai Chen <chenhuacai@loongson.cn>,
	Yawei Li <liyawei@loongson.cn>
Subject: [PATCH V3 00/14] LoongArch: Add basic LoongArch32 support
Date: Sat, 22 Nov 2025 12:36:20 +0800
Message-ID: <20251122043634.3447854-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch32 mainly use FDT
(but ACPI is also an alternative) as its boot protocol which is already
supported in LoongArch64. LoongArch32's ILP32 ABI use the same calling
convention as LoongArch64.

Although 32-bit systems are experiencing declining adoption in general
computing, LoongArch32 remains highly relevant within specific niches.
Beyond embedded applications, several vendors are actively developing
application-level LoongArch32 processors. Loongson, for example, has
released two open-source reference hardware implementations: openLA500
and openLA1000 [6].

The architecture also holds considerable educational value, having been
integrated into China's national computer architecture curricula and
embedded systems courses. Additionally, the National Student Computer
System Capability Challenge (NSCSCC) [1] features LoongArch32 CPUs, where
hundreds of students design Linux-capable hardware implementations and
compete on performance. This initiative has resulted in several exciting
high-performance LoongArch32 cores, including LainCore[2], Wired[3],
NOP-Core[4], NagiCore[5]....

From an upstream perspective, we will largely reuse the infrastructure
already established for LoongArch64, ensuring that the maintenance burden
remains minimal.

[1]: https://www.tsinghua.edu.cn/en/info/1245/13802.htm
[2]: https://github.com/LainChip/LainCore
[3]: https://github.com/gmlayer0/wired
[4]: https://github.com/NOP-Processor/NOP-Core
[5]: https://github.com/MrAMS/NagiCore
[6]: https://gitee.com/loongson-edu

This patchset is adding basic LoongArch32 support in mainline kernel, it
is the successor of Jiaxun Yang's previous work (V1):
https://lore.kernel.org/loongarch/20250102-la32-uapi-v1-0-db32aa769b88@flygoat.com/

We can see a complete snapshot here:
https://github.com/chenhuacai/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/sunhaiyong1978/Yongbao-Embedded/releases/download/0.13-2025.9.3/loongarch32-unknown-linux-gnu-gcc-0.13-20251105.x86_64.tar.xz

A CLFS-based Linux distro (Yongbao):
https://github.com/sunhaiyong1978/Yongbao-Embedded/releases/download/0.13-2025.9.3/loongarch32-Yongbao-Embedded-0.13-20251018-sysroot.tar.xz

Open-source tool chain which is under review (Also in maillist for upstream):
https://github.com/cloudspurs/binutils-gdb/tree/la32/
https://github.com/cloudspurs/gcc/tree/la32/
https://github.com/cloudspurs/glibc/tree/la32/

LA32 QEMU emulator (hardware is not as widely used as LA64):
https://github.com/loongson-community/qemu/tree/la32-user-exp/

Usage:
1. Extract Yongbao to a virtual disk (la32.img);
2. qemu-system-loongarch -kernel vmlinux -append "rw root=/dev/vda console=ttyS0,115200" \
   -m 256M -cpu max32 -machine virt,accel=tcg -drive file=la32.img,format=raw,if=virtio -display none -serial stdio

V1 -> V2:
1, Rebased on 6.18-rc6;
2, Port a full runnable kernel (except irqchip drivers);
3, Remove controversial flush_icache syscall for now.

V2 -> V3:
1, Fix 64bit build issues;
2, Fix cpuinfo display issues;
3, Split pci.c changes as a separate patch;
4, Adjust default config files;
5, Update commit messages;
6, Add Arnd's Reviewed-by tags.

Jiaxun Yang, Yawei Li and Huacai Chen(14):
 LoongArch: Add atomic operations for 32BIT/64BIT;
 LoongArch: Add adaptive CSR accessors for 32BIT/64BIT;
 LoongArch: Adjust common macro definitions for 32BIT/64BIT;
 LoongArch: Adjust boot & setup for 32BIT/64BIT;
 LoongArch: Adjust memory management for 32BIT/64BIT;
 LoongArch: Adjust process management for 32BIT/64BIT;
 LoongArch: Adjust time routines for 32BIT/64BIT;
 LoongArch: Adjust module loader for 32BIT/64BIT;
 LoongArch: Adjust system call for 32BIT/64BIT;
 LoongArch: Adjust user accessors for 32BIT/64BIT;
 LoongArch: Adjust misc routines for 32BIT/64BIT;
 LoongArch: Adjust VDSO/VSYSCALL for 32BIT/64BIT;
 LoongArch: Adjust default config files for 32BIT/64BIT;
 LoongArch: Adjust build infrastructure for 32BIT/64BIT.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Yawei Li <liyawei@loongson.cn>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
---
 arch/loongarch/Kconfig                             |  117 ++-
 arch/loongarch/Makefile                            |   29 +-
 arch/loongarch/boot/Makefile                       |    6 +
 arch/loongarch/configs/loongson32_defconfig        | 1104 ++++++++++++++++++++
 .../{loongson3_defconfig => loongson64_defconfig}  |    6 +-
 arch/loongarch/include/asm/Kbuild                  |    1 +
 arch/loongarch/include/asm/addrspace.h             |   15 +-
 arch/loongarch/include/asm/asm.h                   |   77 +-
 arch/loongarch/include/asm/asmmacro.h              |  117 ++-
 arch/loongarch/include/asm/atomic-amo.h            |  206 ++++
 arch/loongarch/include/asm/atomic-llsc.h           |  100 ++
 arch/loongarch/include/asm/atomic.h                |  197 +---
 arch/loongarch/include/asm/checksum.h              |    4 +
 arch/loongarch/include/asm/cmpxchg.h               |   48 +-
 arch/loongarch/include/asm/cpu-features.h          |    3 -
 arch/loongarch/include/asm/elf.h                   |    1 +
 arch/loongarch/include/asm/inst.h                  |   12 +-
 arch/loongarch/include/asm/irq.h                   |    5 +
 arch/loongarch/include/asm/jump_label.h            |   12 +-
 arch/loongarch/include/asm/local.h                 |   37 +
 arch/loongarch/include/asm/loongarch.h             |  102 +-
 arch/loongarch/include/asm/module.h                |   11 +
 arch/loongarch/include/asm/page.h                  |    2 +-
 arch/loongarch/include/asm/percpu.h                |   44 +-
 arch/loongarch/include/asm/pgtable-bits.h          |   36 +-
 arch/loongarch/include/asm/pgtable.h               |   74 +-
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
 arch/loongarch/kernel/module.c                     |   80 +-
 arch/loongarch/kernel/proc.c                       |   10 +-
 arch/loongarch/kernel/process.c                    |    6 +-
 arch/loongarch/kernel/ptrace.c                     |    5 +
 arch/loongarch/kernel/relocate.c                   |    9 +-
 arch/loongarch/kernel/switch.S                     |   25 +-
 arch/loongarch/kernel/syscall.c                    |   15 +-
 arch/loongarch/kernel/time.c                       |   31 +-
 arch/loongarch/kernel/traps.c                      |   15 +-
 arch/loongarch/kernel/unaligned.c                  |   30 +-
 arch/loongarch/kernel/vmlinux.lds.S                |    7 +-
 arch/loongarch/kvm/Kconfig                         |    2 +-
 arch/loongarch/kvm/vcpu.c                          |    5 +-
 arch/loongarch/lib/Makefile                        |    5 +-
 arch/loongarch/lib/clear_user.S                    |   22 +-
 arch/loongarch/lib/copy_user.S                     |   28 +-
 arch/loongarch/lib/dump_tlb.c                      |   14 +-
 arch/loongarch/lib/unaligned.S                     |   72 +-
 arch/loongarch/mm/init.c                           |    4 +-
 arch/loongarch/mm/page.S                           |  118 +--
 arch/loongarch/mm/tlb.c                            |   12 +-
 arch/loongarch/mm/tlbex.S                          |  322 ++++--
 arch/loongarch/power/hibernate.c                   |    6 +-
 arch/loongarch/power/suspend.c                     |   24 +-
 arch/loongarch/power/suspend_asm.S                 |   72 +-
 arch/loongarch/vdso/Makefile                       |    7 +-
 arch/loongarch/vdso/vdso.lds.S                     |    4 +-
 arch/loongarch/vdso/vgetcpu.c                      |    8 +
 drivers/firmware/efi/libstub/Makefile              |    1 +
 drivers/firmware/efi/libstub/loongarch.c           |    8 +-
 drivers/pci/controller/Kconfig                     |    2 +-
 lib/crc/Kconfig                                    |    2 +-
 74 files changed, 2912 insertions(+), 777 deletions(-)
 create mode 100644 arch/loongarch/configs/loongson32_defconfig
 rename arch/loongarch/configs/{loongson3_defconfig => loongson64_defconfig} (99%)
 create mode 100644 arch/loongarch/include/asm/atomic-amo.h
 create mode 100644 arch/loongarch/include/asm/atomic-llsc.h
--
2.27.0


