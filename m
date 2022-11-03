Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86456177FB
	for <lists+linux-arch@lfdr.de>; Thu,  3 Nov 2022 08:51:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbiKCHvc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 3 Nov 2022 03:51:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiKCHv2 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 3 Nov 2022 03:51:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBCD66153;
        Thu,  3 Nov 2022 00:51:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 67ECE61D67;
        Thu,  3 Nov 2022 07:51:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 565D6C433C1;
        Thu,  3 Nov 2022 07:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667461885;
        bh=tdZW+aaPVm0AB0zotKPFgvIWDIGs5UJnWygjbEAcTfg=;
        h=From:To:Cc:Subject:Date:From;
        b=tY2CRKa2az8VYk6gPFBtQaYFdo95ZYvWQ8tHAcjwcJ4h+GqL77DjhEt9YQg+AkVYr
         bwM1ret33PFfDNHf9jGhzGAH2+c+u4y4nLG44AbS0r8NZ8uixIYHglxMd8D/x7m7qL
         29TJ4s5Rt8yaK3dwZ3wq2yzJqag/hjpB/vCS5mZ83sOAdXB6OMTuk1+O7TENGLC1yx
         kqZumJPMVOGzGMm+qcwXnehU2Tyfh25l/U7jJHT1n9O7LiPfC3riCf9SeDCUeGIKl7
         mS7ovoF2+EpEjF68n7PxNaLDivoxQ7A+h5+BfEcpYehu5MH5qgBdZgiij+NVwnICuH
         S+ahn4kFQVkKw==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com, chenzhongjin@huawei.com,
        greentime.hu@sifive.com, andy.chiu@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V8 00/14] riscv: Add GENERIC_ENTRY support and related features
Date:   Thu,  3 Nov 2022 03:50:33 -0400
Message-Id: <20221103075047.1634923-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patches convert riscv to use the generic entry infrastructure from
kernel/entry/*. Additionally, add independent irq stacks (IRQ_STACKS)
for percpu to prevent kernel stack overflows. Add generic_entry based
STACKLEAK support. Some optimization for entry.S with new .macro and
merge ret_from_kernel_thread into ret_from_fork.

We have tested it with rv64, rv32, rv64 + 32rootfs, all are passed.

You can directly try it with:
[1] https://github.com/guoren83/linux/tree/generic_entry_v8

Any reviews and tests are helpful.

v8:
 - Rebase on palmer/for-next branch (20221102)
 - Add save/restore_from_x5_to_x31 .macro (JishengZhang)
 - Consolidate ret_from_kernel_thread into ret_from_fork (JishengZhang)
 - Optimize __noinstr_section comment (JiangshanLai)

v7:
https://lore.kernel.org/linux-riscv/20221015114702.3489989-1-guoren@kernel.org/
 - Fixup regs_irqs_disabled with SR_PIE
 - Optimize stackleak_erase -> stackleak_erase_on_task_stack (Thx Mark
   Rutland)
 - Add BUG_ON(!irqs_disabled()) in trap handlers
 - Using regs_irqs_disabled in __do_page_fault
 - Remove unnecessary irq disable in ret_from_exception and add comment 

v6:
https://lore.kernel.org/linux-riscv/20221002012451.2351127-1-guoren@kernel.org/
 - Use THEAD_SIZE_ORDER for thread size adjustment in kconfig (Thx Arnd)
 - Move call_on_stack to inline style (Thx Peter Zijlstra)
 - Fixup fp chain broken (Thx Chen Zhongjin)
 - Remove common entry modification, and fixup page_fault entry (Thx
   Peter Zijlstra)
 - Treat some traps as nmi entry (Thx Peter Zijlstra)

v5:
https://lore.kernel.org/linux-riscv/20220918155246.1203293-1-guoren@kernel.org/
 - Add riscv own stackleak patch instead of generic entry modification
   (by Mark Rutland)
 - Add EXPERT dependency for THREAD_SIZE (by Arnd)
 - Add EXPERT dependency for IRQ_STACK (by Sebastian, David Laight)
 - Corrected __trap_section (by Peter Zijlstra)
 - Add Tested-by (Yipeng Zou)
 - Use CONFIG_SOFTIRQ_ON_OWN_STACK replace "#ifndef CONFIG_PREEMPT_RT"
 - Fixup systrace_enter compile error
 - Fixup exit_to_user_mode_prepare preempt_disable warning

V4:
https://lore.kernel.org/linux-riscv/20220908022506.1275799-1-guoren@kernel.org/
 - Fixup entry.S with "la" bug (by Conor.Dooley)
 - Fixup missing noinstr bug (by Peter Zijlstra)

V3:
https://lore.kernel.org/linux-riscv/20220906035423.634617-1-guoren@kernel.org/
 - Fixup CONFIG_COMPAT=n compile error
 - Add THREAD_SIZE_ORDER config
 - Optimize elf_kexec.c warning fixup
 - Add static to irq_stack_ptr definition

V2:
https://lore.kernel.org/linux-riscv/20220904072637.8619-1-guoren@kernel.org/
 - Fixup compile error by include "riscv: ptrace: Remove duplicate
   operation"
 - Fixup compile warning
   Reported-by: kernel test robot <lkp@intel.com>
 - Add test repo link in cover letter

V1:
https://lore.kernel.org/linux-riscv/20220903163808.1954131-1-guoren@kernel.org/


Dao Lu (1):
  riscv: Add support for STACKLEAK gcc plugin

Guo Ren (9):
  riscv: elf_kexec: Fixup compile warning
  riscv: compat_syscall_table: Fixup compile warning
  riscv: ptrace: Remove duplicate operation
  riscv: traps: Add noinstr to prevent instrumentation inserted
  riscv: convert to generic entry
  riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
  riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
  riscv: Add config of thread stack size
  riscv: Typo fixup for addi -> andi in comment

Jisheng Zhang (3):
  riscv: remove extra level wrappers of trace_hardirqs_{on,off}
  riscv: consolidate ret_from_kernel_thread into ret_from_fork
  riscv: entry: consolidate general regs saving/restoring

Lai Jiangshan (1):
  compiler_types.h: Add __noinstr_section() for noinstr

 arch/riscv/Kconfig                    |  21 ++
 arch/riscv/include/asm/asm.h          |  63 +++++
 arch/riscv/include/asm/csr.h          |   1 -
 arch/riscv/include/asm/entry-common.h |   8 +
 arch/riscv/include/asm/ptrace.h       |  10 +-
 arch/riscv/include/asm/stacktrace.h   |   5 +
 arch/riscv/include/asm/syscall.h      |   6 +
 arch/riscv/include/asm/thread_info.h  |  27 +--
 arch/riscv/include/asm/vmap_stack.h   |  28 +++
 arch/riscv/kernel/Makefile            |   3 +-
 arch/riscv/kernel/elf_kexec.c         |   2 +-
 arch/riscv/kernel/entry.S             | 327 +++-----------------------
 arch/riscv/kernel/irq.c               | 110 +++++++++
 arch/riscv/kernel/mcount-dyn.S        |  56 +----
 arch/riscv/kernel/process.c           |   5 +-
 arch/riscv/kernel/ptrace.c            |  44 ----
 arch/riscv/kernel/signal.c            |  21 +-
 arch/riscv/kernel/sys_riscv.c         |  27 +++
 arch/riscv/kernel/trace_irq.c         |  27 ---
 arch/riscv/kernel/trace_irq.h         |  11 -
 arch/riscv/kernel/traps.c             |  74 ++++--
 arch/riscv/mm/fault.c                 |  16 +-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 include/linux/compiler_types.h        |  15 +-
 24 files changed, 407 insertions(+), 502 deletions(-)
 create mode 100644 arch/riscv/include/asm/entry-common.h
 create mode 100644 arch/riscv/include/asm/vmap_stack.h
 delete mode 100644 arch/riscv/kernel/trace_irq.c
 delete mode 100644 arch/riscv/kernel/trace_irq.h

-- 
2.36.1

