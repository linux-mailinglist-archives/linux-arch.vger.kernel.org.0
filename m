Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 047E039521E
	for <lists+linux-arch@lfdr.de>; Sun, 30 May 2021 18:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbhE3Qv4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 30 May 2021 12:51:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:37902 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229842AbhE3Qvy (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 30 May 2021 12:51:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DAB57611EE;
        Sun, 30 May 2021 16:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622393415;
        bh=0HrILH6BshJfMkD9I3tL+9zxsVQ6ho2ivjftGmjwtWY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lGnmdIQX5/lR/bejxMh7tJmE7UZ+MI9rOdcdqtoxHKFS+WHPubf3I2WPl3MH+VwF8
         YT6OZRMK4dsErIpby31is3DMgtVvoZDkTycAgIlAMD8X/KrUeC3GSCzpzUFkBQS81e
         ttdoqbb0P5Vmh486kvmiZw4MG5KqToKxVQCFTPR9sgwF053MZ9B64TzJvTPU8izK2v
         LWLdvN7gcfGYbY5eIHgU3ukOanRhInO6tcMNhYBnof6sJ1yKHOmDH9hNa56MV/wBgw
         rG5XWP+1pVQ+jt6nINM57mnq/WlVHfYDvDc9Fx6+bso2BJhITIziSE8daBXkBuN9Jb
         Wk0ib9pMVzx1w==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de, hch@lst.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V5 1/3] riscv: Use global mappings for kernel pages
Date:   Sun, 30 May 2021 16:49:24 +0000
Message-Id: <1622393366-46079-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1622393366-46079-1-git-send-email-guoren@kernel.org>
References: <1622393366-46079-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

We map kernel pages into all addresses space, so they can be marked as
global. This allows hardware to avoid flushing the kernel mappings when
moving between address spaces.

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

