Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7722058C3AC
	for <lists+linux-arch@lfdr.de>; Mon,  8 Aug 2022 09:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiHHHNq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 8 Aug 2022 03:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHHHNp (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 8 Aug 2022 03:13:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EBE26ED;
        Mon,  8 Aug 2022 00:13:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CE90760C21;
        Mon,  8 Aug 2022 07:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76568C433D6;
        Mon,  8 Aug 2022 07:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659942818;
        bh=mp7IlNGuC/mEeBlxm+TFmON4y1tQUocDWgcQyAy5k2Q=;
        h=From:To:Cc:Subject:Date:From;
        b=DiuuBcyVYaTX3T3cqhBu0StXLE+g8PiCN3zuRNn1XijfnR+rny0forVTFI/RVUMNr
         c9m+LgHDqQv79MTlVHjFDyj0sAXPH6CGYLlXDvBq2WdxbitT5MZ/lWa//F9blFQArY
         J+U6d/v/hOEWUG5W45hXqZ9W/2uRWVgxWmOP0Qpn5j/pGIACrMwQA9dl95da7Pp7bq
         TRJQ//iMi5kVeBew0P39u2XyLYYisW6kzbAnX0fa6Fz5pk6Ih3hTw0CwIYbtS5v0uc
         c0ucRlvJyGr3j6XlOGTxfkKVII+/yvungk2ze18j7j/jSNs6Nq10aedthG225TjTh+
         qxXB7C3bJmUIw==
From:   guoren@kernel.org
To:     palmer@rivosinc.com, heiko@sntech.de, hch@infradead.org,
        arnd@arndb.de, peterz@infradead.org, will@kernel.org,
        boqun.feng@gmail.com, longman@redhat.com, shorne@gmail.com,
        conor.dooley@microchip.com
Cc:     linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V9 00/15] arch: Add qspinlock support and atomic cleanup
Date:   Mon,  8 Aug 2022 03:13:03 -0400
Message-Id: <20220808071318.3335746-1-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
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

In this series:
 - Cleanup generic ticket-lock code, (Using smp_mb__after_spinlock as RCsc)
 - Add qspinlock and combo-lock for riscv
 - Add qspinlock to openrisc
 - Use generic header in csky
 - Optimize cmpxchg & atomic code

Enable qspinlock and meet the requirements mentioned in a8ad07e5240c9
("asm-generic: qspinlock: Indicate the use of mixed-size atomics").

RISC-V LR/SC pairs could provide a strong/weak forward guarantee that
depends on micro-architecture. And RISC-V ISA spec has given out
several limitations to let hardware support strict forward guarantee
(RISC-V User ISA - 8.3 Eventual Success of Store-Conditional
Instructions).

eg:
Some riscv hardware such as BOOMv3 & XiangShan could provide strict &
strong forward guarantee (The cache line would be kept in an exclusive
state for Backoff cycles, and only this core's interrupt could break
the LR/SC pair).
Qemu riscv give a weak forward guarantee by wrong implementation
currently [1].

So we Add combo spinlock (ticket & queued) support for riscv. Thus different
kinds of memory model micro-arch processors could use the same Image

The first try of qspinlock for riscv was made in 2019.1 [2].

[1] https://github.com/qemu/qemu/blob/master/target/riscv/insn_trans/trans_rva.c.inc
[2] https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/#r

Guo Ren (15):
  asm-generic: ticket-lock: Remove unnecessary atomic_read
  asm-generic: ticket-lock: Use the same struct definitions with qspinlock
  asm-generic: ticket-lock: Move into ticket_spinlock.h
  asm-generic: ticket-lock: Keep ticket-lock the same semantic with qspinlock
  asm-generic: spinlock: Add queued spinlock support in common header
  riscv: atomic: Clean up unnecessary acquire and release definitions
  riscv: cmpxchg: Remove xchg32 and xchg64
  riscv: cmpxchg: Forbid arch_cmpxchg64 for 32-bit
  riscv: cmpxchg: Optimize cmpxchg64
  riscv: Enable ARCH_INLINE_READ*/WRITE*/SPIN*
  riscv: Add qspinlock support
  riscv: Add combo spinlock support
  openrisc: cmpxchg: Cleanup unnecessary codes
  openrisc: Move from ticket-lock to qspinlock
  csky: spinlock: Use the generic header files

 arch/csky/include/asm/Kbuild           |   2 +
 arch/csky/include/asm/spinlock.h       |  12 --
 arch/csky/include/asm/spinlock_types.h |   9 --
 arch/openrisc/Kconfig                  |   1 +
 arch/openrisc/include/asm/Kbuild       |   2 +
 arch/openrisc/include/asm/cmpxchg.h    | 192 ++++++++++---------------
 arch/riscv/Kconfig                     |  49 +++++++
 arch/riscv/include/asm/Kbuild          |   3 +-
 arch/riscv/include/asm/atomic.h        |  19 ---
 arch/riscv/include/asm/cmpxchg.h       | 177 +++++++----------------
 arch/riscv/include/asm/spinlock.h      |  77 ++++++++++
 arch/riscv/kernel/setup.c              |  22 +++
 include/asm-generic/spinlock.h         |  94 ++----------
 include/asm-generic/spinlock_types.h   |  12 +-
 include/asm-generic/ticket_spinlock.h  |  93 ++++++++++++
 15 files changed, 384 insertions(+), 380 deletions(-)
 delete mode 100644 arch/csky/include/asm/spinlock.h
 delete mode 100644 arch/csky/include/asm/spinlock_types.h
 create mode 100644 arch/riscv/include/asm/spinlock.h
 create mode 100644 include/asm-generic/ticket_spinlock.h

-- 
2.36.1

