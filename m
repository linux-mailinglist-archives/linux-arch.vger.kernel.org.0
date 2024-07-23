Return-Path: <linux-arch+bounces-5578-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1D80939ADE
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317251F228CE
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47B5414B976;
	Tue, 23 Jul 2024 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ntd+jqKC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D86214AD23;
	Tue, 23 Jul 2024 06:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717171; cv=none; b=rJAhwNg/pmffmH+K1yjF1ePRE4xZYv45tnzBL/vM3Ux0baODtg9z9bAqyWYI4meQ4+g3Q/nSh2HoSuRt+TiCTnTn+IL/6KKCS+shJ6QEv9fTIcpAHILcyobTVtYWE4yrvW3ehlbPMKjSm12x14GDNxJ/jUwBrLK5V/1pJ0E3Cok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717171; c=relaxed/simple;
	bh=kD57Jpdf1Sifrg0HuWEuP1eEmN5e3TwpoxqLH1SlKlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kz42/rb6cgVe3XgUeThDEQVvpBRDtfM2AeS5u6q8ixAjOsyXOWyE2UdVdN1Y2RmiwWyq5zgmxi2OL0K1VqPogM12FrRcTnmnaxMfFjPpYA95nYQqbM06TTtYiTqby7AsJ8hRNZ2S+Hqw+idiuXh+HjgKgeZTnnhVabWtIjlD+3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ntd+jqKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F421C4AF09;
	Tue, 23 Jul 2024 06:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717170;
	bh=kD57Jpdf1Sifrg0HuWEuP1eEmN5e3TwpoxqLH1SlKlc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ntd+jqKCTeoDnExqCCdBPL7lv8CDP772xGvpJYnoZB3H1j5K4RaH1Pm3hR5MWjY2F
	 mbNgHo/qOcYQJ2f3LkNpJ2aJhWE5NDhNohDv5Y9x7zkMfJqfewkRJCmGmr8Kt3hLHw
	 QOlKJXxNpgbtrruPZxfNG/pJ+VzgN6ZMT7DkBpingearXPAtfb2U0n8SibZi/+LeH0
	 x/4CucxKu2uwRSNRBQsKuBvzPemwWatFIN+LX+NZa6PcrSDsTSMSIYm/V3ac/p/Nl+
	 iXzOBbWEJbd6omVeZW9TKKP/31EDm43NyeP/lxVBXrGVoR+lfACPRO3bnQTDaDngVg
	 BbxVg2bri0umw==
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
	x86@kernel.org
Subject: [PATCH v2 20/25] mm: numa_memblks: introduce numa_memblks_init
Date: Tue, 23 Jul 2024 09:41:51 +0300
Message-ID: <20240723064156.4009477-21-rppt@kernel.org>
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

Move most of x86::numa_init() to numa_memblks so that the latter will be
more self-contained.

With this numa_memblk data structures should not be exposed to the
architecture specific code.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/numa.c           | 40 ++++-------------------------------
 include/linux/numa_memblks.h |  3 +++
 mm/numa_memblks.c            | 41 ++++++++++++++++++++++++++++++++++++
 3 files changed, 48 insertions(+), 36 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 8eb15578625e..16bc703c9272 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -115,13 +115,9 @@ void __init setup_node_to_cpumask_map(void)
 	pr_debug("Node to cpumask map for %u nodes\n", nr_node_ids);
 }
 
-static int __init numa_register_memblks(struct numa_meminfo *mi)
+static int __init numa_register_nodes(void)
 {
-	int nid, err;
-
-	err = numa_register_meminfo(mi);
-	if (err)
-		return err;
+	int nid;
 
 	if (!memblock_validate_numa_coverage(SZ_1M))
 		return -EINVAL;
@@ -171,39 +167,11 @@ static int __init numa_init(int (*init_func)(void))
 	for (i = 0; i < MAX_LOCAL_APIC; i++)
 		set_apicid_to_node(i, NUMA_NO_NODE);
 
-	nodes_clear(numa_nodes_parsed);
-	nodes_clear(node_possible_map);
-	nodes_clear(node_online_map);
-	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
-	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
-				  NUMA_NO_NODE));
-	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.reserved,
-				  NUMA_NO_NODE));
-	/* In case that parsing SRAT failed. */
-	WARN_ON(memblock_clear_hotplug(0, ULLONG_MAX));
-	numa_reset_distance();
-
-	ret = init_func();
+	ret = numa_memblks_init(init_func, /* memblock_force_top_down */ true);
 	if (ret < 0)
 		return ret;
 
-	/*
-	 * We reset memblock back to the top-down direction
-	 * here because if we configured ACPI_NUMA, we have
-	 * parsed SRAT in init_func(). It is ok to have the
-	 * reset here even if we did't configure ACPI_NUMA
-	 * or acpi numa init fails and fallbacks to dummy
-	 * numa init.
-	 */
-	memblock_set_bottom_up(false);
-
-	ret = numa_cleanup_meminfo(&numa_meminfo);
-	if (ret < 0)
-		return ret;
-
-	numa_emulation(&numa_meminfo, numa_distance_cnt);
-
-	ret = numa_register_memblks(&numa_meminfo);
+	ret = numa_register_nodes();
 	if (ret < 0)
 		return ret;
 
diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index f81f98678074..07381320848f 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -34,6 +34,9 @@ int __init numa_register_meminfo(struct numa_meminfo *mi);
 void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
 				       const struct numa_meminfo *mi);
 
+int __init numa_memblks_init(int (*init_func)(void),
+			     bool memblock_force_top_down);
+
 #ifdef CONFIG_NUMA_EMU
 int numa_emu_cmdline(char *str);
 void __init numa_emu_update_cpu_to_node(int *emu_nid_to_phys,
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index e3c3519725d4..7749b6f6b250 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -415,6 +415,47 @@ int __init numa_register_meminfo(struct numa_meminfo *mi)
 	return 0;
 }
 
+int __init numa_memblks_init(int (*init_func)(void),
+			     bool memblock_force_top_down)
+{
+	int ret;
+
+	nodes_clear(numa_nodes_parsed);
+	nodes_clear(node_possible_map);
+	nodes_clear(node_online_map);
+	memset(&numa_meminfo, 0, sizeof(numa_meminfo));
+	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.memory,
+				  NUMA_NO_NODE));
+	WARN_ON(memblock_set_node(0, ULLONG_MAX, &memblock.reserved,
+				  NUMA_NO_NODE));
+	/* In case that parsing SRAT failed. */
+	WARN_ON(memblock_clear_hotplug(0, ULLONG_MAX));
+	numa_reset_distance();
+
+	ret = init_func();
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * We reset memblock back to the top-down direction
+	 * here because if we configured ACPI_NUMA, we have
+	 * parsed SRAT in init_func(). It is ok to have the
+	 * reset here even if we did't configure ACPI_NUMA
+	 * or acpi numa init fails and fallbacks to dummy
+	 * numa init.
+	 */
+	if (memblock_force_top_down)
+		memblock_set_bottom_up(false);
+
+	ret = numa_cleanup_meminfo(&numa_meminfo);
+	if (ret < 0)
+		return ret;
+
+	numa_emulation(&numa_meminfo, numa_distance_cnt);
+
+	return numa_register_meminfo(&numa_meminfo);
+}
+
 static int __init cmp_memblk(const void *a, const void *b)
 {
 	const struct numa_memblk *ma = *(const struct numa_memblk **)a;
-- 
2.43.0


