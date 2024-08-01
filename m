Return-Path: <linux-arch+bounces-5811-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD539443B1
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:15:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F76A1C21871
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302D116E868;
	Thu,  1 Aug 2024 06:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cc4WvpYS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BB6158547;
	Thu,  1 Aug 2024 06:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492703; cv=none; b=YOTcPEB1A6gsifCVa1H1d1bVpq8RMUcx0zwAocKkDBAC5mQW/VpNAOhsgivVnxEJBnxCCCyPF8j6OIDL+zxNR8ZddwEettPGmR10l7kkBu2u/wrVch8WCbFc2FauxrlyejimRov95WnR3QY0gu0dJuvN7nSnkk9Ac7uEuTjMR0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492703; c=relaxed/simple;
	bh=a5wWvXp5sZfTjfQzLNJ+a5bJ5ZJPXICMVCqsCnclVEE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qx5l61nXCpFv0XL8o3MJHBLbboi9Ubz9CWvoV8KV5bc1HqZjHWgBOOL2PXoH+DpOt8H52cwO6USOahmCg21Ei1FKN2bGqcqc9IQ6zhxo0OoWlV921qKVpOq+SBt8RF8vKtyR5rSf5TgKQaxB828uF27XfGGZYvnXzk6ppC+MlLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cc4WvpYS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83720C4AF09;
	Thu,  1 Aug 2024 06:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492702;
	bh=a5wWvXp5sZfTjfQzLNJ+a5bJ5ZJPXICMVCqsCnclVEE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cc4WvpYSk2IgT7M8f19PtLCANZs9ejYsgNz/cO/n9jZN8qc0EaFo0hFRtACL2ndu9
	 6mQNevH4Cv97QgSeWny58SoJTelXG7+q/yupDHNjypMc9KfJSvH9dJkMYoPTVHXTFt
	 qOV8qLNBVKP+KQ0TDEb4IxRQJnulZa3OTDwTCKv2ZaDrPMf/7n9eMwLrQ+9DBTKaQ2
	 CscX8zJ0BsTHTjThMBHjRi6ejLjZ0Khv97xgxfXs5HKaUT5vo9NA59YW7rniE33hCD
	 LqVJKeLyrOjDdwbfYs2UANWDOREYQ7kpVO/8B3QyCKE+mrBu4NqR3hacT/uObjnyRS
	 Fd/de2lMyOA4Q==
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
Subject: [PATCH v3 15/26] x86/numa_emu: use a helper function to get MAX_DMA32_PFN
Date: Thu,  1 Aug 2024 09:08:15 +0300
Message-ID: <20240801060826.559858-16-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801060826.559858-1-rppt@kernel.org>
References: <20240801060826.559858-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

This is required to make numa emulation code architecture independent so
that it can be moved to generic code in following commits.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
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
index 9180d524cfe4..8b7c6580d268 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -868,6 +868,11 @@ void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
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


