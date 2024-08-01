Return-Path: <linux-arch+bounces-5806-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3832A94437A
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3F8B235CF
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C855B16B38E;
	Thu,  1 Aug 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzrrpwSU"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878AF15748B;
	Thu,  1 Aug 2024 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492644; cv=none; b=VVRBOJbX62UDZNIdVqUFcDQMgM577Nu+ldSxkB64vPBG0thSlMhIOul4MAjM1nvMxxzHy44Xm1sIiB1YOhe45DwIfPipcLFGZW73PmQHwAQiqCMsJKrLRdCqf0BEI2Q0iu8fBFyBycVyOlFhjDAZB2l7/0YaQqNWj6OLVO/IR3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492644; c=relaxed/simple;
	bh=ONCzrmemywG2vkX0T5B4JcZZcN6Oq4w/h9cKr2li05M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/2J7dTldtxYHPnZdMDGH0b24SGQMSuGWvaJ9YgTZ/Oj0moLKjtOXWXXNkX6KIKa9PAOmFwykZkcdI0I8JPwWIsGEIVJghAhfscD2rrM7n+jVnBpLoKhpJkSGqruI8jpuX2LDqw/d8u8hfBUCGgoFiGvbSd0z9LVnM+nl0FKsko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzrrpwSU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE00C4AF0E;
	Thu,  1 Aug 2024 06:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492644;
	bh=ONCzrmemywG2vkX0T5B4JcZZcN6Oq4w/h9cKr2li05M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BzrrpwSUCZF+YtPmGe8wYoZtOINEkc03C0wjZ6L1V7Ke9yxnnMKhlxOvWTmr3xNKL
	 RwwQ4qbUzVP72GFWRT0LGacckCL17mMefUkGOCL5lNJFKFcUO5MN1ZU5IcXIYSAsBa
	 Ayk8ocLa9tikf+2dBzqD2xckHWAaWuGol/rUMIS3I0bensi+3b8VKqMhBWSQUxWvWz
	 7OosMhy+ydzopL682Cq/octMdJ4VWiYIdp8tVyjGqJJLE9jFcr4SQmDw2fW/hbasZw
	 zsU4ENLhqEvLQCPXighzypwrPAnA2uGQICNKQ2ub5hIHuHOxXf35551P+mRG1wi1wA
	 3mCgasT1JPP8Q==
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
Subject: [PATCH v3 10/26] x86/numa: simplify numa_distance allocation
Date: Thu,  1 Aug 2024 09:08:10 +0300
Message-ID: <20240801060826.559858-11-rppt@kernel.org>
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

Allocation of numa_distance uses memblock_phys_alloc_range() to limit
allocation to be below the last mapped page.

But NUMA initializaition runs after the direct map is populated and
there is also code in setup_arch() that adjusts memblock limit to
reflect how much memory is already mapped in the direct map.

Simplify the allocation of numa_distance and use plain memblock_alloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
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


