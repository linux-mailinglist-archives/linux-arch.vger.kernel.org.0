Return-Path: <linux-arch+bounces-5415-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC7B932527
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 13:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9B491F20F22
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 11:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527819A290;
	Tue, 16 Jul 2024 11:15:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aUg6c6D0"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17B791991A4;
	Tue, 16 Jul 2024 11:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128548; cv=none; b=SI93DJ4gFeFiG0V8pjfyQ2l3AGviKlNV+2l0uXersP1ctn57SvsM1+F37G+O7AUOL55ex1J4VFMb6y52kXFTppSzzbxfCllMm9eCjJv9ziWjEKUd+Fu1I6Wn5ezlriw2+QVmHcCKcTXQhCYLsMxKxkNEkty+x4cFf4MO4sCNweY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128548; c=relaxed/simple;
	bh=ym0kawqEGV0FNmvOsYm3DWOKfdlDmSXOdSkjneozt3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HgzSxOwZUi9LrwxE5xeXWgr8gF8QoRpNWA9lcSaCrBDKufuR/CJ6zRPULAZA1d5iIIzNO4s87y5c9C2+Nm12qXWkLqogP9H3WKb24sowdhiPvYE9Yx5EUubcYJee2/bHM4GsoEYxzSZPQ/5Zuo9bEOxK8a50RSyXXalW2R7t14k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aUg6c6D0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17FC9C4AF0F;
	Tue, 16 Jul 2024 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128547;
	bh=ym0kawqEGV0FNmvOsYm3DWOKfdlDmSXOdSkjneozt3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aUg6c6D0pXxFYfxdCla0UlGGSb+fzaMJ98PhtEuPZ4xlpOrwMZNzxrunxPvcfDdc7
	 NXufJhNRBO67I6yVAwRrB24yf+HtAH8pnnvS0xcP/IRbHEWL7yqiHMbLPL3az/7dke
	 kLw1+nQiaSDwkyvjoNw2D0R3dN+SnBi06HG1s3TOoOvNCDUXV5ucaNQK1Kbys49hx6
	 /juYk12sHgDnrQrIMEwtmEumKOES0H1okVRE5+R168aRmF+qYQ4ppw/Kfra4PrNfW3
	 YhaZIeYTe6w4tK9Ox3H4968ZbRGp43kkC7vp81Gd13qPzugi8VN9tKHerIr0CKBuPG
	 CUc4ZCR6v33eg==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 10/17] x86/numa_emu: use a helper function to get MAX_DMA32_PFN
Date: Tue, 16 Jul 2024 14:13:39 +0300
Message-ID: <20240716111346.3676969-11-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716111346.3676969-1-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

This is required to make numa emulation code architecture independent s
that it can be moved to generic code in following commits.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/include/asm/numa.h  | 1 +
 arch/x86/mm/numa.c           | 5 +++++
 arch/x86/mm/numa_emulation.c | 4 ++--
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 7017d540894a..b22c85c1ef18 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -74,6 +74,7 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enable);
 int numa_emu_cmdline(char *str);
 void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
 					unsigned int nr_emu_nids);
+u64 __init numa_emu_dma_end(void);
 #else /* CONFIG_NUMA_EMU */
 static inline int numa_emu_cmdline(char *str)
 {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 1320d776caed..0a59e3ceecda 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -872,6 +872,11 @@ void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
 		__apicid_to_node[i] = j < nr_emu_nids ? j : 0;
 	}
 }
+
+u64 __init numa_emu_dma_end(void)
+{
+	return PFN_PHYS(MAX_DMA32_PFN);
+}
 #endif /* CONFIG_NUMA_EMU */
 
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index f2746e52ab93..fb4814497446 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -128,7 +128,7 @@ static int __init split_nodes_interleave(struct numa_meminfo *ei,
 	 */
 	while (!nodes_empty(physnode_mask)) {
 		for_each_node_mask(i, physnode_mask) {
-			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
+			u64 dma32_end = numa_emu_dma_end();
 			u64 start, limit, end;
 			int phys_blk;
 
@@ -275,7 +275,7 @@ static int __init split_nodes_size_interleave_uniform(struct numa_meminfo *ei,
 	 */
 	while (!nodes_empty(physnode_mask)) {
 		for_each_node_mask(i, physnode_mask) {
-			u64 dma32_end = PFN_PHYS(MAX_DMA32_PFN);
+			u64 dma32_end = numa_emu_dma_end();
 			u64 start, limit, end;
 			int phys_blk;
 
-- 
2.43.0


