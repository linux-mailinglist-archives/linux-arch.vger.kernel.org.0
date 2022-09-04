Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411635AC328
	for <lists+linux-arch@lfdr.de>; Sun,  4 Sep 2022 09:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiIDH1P (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 4 Sep 2022 03:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiIDH1O (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 4 Sep 2022 03:27:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA8D44562;
        Sun,  4 Sep 2022 00:27:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CA8260F08;
        Sun,  4 Sep 2022 07:27:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E68DC433D6;
        Sun,  4 Sep 2022 07:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662276432;
        bh=Ch23AYNtyFVoUZ3rSTNSj6dwqtU+Er2LgcLRrNLkFPA=;
        h=From:To:Cc:Subject:Date:From;
        b=qrbRku5mHXR59ThJPg6vRzifYd9nBFm/gjPCPVslkuW7mcC5E4SEuhAE06FS2A20y
         8Rbaq9hblTYfQmzCHKTem8c/cHZu+SiMs8/Ir7+WG0cBMu/kvNOJIdqYFKjMp+/u+m
         UyzOB5YfSdP46zf5ww/esW8HKA3qeaOvihlQss+z3Kzh8nMfyPBfHjoCTLFOShWFMQ
         CTAcGBPiB65y89jEaIZINeWbchR/s893whkQCRj/iMkvc+DIDMFCZW2I/eexkYQWJ+
         u2wMltVUGh+niStNVvgWxPK+1rVSBvIf1Y7R4szS0XXfvIZfKEWw7Pzs2xiCOE+C00
         VsqaBxarLwb7A==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, peterz@infradead.org, luto@kernel.org,
        conor.dooley@microchip.com, heiko@sntech.de, jszhang@kernel.org,
        lazyparser@gmail.com, falcon@tinylab.org, chenhuacai@kernel.org,
        apatel@ventanamicro.com, atishp@atishpatra.org, palmer@dabbelt.com,
        paul.walmsley@sifive.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/6] riscv: Add GENERIC_ENTRY, IRQ_STACKS support
Date:   Sun,  4 Sep 2022 03:26:31 -0400
Message-Id: <20220904072637.8619-1-guoren@kernel.org>
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

[1] https://github.com/guoren83/linux/tree/generic_entry_v2

Changes in V2:
 - Fixup compile error by include "riscv: ptrace: Remove duplicate
   operation"
   https://lore.kernel.org/linux-riscv/20220903162328.1952477-2-guoren@kernel.org/T/#u
 - Fixup compile warning
   Reported-by: kernel test robot <lkp@intel.com>
 - Add test repo link in cover letter

Guo Ren (6):
  riscv: ptrace: Remove duplicate operation
  riscv: convert to generic entry
  riscv: Support HAVE_IRQ_EXIT_ON_IRQ_STACK
  riscv: Support HAVE_SOFTIRQ_ON_OWN_STACK
  riscv: elf_kexec: Fixup compile warning
  riscv: compat_syscall_table: Fixup compile warning

 arch/riscv/Kconfig                    |  10 +
 arch/riscv/include/asm/csr.h          |   1 -
 arch/riscv/include/asm/entry-common.h |   8 +
 arch/riscv/include/asm/irq.h          |   3 +
 arch/riscv/include/asm/ptrace.h       |  10 +-
 arch/riscv/include/asm/stacktrace.h   |   5 +
 arch/riscv/include/asm/syscall.h      |   6 +
 arch/riscv/include/asm/thread_info.h  |  15 +-
 arch/riscv/include/asm/vmap_stack.h   |  28 +++
 arch/riscv/kernel/Makefile            |   1 +
 arch/riscv/kernel/elf_kexec.c         |   4 +
 arch/riscv/kernel/entry.S             | 255 +++++---------------------
 arch/riscv/kernel/irq.c               |  75 ++++++++
 arch/riscv/kernel/ptrace.c            |  41 -----
 arch/riscv/kernel/signal.c            |  21 +--
 arch/riscv/kernel/sys_riscv.c         |  26 +++
 arch/riscv/kernel/traps.c             |  11 ++
 arch/riscv/mm/fault.c                 |  12 +-
 18 files changed, 250 insertions(+), 282 deletions(-)
 create mode 100644 arch/riscv/include/asm/entry-common.h
 create mode 100644 arch/riscv/include/asm/vmap_stack.h

-- 
2.36.1

