Return-Path: <linux-arch+bounces-5574-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC60939AAD
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:47:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FFC21C21B56
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D2414B950;
	Tue, 23 Jul 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sJMN+k7p"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C388136E3F;
	Tue, 23 Jul 2024 06:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717124; cv=none; b=fwZ0aBX8v6qMJ2+dteffh0nf1x78cuZLJ4u/oAipOXGp1ZJ61h0TvAPawokoka8ByZOE1jQfqgmUB9SCJ5rqK5ZEq9mE/Ym9eQG0DtQY6QQwbU8++DKqj+xtEHK8Is4z/Xr+iOYI2YerxYBa7D6PDublkijlPqctKvMtStdU8gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717124; c=relaxed/simple;
	bh=pNYfU5nbHx/fmG089PdPYGa3502wUyTtzM4zHrG8Mvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASzXJau4HM7DkAtN+JnEs/uCbauR1M36a+FrltuIxViA9EvWxbtTfLnCtqJmmxwFDyZhIhUx3o0P6UNo3rDBxxyTq+PPwKmNs+4XTspJcNZo3l2Q15acwD5TPPluG4GKn94Ijgog/fmzCC6VyzElcoWZ28FSIuy8cUxvu82vttg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sJMN+k7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA842C4AF0C;
	Tue, 23 Jul 2024 06:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717124;
	bh=pNYfU5nbHx/fmG089PdPYGa3502wUyTtzM4zHrG8Mvo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sJMN+k7pUNhxKMGnIuCjgZTlPbUXg5/os1ykrILC9mUEWtB/1tafJrHYsT3Lzg6CC
	 KxPlE4rLwAsWg/jKdXOabKO5hifhNh89+1FGJQUF+HuswOt6jRskwY16gaVvWcjg/u
	 JaaAiOp6hsF6GNf1J4jgCi5e4XLZRTtF48K7QOEb7BcTzzyd78BuVnpn+3nEetKgQf
	 pE/iZ00OiDD3XHUDQouzidclYaIdyKCfhkVnZGJn2HO5Ygy861wCszx7RSgDBl462P
	 a5O5umZhDFqU4hwmQ7pIFqaYYCMo9SUyHpQy8O0yggfld3P/JTN0RCi+SHOyn2AaAG
	 hdaJ2RE8Lgb/g==
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
Subject: [PATCH v2 16/25] x86/numa: numa_{add,remove}_cpu: make cpu parameter unsigned
Date: Tue, 23 Jul 2024 09:41:47 +0300
Message-ID: <20240723064156.4009477-17-rppt@kernel.org>
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

CPU id cannot be negative.

Making it unsigned also aligns with declarations in
include/asm-generic/numa.h used by arm64 and riscv and allows sharing
numa emulation code with these architectures.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


