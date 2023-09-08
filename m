Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F2AF79864E
	for <lists+linux-arch@lfdr.de>; Fri,  8 Sep 2023 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242014AbjIHLLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 8 Sep 2023 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242334AbjIHLLb (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 8 Sep 2023 07:11:31 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B01FC4;
        Fri,  8 Sep 2023 04:11:23 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA41C433CA;
        Fri,  8 Sep 2023 11:11:20 +0000 (UTC)
From:   Huacai Chen <chenhuacai@loongson.cn>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     loongarch@lists.linux.dev, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Xuerui Wang <kernel@xen0n.name>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: [GIT PULL] LoongArch changes for v6.6
Date:   Fri,  8 Sep 2023 19:10:53 +0800
Message-Id: <20230908111053.1660033-1-chenhuacai@loongson.cn>
X-Mailer: git-send-email 2.39.3
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

The following changes since commit 2dde18cd1d8fac735875f2e4987f11817cc0bc2c:

  Linux 6.5 (2023-08-27 14:49:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/chenhuacai/linux-loongson.git tags/loongarch-6.6

for you to fetch changes up to 671eae93ae2090d2df01d810d354cab05f6bed8b:

  LoongArch: Update Loongson-3 default config file (2023-09-07 12:06:20 +0800)

----------------------------------------------------------------
LoongArch changes for v6.6

1, Allow usage of LSX/LASX in the kernel;
2, Add SIMD-optimized RAID5/RAID6 routines;
3, Add Loongson Binary Translation (LBT) extension support;
4, Add basic KGDB & KDB support;
5, Add building with kcov coverage;
6, Add KFENCE (Kernel Electric-Fence) support;
7, Add KASAN (Kernel Address Sanitizer) support;
8, Some bug fixes and other small changes;
9, Update the default config file.

Note: There is a conflicts in arch/loongarch/mm/pgtable.c but can be
simply fixed by adjusting context.

----------------------------------------------------------------
Bibo Mao (3):
      LoongArch: Code improvements in function pcpu_populate_pte()
      LoongArch: mm: Introduce unified function populate_kernel_pte()
      LoongArch: Use static defined zero page rather than allocated

Enze Li (4):
      kfence: Defer the assignment of the local variable addr
      LoongArch: mm: Add page table mapped mode support for virt_to_page()
      LoongArch: Get partial stack information when providing regs parameter
      LoongArch: Add KFENCE (Kernel Electric-Fence) support

Feiyang Chen (2):
      LoongArch: Provide kaslr_offset() to get kernel offset
      LoongArch: Allow building with kcov coverage

Hongchen Zhang (1):
      LoongArch: mm: Add p?d_leaf() definitions

Huacai Chen (4):
      Merge tag 'md-next-20230814-resend' into loongarch-next
      LoongArch: Remove shm_align_mask and use SHMLBA instead
      LoongArch: Allow usage of LSX/LASX in the kernel
      LoongArch: Update Loongson-3 default config file

Nathan Chancellor (1):
      LoongArch: Drop unused parse_r and parse_v macros

Qi Hu (1):
      LoongArch: Add Loongson Binary Translation (LBT) extension support

Qing Zhang (5):
      LoongArch: Add basic KGDB & KDB support
      kasan: Add __HAVE_ARCH_SHADOW_MAP to support arch specific mapping
      kasan: Add (pmd|pud)_init for LoongArch zero_(pud|p4d)_populate process
      LoongArch: Simplify the processing of jumping new kernel for KASLR
      LoongArch: Add KASAN (Kernel Address Sanitizer) support

Tiezhu Yang (1):
      LoongArch: Define symbol 'fault' as a local label in fpu.S

WANG Xuerui (3):
      LoongArch: Add SIMD-optimized XOR routines
      raid6: Add LoongArch SIMD syndrome calculation
      raid6: Add LoongArch SIMD recovery implementation

Weihao Li (1):
      LoongArch: Adjust {copy, clear}_user exception handler behavior

 Documentation/dev-tools/kasan.rst                  |   4 +-
 .../features/debug/KASAN/arch-support.txt          |   2 +-
 Documentation/features/debug/kcov/arch-support.txt |   2 +-
 Documentation/features/debug/kgdb/arch-support.txt |   2 +-
 .../translations/zh_CN/dev-tools/kasan.rst         |   2 +-
 arch/loongarch/Kconfig                             |  26 +
 arch/loongarch/Makefile                            |   3 +
 arch/loongarch/configs/loongson3_defconfig         |  74 ++-
 arch/loongarch/include/asm/asm-prototypes.h        |   1 +
 arch/loongarch/include/asm/asmmacro.h              | 158 ++---
 arch/loongarch/include/asm/kasan.h                 | 126 ++++
 arch/loongarch/include/asm/kfence.h                |  61 ++
 arch/loongarch/include/asm/kgdb.h                  |  97 +++
 arch/loongarch/include/asm/lbt.h                   | 109 +++
 arch/loongarch/include/asm/loongarch.h             |  47 +-
 arch/loongarch/include/asm/mmzone.h                |   2 -
 arch/loongarch/include/asm/page.h                  |   7 +-
 arch/loongarch/include/asm/pgalloc.h               |   1 +
 arch/loongarch/include/asm/pgtable.h               |  31 +-
 arch/loongarch/include/asm/processor.h             |  26 +-
 arch/loongarch/include/asm/setup.h                 |   8 +-
 arch/loongarch/include/asm/stackframe.h            |   4 +
 arch/loongarch/include/asm/string.h                |  20 +
 arch/loongarch/include/asm/switch_to.h             |   2 +
 arch/loongarch/include/asm/thread_info.h           |   4 +
 arch/loongarch/include/asm/xor.h                   |  68 ++
 arch/loongarch/include/asm/xor_simd.h              |  34 +
 arch/loongarch/include/uapi/asm/ptrace.h           |   6 +
 arch/loongarch/include/uapi/asm/sigcontext.h       |  10 +
 arch/loongarch/kernel/Makefile                     |   9 +
 arch/loongarch/kernel/asm-offsets.c                |  18 +-
 arch/loongarch/kernel/cpu-probe.c                  |  14 +
 arch/loongarch/kernel/entry.S                      |   5 +
 arch/loongarch/kernel/fpu.S                        |  14 +-
 arch/loongarch/kernel/head.S                       |  13 +-
 arch/loongarch/kernel/kfpu.c                       |  55 +-
 arch/loongarch/kernel/kgdb.c                       | 727 +++++++++++++++++++++
 arch/loongarch/kernel/lbt.S                        | 155 +++++
 arch/loongarch/kernel/numa.c                       |  35 +-
 arch/loongarch/kernel/process.c                    |  15 +-
 arch/loongarch/kernel/ptrace.c                     |  54 ++
 arch/loongarch/kernel/relocate.c                   |   8 +-
 arch/loongarch/kernel/setup.c                      |   4 +
 arch/loongarch/kernel/signal.c                     | 188 ++++++
 arch/loongarch/kernel/stacktrace.c                 |  18 +-
 arch/loongarch/kernel/traps.c                      |  50 +-
 arch/loongarch/lib/Makefile                        |   2 +
 arch/loongarch/lib/clear_user.S                    |  87 +--
 arch/loongarch/lib/copy_user.S                     | 161 ++---
 arch/loongarch/lib/memcpy.S                        |   8 +-
 arch/loongarch/lib/memmove.S                       |  20 +-
 arch/loongarch/lib/memset.S                        |   8 +-
 arch/loongarch/lib/xor_simd.c                      |  93 +++
 arch/loongarch/lib/xor_simd.h                      |  38 ++
 arch/loongarch/lib/xor_simd_glue.c                 |  72 ++
 arch/loongarch/lib/xor_template.c                  | 110 ++++
 arch/loongarch/mm/Makefile                         |   3 +
 arch/loongarch/mm/cache.c                          |   1 -
 arch/loongarch/mm/fault.c                          |  22 +-
 arch/loongarch/mm/init.c                           |  71 +-
 arch/loongarch/mm/kasan_init.c                     | 243 +++++++
 arch/loongarch/mm/mmap.c                           |  13 +-
 arch/loongarch/mm/pgtable.c                        |  12 +
 arch/loongarch/vdso/Makefile                       |   3 +
 include/linux/kasan.h                              |   2 +
 include/linux/raid/pq.h                            |   4 +
 lib/raid6/Makefile                                 |   1 +
 lib/raid6/algos.c                                  |  16 +
 lib/raid6/loongarch.h                              |  38 ++
 lib/raid6/loongarch_simd.c                         | 422 ++++++++++++
 lib/raid6/recov_loongarch_simd.c                   | 513 +++++++++++++++
 lib/raid6/test/Makefile                            |  12 +
 mm/kasan/init.c                                    |  18 +-
 mm/kasan/kasan.h                                   |   6 +
 mm/kfence/core.c                                   |   5 +-
 75 files changed, 3862 insertions(+), 461 deletions(-)
 create mode 100644 arch/loongarch/include/asm/kasan.h
 create mode 100644 arch/loongarch/include/asm/kfence.h
 create mode 100644 arch/loongarch/include/asm/kgdb.h
 create mode 100644 arch/loongarch/include/asm/lbt.h
 create mode 100644 arch/loongarch/include/asm/xor.h
 create mode 100644 arch/loongarch/include/asm/xor_simd.h
 create mode 100644 arch/loongarch/kernel/kgdb.c
 create mode 100644 arch/loongarch/kernel/lbt.S
 create mode 100644 arch/loongarch/lib/xor_simd.c
 create mode 100644 arch/loongarch/lib/xor_simd.h
 create mode 100644 arch/loongarch/lib/xor_simd_glue.c
 create mode 100644 arch/loongarch/lib/xor_template.c
 create mode 100644 arch/loongarch/mm/kasan_init.c
 create mode 100644 lib/raid6/loongarch.h
 create mode 100644 lib/raid6/loongarch_simd.c
 create mode 100644 lib/raid6/recov_loongarch_simd.c
