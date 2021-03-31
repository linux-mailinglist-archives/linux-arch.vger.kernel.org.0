Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C913A35023D
	for <lists+linux-arch@lfdr.de>; Wed, 31 Mar 2021 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235957AbhCaObt (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 31 Mar 2021 10:31:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235630AbhCaObo (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 31 Mar 2021 10:31:44 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 01F3760FF0;
        Wed, 31 Mar 2021 14:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617201104;
        bh=Oq2p2++lqOERCPM++AATk5Rdw/3Ja6gaVMhRgPIzPF0=;
        h=From:To:Cc:Subject:Date:From;
        b=nzY/wb74M0jYfXHnZiSzoI4o7pq5Y3fTkzio1WdfkdRKufUohKQwkm1PBLN3tufHE
         9OgAOpE32h2+T9nnF1ZCPS1coRoUrCzNA6DyKMuNSxpqkRqMIdROAGSe2CoLT6u0u0
         /1h66strn7saF1NEJrq8/A+Hy2dp6ib8IsgmKIVMt9rrPFl0WEWvgcqy/N+E6U5hwm
         TGkr8KWwp9XlnInAw2drOXo7N61mG3GRNZ4E45pXzIx/rRrUYdKrtzVzakE1zxYrUT
         pBm1qXLMVF5/zB174lV3VS47Fv+LLoFhQ33oZLj5e8FJszP+LGNs4UTY3rumbNQKgY
         KMQvZq5datBQg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v6 0/9] riscv: Add qspinlock/qrwlock
Date:   Wed, 31 Mar 2021 14:30:31 +0000
Message-Id: <1617201040-83905-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Current riscv is still using baby spinlock implementation. It'll cause
fairness and cache line bouncing problems. Many people are involved
and pay the efforts to improve it:

 - The first version of patch was made in 2019.1:
   https://lore.kernel.org/linux-riscv/20190211043829.30096-1-michaeljclark@mac.com/#r

 - The second version was made in 2020.11:
   https://lore.kernel.org/linux-riscv/1606225437-22948-2-git-send-email-guoren@kernel.org/

 - A good discussion at Platform HSC.2021-03-08:
   https://drive.google.com/drive/folders/1ooqdnIsYx7XKor5O1XTtM6D1CHp4hc0p

 - A good discussion on V4 in mailling list:
   https://lore.kernel.org/linux-riscv/1616868399-82848-1-git-send-email-guoren@kernel.org/T/#t

 - Openrisc's maintainer want to implement arch_cmpxchg infrastructure.
   https://lore.kernel.org/linux-riscv/1616868399-82848-1-git-send-email-guoren@kernel.org/T/#m11b712fb6a4fda043811b1f4c3d61446951ed65a

Hope your comments and Tested-by or Co-developed-by or Reviewed-by ...

Let's kick the qspinlock into riscv right now (Also for the
architecture which hasn't xchg16 atomic instruction.)

Change V6:
 - Add  ticket-lock for riscv, default is qspinlock
 - Keep ticket-lock for csky,  default is ticketlock
 - Using smp_cond_load for riscv ticket-lock
 - Optimize csky ticketlock with smp_cond_load, store_release
 - Add PPC_LBARX_LWARX for powerpc 

Change V5:
 - Fixup #endif comment typo by Waiman
 - Remove cmpxchg coding convention patches which will get into a
   separate patchset later by Arnd's advice
 - Try to involve more architectures in the discussion

Change V4:
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock

Change V3:
 - Coding convention by Peter Zijlstra's advices

Change V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

Guo Ren (8):
  locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  riscv: locks: Introduce ticket-based spinlock implementation
  csky: locks: Optimize coding convention
  csky: Convert custom spinlock/rwlock to generic qspinlock/qrwlock
  openrisc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  sparc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  xtensa: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  powerpc/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32

Michael Clark (1):
  riscv: Convert custom spinlock/rwlock to generic qspinlock/qrwlock

 arch/csky/Kconfig                       |   8 ++
 arch/csky/include/asm/Kbuild            |   2 +
 arch/csky/include/asm/spinlock.h        |  15 +--
 arch/csky/include/asm/spinlock_types.h  |   4 +
 arch/openrisc/Kconfig                   |   1 +
 arch/powerpc/Kconfig                    |   1 +
 arch/riscv/Kconfig                      |   8 ++
 arch/riscv/include/asm/Kbuild           |   3 +
 arch/riscv/include/asm/spinlock.h       | 158 +++++++++---------------
 arch/riscv/include/asm/spinlock_types.h |  26 ++--
 arch/sparc/Kconfig                      |   1 +
 arch/xtensa/Kconfig                     |   1 +
 kernel/Kconfig.locks                    |   3 +
 kernel/locking/qspinlock.c              |  46 +++----
 14 files changed, 142 insertions(+), 135 deletions(-)

-- 
2.17.1

