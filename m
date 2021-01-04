Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09EDD2E9EA2
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:12:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbhADULJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:11:09 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:45607 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728011AbhADULJ (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:11:09 -0500
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 756C5E0008;
        Mon,  4 Jan 2021 20:10:25 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Subject: [RFC PATCH 11/12] riscv: Explicit comment about user virtual address space size
Date:   Mon,  4 Jan 2021 14:58:39 -0500
Message-Id: <20210104195840.1593-12-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Define precisely the size of the user accessible virtual space size
for sv32/39/48 mmu types and explain why the whole virtual address
space is split into 2 equal chunks between kernel and user space.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/include/asm/pgtable.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 95721016049d..360858cdbfdd 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -465,8 +465,15 @@ static inline int ptep_clear_flush_young(struct vm_area_struct *vma,
 #endif
 
 /*
- * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
- * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
+ * Task size is:
+ * -     0x9fc00000 (~2.5GB) for RV32.
+ * -   0x4000000000 ( 256GB) for RV64 using SV39 mmu
+ * - 0x800000000000 ( 128TB) for RV64 using SV48 mmu
+ *
+ * Note that PGDIR_SIZE must evenly divide TASK_SIZE since "RISC-V
+ * Instruction Set Manual Volume II: Privileged Architecture" states that
+ * "load and store effective addresses, which are 64bits, must have bits
+ * 63–48 all equal to bit 47, or else a page-fault exception will occur."
  */
 #ifdef CONFIG_64BIT
 #define TASK_SIZE	(PGDIR_SIZE * PTRS_PER_PGD / 2)
-- 
2.20.1

