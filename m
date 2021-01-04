Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFEBC2E9E95
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728040AbhADUJE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:09:04 -0500
Received: from relay2-d.mail.gandi.net ([217.70.183.194]:53675 "EHLO
        relay2-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbhADUJE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:09:04 -0500
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay2-d.mail.gandi.net (Postfix) with ESMTPSA id 4135E40007;
        Mon,  4 Jan 2021 20:08:20 +0000 (UTC)
From:   Alexandre Ghiti <alex@ghiti.fr>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Zong Li <zong.li@sifive.com>, Anup Patel <anup@brainfault.org>,
        Christoph Hellwig <hch@lst.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-efi@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Alexandre Ghiti <alex@ghiti.fr>
Subject: [RFC PATCH 09/12] riscv: Allow user to downgrade to sv39 when hw supports sv48
Date:   Mon,  4 Jan 2021 14:58:37 -0500
Message-Id: <20210104195840.1593-10-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is made possible by using the mmu-type property of the cpu node of
the device tree.

By default, the kernel will boot with 4-level page table if the hw supports
it but it can be interesting for the user to select 3-level page table as
it is less memory consuming and faster since it requires less memory
accesses in case of a TLB miss.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/mm/init.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index cb23a30d9af3..f9a99cb1870b 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -550,10 +550,32 @@ void disable_pgtable_l4(void)
  * then read SATP to see if the configuration was taken into account
  * meaning sv48 is supported.
  */
-asmlinkage __init void set_satp_mode(uintptr_t load_pa)
+asmlinkage __init void set_satp_mode(uintptr_t load_pa, uintptr_t dtb_pa)
 {
 	u64 identity_satp, hw_satp;
+	int cpus_node;
 
+	/* 1/ Check if the user asked for sv39 explicitly in the device tree */
+	cpus_node = fdt_path_offset((void *)dtb_pa, "/cpus");
+	if (cpus_node >= 0) {
+		int node;
+
+		fdt_for_each_subnode(node, (void *)dtb_pa, cpus_node) {
+			const char *mmu_type = fdt_getprop((void *)dtb_pa, node,
+							"mmu-type", NULL);
+			if (!mmu_type)
+				continue;
+
+			if (!strcmp(mmu_type, "riscv,sv39")) {
+				disable_pgtable_l4();
+				return;
+			}
+
+			break;
+		}
+	}
+
+	/* 2/ Determine if the HW supports sv48: if not, fallback to sv39 */
 	create_pgd_mapping(early_pg_dir, load_pa, (uintptr_t)early_pud,
 			   PGDIR_SIZE, PAGE_TABLE);
 	create_pud_mapping(early_pud, load_pa, (uintptr_t)early_pmd,
@@ -611,7 +633,7 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
 #endif
 
 #if defined(CONFIG_64BIT) && !defined(CONFIG_MAXPHYSMEM_2GB)
-	set_satp_mode(load_pa);
+	set_satp_mode(load_pa, dtb_pa);
 #endif
 
 	kernel_virt_addr = KERNEL_VIRT_ADDR;
-- 
2.20.1

