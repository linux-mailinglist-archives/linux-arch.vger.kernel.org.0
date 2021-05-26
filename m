Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8287391029
	for <lists+linux-arch@lfdr.de>; Wed, 26 May 2021 07:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbhEZFvw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 26 May 2021 01:51:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:47636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhEZFvv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 26 May 2021 01:51:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 93CA1613F6;
        Wed, 26 May 2021 05:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622008209;
        bh=inTZKABnBrUQ84H4gADlk73DnbiHL4nyjoNWVqTyW0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DQvJYjozsY+wiG56YStah9peEx+ppXBeI/guU6j0EpYckdBAU0TPLT2PxyKsMAsV5
         5jH49GETghaDZhrwJAFsLSlSMK7TNWJYYKlOweCbKjkBMgBOW2gpgSYTxwv208pTH0
         9vwSp3oPFMPWyeEr/fAcesWRZF5TwmhWJmpFBWSFOBtD0MWaSgPZnVZN+HdWV6UoQK
         PzKxKC4L3umMW1z4nxyTk/o7SkvijnO5RJKn1fZRj6cQF2txPlvgFWysJYq/T4gOKs
         6aupWYLToU7ljMwYgEARhnviMx1EX6DUfyNPH0Lgt4K7WpCBxgkZH7NcDkmg1/PtjI
         TWOOwcbx1zu6w==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V4 1/2] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
Date:   Wed, 26 May 2021 05:49:20 +0000
Message-Id: <1622008161-41451-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622008161-41451-1-git-send-email-guoren@kernel.org>
References: <1622008161-41451-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Kernel virtual address translation should avoid to use ASIDs or it'll
cause more TLB-miss and TLB-refill. Because the current ASID in satp
belongs to the current process, but the target kernel va TLB entry's
ASID still belongs to the previous process.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 9469f46..346a3c6 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -134,7 +134,8 @@
 				| _PAGE_WRITE \
 				| _PAGE_PRESENT \
 				| _PAGE_ACCESSED \
-				| _PAGE_DIRTY)
+				| _PAGE_DIRTY \
+				| _PAGE_GLOBAL)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
 #define PAGE_KERNEL_READ	__pgprot(_PAGE_KERNEL & ~_PAGE_WRITE)
-- 
2.7.4

