Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6513900EA
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 14:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhEYM0Z (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 25 May 2021 08:26:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232504AbhEYM0Z (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 25 May 2021 08:26:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B559D61409;
        Tue, 25 May 2021 12:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621945495;
        bh=kTICQpWTbjTcpQWhVugJHEfXiH/3wCrrriPNXPOkttw=;
        h=From:To:Cc:Subject:Date:From;
        b=El4UawTPYLEjOubsZ760YYIv6i9zWEW9P015m+Qk/oKYQGYFis2uosnXZbX4cew1z
         IO15KdNgaIh1Uj1Idle3GR6y0Ms2RLXUNKUgE3KMtVxbNf4M1uaj9Dmd5bIw3pSrBv
         g8WDJ+pTfUaCbqH58p0elfBYECgXnlyW6xWJ1iYP28d4Vn6CfL3eDK9mwl5FnJriA+
         CCY7KOTb56QoBqRi/iJjJXTvrBDaJdMT87rWtP6t+Ovpd6+frD5ZCgE+YcoqI2YZop
         c004SKao/40ZNZIfO9OddIb9T3LAD9sQtaL9XUZ7MRJIOqZ40+dvdWhYUovJ8HofNE
         lSnw9GHL6dmbw==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 0/2] riscv: Fixup asid_allocator remaining issues
Date:   Tue, 25 May 2021 12:24:05 +0000
Message-Id: <1621945447-38820-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patchset fixes the remaining problems of asid_allocator.
 - Fixup _PAGE_GLOBAL for kernel virtual address mapping
 - Optimize tlb_flush with asid & range

Changes since v2:
 - Remove PAGE_UP/DOWN usage in tlbflush.h
 - Optimize variable name

Changes since v1:
 - Drop PAGE_UP wrong fixup
 - Rebase on clean linux-5.13-rc2
 - Add Reviewed-by

Guo Ren (2):
  riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
  riscv: Use use_asid_allocator flush TLB

 arch/riscv/include/asm/mmu_context.h |  2 ++
 arch/riscv/include/asm/pgtable.h     |  3 ++-
 arch/riscv/include/asm/tlbflush.h    | 21 +++++++++++++++++++
 arch/riscv/mm/context.c              |  2 +-
 arch/riscv/mm/tlbflush.c             | 40 +++++++++++++++++++++++++++++++++---
 5 files changed, 63 insertions(+), 5 deletions(-)

-- 
2.7.4

