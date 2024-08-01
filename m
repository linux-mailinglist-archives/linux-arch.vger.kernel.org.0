Return-Path: <linux-arch+bounces-5812-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 767719443C0
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 358F728408E
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CD016EB48;
	Thu,  1 Aug 2024 06:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkLWQm1Q"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4E5D158554;
	Thu,  1 Aug 2024 06:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492714; cv=none; b=fFA+1pfahPCiydP2gBOlMud8OyQytdzIsEZy6gOgVTSn9tI1v8+g3jiqpnN1whOJLSHmzIRFDAv0p2JypCaQF368O2VNsjXJ/GQENpucdR6jQGqeQeLxt+bYkxiX6Up55ieBUu2S5AIA6BFft8Lgl+Tn3WtaxPrj0UVxzU/ITZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492714; c=relaxed/simple;
	bh=tUveSvpmOKw9bqMG5RQ6nMnK0ZuTV9etYelIhziTeKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pwu/EXX/PoD81T6e6jZUytEToFey9wEc7B0DOP08X+GrktbcU4HPdgrAc1KEe+gbBonEdC1EOKtsu8PovFIRz2mhUAute2ZFMb9csPqQK0cW97MQ+Dgesd/O6BxXQcmurF3kJJcpqW8FXzCP9T2ZI4uYOTXN6AFokmWex/gKNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkLWQm1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 529C4C4AF09;
	Thu,  1 Aug 2024 06:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492714;
	bh=tUveSvpmOKw9bqMG5RQ6nMnK0ZuTV9etYelIhziTeKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GkLWQm1Q39ABfZyuhL6Q3SBO4x8iIO1aOYcDhmjxdECKBtds6RIO3AsP0dLgQUStG
	 QtW9mrfuZenyPBlVOdTI6i/S7REgDYRiKN1CA/IZhqIQyTIcJ90XkexFNG60he+YcW
	 nwrOGB28RY2W+r/fDE7isGmLMQjlQEUqNl+lxkKeFvYHRXETpNfOonPK6ZTeFWShkT
	 jzJ1lBRW55/u4dxl3cz/0+RXH32Yt5toq8GS93/M5oq7C7KyDwt05M6VQW3pWbSuRL
	 AZSqAJyclCGUpW1mJRDt2v/lV8TLLPtVR/5UoF3gKYIFZwKuaKKOEqL3YLG7fkgpyx
	 /3cmatQc1Tbwg==
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
Subject: [PATCH v3 16/26] x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
Date: Thu,  1 Aug 2024 09:08:16 +0300
Message-ID: <20240801060826.559858-17-rppt@kernel.org>
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

CPU id cannot be negative.

Making it unsigned also aligns with declarations in
include/asm-generic/numa.h used by arm64 and riscv and allows sharing
numa emulation code with these architectures.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
---
 arch/x86/include/asm/numa.h  | 10 +++++-----
 arch/x86/mm/numa.c           | 10 +++++-----
 arch/x86/mm/numa_emulation.c | 10 +++++-----
 3 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/numa.h b/arch/x86/include/asm/numa.h
index b22c85c1ef18..6fa5ea925aac 100644
--- a/arch/x86/include/asm/numa.h
+++ b/arch/x86/include/asm/numa.h
@@ -54,20 +54,20 @@ static inline int numa_cpu_node(int cpu)
 extern void numa_set_node(int cpu, int node);
 extern void numa_clear_node(int cpu);
 extern void __init init_cpu_to_node(void);
-extern void numa_add_cpu(int cpu);
-extern void numa_remove_cpu(int cpu);
+extern void numa_add_cpu(unsigned int cpu);
+extern void numa_remove_cpu(unsigned int cpu);
 extern void init_gi_nodes(void);
 #else	/* CONFIG_NUMA */
 static inline void numa_set_node(int cpu, int node)	{ }
 static inline void numa_clear_node(int cpu)		{ }
 static inline void init_cpu_to_node(void)		{ }
-static inline void numa_add_cpu(int cpu)		{ }
-static inline void numa_remove_cpu(int cpu)		{ }
+static inline void numa_add_cpu(unsigned int cpu)	{ }
+static inline void numa_remove_cpu(unsigned int cpu)	{ }
 static inline void init_gi_nodes(void)			{ }
 #endif	/* CONFIG_NUMA */
 
 #ifdef CONFIG_DEBUG_PER_CPU_MAPS
-void debug_cpumask_set_cpu(int cpu, int node, bool enable);
+void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable);
 #endif
 
 #ifdef CONFIG_NUMA_EMU
diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8b7c6580d268..cf7b95125d2a 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -737,12 +737,12 @@ void __init init_cpu_to_node(void)
 #ifndef CONFIG_DEBUG_PER_CPU_MAPS
 
 # ifndef CONFIG_NUMA_EMU
-void numa_add_cpu(int cpu)
+void numa_add_cpu(unsigned int cpu)
 {
 	cpumask_set_cpu(cpu, node_to_cpumask_map[early_cpu_to_node(cpu)]);
 }
 
-void numa_remove_cpu(int cpu)
+void numa_remove_cpu(unsigned int cpu)
 {
 	cpumask_clear_cpu(cpu, node_to_cpumask_map[early_cpu_to_node(cpu)]);
 }
@@ -780,7 +780,7 @@ int early_cpu_to_node(int cpu)
 	return per_cpu(x86_cpu_to_node_map, cpu);
 }
 
-void debug_cpumask_set_cpu(int cpu, int node, bool enable)
+void debug_cpumask_set_cpu(unsigned int cpu, int node, bool enable)
 {
 	struct cpumask *mask;
 
@@ -812,12 +812,12 @@ static void numa_set_cpumask(int cpu, bool enable)
 	debug_cpumask_set_cpu(cpu, early_cpu_to_node(cpu), enable);
 }
 
-void numa_add_cpu(int cpu)
+void numa_add_cpu(unsigned int cpu)
 {
 	numa_set_cpumask(cpu, true);
 }
 
-void numa_remove_cpu(int cpu)
+void numa_remove_cpu(unsigned int cpu)
 {
 	numa_set_cpumask(cpu, false);
 }
diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index fb4814497446..235f8a4eb2fa 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -514,7 +514,7 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 }
 
 #ifndef CONFIG_DEBUG_PER_CPU_MAPS
-void numa_add_cpu(int cpu)
+void numa_add_cpu(unsigned int cpu)
 {
 	int physnid, nid;
 
@@ -532,7 +532,7 @@ void numa_add_cpu(int cpu)
 			cpumask_set_cpu(cpu, node_to_cpumask_map[nid]);
 }
 
-void numa_remove_cpu(int cpu)
+void numa_remove_cpu(unsigned int cpu)
 {
 	int i;
 
@@ -540,7 +540,7 @@ void numa_remove_cpu(int cpu)
 		cpumask_clear_cpu(cpu, node_to_cpumask_map[i]);
 }
 #else	/* !CONFIG_DEBUG_PER_CPU_MAPS */
-static void numa_set_cpumask(int cpu, bool enable)
+static void numa_set_cpumask(unsigned int cpu, bool enable)
 {
 	int nid, physnid;
 
@@ -560,12 +560,12 @@ static void numa_set_cpumask(int cpu, bool enable)
 	}
 }
 
-void numa_add_cpu(int cpu)
+void numa_add_cpu(unsigned int cpu)
 {
 	numa_set_cpumask(cpu, true);
 }
 
-void numa_remove_cpu(int cpu)
+void numa_remove_cpu(unsigned int cpu)
 {
 	numa_set_cpumask(cpu, false);
 }
-- 
2.43.0


