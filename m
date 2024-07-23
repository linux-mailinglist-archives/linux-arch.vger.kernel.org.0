Return-Path: <linux-arch+bounces-5568-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 536C7939A70
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:45:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0F5D1F21E94
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B20214D29C;
	Tue, 23 Jul 2024 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DDQPEURu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17770149DF7;
	Tue, 23 Jul 2024 06:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717054; cv=none; b=IIQBxIENAAeblDTdLvpncyUtbR9hgvvthIM6/2NBey6/u8zWuUyjUpDhJcN21HJkp23EJFEOlg1g+6lpVB/4S1UzHh89mlaWh80sgiWuvX7gj6tRbAaqScFkzbrDyo24PY8s3HXZNw3aFN6bbs1EXaR/NN4Ukd9Xz1tTN+AXmlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717054; c=relaxed/simple;
	bh=EH8wWBlMwsfXjtpnY4+zGDnJa6g8CExH9y2mEtavJgs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Po6baNV3880DIad/vchPL1LHGnOTJoXO/0A9OCQt7OrtAfMUXCngHPBOcpnUcFdc+TD1INzBeTMAdqz7R7iyC22Ego0lieEAwb4PMC+WkxxT2/DWwF5dxWJm7CgiNtNsZZ6GLVHJxMpQstrczed9DFUtp2OWk0ARXDOOYun4JmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DDQPEURu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 893C4C4AF0C;
	Tue, 23 Jul 2024 06:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717053;
	bh=EH8wWBlMwsfXjtpnY4+zGDnJa6g8CExH9y2mEtavJgs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DDQPEURuf/2youpPGfR9PjjP5vqWwzVt9eMvU1zvtUy1E8FR1p79NkbmM51BKspfd
	 8pPjpSZwbogFIC5obAc5U6evqQGBM5HUm6lxVwnbAc2y0V9AQLZvJrPIWQm3H2eDUc
	 0AfSs6duiMgIPOvoZ8jr4R6aW9CMtC2gm+/GLrYx+cHgiw6adzF0OS/0yTiaEKmYmh
	 za6G0/Yrep1fQfHvALuhsHrvGHJ2rdPqnTHIGIUqj6QSFo41/n1Qco3z9vNXXkcwdU
	 WlgTUrsz908dqxlqeUh9qqehWOyfDcAflFSCUd2WnY69Xee8sgqHsaJOe1Fv5ceY/y
	 gEmEW190CPEBA==
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
Subject: [PATCH v2 10/25] x86/numa: simplify numa_distance allocation
Date: Tue, 23 Jul 2024 09:41:41 +0300
Message-ID: <20240723064156.4009477-11-rppt@kernel.org>
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

Allocation of numa_distance uses memblock_phys_alloc_range() to limit
allocation to be below the last mapped page.

But NUMA initializaition runs after the direct map is populated and
there is also code in setup_arch() that adjusts memblock limit to
reflect how much memory is already mapped in the direct map.

Simplify the allocation of numa_distance and use plain memblock_alloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/numa.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5e1dde26674b..edfc38803779 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -331,7 +331,6 @@ static int __init numa_alloc_distance(void)
 	nodemask_t nodes_parsed;
 	size_t size;
 	int i, j, cnt = 0;
-	u64 phys;
 
 	/* size the new table and allocate it */
 	nodes_parsed = numa_nodes_parsed;
@@ -342,16 +341,14 @@ static int __init numa_alloc_distance(void)
 	cnt++;
 	size = cnt * cnt * sizeof(numa_distance[0]);
 
-	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
-					 PFN_PHYS(max_pfn_mapped));
-	if (!phys) {
+	numa_distance = memblock_alloc(size, PAGE_SIZE);
+	if (!numa_distance) {
 		pr_warn("Warning: can't allocate distance table!\n");
 		/* don't retry until explicitly reset */
 		numa_distance = (void *)1LU;
 		return -ENOMEM;
 	}
 
-	numa_distance = __va(phys);
 	numa_distance_cnt = cnt;
 
 	/* fill with the default distances */
-- 
2.43.0


