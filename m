Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5921A6A67D4
	for <lists+linux-arch@lfdr.de>; Wed,  1 Mar 2023 07:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjCAG6Y (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Mar 2023 01:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjCAG6Y (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Mar 2023 01:58:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10B9303DB;
        Tue, 28 Feb 2023 22:58:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4C970B80760;
        Wed,  1 Mar 2023 06:58:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81DD9C4339B;
        Wed,  1 Mar 2023 06:58:17 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.3
Date:   Wed,  1 Mar 2023 14:58:08 +0800
Message-Id: <20230301065808.2259768-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit c9c3395d5e3dcc6daee66c6908354d47bf98cb0c:

  Linux 6.2 (2023-02-19 14:24:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.3

for you to fetch changes up to 8883bf83127d533abb415b204eabc064863ae6c9:

  selftests/ftrace: Add LoongArch kprobe args string tests support (2023-02-25 22:12:18 +0800)

----------------------------------------------------------------
LoongArch changes for v6.3

1, Make -mstrict-align configurable;
2, Add kernel relocation and KASLR support;
3, Add single kernel image implementation for kdump;
4, Add hardware breakpoints/watchpoints support;
5, Add kprobes/kretprobes/kprobes_on_ftrace support;
6, Add LoongArch support for some selftests.

----------------------------------------------------------------
Huacai Chen (4):
      Merge 'pci/enumeration' into loongarch-next
      LoongArch: Make -mstrict-align configurable
      tools: Add LoongArch build infrastructure
      selftests/seccomp: Add LoongArch selftesting support

Jinyang He (1):
      LoongArch: Fix Chinese comma in cpu.h

Qing Zhang (5):
      LoongArch: Add hardware breakpoints/watchpoints support
      LoongArch: ptrace: Expose hardware breakpoints to debuggers
      LoongArch: ptrace: Add function argument access API
      LoongArch: ptrace: Add hardware single step support
      selftests/ftrace: Add LoongArch kprobe args string tests support

Tiezhu Yang (7):
      LoongArch: Only call get_timer_irq() once in constant_clockevent_init()
      LoongArch: Simulate branch and PC* instructions
      LoongArch: Add kprobes support
      LoongArch: Add kretprobes support
      LoongArch: Add kprobes on ftrace support
      LoongArch: Mark some assembler symbols as non-kprobe-able
      samples/kprobes: Add LoongArch support

Xi Ruoyao (1):
      LoongArch: Use la.pcrel instead of la.abs when it's trivially possible

Youling Tang (6):
      LoongArch: Add JUMP_VIRT_ADDR macro implementation to avoid using la.abs
      LoongArch: Add la_abs macro implementation
      LoongArch: Add support for kernel relocation
      LoongArch: Add support for kernel address space layout randomization (KASLR)
      LoongArch: kdump: Add single kernel image implementation
      LoongArch: kdump: Add crashkernel=YM handling

 arch/loongarch/Kconfig                             |  65 ++-
 arch/loongarch/Makefile                            |  14 +-
 arch/loongarch/configs/loongson3_defconfig         |   1 +
 arch/loongarch/include/asm/addrspace.h             |   2 +
 arch/loongarch/include/asm/asm.h                   |  10 +
 arch/loongarch/include/asm/asmmacro.h              |  17 +
 arch/loongarch/include/asm/cpu.h                   |   2 +-
 arch/loongarch/include/asm/hw_breakpoint.h         | 145 ++++++
 arch/loongarch/include/asm/inst.h                  |  58 +++
 arch/loongarch/include/asm/kprobes.h               |  61 +++
 arch/loongarch/include/asm/loongarch.h             |  35 +-
 arch/loongarch/include/asm/processor.h             |  16 +-
 arch/loongarch/include/asm/ptrace.h                |  39 ++
 arch/loongarch/include/asm/setup.h                 |  16 +
 arch/loongarch/include/asm/stackframe.h            |  13 +-
 arch/loongarch/include/asm/switch_to.h             |   1 +
 arch/loongarch/include/asm/uaccess.h               |   1 -
 arch/loongarch/include/uapi/asm/ptrace.h           |   9 +
 arch/loongarch/kernel/Makefile                     |   9 +-
 arch/loongarch/kernel/entry.S                      |  91 ++--
 arch/loongarch/kernel/ftrace_dyn.c                 |  64 +++
 arch/loongarch/kernel/genex.S                      |   8 +-
 arch/loongarch/kernel/head.S                       |  33 +-
 arch/loongarch/kernel/hw_breakpoint.c              | 548 +++++++++++++++++++++
 arch/loongarch/kernel/inst.c                       | 123 +++++
 arch/loongarch/kernel/kprobes.c                    | 406 +++++++++++++++
 arch/loongarch/kernel/kprobes_trampoline.S         |  96 ++++
 arch/loongarch/kernel/process.c                    |   7 +
 arch/loongarch/kernel/ptrace.c                     | 472 ++++++++++++++++++
 arch/loongarch/kernel/relocate.c                   | 242 +++++++++
 arch/loongarch/kernel/setup.c                      |  14 +-
 arch/loongarch/kernel/time.c                       |  11 +-
 arch/loongarch/kernel/traps.c                      |  68 ++-
 arch/loongarch/kernel/vmlinux.lds.S                |  20 +-
 arch/loongarch/lib/memcpy.S                        |   3 +
 arch/loongarch/lib/memmove.S                       |   4 +
 arch/loongarch/lib/memset.S                        |   3 +
 arch/loongarch/mm/fault.c                          |   3 +
 arch/loongarch/mm/tlbex.S                          |  17 +-
 arch/loongarch/power/suspend_asm.S                 |   5 +-
 drivers/pci/controller/pci-loongson.c              |  71 +--
 drivers/pci/pci.c                                  |  10 +
 drivers/pci/pcie/portdrv.c                         |  16 +-
 drivers/pci/probe.c                                |   2 +
 include/linux/pci.h                                |   1 +
 include/uapi/linux/elf.h                           |   2 +
 samples/kprobes/kprobe_example.c                   |   8 +
 .../arch/loongarch/include/uapi/asm/bitsperlong.h  |   9 +
 tools/scripts/Makefile.arch                        |  11 +-
 .../ftrace/test.d/kprobe/kprobe_args_string.tc     |   3 +
 .../ftrace/test.d/kprobe/kprobe_args_syntax.tc     |   4 +
 tools/testing/selftests/seccomp/seccomp_bpf.c      |   6 +
 52 files changed, 2728 insertions(+), 167 deletions(-)
 create mode 100644 arch/loongarch/include/asm/hw_breakpoint.h
 create mode 100644 arch/loongarch/include/asm/kprobes.h
 create mode 100644 arch/loongarch/kernel/hw_breakpoint.c
 create mode 100644 arch/loongarch/kernel/kprobes.c
 create mode 100644 arch/loongarch/kernel/kprobes_trampoline.S
 create mode 100644 arch/loongarch/kernel/relocate.c
 create mode 100644 tools/arch/loongarch/include/uapi/asm/bitsperlong.h
