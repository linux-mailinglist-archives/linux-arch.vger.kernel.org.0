Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E52CB34BB45
	for <lists+linux-arch@lfdr.de>; Sun, 28 Mar 2021 08:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbhC1GbU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 28 Mar 2021 02:31:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229485AbhC1GbR (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 28 Mar 2021 02:31:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A43E36197C;
        Sun, 28 Mar 2021 06:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616913076;
        bh=fIYmtiiVahTZKgHaQD+jDuMxYY5AvOy62Q+boojOK1E=;
        h=From:To:Cc:Subject:Date:From;
        b=TZ3ei7zBeAgVBpKeSMgUIfT7cFEsCeH1gjJAc1Xka+xh1tEnN6M+Juhcxj4cMHSJ6
         WmILreZnGkimmxPtbMXMLKfedRa/wD37UVBmGCsKO3FB75rnREvgypwcEkfIe51j4u
         /lAcvsk3EEHh9Hg1GmHcvDQb7ilTxctp3FsxA13LHoejLlR7k2ECSFxo9LF+OTle7G
         sS1dndQX+pK0CxgW0gsgWvaFbWNF+lH/vurb0mQGAd1dG3eq4gg6flYOpQa4HmQrua
         0CR5asMfgeWZ1rL4qzvhyivvy1moujsSCNT4SCYn4sfSp0zU71oleIAtjphFxp9yb1
         MVZVtA9yLHxfA==
From:   guoren@kernel.org
To:     guoren@kernel.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-xtensa@linux-xtensa.org,
        openrisc@lists.librecores.org, sparclinux@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v5 0/7] riscv: Add qspinlock/qrwlock
Date:   Sun, 28 Mar 2021 06:30:21 +0000
Message-Id: <1616913028-83376-1-git-send-email-guoren@kernel.org>
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

Guo Ren (6):
  locking/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  csky: Convert custom spinlock/rwlock to generic qspinlock/qrwlock
  powerpc/qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  openrisc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  sparc: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32
  xtensa: qspinlock: Add ARCH_USE_QUEUED_SPINLOCKS_XCHG32

Michael Clark (1):
  riscv: Convert custom spinlock/rwlock to generic qspinlock/qrwlock

 arch/csky/Kconfig                       |   2 +
 arch/csky/include/asm/Kbuild            |   2 +
 arch/csky/include/asm/spinlock.h        |  82 +--------------
 arch/csky/include/asm/spinlock_types.h  |  16 +--
 arch/openrisc/Kconfig                   |   1 +
 arch/powerpc/Kconfig                    |   1 +
 arch/riscv/Kconfig                      |   3 +
 arch/riscv/include/asm/Kbuild           |   3 +
 arch/riscv/include/asm/spinlock.h       | 126 +-----------------------
 arch/riscv/include/asm/spinlock_types.h |  15 +--
 arch/sparc/Kconfig                      |   1 +
 arch/xtensa/Kconfig                     |   1 +
 kernel/Kconfig.locks                    |   3 +
 kernel/locking/qspinlock.c              |  46 +++++----
 14 files changed, 49 insertions(+), 253 deletions(-)

-- 
2.17.1

