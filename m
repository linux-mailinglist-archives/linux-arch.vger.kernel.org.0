Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 280D95534F4
	for <lists+linux-arch@lfdr.de>; Tue, 21 Jun 2022 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352061AbiFUOuC (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Jun 2022 10:50:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352069AbiFUOts (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Jun 2022 10:49:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE2A9275F4;
        Tue, 21 Jun 2022 07:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B145EB81815;
        Tue, 21 Jun 2022 14:49:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C0EC3411C;
        Tue, 21 Jun 2022 14:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655822983;
        bh=SZKgLW9pCUpPaA4Q2joB2cVjf3OSIICpzQIzPOyXTmo=;
        h=From:To:Cc:Subject:Date:From;
        b=q3170b0IF27mRdU22SwhXmvvuiW+lv6RfPUKC1/YwQ4Ho7JMBxwbRmQuZYUrsMHPt
         PYt/B2QlsCF3wEgBFDFj4GFRalU92JO1gDLagjBG98kJMgHSCHBzAfIZjNYf1GpNuO
         xfyyfhOrjq1Jn32cEfJHzhiJiWXSuKxp767ldZNTkL8RRWE/DhsjZq8qEphgzxXKb0
         oCK9qancnHuOBA2xgGxwj/ltUMXLIrGDl5qyhtZ2EkvZH6m6IfhR3z1HSC5NTQd1h3
         mBywDwuXt9j14wU1huTls2Bq9UYbxTvVyGwQ604q+hEsZvNvtpYbO4yE4V0oqFO7cl
         NE2N6pqaMUADw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, peterz@infradead.org,
        longman@redhat.com, boqun.feng@gmail.com,
        Conor.Dooley@microchip.com, chenhuacai@loongson.cn,
        kernel@xen0n.name, r@hev.cc, shorne@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V6 0/2] riscv: Support qspinlock with generic headers
Date:   Tue, 21 Jun 2022 10:49:18 -0400
Message-Id: <20220621144920.2945595-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Enable qspinlock and meet the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

RISC-V LR/SC pairs could provide a strong/weak forward guarantee that
depends on micro-architecture. And RISC-V ISA spec has given out
several limitations to let hardware support strict forward guarantee
(RISC-V User ISA - 8.3 Eventual Success of Store-Conditional
Instructions):
We restricted the length of LR/SC loops to fit within 64 contiguous
instruction bytes in the base ISA to avoid undue restrictions on
instruction cache and TLB size and associativity. Similarly, we
disallowed other loads and stores within the loops to avoid restrictions
on data-cache associativity in simple implementations that track the
reservation within a private cache. The restrictions on branches and
jumps limit the time that can be spent in the sequence. Floating-point
operations and integer multiply/divide were disallowed to simplify the
operating system’s emulation of these instructions on implementations
lacking appropriate hardware support.
Software is not forbidden from using unconstrained LR/SC sequences, but
portable software must detect the case that the sequence repeatedly
fails, then fall back to an alternate code sequence that does not rely
on an unconstrained LR/SC sequence. Implementations are permitted to
unconditionally fail any unconstrained LR/SC sequence.

eg:
Some riscv hardware such as BOOMv3 & XiangShan could provide strict &
strong forward guarantee (The cache line would be kept in an exclusive
state for Backoff cycles, and only this core's interrupt could break
the LR/SC pair).
Qemu riscv give a weak forward guarantee by wrong implementation
currently [1].

The first version of patch was made in 2019.1 [2].

[1] https://github.com/qemu/qemu/blob/master/target/riscv/insn_trans/trans_rva.c.inc
[2] https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/#r

Change V6:
 - Fixup Clang compile problem Reported-by: kernel test robot
   <lkp@intel.com>
 - Cleanup asm-generic/spinlock.h
 - Remove changelog in patch main comment part, suggested by
   Conor.Dooley@microchip.com
 - Remove "default y if NUMA" in Kconfig

Change V5:
 - Update comment with RISC-V forward guarantee feature.
 - Back to V3 direction and optimize asm code.

Change V4:
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock

Change V3:
 - Coding convention by Peter Zijlstra's advices

Change V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

Guo Ren (2):
  asm-generic: spinlock: Move qspinlock & ticket-lock into generic
    spinlock.h
  riscv: Add qspinlock support

 arch/riscv/Kconfig                    |  8 +++
 arch/riscv/include/asm/Kbuild         |  2 +
 arch/riscv/include/asm/cmpxchg.h      | 17 +++++
 include/asm-generic/spinlock.h        | 90 ++------------------------
 include/asm-generic/spinlock_types.h  | 14 ++--
 include/asm-generic/tspinlock.h       | 92 +++++++++++++++++++++++++++
 include/asm-generic/tspinlock_types.h | 17 +++++
 7 files changed, 146 insertions(+), 94 deletions(-)
 create mode 100644 include/asm-generic/tspinlock.h
 create mode 100644 include/asm-generic/tspinlock_types.h

-- 
2.36.1

