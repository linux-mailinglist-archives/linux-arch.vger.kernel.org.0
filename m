Return-Path: <linux-arch+bounces-5565-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D0A939A4A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:44:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE21E1C21B36
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4EE14B06C;
	Tue, 23 Jul 2024 06:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWkFKSq6"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBC314A602;
	Tue, 23 Jul 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717019; cv=none; b=m3rOUvBTTsq/QD2V2BbRPJYnDd4hzuJQ+IOjX2bYA129Qt83jA0TakeJC3iu76CMhNF1I/A9tDjZxWcoXeHsmB1ym0zzQxBKChR+Fj06te2cXwBZ80mPFVK7G7FgB8/nOxKYwdCEAelLElA55ZGx5nC00ogHdxXIDbp4DqA9imw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717019; c=relaxed/simple;
	bh=KMUHd3pa3/sGl5j0P1xwN5TvNIt/JcquxvbUe/9/m24=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6AK/ODELuCCfIDOQLhlvXP4dnKvCiSJDrtvcB1QhVrbTQZ6dLlaBn3WFMhIDmtTVG20CfbLhELCZn4nKV0mGba8jYqd0WOF7TMZGT98PKdp0spNiQRM1MlTrtUEI4ahsyOCQD1dgzhyKvRRRG67nZw2BDLro4gtmxQTdD9qzxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWkFKSq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4FBC4AF0B;
	Tue, 23 Jul 2024 06:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717018;
	bh=KMUHd3pa3/sGl5j0P1xwN5TvNIt/JcquxvbUe/9/m24=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWkFKSq6/pd3Gz6zgozY8S3W7YN4XbwG3Jb+Xk1cnC7gLl9AmB1RBeBbxRXvm10mo
	 9bPr1wCujAi72DOi3ZZ6MxSR662xYGaP/kzvSESqPfaz1lvZuDUlpNyX5dy0tZ3lAx
	 vz+FWcxLgBq3UZrFr48M/v7opiixPXJGVSfeeBAwDCwB2EKwm/q6Ap7lwJBWSb6Ng5
	 jnpe/p1tJ4ATxte1nyJpzrRcOlfhLY+Hu2RL+8RHtYPodmwgh7+5jPEPXLaZj05dRa
	 DhWm6z0Df650Ih1lo97lRpDW1J7ogEdU4fxwaf5/0kt8pUV2Fa2hUe97zXFTJbJXes
	 bhLJjXOhO3S/w==
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
Subject: [PATCH v2 07/25] mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
Date: Tue, 23 Jul 2024 09:41:38 +0300
Message-ID: <20240723064156.4009477-8-rppt@kernel.org>
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

There are no users of HAVE_ARCH_NODEDATA_EXTENSION left, so
arch_alloc_nodedata() and arch_refresh_nodedata() are not needed
anymore.

Replace the call to arch_alloc_nodedata() in free_area_init() with
memblock_alloc(), remove arch_refresh_nodedata() and cleanup
include/linux/memory_hotplug.h from the associated ifdefery.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 include/linux/memory_hotplug.h | 48 ----------------------------------
 mm/mm_init.c                   |  3 +--
 2 files changed, 1 insertion(+), 50 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index 7a9ff464608d..978c0dfb64a1 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -16,54 +16,6 @@ struct resource;
 struct vmem_altmap;
 struct dev_pagemap;
 
-#ifdef CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
-/*
- * For supporting node-hotadd, we have to allocate a new pgdat.
- *
- * If an arch has generic style NODE_DATA(),
- * node_data[nid] = kzalloc() works well. But it depends on the architecture.
- *
- * In general, generic_alloc_nodedata() is used.
- *
- */
-extern pg_data_t *arch_alloc_nodedata(int nid);
-extern void arch_refresh_nodedata(int nid, pg_data_t *pgdat);
-
-#else /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
-
-#define arch_alloc_nodedata(nid)	generic_alloc_nodedata(nid)
-
-#ifdef CONFIG_NUMA
-/*
- * XXX: node aware allocation can't work well to get new node's memory at this time.
- *	Because, pgdat for the new node is not allocated/initialized yet itself.
- *	To use new node's memory, more consideration will be necessary.
- */
-#define generic_alloc_nodedata(nid)				\
-({								\
-	memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);	\
-})
-
-extern pg_data_t *node_data[];
-static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-	node_data[nid] = pgdat;
-}
-
-#else /* !CONFIG_NUMA */
-
-/* never called */
-static inline pg_data_t *generic_alloc_nodedata(int nid)
-{
-	BUG();
-	return NULL;
-}
-static inline void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-}
-#endif /* CONFIG_NUMA */
-#endif /* CONFIG_HAVE_ARCH_NODEDATA_EXTENSION */
-
 #ifdef CONFIG_MEMORY_HOTPLUG
 struct page *pfn_to_online_page(unsigned long pfn);
 
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 3ec04933f7fd..e1b3ea0523bd 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1831,11 +1831,10 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 
 		if (!node_online(nid)) {
 			/* Allocator not initialized yet */
-			pgdat = arch_alloc_nodedata(nid);
+			pgdat = memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);
 			if (!pgdat)
 				panic("Cannot allocate %zuB for node %d.\n",
 				       sizeof(*pgdat), nid);
-			arch_refresh_nodedata(nid, pgdat);
 		}
 
 		pgdat = NODE_DATA(nid);
-- 
2.43.0


