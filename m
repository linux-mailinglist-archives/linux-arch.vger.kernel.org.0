Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A723F3BC52F
	for <lists+linux-arch@lfdr.de>; Tue,  6 Jul 2021 06:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhGFEUi (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 6 Jul 2021 00:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229550AbhGFEUi (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 6 Jul 2021 00:20:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3210A61973;
        Tue,  6 Jul 2021 04:17:56 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Arnd Bergmann <arnd@arndb.de>, Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Airlie <airlied@linux.ie>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-arch@vger.kernel.org, Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Chen Zhu <zhuchen@loongson.cn>
Subject: [PATCH 00/19] arch: Add basic LoongArch support
Date:   Tue,  6 Jul 2021 12:18:01 +0800
Message-Id: <20210706041820.1536502-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

LoongArch is a new RISC ISA, which is a bit like MIPS or RISC-V.
LoongArch includes a reduced 32-bit version (LA32R), a standard 32-bit
version (LA32S) and a 64-bit version (LA64). LoongArch use ACPI as its
boot protocol LoongArch-specific interrupt controllers (similar to APIC)
are already added in the next revision of ACPI Specification (current
revision is 6.4).

This patchset is adding basic LoongArch support in mainline kernel, we
can see a complete snapshot here:
https://github.com/loongson/linux/tree/loongarch-next

Cross-compile tool chain to build kernel:
https://github.com/loongson/build-tools/releases

Loongson and LoongArch documentations:
https://github.com/loongson/LoongArch-Documentation

LoongArch-specific interrupt controllers:
https://mantis.uefi.org/mantis/view.php?id=2203

Huacai Chen(19):
 LoongArch: Add elf-related definitions.
 LoongArch: Add writecombine support for drm.
 LoongArch: Add build infrastructure.
 LoongArch: Add common headers.
 LoongArch: Add boot and setup routines.
 LoongArch: Add exception/interrupt handling. 
 LoongArch: Add process management.
 LoongArch: Add memory management.
 LoongArch: Add system call support.
 LoongArch: Add signal handling support.
 LoongArch: Add elf and module support.
 LoongArch: Add misc common routines.
 LoongArch: Add some library functions.
 LoongArch: Add 64-bit Loongson platform.
 LoongArch: Add PCI controller support.
 LoongArch: Add VDSO and VSYSCALL support.
 LoongArch: Add multi-processor (SMP) support.
 LoongArch: Add Non-Uniform Memory Access (NUMA) support.
 LoongArch: Add Loongson-3 default config file.

Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Chen Zhu <zhuchen@loongson.cn> 
---
 drivers/irqchip/Kconfig                |  37 +++-
 drivers/irqchip/Makefile               |   3 +
 drivers/irqchip/irq-loongarch-cpu.c    |  87 ++++++++++
 drivers/irqchip/irq-loongson-eiointc.c | 308 +++++++++++++++++++++++++++++++++
 drivers/irqchip/irq-loongson-htvec.c   | 102 ++++++++++-
 drivers/irqchip/irq-loongson-liointc.c | 140 ++++++++++++++-
 drivers/irqchip/irq-loongson-pch-lpc.c | 204 ++++++++++++++++++++++
 drivers/irqchip/irq-loongson-pch-msi.c |  69 +++++++-
 drivers/irqchip/irq-loongson-pch-pic.c | 139 ++++++++++++++-
 include/linux/cpuhotplug.h             |   1 +
 10 files changed, 1069 insertions(+), 21 deletions(-)
 create mode 100644 drivers/irqchip/irq-loongarch-cpu.c
 create mode 100644 drivers/irqchip/irq-loongson-eiointc.c
 create mode 100644 drivers/irqchip/irq-loongson-pch-lpc.c
--
2.27.0

