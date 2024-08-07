Return-Path: <linux-arch+bounces-6080-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD1794A04C
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A6DCB2696A
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E688B1B9B40;
	Wed,  7 Aug 2024 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Du37ztns"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A448A1B86DA;
	Wed,  7 Aug 2024 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012988; cv=none; b=p0B+XNezc2fILx04pN51GnN34PJ2g/W6H9HmlJeTk1HmsbmvKgVTIgLVDRqB0OUqF+wWr8h310qOAN7HNTVfZknwULnW/izO5WGB+CdocIdS9p6v1vmwnYXNDH3D0mTPJ1ooE4p3BDUuaJiFDKbXCo7eyAwdWOVKil830EBzzto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012988; c=relaxed/simple;
	bh=e2bRBXW1tVG35BfXPznN2F4VBaEe2hanvO4z/dzE1s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ggd7RkiY7lCOeu8vUnqzhyzs/knp0141LgEE6KFQWSQZ2OjxpQCCE7Ufx/dggChdD+d3ipA5l6hlXxPbTa8kW0musLnrn7sBzgUNlsOg9fOlffRrmV4cf+VMO0jyxQKNN8VczIg3YnfrG+HuOsXDl/HIm5WIoh9+gdR3915uXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Du37ztns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13981C4AF0E;
	Wed,  7 Aug 2024 06:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723012988;
	bh=e2bRBXW1tVG35BfXPznN2F4VBaEe2hanvO4z/dzE1s4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Du37ztnse1Ii8FvthWxnQmQGrffnOCM7CijKaU8GwxbNiaKrxeHgT5CcgcRvQX0d4
	 7HnSOfSXHdLWNTud3qgp0veIEysIAEAuZkoTNTPOKfdgleEPMEJRWikkynQIyRe1yI
	 PYkEynGrNkSreZ/8nN7vqwwZumQyHZ+V85KYkY8NpS0OoDkgzVRgDCVOVEnjaLxTpC
	 NlbrppOOSqutT7CXORlXHtDvIrsHJ6ofqFyxmrbuD95Ad1BMf+KVt//l0Z09zmyqus
	 0mvuhylxy2Cjmkln1PiqBSMUnGadwLQb6YB/RQtwdpQgl1NqlwtNMT2mp4rUFQxaqM
	 Bh/E5qKQvDtew==
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
Subject: [PATCH v4 08/26] mm: drop CONFIG_HAVE_ARCH_NODEDATA_EXTENSION
Date: Wed,  7 Aug 2024 09:40:52 +0300
Message-ID: <20240807064110.1003856-9-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807064110.1003856-1-rppt@kernel.org>
References: <20240807064110.1003856-1-rppt@kernel.org>
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

Replace the call to arch_alloc_nodedata() in free_area_init() with a
new helper alloc_offline_node_data(), remove arch_refresh_nodedata()
and cleanup include/linux/memory_hotplug.h from the associated
ifdefery.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
Acked-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memory_hotplug.h | 48 ----------------------------------
 include/linux/numa.h           |  4 +++
 mm/mm_init.c                   | 10 ++-----
 mm/numa.c                      | 12 +++++++++
 4 files changed, 18 insertions(+), 56 deletions(-)

diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index ebe876930e78..b27ddce5d324 100644
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
 
diff --git a/include/linux/numa.h b/include/linux/numa.h
index e5841d4057ab..b41b1569781b 100644
--- a/include/linux/numa.h
+++ b/include/linux/numa.h
@@ -33,6 +33,8 @@ static inline bool numa_valid_node(int nid)
 extern struct pglist_data *node_data[];
 #define NODE_DATA(nid)	(node_data[nid])
 
+void __init alloc_offline_node_data(int nid);
+
 /* Generic implementation available */
 int numa_nearest_node(int node, unsigned int state);
 
@@ -60,6 +62,8 @@ static inline int phys_to_target_node(u64 start)
 {
 	return 0;
 }
+
+static inline void alloc_offline_node_data(int nid) {}
 #endif
 
 #define numa_map_to_online_node(node) numa_nearest_node(node, N_ONLINE)
diff --git a/mm/mm_init.c b/mm/mm_init.c
index 75c3bd42799b..2785be04e7bb 100644
--- a/mm/mm_init.c
+++ b/mm/mm_init.c
@@ -1836,14 +1836,8 @@ void __init free_area_init(unsigned long *max_zone_pfn)
 	for_each_node(nid) {
 		pg_data_t *pgdat;
 
-		if (!node_online(nid)) {
-			/* Allocator not initialized yet */
-			pgdat = arch_alloc_nodedata(nid);
-			if (!pgdat)
-				panic("Cannot allocate %zuB for node %d.\n",
-				       sizeof(*pgdat), nid);
-			arch_refresh_nodedata(nid, pgdat);
-		}
+		if (!node_online(nid))
+			alloc_offline_node_data(nid);
 
 		pgdat = NODE_DATA(nid);
 		free_area_init_node(nid);
diff --git a/mm/numa.c b/mm/numa.c
index 8c157d41c026..64e1b7d2c1ee 100644
--- a/mm/numa.c
+++ b/mm/numa.c
@@ -6,6 +6,18 @@
 struct pglist_data *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
 
+void __init alloc_offline_node_data(int nid)
+{
+	pg_data_t *pgdat;
+
+	pgdat = memblock_alloc(sizeof(*pgdat), SMP_CACHE_BYTES);
+	if (!pgdat)
+		panic("Cannot allocate %zuB for node %d.\n",
+		      sizeof(*pgdat), nid);
+
+	node_data[nid] = pgdat;
+}
+
 /* Stub functions: */
 
 #ifndef memory_add_physaddr_to_nid
-- 
2.43.0


