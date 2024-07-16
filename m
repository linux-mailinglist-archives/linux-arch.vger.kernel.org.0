Return-Path: <linux-arch+bounces-5411-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D72E9324F5
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 13:17:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B3261C224FD
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 11:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A6A1991B0;
	Tue, 16 Jul 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eUYe44Ch"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917811991D7;
	Tue, 16 Jul 2024 11:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128507; cv=none; b=iXBarSLHrT8qx3CnGc+glOaqMbAxqw3m19PqpJXj3q9cR4NyfObp7VuQKOrjFFY9bPX/2WF/llbYuCb6r9VMbmOQQ6toq4zHsfjD5wfagp2lwGBYg0LIqOwnlVBL8Z3KS90TL6oEDd+Lg5jSrP7RA3bXysBz0gyR9WmY1yfoch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128507; c=relaxed/simple;
	bh=GElWHq2qRIT8py39Ko6uJRewjseLB9ydLgZveNWdQ+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=utxYjYY2WdSyyWiV9UZtYQr2aNzuHADdJeyhpAPbnVrb4/JJ+DA4NrGmIWnGKubE2Up1A87/MDBZZEEFKTC5Zh26/eBCa4mi0c3bpVM1ynwfDzpPHiKFXqBoNFHi27pF1dQ1iWfxMUXHhdB0ZLYgXq0JMgD7q0Klv+PFuWhO4z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUYe44Ch; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DCECC116B1;
	Tue, 16 Jul 2024 11:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128507;
	bh=GElWHq2qRIT8py39Ko6uJRewjseLB9ydLgZveNWdQ+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eUYe44ChrhAY+EIKXqRBxJW/GGnRiqr4keNuzA8k+5ofeJ4HBvR/n8QM0J61no1f2
	 abiQBz3/QII7idJTs0afg3rMGY90A9xGmtBhYCNbiK9q4iubegCmxJf7NrcoovNvKG
	 qQRxvsWN8oXJMXkni0JawCEhHK8wA6sAxUA+cca/xtj4Q9hkmUftsVcp/KiDWJ6cLF
	 921Vh4BmVDEODNmwHfRepZDaSRiM/CEFqWbhNtHQKO/A34nitM0llJ5YCV7ixvsAcB
	 JHNcrvbEtQV/XUjf4mxX16sZ1+VCT2rSdlrKQOTKpNfcPTqTHU8isN0T/2V75O32aW
	 WPUTqww3gzW2A==
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Will Deacon <will@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 06/17] x86/numa: simplify numa_distance allocation
Date: Tue, 16 Jul 2024 14:13:35 +0300
Message-ID: <20240716111346.3676969-7-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240716111346.3676969-1-rppt@kernel.org>
References: <20240716111346.3676969-1-rppt@kernel.org>
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
This makes the code clearer and ensures that when numa_distance is not
allocated it is always NULL.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/numa.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 5e1dde26674b..ab2d4ecef786 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -319,8 +319,7 @@ void __init numa_reset_distance(void)
 {
 	size_t size = numa_distance_cnt * numa_distance_cnt * sizeof(numa_distance[0]);
 
-	/* numa_distance could be 1LU marking allocation failure, test cnt */
-	if (numa_distance_cnt)
+	if (numa_distance)
 		memblock_free(numa_distance, size);
 	numa_distance_cnt = 0;
 	numa_distance = NULL;	/* enable table creation */
@@ -331,7 +330,6 @@ static int __init numa_alloc_distance(void)
 	nodemask_t nodes_parsed;
 	size_t size;
 	int i, j, cnt = 0;
-	u64 phys;
 
 	/* size the new table and allocate it */
 	nodes_parsed = numa_nodes_parsed;
@@ -342,16 +340,12 @@ static int __init numa_alloc_distance(void)
 	cnt++;
 	size = cnt * cnt * sizeof(numa_distance[0]);
 
-	phys = memblock_phys_alloc_range(size, PAGE_SIZE, 0,
-					 PFN_PHYS(max_pfn_mapped));
-	if (!phys) {
+	numa_distance = memblock_alloc(size, PAGE_SIZE);
+	if (!numa_distance) {
 		pr_warn("Warning: can't allocate distance table!\n");
-		/* don't retry until explicitly reset */
-		numa_distance = (void *)1LU;
 		return -ENOMEM;
 	}
 
-	numa_distance = __va(phys);
 	numa_distance_cnt = cnt;
 
 	/* fill with the default distances */
-- 
2.43.0


