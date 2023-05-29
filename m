Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 264EB714676
	for <lists+linux-arch@lfdr.de>; Mon, 29 May 2023 10:46:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjE2IqY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 29 May 2023 04:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE2IqX (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 29 May 2023 04:46:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B24AC2;
        Mon, 29 May 2023 01:46:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82F6C612FB;
        Mon, 29 May 2023 08:46:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5181C4339B;
        Mon, 29 May 2023 08:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685349980;
        bh=/V+SLKdvaHtCYTQwLxo45gaPakkF4D8ubWUXjKcsgvQ=;
        h=From:To:Cc:Subject:Date:From;
        b=LrQixWfnMt+yEPDB9h2XI2CwlaOtVIZySVDvok3CKpeqKtBzv6elnzL5duj96HIua
         mvZnNhHyQcL04IG5J2uPpotmvNzNG2+FO0wnTiPCE54cXMKT89v6cQgZ3DSJo1Skyq
         QV5+oqtMW88EAq6jQulWdWC75VvFm+bcrmg7FPPkNuXw+6iwt7cpS+cp+nLYYLzhv8
         ESHZILORDrFboBFuQhYb2GlrC4DRV6miEsSFFpALvXNjkWWB361dchGm9qmOWEDgpA
         Ukfx+DRTC8qoC/ep9/s/FV3RhvxsrIyPIg3EJn+eSytM3Hbj6+NqyZG+TQ9co+F+Ud
         H6vfmhpteK2fg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        bjorn@kernel.org, greentime.hu@sifive.com, vincent.chen@sifive.com,
        andy.chiu@sifive.com, paul.walmsley@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH -next V12 0/3] riscv: Add independent irq/softirq stacks
Date:   Mon, 29 May 2023 04:45:57 -0400
Message-Id: <20230529084600.2878130-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This patch series adds independent irq/softirq stacks to decrease the
press of the thread stack. Also, add a thread STACK_SIZE config for
users to adjust the proper size during compile time.

This patch series belonged to the generic entry, which has been merged
to for-next now.

v12:
 - Rebase on palmer/for-next (20230529)
 - Move DECLARE_PER_CPU(ulong *, irq_stack_ptr) into irq_stack.h (Thx Conor)
 - Optimize commit msg

v11:
https://lore.kernel.org/linux-riscv/20230324071239.151677-1-guoren@kernel.org/
 - Rebase on palmer/for-next (20230324)
 - Separate from generic entry patch series.

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
  riscv: stack: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
  riscv: stack: Support HAVE_SOFTIRQ_ON_OWN_STACK
  riscv: stack: Add config of thread stack size

 arch/riscv/Kconfig                   | 19 ++++++++
 arch/riscv/include/asm/irq_stack.h   | 32 +++++++++++++
 arch/riscv/include/asm/thread_info.h | 14 ++----
 arch/riscv/kernel/irq.c              | 68 ++++++++++++++++++++++++++++
 arch/riscv/kernel/traps.c            | 35 +++++++++++++-
 5 files changed, 155 insertions(+), 13 deletions(-)
 create mode 100644 arch/riscv/include/asm/irq_stack.h

-- 
2.36.1

