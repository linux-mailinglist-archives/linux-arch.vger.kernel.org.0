Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3038A38F84D
	for <lists+linux-arch@lfdr.de>; Tue, 25 May 2021 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230090AbhEYCss (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 22:48:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:49386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229986AbhEYCss (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 22:48:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 491FF613F5;
        Tue, 25 May 2021 02:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621910839;
        bh=idAratzNTXPgcm61LdWO/f8aWakVRytFHu0GjCWMvLo=;
        h=From:To:Cc:Subject:Date:From;
        b=jzkgyT3GM9/C4MyH0ZehSbxHe//2BASxk8pYw3ziq54naHYtRIfoEXtbZjd9U4pFt
         2P5I04cQ40m4m6B+TWs7ydTKnDV7lz9pYtYDi1UcwzrMtDwkNSj9ULDPeI7D5bjTar
         XT5UW3bKZRJFwn3OOeJ5lhNK2R2931UCFZC7Qer5PWbjFTyi6VJspgb00XBdJg8A29
         aB/LHouaCOzV8UgGftJKvJXIZlh9QhdUuIUcZcSCdOLbM7aMFoSGjhu7ZYJPbP0oIv
         Hu8YWcG6tWQyN7aKUSrEguuqXQhcPWMdydmhrXjHHXWc4qgrm1CigrAH/6CfOcIwgI
         ca9W0gSJF9K1g==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 0/2] riscv: Fixup asid_allocator remaining issues
Date:   Tue, 25 May 2021 02:46:25 +0000
Message-Id: <1621910787-34598-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The patchset fixes the remaining problems of asid_allocator.
 - Fixup _PAGE_GLOBAL for kernel virtual address mapping
 - Optimize tlb_flush with asid & range

Changes since v1:
 - Drop PAGE_UP wrong fixup
 - Rebase on clean linux-5.13-rc2
 - Add Reviewed-by

Guo Ren (2):
  riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
  riscv: Use use_asid_allocator flush TLB

 arch/riscv/include/asm/mmu_context.h |  2 ++
 arch/riscv/include/asm/pgtable.h     |  3 ++-
 arch/riscv/include/asm/tlbflush.h    | 22 ++++++++++++++++++++
 arch/riscv/mm/context.c              |  2 +-
 arch/riscv/mm/tlbflush.c             | 40 +++++++++++++++++++++++++++++++++---
 5 files changed, 64 insertions(+), 5 deletions(-)

-- 
2.7.4

