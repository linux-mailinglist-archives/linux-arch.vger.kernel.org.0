Return-Path: <linux-arch+bounces-5809-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC8C94439B
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F63DB24A59
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2EE173331;
	Thu,  1 Aug 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QI4Ewjqh"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C219171089;
	Thu,  1 Aug 2024 06:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492679; cv=none; b=oG5fJEcuHXI345XRKOSktuilxmEHTusL8wj7NzGC3Tv2tMCw5iFJozdCmGD3ZW8VQmgDjjPZEJYWSrIA0QA2NnLZ+lmyFB7qk9js2Ywsb70D7FgUvvIHu7+6PrU9GKttdtz5dnY7g4FByLG2o6I8UYQeYA7INdbnjhsZMyK9HnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492679; c=relaxed/simple;
	bh=UKbRiZvva5pXaCAN24L+st+TlDsrE6ScVNjHbfzaMRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UO3D97rf1Ln+mlcJ5BAi7qTQ57CpYczxFodqmje8PHosnLDbjWEYC8flUl6SKk6nmdt0JNIFA7kTnZVWp6psqjn+RB0etfMXbj+HR471aeAye03H86wejniamnmxFXXqZINtR0zKxvGzl/YVu9cVWzAETJqrERoW6dKmM16lNTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QI4Ewjqh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE12DC4AF0A;
	Thu,  1 Aug 2024 06:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492679;
	bh=UKbRiZvva5pXaCAN24L+st+TlDsrE6ScVNjHbfzaMRQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QI4EwjqhxFK7jXHI8z7S0O57azEU4hGOVevIE/YotTQq1td3MZ2supNz+Ar1UY/8p
	 CqH0vm+HUdWwyyQtOmTJL8GxeHWgkoxA9rHrAqFDpO8QZvDQ0B7A/qtQd6XIYMmvCL
	 yF+WVGjYTgkr8pTlPUXdfLQPO4+BiiuOVGnFri2SIJQj7s3JUdSLac9RwDt0im45/z
	 KF+xkSA/StepsYoUsUx9dms3l08hn82DVtcw4Ebjuu7NI0IYntmyRLFRWCUSLJV2AM
	 w6aVlRwary2DoahCBShwjZmokC0xXVajZA+CqgVwGuwUANLNZrZgdNx4T+e3NLqx7w
	 MkJo6xLcQkn0w==
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
Subject: [PATCH v3 13/26] x86/numa_emu: simplify allocation of phys_dist
Date: Thu,  1 Aug 2024 09:08:13 +0300
Message-ID: <20240801060826.559858-14-rppt@kernel.org>
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

By the time numa_emulation() is called, all physical memory is already
mapped in the direct map and there is no need to define limits for
memblock allocation.

Replace memblock_phys_alloc_range() with memblock_alloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
---
 arch/x86/mm/numa_emulation.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/numa_emulation.c b/arch/x86/mm/numa_emulation.c
index 1ce22e315b80..439804e21962 100644
--- a/arch/x86/mm/numa_emulation.c
+++ b/arch/x86/mm/numa_emulation.c
@@ -448,15 +448,11 @@ void __init numa_emulation(struct numa_meminfo *numa_meminfo, int numa_dist_cnt)
 
 	/* copy the physical distance table */
 	if (numa_dist_cnt) {
-		u64 phys;
-
-		phys = memblock_phys_alloc_range(phys_size, PAGE_SIZE, 0,
-						 PFN_PHYS(max_pfn_mapped));
-		if (!phys) {
+		phys_dist = memblock_alloc(phys_size, PAGE_SIZE);
+		if (!phys_dist) {
 			pr_warn("NUMA: Warning: can't allocate copy of distance table, disabling emulation\n");
 			goto no_emu;
 		}
-		phys_dist = __va(phys);
 
 		for (i = 0; i < numa_dist_cnt; i++)
 			for (j = 0; j < numa_dist_cnt; j++)
-- 
2.43.0


