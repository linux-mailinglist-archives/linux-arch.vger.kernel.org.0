Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66EF42E9E7D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbhADUCr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:02:47 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:38689 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbhADUCr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:02:47 -0500
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 721C524000A;
        Mon,  4 Jan 2021 20:02:02 +0000 (UTC)
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
Subject: [RFC PATCH 03/12] riscv: Get rid of compile time logic with MAX_EARLY_MAPPING_SIZE
Date:   Mon,  4 Jan 2021 14:58:31 -0500
Message-Id: <20210104195840.1593-4-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

There is no need to compare at compile time MAX_EARLY_MAPPING_SIZE value
with PGDIR_SIZE since MAX_EARLY_MAPPING_SIZE is set to 128MB which is less
than PGDIR_SIZE that is equal to 1GB: that allows to simplify early_pmd
definition.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/mm/init.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 7b87c14f1d24..694efcc3a131 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -296,13 +296,7 @@ static void __init create_pte_mapping(pte_t *ptep,
 
 pmd_t trampoline_pmd[PTRS_PER_PMD] __page_aligned_bss;
 pmd_t fixmap_pmd[PTRS_PER_PMD] __page_aligned_bss;
-
-#if MAX_EARLY_MAPPING_SIZE < PGDIR_SIZE
-#define NUM_EARLY_PMDS		1UL
-#else
-#define NUM_EARLY_PMDS		(1UL + MAX_EARLY_MAPPING_SIZE / PGDIR_SIZE)
-#endif
-pmd_t early_pmd[PTRS_PER_PMD * NUM_EARLY_PMDS] __initdata __aligned(PAGE_SIZE);
+pmd_t early_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 pmd_t early_dtb_pmd[PTRS_PER_PMD] __initdata __aligned(PAGE_SIZE);
 
 static pmd_t *__init get_pmd_virt_early(phys_addr_t pa)
@@ -324,11 +318,9 @@ static pmd_t *get_pmd_virt_late(phys_addr_t pa)
 
 static phys_addr_t __init alloc_pmd_early(uintptr_t va)
 {
-	uintptr_t pmd_num;
+	BUG_ON((va - kernel_virt_addr) >> PGDIR_SHIFT);
 
-	pmd_num = (va - kernel_virt_addr) >> PGDIR_SHIFT;
-	BUG_ON(pmd_num >= NUM_EARLY_PMDS);
-	return (uintptr_t)&early_pmd[pmd_num * PTRS_PER_PMD];
+	return (uintptr_t)early_pmd;
 }
 
 static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
-- 
2.20.1

