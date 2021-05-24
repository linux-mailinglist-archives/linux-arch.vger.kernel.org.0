Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C92B38E135
	for <lists+linux-arch@lfdr.de>; Mon, 24 May 2021 08:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232266AbhEXGxY (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 24 May 2021 02:53:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:60518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232238AbhEXGxY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 24 May 2021 02:53:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6A9CF6105A;
        Mon, 24 May 2021 06:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621839116;
        bh=hn/pNdORUktwb876bgR0Q9d7/7wCHAT4MmtogXIo1fI=;
        h=From:To:Cc:Subject:Date:From;
        b=OyLPKyKN4zCBvU1tXo+4+eiqPf0uANbR6+w/b1cVC6Hb6dyNlVHepztt/rGDEDz3S
         QAJ4G661BTNRHFqAsX7vn2T9uldInvS0oEc/jRsgscxg3Xo7CQGDzsy2449DxBtmsP
         eSKyh3moIbEbOZfntQbDUui/mYqJUBYDmg5RJDod/X6QQwxyosXHNQNlreC0k3+lo0
         j1ZMCqqjh6d+xn/ZDbyq9NYzsUn/gutXKm8ixERLfxWudQoVvgbx1r7jHPt14GdXj7
         tzMq5Q4YWwpfYz19ZUdjJK7eYdZWyGcEPpFfo/L7OOqfkRfz+23uraImrNrf3rOct/
         tM1L24PbV4j9g==
From:   guoren@kernel.org
To:     guoren@kernel.org, anup.patel@wdc.com, palmerdabbelt@google.com,
        arnd@arndb.de
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/3] riscv: Fixup _PAGE_GLOBAL in _PAGE_KERNEL
Date:   Mon, 24 May 2021 06:51:06 +0000
Message-Id: <1621839068-31738-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Kernel virtual address translation should avoid care asid or it'll
cause more TLB-miss and TLB-refill. Because the current asid in satp
belongs to the current process, but the target kernel va TLB entry's
asid still belongs to the previous process.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Anup Patel <anup.patel@wdc.com>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 78f2323..017da15 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -135,6 +135,7 @@
 				| _PAGE_PRESENT \
 				| _PAGE_ACCESSED \
 				| _PAGE_DIRTY \
+				| _PAGE_GLOBAL \
 				| _PAGE_CACHE)
 
 #define PAGE_KERNEL		__pgprot(_PAGE_KERNEL)
-- 
2.7.4

