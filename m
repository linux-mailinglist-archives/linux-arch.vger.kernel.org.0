Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD1755E1BC
	for <lists+linux-arch@lfdr.de>; Tue, 28 Jun 2022 15:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236359AbiF1IV6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 28 Jun 2022 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245192AbiF1IT5 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 28 Jun 2022 04:19:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108632DABE;
        Tue, 28 Jun 2022 01:19:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C9D56B81D12;
        Tue, 28 Jun 2022 08:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD599C3411D;
        Tue, 28 Jun 2022 08:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656404393;
        bh=yGob1Vr8BR4JA5385szP2YP45oWt14YDHpLRa/YTWAo=;
        h=From:To:Cc:Subject:Date:From;
        b=qyJX3C1/aIuiM6xAjTcD8eOrtA9FWuC7wRpJC211TfRs8LQ45xJ2HLSdhbIoPDuEP
         QLTcjQv1WdOC1etdBxsDgsUVmTcHQI2LnJQUkQQhgmpA5D0BJ1yEE4gf8ldMpxDSG8
         0IoXqWWnLTvZGUaNIyf2n29IZuQOeOWu5YWUX6zhKrxbLgt7RQRczX2RxRr/Qc5ABM
         NUS5V5dguuWoFT0b+DlLhBuxxk3nKKByZCwlrQMo27MWZ7YfmRbNHlZffmUL7ZBIHB
         YD+jAC+aqJFxVnUqK3vkLq68ZyZk5YoJTLIGDsaTNUwqadK0c9uJHETEHBcJfpvLWl
         hPKU+fjDA3DOg==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, arnd@arndb.de, mingo@redhat.com,
        will@kernel.org, longman@redhat.com, boqun.feng@gmail.com
Cc:     linux-riscv@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V7 0/5] riscv: Add qspinlock support with combo style
Date:   Tue, 28 Jun 2022 04:19:46 -0400
Message-Id: <20220628081946.1999419-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Add combo spinlock (ticket & queued) support
Some architecture has a flexible requirement on the type of spinlock.
Some LL/SC architectures of ISA don't force micro-arch to give a strong
forward guarantee. Thus different kinds of memory model micro-arch would
come out in one ISA. The ticket lock is suitable for exclusive monitor
designed LL/SC micro-arch with limited cores and "!NUMA". The
queue-spinlock could deal with NUMA/large-scale scenarios with a strong
forward guarantee designed LL/SC micro-arch.

The first version of patch was made in 2019.1 [2].

[1] https://github.com/qemu/qemu/blob/master/target/riscv/insn_trans/trans_rva.c.inc
[2] https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/#r

Change V7:
 - Add combo spinlock (ticket & queued) support
 - Rename ticket_spinlock.h
 - Remove unnecessary atomic_read in ticket_spin_value_unlocked  

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

Guo Ren (5):
  asm-generic: ticket-lock: Remove unnecessary atomic_read
  asm-generic: ticket-lock: Use the same struct definitions with qspinlock
  asm-generic: ticket-lock: Move into ticket_spinlock.h
  asm-generic: spinlock: Add combo spinlock (ticket & queued)
  riscv: Add qspinlock support

 arch/riscv/Kconfig                    |  9 +++
 arch/riscv/include/asm/Kbuild         |  2 +
 arch/riscv/include/asm/cmpxchg.h      | 17 +++++
 arch/riscv/kernel/setup.c             |  4 ++
 include/asm-generic/spinlock.h        | 81 +++++++++++++----------
 include/asm-generic/spinlock_types.h  | 12 +---
 include/asm-generic/ticket_spinlock.h | 92 +++++++++++++++++++++++++++
 kernel/locking/qspinlock.c            |  2 +
 8 files changed, 174 insertions(+), 45 deletions(-)
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.36.1

