Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE6C5ADE2C
	for <lists+linux-arch@lfdr.de>; Tue,  6 Sep 2022 05:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbiIFDyn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 5 Sep 2022 23:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiIFDyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 5 Sep 2022 23:54:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F093963A5;
        Mon,  5 Sep 2022 20:54:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EEE44B815CB;
        Tue,  6 Sep 2022 03:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2C7C433C1;
        Tue,  6 Sep 2022 03:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662436475;
        bh=EQdZazAdpQa+R8r6QHYhsh3tG+kWaf7hmg/+UOoGj60=;
        h=From:To:Cc:Subject:Date:From;
        b=VInTuYLASiMmyDYMCPsmnfJ5cwbz1MIQZnEgeByMqQ+vnnPKM66mZsmfKzcTTsfZT
         cVPBO/Ujglx/4sjXB8j2wN0LtkmLCw/Xpu1I1osURi5DI1RK86lNpPECrDiL1WfSpB
         NRaAveRZiR0Fnj3hjxlP0PjHZ/YAhA976+7zd1lTYj3O70nmeT9kSlxeSsBIr21Yvk
         c44kYb044dTUnE44P2UKROPeYTiDHqq0Ihch4J7MDQsYyVHujfSNlGe/Vw1rN8acE8
         PQhV1+DN3SWgW/Yzsm9DLWuh7uDmHpE6mAYSxGn40On1YZ5mI5psCX27PRlS1xvloT
         r6XptLtDHOURg==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com, bigeasy@linutronix.de
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/7] riscv: Add GENERIC_ENTRY, irq stack support
Date:   Mon,  5 Sep 2022 23:54:16 -0400
Message-Id: <20220906035423.634617-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patches convert riscv to use the generic entry infrastructure from
kernel/entry/*. Add independent irq stacks (IRQ_STACKS) for percpu to
prevent kernel stack overflows. Add the HAVE_SOFTIRQ_ON_OWN_STACK
feature for the IRQ_STACKS config. You can try it directly with [1].

[1] https://github.com/guoren83/linux/tree/generic_entry_v3

V3:
 - Fixup CONFIG_COMPAT=n compile error
 - Add THREAD_SIZE_ORDER config
 - Optimize elf_kexec.c warning fixup
 - Add static to irq_stack_ptr definition

V2:
 Link: https://lore.kernel.org/linux-riscv/20220904072637.8619-1-guoren@kernel.org/
 - Fixup compile error by include "riscv: ptrace: Remove duplicate
   operation"
 - Fixup compile warning
   Reported-by: kernel test robot <lkp@intel.com>
 - Add test repo link in cover letter

V1:
 Link: https://lore.kernel.org/linux-riscv/20220903163808.1954131-1-guoren@kernel.org/ 

Guo Ren (7):
  riscv: elf_kexec: Fixup compile warning
  riscv: compat_syscall_table: Fixup compile warning
  riscv: ptrace: Remove duplicate operation
  riscv: convert to generic entry
  riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
  riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
  riscv: Add config of thread stack size

 arch/riscv/Kconfig                    |  19 ++
 arch/riscv/include/asm/csr.h          |   1 -
 arch/riscv/include/asm/entry-common.h |   8 +
 arch/riscv/include/asm/irq.h          |   3 +
 arch/riscv/include/asm/ptrace.h       |  10 +-
 arch/riscv/include/asm/stacktrace.h   |   5 +
 arch/riscv/include/asm/syscall.h      |   6 +
 arch/riscv/include/asm/thread_info.h  |  19 +-
 arch/riscv/include/asm/vmap_stack.h   |  28 +++
 arch/riscv/kernel/Makefile            |   1 +
 arch/riscv/kernel/elf_kexec.c         |   2 +-
 arch/riscv/kernel/entry.S             | 255 +++++---------------------
 arch/riscv/kernel/irq.c               |  75 ++++++++
 arch/riscv/kernel/ptrace.c            |  41 -----
 arch/riscv/kernel/signal.c            |  21 +--
 arch/riscv/kernel/sys_riscv.c         |  27 +++
 arch/riscv/kernel/traps.c             |  11 ++
 arch/riscv/mm/fault.c                 |  12 +-
 18 files changed, 259 insertions(+), 285 deletions(-)
 create mode 100644 arch/riscv/include/asm/entry-common.h
 create mode 100644 arch/riscv/include/asm/vmap_stack.h

-- 
2.36.1

