Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B10E348AD4
	for <lists+linux-arch@lfdr.de>; Thu, 25 Mar 2021 08:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbhCYH4r (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Mar 2021 03:56:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:44598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCYH4q (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Mar 2021 03:56:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D59E761945;
        Thu, 25 Mar 2021 07:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616659005;
        bh=/wwJUDyl0L2cZlkv2+pe9ddYhc6OecFJJCkq6BkU3O0=;
        h=From:To:Cc:Subject:Date:From;
        b=OpFmlg9OBvyO10jNum7/CquDBaJxsFlSi9+zj3wgYdbg2fsOreULnLun9bZCz6SXp
         JKwPRVJP3lF4PdMljN0mTC0wTK8kewvJUOPRgys0fw7ouGfWsTFjb6vIRXA3yMf+qZ
         L+fKTi1+5bjzf5RMASfAexFZ7PPKNf7Oq+p+VDvyjeze1j4hDMh43j/hYhvJwtACO/
         cr93gggBCwAJyE3k053ltgHgXMwridRPmVpdsyS75eCAQdt9IjAebSzKTHGX6Nlerw
         ZwYdPrxr7fTxULpmjdXr16VMPEokqvEUpzabcJF4cqJXdck/40geNJyQmPgYaaG6C1
         vgM5pozmDujrA==
From:   guoren@kernel.org
To:     guoren@kernel.org, Anup.Patel@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-csky@vger.kernel.org, linux-arch@vger.kernel.org,
        tech-unixplatformspec@lists.riscv.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH v3 0/4] riscv: Add qspinlock/qrwlock
Date:   Thu, 25 Mar 2021 07:55:33 +0000
Message-Id: <1616658937-82063-1-git-send-email-guoren@kernel.org>
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
architectures which doesn't have short atmoic xchg instructions.)

Change V3:
 - Fixup short-xchg asm code (slli -> slliw, srli -> srliw)
 - Coding convention by Peter Zijlstra's advices 

Change V2:
 - Coding convention in cmpxchg.h
 - Re-implement short xchg
 - Remove char & cmpxchg implementations

V1: (by michael)

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

