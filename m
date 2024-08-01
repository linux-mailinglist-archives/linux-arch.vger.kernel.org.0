Return-Path: <linux-arch+bounces-5817-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AE6B9443F3
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEC331F23BE5
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0470116F0EF;
	Thu,  1 Aug 2024 06:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QHe/KHJa"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC9915821D;
	Thu,  1 Aug 2024 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492772; cv=none; b=PYEQBhPbj+4Sf/XeRhUkOd6WQXdbjdcyGzGLmn9CZg8WeiY1QQiqM+bwBcXCzqIlWJkOVoHUWL1Fa5cgAHAtqf9GRvVwzQDu+JlhBL7mO/6Iggy5bzy8Ugnbz94peCU3CJHmaQEWYJGQtk/6n7NiwDkWJyxaoY8tw64S5j86WaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492772; c=relaxed/simple;
	bh=Kiw+lzJCjsSsbhtIZxwLgv2SD/DXB55tpwh9QzdUDmc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O9K5EulzRDrHDrSgjv8tT7J90z21a694agqBvxYPFKmyaxAi5i0x10ULI6pdJzwvG11VxCovNcww/11RbYDtKhr0bL4yjCpAQ2T9qHUD2z70BEJvEjPZb3KWGrWJteMddC6IQM+wGRsVZOFcKDgzKKYnTcD54Qizc9L7kOZMOek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QHe/KHJa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927C8C4AF12;
	Thu,  1 Aug 2024 06:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492772;
	bh=Kiw+lzJCjsSsbhtIZxwLgv2SD/DXB55tpwh9QzdUDmc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QHe/KHJazM0v/nplwG5s3+ZVp/L2jgEbi1dAA7kI36bQHQxVX67pLYADN6L10kJez
	 yB/53N0Q6hEdBC2SFahsylWI7nBaESLR3DQq2JsYEHiBImr934xtOyvm4Z+SfO8iQG
	 LCkv8QIpMxgOYCqnzXm2hQ+RmGiMgU9Fy/sfAbU/d8mtdH0DJnmOPORi9XAhK9MrE4
	 lmeVablRXPU4gYsaPkvkeWWr/GbW4Dcgn54JwPrphIWIvmniKt3v3q5RtSdrip1m1m
	 FhwTi4fe9PMGKjpCUukzkntyFCkMvHWoPk0cZQKJm2g1mBaf93NkCaLD4VAP1UMVr4
	 iTlOfkJLht9Zw==
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
Subject: [PATCH v3 21/26] mm: numa_memblks: make several functions and variables static
Date: Thu,  1 Aug 2024 09:08:21 +0300
Message-ID: <20240801060826.559858-22-rppt@kernel.org>
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

Make functions and variables that are exclusively used by numa_memblks
static.

Move numa_nodemask_from_meminfo() before its callers to avoid forward
declaration.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
---
 include/linux/numa_memblks.h |  8 --------
 mm/numa_memblks.c            | 36 ++++++++++++++++++------------------
 2 files changed, 18 insertions(+), 26 deletions(-)

diff --git a/include/linux/numa_memblks.h b/include/linux/numa_memblks.h
index 07381320848f..5c6e12ad0b7a 100644
--- a/include/linux/numa_memblks.h
+++ b/include/linux/numa_memblks.h
@@ -7,7 +7,6 @@
 
 #define NR_NODE_MEMBLKS		(MAX_NUMNODES * 2)
 
-extern int numa_distance_cnt;
 void __init numa_set_distance(int from, int to, int distance);
 void __init numa_reset_distance(void);
 
@@ -22,17 +21,10 @@ struct numa_meminfo {
 	struct numa_memblk	blk[NR_NODE_MEMBLKS];
 };
 
-extern struct numa_meminfo numa_meminfo __initdata_or_meminfo;
-extern struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
-
 int __init numa_add_memblk(int nodeid, u64 start, u64 end);
 void __init numa_remove_memblk_from(int idx, struct numa_meminfo *mi);
 
 int __init numa_cleanup_meminfo(struct numa_meminfo *mi);
-int __init numa_register_meminfo(struct numa_meminfo *mi);
-
-void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
-				       const struct numa_meminfo *mi);
 
 int __init numa_memblks_init(int (*init_func)(void),
 			     bool memblock_force_top_down);
diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index 7749b6f6b250..e97665a5e8ce 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -7,13 +7,27 @@
 #include <linux/numa.h>
 #include <linux/numa_memblks.h>
 
-int numa_distance_cnt;
+static int numa_distance_cnt;
 static u8 *numa_distance;
 
 nodemask_t numa_nodes_parsed __initdata;
 
-struct numa_meminfo numa_meminfo __initdata_or_meminfo;
-struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
+static struct numa_meminfo numa_meminfo __initdata_or_meminfo;
+static struct numa_meminfo numa_reserved_meminfo __initdata_or_meminfo;
+
+/*
+ * Set nodes, which have memory in @mi, in *@nodemask.
+ */
+static void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
+					      const struct numa_meminfo *mi)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
+		if (mi->blk[i].start != mi->blk[i].end &&
+		    mi->blk[i].nid != NUMA_NO_NODE)
+			node_set(mi->blk[i].nid, *nodemask);
+}
 
 /**
  * numa_reset_distance - Reset NUMA distance table
@@ -290,20 +304,6 @@ int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 	return 0;
 }
 
-/*
- * Set nodes, which have memory in @mi, in *@nodemask.
- */
-void __init numa_nodemask_from_meminfo(nodemask_t *nodemask,
-				       const struct numa_meminfo *mi)
-{
-	int i;
-
-	for (i = 0; i < ARRAY_SIZE(mi->blk); i++)
-		if (mi->blk[i].start != mi->blk[i].end &&
-		    mi->blk[i].nid != NUMA_NO_NODE)
-			node_set(mi->blk[i].nid, *nodemask);
-}
-
 /*
  * Mark all currently memblock-reserved physical memory (which covers the
  * kernel's own memory ranges) as hot-unswappable.
@@ -371,7 +371,7 @@ static void __init numa_clear_kernel_node_hotplug(void)
 	}
 }
 
-int __init numa_register_meminfo(struct numa_meminfo *mi)
+static int __init numa_register_meminfo(struct numa_meminfo *mi)
 {
 	int i;
 
-- 
2.43.0


