Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 706CA2E9E8D
	for <lists+linux-arch@lfdr.de>; Mon,  4 Jan 2021 21:07:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbhADUF6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 Jan 2021 15:05:58 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:48603 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727837AbhADUFz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 4 Jan 2021 15:05:55 -0500
X-Originating-IP: 90.112.190.212
Received: from debian.home (lfbn-gre-1-231-212.w90-112.abo.wanadoo.fr [90.112.190.212])
        (Authenticated sender: alex@ghiti.fr)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 53D97E0002;
        Mon,  4 Jan 2021 20:05:11 +0000 (UTC)
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
Subject: [RFC PATCH 06/12] riscv: Prepare ptdump for vm layout dynamic addresses
Date:   Mon,  4 Jan 2021 14:58:34 -0500
Message-Id: <20210104195840.1593-7-alex@ghiti.fr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210104195840.1593-1-alex@ghiti.fr>
References: <20210104195840.1593-1-alex@ghiti.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

This is a preparatory patch for sv48 support that will introduce
dynamic PAGE_OFFSET.

Dynamic PAGE_OFFSET implies that all zones (vmalloc, vmemmap, fixaddr...)
whose addresses depend on PAGE_OFFSET become dynamic and can't be used
to statically initialize the array used by ptdump to identify the
different zones of the vm layout.

Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
Reviewed-by: Anup Patel <anup@brainfault.org>
---
 arch/riscv/mm/ptdump.c | 56 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/arch/riscv/mm/ptdump.c b/arch/riscv/mm/ptdump.c
index ace74dec7492..1be2ca81f8ad 100644
--- a/arch/riscv/mm/ptdump.c
+++ b/arch/riscv/mm/ptdump.c
@@ -58,29 +58,50 @@ struct ptd_mm_info {
 	unsigned long end;
 };
 
+enum address_markers_idx {
+#ifdef CONFIG_KASAN
+	KASAN_SHADOW_START_NR,
+	KASAN_SHADOW_END_NR,
+#endif
+	FIXMAP_START_NR,
+	FIXMAP_END_NR,
+	PCI_IO_START_NR,
+	PCI_IO_END_NR,
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	VMEMMAP_START_NR,
+	VMEMMAP_END_NR,
+#endif
+	VMALLOC_START_NR,
+	VMALLOC_END_NR,
+	PAGE_OFFSET_NR,
+    KERNEL_MAPPING_NR,
+	END_OF_SPACE_NR
+};
+
 static struct addr_marker address_markers[] = {
 #ifdef CONFIG_KASAN
 	{KASAN_SHADOW_START,	"Kasan shadow start"},
 	{KASAN_SHADOW_END,	"Kasan shadow end"},
 #endif
-	{FIXADDR_START,		"Fixmap start"},
-	{FIXADDR_TOP,		"Fixmap end"},
-	{PCI_IO_START,		"PCI I/O start"},
-	{PCI_IO_END,		"PCI I/O end"},
+	{0,			"Fixmap start"},
+	{0,			"Fixmap end"},
+	{0,			"PCI I/O start"},
+	{0,			"PCI I/O end"},
 #ifdef CONFIG_SPARSEMEM_VMEMMAP
-	{VMEMMAP_START,		"vmemmap start"},
-	{VMEMMAP_END,		"vmemmap end"},
+	{0,			"vmemmap start"},
+	{0,			"vmemmap end"},
 #endif
-	{VMALLOC_START,		"vmalloc() area"},
-	{VMALLOC_END,		"vmalloc() end"},
-	{PAGE_OFFSET,		"Linear mapping"},
+	{0,			"vmalloc() area"},
+	{0,			"vmalloc() end"},
+	{0,			"Linear mapping"},
+	{0,			"Kernel mapping (kernel, BPF, modules)"},
 	{-1, NULL},
 };
 
 static struct ptd_mm_info kernel_ptd_info = {
 	.mm		= &init_mm,
 	.markers	= address_markers,
-	.base_addr	= KERN_VIRT_START,
+	.base_addr	= 0,
 	.end		= ULONG_MAX,
 };
 
@@ -335,6 +356,21 @@ static int ptdump_init(void)
 {
 	unsigned int i, j;
 
+	address_markers[FIXMAP_START_NR].start_address = FIXADDR_START;
+	address_markers[FIXMAP_END_NR].start_address = FIXADDR_TOP;
+	address_markers[PCI_IO_START_NR].start_address = PCI_IO_START;
+	address_markers[PCI_IO_END_NR].start_address = PCI_IO_END;
+#ifdef CONFIG_SPARSEMEM_VMEMMAP
+	address_markers[VMEMMAP_START_NR].start_address = VMEMMAP_START;
+	address_markers[VMEMMAP_END_NR].start_address = VMEMMAP_END;
+#endif
+	address_markers[VMALLOC_START_NR].start_address = VMALLOC_START;
+	address_markers[VMALLOC_END_NR].start_address = VMALLOC_END;
+	address_markers[PAGE_OFFSET_NR].start_address = PAGE_OFFSET;
+	address_markers[KERNEL_MAPPING_NR].start_address = KERNEL_LINK_ADDR;
+
+	kernel_ptd_info.base_addr = KERN_VIRT_START;
+
 	for (i = 0; i < ARRAY_SIZE(pg_level); i++)
 		for (j = 0; j < ARRAY_SIZE(pte_bits); j++)
 			pg_level[i].mask |= pte_bits[j].mask;
-- 
2.20.1

