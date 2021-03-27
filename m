Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F93F34B8BE
	for <lists+linux-arch@lfdr.de>; Sat, 27 Mar 2021 19:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbhC0SHz (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Mar 2021 14:07:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:42432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230043AbhC0SH1 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 27 Mar 2021 14:07:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3102E61971;
        Sat, 27 Mar 2021 18:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616868447;
        bh=jOjbe1bkmnmiLoMyYXpPV5LKMugQ9fEQ5nrJ29GUIc4=;
        h=From:To:Cc:Subject:Date:From;
        b=QnO8uaJANl2WK3/TSy5NyvRa0HtcCox/KyFmkdXVNBiD5Sv3pjR2yMw5wuHbViQ+Q
         QqPhA4BcmkYLmox7w0qz3woi53OwRGpbXq0B2pMx6s9iav0OFIAyWboLfCk3jIg4Vq
         KfW+vK5Bg9FDTLXGknXKye9nVGP4IS9rhMb5qJpG7CWRQenDNQ446u404J9fU9tWXK
         vFOw4Ix6lYhPvksO+5OCMBdbBGN6VNQUAEbRX+q0JdrFlCy+gI1xBKsgNJFww60rNf
         NgEMC1SJP2ewGymKaa4Czon2swVmLU4sAx76arr2ZujjZ/EhFPPc32OQLQfx7+crSe
         WN+Z+3cByBzSg==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v4 0/4] riscv: Add qspinlock/qrwlock
Date:   Sat, 27 Mar 2021 18:06:35 +0000
Message-Id: <1616868399-82848-1-git-send-email-guoren@kernel.org>
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

Hope your comments and Tested-by or Co-developed-by or Reviewed-by ...

Let's kick the qspinlock into riscv right now (Also for the
architecture which hasn't xchg16 atomic instruction.)

Change V4:
 - Remove custom sub-word xchg implementation
 - Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32 in locking/qspinlock 

Change V3:
 - Coding convention by Peter Zijlstra's advices 

Change V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

Guo Ren (3):
  riscv: cmpxchg.h: Cleanup unused code
  riscv: cmpxchg.h: Merge macros
  riscv: cmpxchg.h: Implement xchg for short

Michael Clark (1):
  riscv: Convert custom spinlock/rwlock to generic qspinlock/qrwlock

 arch/riscv/Kconfig                      |   2 +
 arch/riscv/include/asm/Kbuild           |   3 +
 arch/riscv/include/asm/cmpxchg.h        | 211 ++++++------------------
 arch/riscv/include/asm/spinlock.h       | 126 +-------------
 arch/riscv/include/asm/spinlock_types.h |  15 +-
 5 files changed, 58 insertions(+), 299 deletions(-)

-- 
2.17.1

