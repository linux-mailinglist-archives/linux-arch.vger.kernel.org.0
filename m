Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9C4B6F6C6F
	for <lists+linux-arch@lfdr.de>; Thu,  4 May 2023 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbjEDMyw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 4 May 2023 08:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjEDMyv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 4 May 2023 08:54:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112D610DE;
        Thu,  4 May 2023 05:54:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 80E6763403;
        Thu,  4 May 2023 12:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C39C433D2;
        Thu,  4 May 2023 12:54:44 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.4
Date:   Thu,  4 May 2023 20:54:09 +0800
Message-Id: <20230504125409.2444851-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

The following changes since commit 457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.4

for you to fetch changes up to 2fa5ebe3bc4e31e07a99196455498472417842f2:

  tools/perf: Add basic support for LoongArch (2023-05-01 17:19:59 +0800)

----------------------------------------------------------------
LoongArch changes for v6.4

1, Better backtraces for humanization;
2, Relay BCE exceptions to userland as SIGSEGV;
3, Provide kernel fpu functions;
4, Optimize memory ops (memset/memcpy/memmove);
5, Optimize checksum and crc32(c) calculation;
6, Add ARCH_HAS_FORTIFY_SOURCE selection;
7, Add function error injection support;
8, Add ftrace with direct call support;
9, Add basic perf tools support.

Note: There are merge conflicts in these files but can be simply fixed
by adjusting context around "static struct ftrace_ops direct":

  samples/ftrace/ftrace-direct-modify.c
  samples/ftrace/ftrace-direct-too.c
  samples/ftrace/ftrace-direct.c

----------------------------------------------------------------
Bibo Mao (1):
      LoongArch: Add checksum optimization for 64-bit system

Huacai Chen (3):
      Merge 'irq/loongarch-fixes-6.4' into loongarch-next
      LoongArch: Provide kernel fpu functions
      tools/perf: Add basic support for LoongArch

Jianmin Lv (5):
      irqchip/loongson-eiointc: Fix returned value on parsing MADT
      irqchip/loongson-eiointc: Fix incorrect use of acpi_get_vec_parent
      irqchip/loongson-eiointc: Fix registration of syscore_ops
      irqchip/loongson-pch-pic: Fix registration of syscore_ops
      irqchip/loongson-pch-pic: Fix pch_pic_acpi_init calling

Min Zhou (1):
      LoongArch: crypto: Add crc32 and crc32c hw acceleration

Qing Zhang (2):
      LoongArch: Add ARCH_HAS_FORTIFY_SOURCE selection
      LoongArch: ftrace: Abstract DYNAMIC_FTRACE_WITH_ARGS accesses

Tiezhu Yang (1):
      LoongArch: Add support for function error injection

WANG Rui (1):
      LoongArch: Optimize memory ops (memset/memcpy/memmove)

WANG Xuerui (12):
      LoongArch: Clean up the architectural interrupt definitions
      LoongArch: Define regular names for BCE/WATCH/HVC/GSPR exceptions
      LoongArch: Print GPRs with ABI names when showing registers
      LoongArch: Print symbol info for $ra and CSR.ERA only for kernel-mode contexts
      LoongArch: Fix format of CSR lines during show_regs()
      LoongArch: Humanize the CRMD line when showing registers
      LoongArch: Humanize the PRMD line when showing registers
      LoongArch: Humanize the EUEN line when showing registers
      LoongArch: Humanize the ECFG line when showing registers
      LoongArch: Humanize the ESTAT line when showing registers
      LoongArch: Tweak the BADV and CPUCFG.PRID lines in show_regs()
      LoongArch: Relay BCE exceptions to userland as SIGSEGV with si_code=SEGV_BNDERR

Youling Tang (4):
      LoongArch: ftrace: Fix build error if DYNAMIC_FTRACE_WITH_REGS is not set
      LoongArch: ftrace: Implement ftrace_find_callable_addr() to simplify code
      LoongArch: ftrace: Add direct call support
      LoongArch: ftrace: Add direct call trampoline samples support

 arch/loongarch/Kconfig                             |   5 +
 arch/loongarch/Makefile                            |   2 +
 arch/loongarch/crypto/Kconfig                      |  14 +
 arch/loongarch/crypto/Makefile                     |   6 +
 arch/loongarch/crypto/crc32-loongarch.c            | 304 ++++++++++++++++++++
 arch/loongarch/include/asm/checksum.h              |  66 +++++
 arch/loongarch/include/asm/fpu.h                   |   3 +
 arch/loongarch/include/asm/ftrace.h                |  37 +++
 arch/loongarch/include/asm/inst.h                  |  26 ++
 arch/loongarch/include/asm/loongarch.h             |  57 ++--
 arch/loongarch/include/asm/ptrace.h                |   5 +
 arch/loongarch/kernel/Makefile                     |   2 +-
 arch/loongarch/kernel/ftrace_dyn.c                 | 128 +++++----
 arch/loongarch/kernel/genex.S                      |   1 +
 arch/loongarch/kernel/irq.c                        |   2 +-
 arch/loongarch/kernel/kfpu.c                       |  43 +++
 arch/loongarch/kernel/mcount_dyn.S                 |  13 +-
 arch/loongarch/kernel/perf_event.c                 |   2 +-
 arch/loongarch/kernel/time.c                       |   2 +-
 arch/loongarch/kernel/traps.c                      | 318 ++++++++++++++++++---
 arch/loongarch/lib/Makefile                        |   4 +-
 arch/loongarch/lib/clear_user.S                    | 136 ++++++++-
 arch/loongarch/lib/copy_user.S                     | 251 ++++++++++++----
 arch/loongarch/lib/csum.c                          | 141 +++++++++
 arch/loongarch/lib/error-inject.c                  |  10 +
 arch/loongarch/lib/memcpy.S                        | 147 ++++++++--
 arch/loongarch/lib/memmove.S                       | 120 ++++----
 arch/loongarch/lib/memset.S                        | 116 ++++++--
 crypto/Kconfig                                     |   3 +
 drivers/irqchip/irq-loongson-eiointc.c             |  32 ++-
 drivers/irqchip/irq-loongson-pch-pic.c             |   6 +-
 samples/ftrace/ftrace-direct-modify.c              |  34 +++
 samples/ftrace/ftrace-direct-multi-modify.c        |  41 +++
 samples/ftrace/ftrace-direct-multi.c               |  25 ++
 samples/ftrace/ftrace-direct-too.c                 |  27 ++
 samples/ftrace/ftrace-direct.c                     |  23 ++
 tools/arch/loongarch/include/uapi/asm/perf_regs.h  |  40 +++
 tools/arch/loongarch/include/uapi/asm/unistd.h     |   9 +
 tools/perf/Makefile.config                         |  12 +-
 tools/perf/arch/loongarch/Build                    |   1 +
 tools/perf/arch/loongarch/Makefile                 |  28 ++
 tools/perf/arch/loongarch/annotate/instructions.c  |  45 +++
 .../arch/loongarch/entry/syscalls/mksyscalltbl     |  61 ++++
 .../perf/arch/loongarch/include/dwarf-regs-table.h |  16 ++
 tools/perf/arch/loongarch/include/perf_regs.h      |  15 +
 tools/perf/arch/loongarch/util/Build               |   5 +
 tools/perf/arch/loongarch/util/dwarf-regs.c        |  44 +++
 tools/perf/arch/loongarch/util/perf_regs.c         |   6 +
 tools/perf/arch/loongarch/util/unwind-libdw.c      |  56 ++++
 tools/perf/arch/loongarch/util/unwind-libunwind.c  |  82 ++++++
 tools/perf/check-headers.sh                        |   1 +
 tools/perf/util/annotate.c                         |   8 +
 tools/perf/util/dwarf-regs.c                       |   7 +
 tools/perf/util/env.c                              |   2 +
 tools/perf/util/genelf.h                           |   3 +
 tools/perf/util/perf_regs.c                        |  76 +++++
 tools/perf/util/syscalltbl.c                       |   4 +
 57 files changed, 2364 insertions(+), 309 deletions(-)
 create mode 100644 arch/loongarch/crypto/Kconfig
 create mode 100644 arch/loongarch/crypto/Makefile
 create mode 100644 arch/loongarch/crypto/crc32-loongarch.c
 create mode 100644 arch/loongarch/include/asm/checksum.h
 create mode 100644 arch/loongarch/kernel/kfpu.c
 create mode 100644 arch/loongarch/lib/csum.c
 create mode 100644 arch/loongarch/lib/error-inject.c
 create mode 100644 tools/arch/loongarch/include/uapi/asm/perf_regs.h
 create mode 100644 tools/arch/loongarch/include/uapi/asm/unistd.h
 create mode 100644 tools/perf/arch/loongarch/Build
 create mode 100644 tools/perf/arch/loongarch/Makefile
 create mode 100644 tools/perf/arch/loongarch/annotate/instructions.c
 create mode 100755 tools/perf/arch/loongarch/entry/syscalls/mksyscalltbl
 create mode 100644 tools/perf/arch/loongarch/include/dwarf-regs-table.h
 create mode 100644 tools/perf/arch/loongarch/include/perf_regs.h
 create mode 100644 tools/perf/arch/loongarch/util/Build
 create mode 100644 tools/perf/arch/loongarch/util/dwarf-regs.c
 create mode 100644 tools/perf/arch/loongarch/util/perf_regs.c
 create mode 100644 tools/perf/arch/loongarch/util/unwind-libdw.c
 create mode 100644 tools/perf/arch/loongarch/util/unwind-libunwind.c
