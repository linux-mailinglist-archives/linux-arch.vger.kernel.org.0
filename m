Return-Path: <linux-arch+bounces-5572-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B3D2939A9B
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBBD0B222E6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4024014E2DF;
	Tue, 23 Jul 2024 06:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NVxK/dES"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0113614C58C;
	Tue, 23 Jul 2024 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717101; cv=none; b=iiFStO6Zyxfo91695yDEqOeyMz/6r0vyZTrJ2gMM9KnRD0BtGyTPdKdNbH9k4i3OsMOY3FwKQR8E+eS4lx3g5LzTBvZ60TMWXU4p7XSuip4HA30vsx13OnUbZeJi7FfPudRR5q7Nby467QEoixNnUjSt7qAe1ZajbdVG43Bbdd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717101; c=relaxed/simple;
	bh=YsRpIjHui/E4Nyhzc91eYVtJPXNfygPjzJVhFxfItC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CYl498YTFrNjjXluA7gQi90kybPBLuMYs0CjoNlLOOD0t0sZDkii6GrA+AAd3UEd/bt948VmrctegNM96PNg7YGk9GPq2TOsCwD/Z8Fj3+zPCRkai1r3KRW/SuP9uQBunOCyUiSp75N8WUE+1VP0rZNdIDZxzjTt+YpMruxvWVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NVxK/dES; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41369C4AF0B;
	Tue, 23 Jul 2024 06:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717100;
	bh=YsRpIjHui/E4Nyhzc91eYVtJPXNfygPjzJVhFxfItC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NVxK/dESWkZTLqLMzH+QJWFfHzOuDB5Zg9jxVFrm55l8etkE62sOi/PKgAV8Do0QY
	 9rqjDpdBneIIs6hLXbaC9H5ardG4k9hNSS/24b9JnxWSwubCihG79QaFgLXjiOt26i
	 p5kfVp+usEUs2GaoIHsD2Gg+yWKdMTm1ax+yF74qZvG4LhsUAIfWXOI8A0pzR+4k2C
	 4L30n/ESR2jhEAg8I5Cgx9nuBQXnCjuKDvQSU/NlgeR8s9cl3adIfhZnMK/jclT8fC
	 sCU2WFhWD8J2tFeo6YMWlMfyl6EZSdgTeivf6nLJX9D94/RMTIzVb5nPxrBdMYvlet
	 +qODh3gpzSY0w==
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
Subject: [PATCH v2 14/25] x86/numa_emu: split __apicid_to_node update to a helper function
Date: Tue, 23 Jul 2024 09:41:45 +0300
Message-ID: <20240723064156.4009477-15-rppt@kernel.org>
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

This is required to make numa emulation code architecture independent so
that it can be moved to generic code in following commits.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 arch/x86/include/asm/numa.h  |  2 ++
 arch/x86/mm/numa.c           | 22 ++++++++++++++++++++++
 arch/x86/mm/numa_emulation.c | 14 +-------------
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index 2dab1ada96cf..7017d540894a 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -72,6 +72,8 @@ void debug_cpumask_set_cpu(int cpu, int node, bool enable);
 
 #ifdef CONFIG_NUMA_EMU
 int numa_emu_cmdline(char *str);
+void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
+					unsigned int nr_emu_nids);
 #else /* CONFIG_NUMA_EMU */
 static inline int numa_emu_cmdline(char *str)
 {
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index cfe7e5477cf8..9180d524cfe4 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -848,6 +848,28 @@ EXPORT_SYMBOL(cpumask_of_node);
 
 #endif	/* !CONFIG_DEBUG_PER_CPU_MAPS */
 
+#ifdef CONFIG_NUMA_EMU
+void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
+					unsigned int nr_emu_nids)
+{
+	int i, j;
+
+	/*
+	 * Transform __apicid_to_node table to use emulated nids by
+	 * reverse-mapping phys_nid.  The maps should always exist but fall
+	 * back to zero just in case.
+	 */
+	for (i = 0; i < ARRAY_SIZE(__apicid_to_node); i++) {
+		if (__apicid_to_node[i] == NUMA_NO_NODE)
+			continue;
+		for (j = 0; j < nr_emu_nids; j++)
+			if (__apicid_to_node[i] == emu_nid_to_phys[j])
+				break;
+		__apicid_to_node[i] = j < nr_emu_nids ? j : 0;
+	}
+}
+#endif /* CONFIG_NUMA_EMU */
+
 #ifdef CONFIG_NUMA_KEEP_MEMINFO
 static int meminfo_to_nid(struct numa_meminfo *mi, u64 start)
 {
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 439804e21962..f2746e52ab93 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -476,19 +476,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 		    ei.blk[i].nid != NUMA_NO_NODE)
 			node_set(ei.blk[i].nid, numa_nodes_parsed);
 
-	/*
-	 * Transform __apicid_to_node table to use emulated nids by
-	 * reverse-mapping phys_nid.  The maps should always exist but fall
-	 * back to zero just in case.
-	 */
-	for (i = 0; i < ARRAY_SIZE(__apicid_to_node); i++) {
-		if (__apicid_to_node[i] == NUMA_NO_NODE)
-			continue;
-		for (j = 0; j < ARRAY_SIZE(emu_nid_to_phys); j++)
-			if (__apicid_to_node[i] == emu_nid_to_phys[j])
-				break;
-		__apicid_to_node[i] = j < ARRAY_SIZE(emu_nid_to_phys) ? j : 0;
-	}
+	numa_emu_update_cpu_to_node(emu_nid_to_phys, ARRAY_SIZE(emu_nid_to_phys));
 
 	/* make sure all emulated nodes are mapped to a physical node */
 	for (i = 0; i < ARRAY_SIZE(emu_nid_to_phys); i++)
-- 
2.43.0


