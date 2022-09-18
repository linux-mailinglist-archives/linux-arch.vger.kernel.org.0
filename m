Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B805BBEC6
	for <lists+linux-arch@lfdr.de>; Sun, 18 Sep 2022 17:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiIRPxE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 18 Sep 2022 11:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIRPxC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 18 Sep 2022 11:53:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B21EAE1;
        Sun, 18 Sep 2022 08:53:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2FC5B81049;
        Sun, 18 Sep 2022 15:52:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F587C433D7;
        Sun, 18 Sep 2022 15:52:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663516378;
        bh=FoCd95aHbihKduTU0YZ17rKso3DNVUhMPWgAshfcpV0=;
        h=From:To:Cc:Subject:Date:From;
        b=PQ/irLDZ2QC9umKChFtuTZsogDUENiniMrIkQ7vVgrN0T896ylPWVLxmO7t7VL0Yq
         Of5AGSjUYgKLJFiPk3+wEa++qDpSq0eVwBra2NxJ/ihdykqfnbgqHHkdIWBy0+5vls
         HAdCL9my6uRCCNJA/Lf8i77ent9ZZ9hJmH3p+/atMg3vq19fmCNie736WyWhAsStro
         7ztyMA4M58AxpPPhPA3MuKUNXf4rJ3xkBzmM0K4SYfscFUpyWHehSuGq5A6CSfBZMw
         umEv6tF2U4/9FzfyxavD4jBClJcmYR4X5MDlVGy6YFy5lmh8kjtpYNMa88xVLPefZc
         QCp/qQFEly2+g==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, mark.rutland@arm.com,
        zouyipeng@huawei.com, bigeasy@linutronix.de,
        David.Laight@aculab.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 00/11] riscv: Add GENERIC_ENTRY support and related features
Date:   Sun, 18 Sep 2022 11:52:35 -0400
Message-Id: <20220918155246.1203293-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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
kernel/entry/*. Additionally, add independent irq stacks (IRQ_STACKS)
for percpu to prevent kernel stack overflows. Add generic_entry based
STACKLEAK support.

[1] https://github.com/guoren83/linux/tree/generic_entry_v5

v5:
 - Add riscv own stackleak patch instead of generic entry modification
   (by Mark Rutland)
 - Add EXPERT dependency for THREAD_SIZE (by Arnd)
 - Add EXPERT dependency for IRQ_STACK (by Sebastian, David Laight)
 - Corrected __trap_section (by Peter Ziji)
 - Add Tested-by (Yipeng Zou)
 - Use CONFIG_SOFTIRQ_ON_OWN_STACK replace "#ifndef CONFIG_PREEMPT_RT"
 - Fixup systrace_enter compile error
 - Fixup exit_to_user_mode_prepare preempt_disable warning

V4:
https://lore.kernel.org/linux-riscv/20220908022506.1275799-1-guoren@kernel.org/
 - Fixup entry.S with "la" bug (by Conor.Dooley)
 - Fixup missing noinstr bug (by Peter Ziji)

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
  entry: Prevent DEBUG_PREEMPT warning
  riscv: convert to generic entry
  riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
  riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
  riscv: Add config of thread stack size

Lai Jiangshan (1):
  compiler_types.h: Add __noinstr_section() for noinstr

 arch/riscv/Kconfig                    |  29 +++
 arch/riscv/include/asm/csr.h          |   1 -
 arch/riscv/include/asm/entry-common.h |   8 +
 arch/riscv/include/asm/irq.h          |   3 +
 arch/riscv/include/asm/ptrace.h       |  10 +-
 arch/riscv/include/asm/stacktrace.h   |   5 +
 arch/riscv/include/asm/syscall.h      |   6 +
 arch/riscv/include/asm/thread_info.h  |  27 +--
 arch/riscv/include/asm/vmap_stack.h   |  28 +++
 arch/riscv/kernel/Makefile            |   1 +
 arch/riscv/kernel/elf_kexec.c         |   2 +-
 arch/riscv/kernel/entry.S             | 257 ++++++--------------------
 arch/riscv/kernel/irq.c               |  75 ++++++++
 arch/riscv/kernel/ptrace.c            |  44 -----
 arch/riscv/kernel/signal.c            |  21 +--
 arch/riscv/kernel/sys_riscv.c         |  27 +++
 arch/riscv/kernel/traps.c             |  15 +-
 arch/riscv/mm/fault.c                 |  12 +-
 drivers/firmware/efi/libstub/Makefile |   2 +-
 include/linux/compiler_types.h        |   8 +-
 kernel/entry/common.c                 |   2 +
 21 files changed, 282 insertions(+), 301 deletions(-)
 create mode 100644 arch/riscv/include/asm/entry-common.h
 create mode 100644 arch/riscv/include/asm/vmap_stack.h

-- 
2.36.1

