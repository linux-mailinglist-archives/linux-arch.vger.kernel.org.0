Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA2E567D2FF
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 18:25:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbjAZRZf (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 12:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjAZRZe (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 12:25:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89ED6EF9F;
        Thu, 26 Jan 2023 09:25:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 264AB618F8;
        Thu, 26 Jan 2023 17:25:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478D8C433EF;
        Thu, 26 Jan 2023 17:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674753932;
        bh=+ygtup1H1Hi1Gj+bbIS1pl26EshplfwU7EhVnXXoFeM=;
        h=From:To:Cc:Subject:Date:From;
        b=UAIcSb4sK6Ij9EyAudyeCc/0lQ+N6Q74Qphh+wBPc/mzam2PLwYJW4bEokgDeCjG3
         XWw5/Tp66QgOycRHuCP69IIhpdN+uWOExXdIi1OR31UD91RHEFi3GgVUl5C3gMR8ps
         m+W16tRVx3j34cPb6wFW7oj9e23r+BnUi7Q725H8VSPrbe/a89lv7jiQtBoxTmnfZi
         z4igKcvO7eEHL07B8DuH59k+i7NAVmOtHM8fTuM2yr8IUQqMi+o8E1FiwCH6nN/fBC
         wD++RxkSFw+SPLRJ+VO08LxrqX7K/UonfZhTdplhP4p2uCPteRxrd3BJWdmN4K+e4q
         cH9IYmXj4fB8g==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org,
        mark.rutland@arm.com, ben@decadent.org.uk, bjorn@kernel.org
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V15 0/7] riscv: Add GENERIC_ENTRY support
Date:   Thu, 26 Jan 2023 12:25:09 -0500
Message-Id: <20230126172516.1580058-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patches convert riscv to use the generic entry infrastructure from
kernel/entry/*. Some optimization for entry.S with new .macro and merge
ret_from_kernel_thread into ret_from_fork.

The 1,2 are the preparation of generic entry. 3~7 are the main part
of generic entry.

All tested with rv64, rv32, rv64 + 32rootfs, all are passed.

You can directly try it with:
[1] https://github.com/guoren83/linux/tree/generic_entry_v15

Any reviews and tests are helpful.

v15:
 - Fixup compile error for !MMU (Thx Conor)
 - Rebase on riscv for-next (20230127)

v14:
https://lore.kernel.org/linux-riscv/20230112095848.1464404-1-guoren@kernel.org/
 - Fixup W=1 warning reported by kernel test robot <lkp@intel.com>

v13:
https://lore.kernel.org/linux-riscv/20230107113838.3969149-1-guoren@kernel.org/
 - Remove noinstr for original do_page_fault
 - Centralize all the necesarily-noinstr bits in
   arch/riscv/kernel/traps.c

v12:
https://lore.kernel.org/linux-riscv/20230103033531.2011112-1-guoren@kernel.org/
 - Rebase on newest for-next-20230103 (Linux 6.2-rc1)
 - Add Reviewed-by: Björn Töpel

v11:
https://lore.kernel.org/linux-riscv/20221210171141.1120123-1-guoren@kernel.org/
 - Rebase on newest for-next-20221211
 - Remove stack optimization patch series
 - Optimize comments
 - Replace ENTRY with SYM_CODE/FUNC_START in entry.S

v10:
https://lore.kernel.org/linux-riscv/20221208025816.138712-1-guoren@kernel.org/
 - Rebase on palmer/for-next branch (20221208)
 - Remove unrelated patches from the series (Suggested-by: Bjorn)
 - Fixup Typos. 

v9:
https://lore.kernel.org/linux-riscv/20221130034059.826599-1-guoren@kernel.org/
 - Fixup NR_syscalls check (by Ben Hutchings)
 - Add Tested-by: Jisheng Zhang

v8:
https://lore.kernel.org/linux-riscv/20221103075047.1634923-1-guoren@kernel.org/
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

Guo Ren (3):
  riscv: ptrace: Remove duplicate operation
  riscv: entry: Add noinstr to prevent instrumentation inserted
  riscv: entry: Convert to generic entry

Jisheng Zhang (3):
  riscv: entry: Remove extra level wrappers of trace_hardirqs_{on,off}
  riscv: entry: Consolidate ret_from_kernel_thread into ret_from_fork
  riscv: entry: Consolidate general regs saving/restoring

Lai Jiangshan (1):
  compiler_types.h: Add __noinstr_section() for noinstr

 arch/riscv/Kconfig                      |   1 +
 arch/riscv/include/asm/asm-prototypes.h |   2 +
 arch/riscv/include/asm/asm.h            |  63 +++++
 arch/riscv/include/asm/csr.h            |   1 -
 arch/riscv/include/asm/entry-common.h   |  11 +
 arch/riscv/include/asm/ptrace.h         |  10 +-
 arch/riscv/include/asm/stacktrace.h     |   5 +
 arch/riscv/include/asm/syscall.h        |  21 ++
 arch/riscv/include/asm/thread_info.h    |  13 +-
 arch/riscv/kernel/Makefile              |   2 -
 arch/riscv/kernel/entry.S               | 324 +++---------------------
 arch/riscv/kernel/head.h                |   1 -
 arch/riscv/kernel/mcount-dyn.S          |  56 +---
 arch/riscv/kernel/process.c             |   5 +-
 arch/riscv/kernel/ptrace.c              |  44 ----
 arch/riscv/kernel/signal.c              |  29 +--
 arch/riscv/kernel/trace_irq.c           |  27 --
 arch/riscv/kernel/trace_irq.h           |  11 -
 arch/riscv/kernel/traps.c               | 144 +++++++++--
 arch/riscv/mm/fault.c                   |   6 +-
 include/linux/compiler_types.h          |  15 +-
 21 files changed, 289 insertions(+), 502 deletions(-)
 create mode 100644 arch/riscv/include/asm/entry-common.h
 delete mode 100644 arch/riscv/kernel/trace_irq.c
 delete mode 100644 arch/riscv/kernel/trace_irq.h

-- 
2.36.1

