Return-Path: <linux-arch+bounces-5563-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A235939A3A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D8061C21B59
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31DA214AD0A;
	Tue, 23 Jul 2024 06:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OfSN7mfv"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAFD513CF85;
	Tue, 23 Jul 2024 06:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716996; cv=none; b=aEtzwLJCE81hxSoBrvrv5ywR1Bt2WA3LB52uqjc8jkMkSRo6OvvYyECdjY2OlVdrU3CYM1Y7OvTB5bPkXXroHjINgY4Sy3xnSpV82C6bhM9kv53mgPk2Ziabdvg8rf7BMGzy3yfb669f3yz1S7lbIKKBy5XNcaXW975PH1gcE4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716996; c=relaxed/simple;
	bh=jUiExhtxbXLJEeICWPE63efzW6eqLaOxDv+h7X1UR1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDL40Ab7WKVV3zxQaugXKc04/7AH8MiOM3DdhOz+A6rpSvhurbgFlgG/TsxJ3Px5nZu5uerus+Iad2xKaJ0P31aH0bF/CASdNiNEkVsyllJyGEuAgEjVD0/4eh6UtCpndbNvKYpo1L82yKEWyR0RBjYO1OTXuZ6U6cyBk5EdREE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OfSN7mfv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A439C4AF0F;
	Tue, 23 Jul 2024 06:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721716995;
	bh=jUiExhtxbXLJEeICWPE63efzW6eqLaOxDv+h7X1UR1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OfSN7mfvIUHKBfqIhZu4h7qRRVMm+y8oNmA1PZ8IOgiRONyTkevyAn920tkmmmcKr
	 xpP457bzAjQ5o9Old6pNpgfaMN77kH+wg/flNiNsqar5IJx3UlJfc28GlDvb8g/Nki
	 8YLM7G4hBB754wH8MzGzVejX8YEGGOFCBD+gjj204V9qWaf5iAgw1msKGw+93wNdiU
	 Y/T9WsphBVb4jLUNIMh8fHzvQY7N57NFxeSu7sOI1PkKRtoBgEoaNx50ekhLLAYrkT
	 rCehBGnW5IqnZfy3tDX8e9KwEEcASO0sRUWPNvbMrIy6RXKo7V247p2U1rVniZYinl
	 SIgVomUX1tYbQ==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	Zi Yan <ziy@nvidia.com>,
	devicetree@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	nvdimm@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [PATCH v2 05/25] MIPS: loongson64: rename __node_data to node_data
Date: Tue, 23 Jul 2024 09:41:36 +0300
Message-ID: <20240723064156.4009477-6-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240723064156.4009477-1-rppt@kernel.org>
References: <20240723064156.4009477-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Make definition of node_data match other architectures.
This will allow pulling declaration of node_data to the generic mm code in
the following commit.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/mips/include/asm/mach-loongson64/mmzone.h | 4 ++--
 arch/mips/loongson64/numa.c                    | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/mips/include/asm/mach-loongson64/mmzone.h b/arch/mips/include/asm/mach-loongson64/mmzone.h
index a3d65d37b8b5..2effd5f8ed62 100644
--- a/arch/mips/include/asm/mach-loongson64/mmzone.h
+++ b/arch/mips/include/asm/mach-loongson64/mmzone.h
@@ -14,9 +14,9 @@
 #define pa_to_nid(addr)  (((addr) & 0xf00000000000) >> NODE_ADDRSPACE_SHIFT)
 #define nid_to_addrbase(nid) ((unsigned long)(nid) << NODE_ADDRSPACE_SHIFT)
 
-extern struct pglist_data *__node_data[];
+extern struct pglist_data *node_data[];
 
-#define NODE_DATA(n)		(__node_data[n])
+#define NODE_DATA(n)		(node_data[n])
 
 extern void __init prom_init_numa_memory(void);
 
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 68dafd6d3e25..b50ce28d2741 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -29,8 +29,8 @@
 
 unsigned char __node_distances[MAX_NUMNODES][MAX_NUMNODES];
 EXPORT_SYMBOL(__node_distances);
-struct pglist_data *__node_data[MAX_NUMNODES];
-EXPORT_SYMBOL(__node_data);
+struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 
 cpumask_t __node_cpumask[MAX_NUMNODES];
 EXPORT_SYMBOL(__node_cpumask);
@@ -107,7 +107,7 @@ static void __init node_mem_init(unsigned int node)
 	tnid = early_pfn_to_nid(nd_pa >> PAGE_SHIFT);
 	if (tnid != node)
 		pr_info("NODE_DATA(%d) on node %d\n", node, tnid);
-	__node_data[node] = nd;
+	node_data[node] = nd;
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
 
@@ -206,5 +206,5 @@ pg_data_t * __init arch_alloc_nodedata(int nid)
 
 void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
 {
-	__node_data[nid] = pgdat;
+	node_data[nid] = pgdat;
 }
-- 
2.43.0


