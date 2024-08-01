Return-Path: <linux-arch+bounces-5818-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 268A5944402
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:18:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFA3B1F21812
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:18:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8549616F837;
	Thu,  1 Aug 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Laf97Z1e"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C57156F5F;
	Thu,  1 Aug 2024 06:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492784; cv=none; b=Z5/L9Q4gpFjUEbQUullTaQtF3rjqcff+oumIZcBJQ+MNEg09p8Fj3R0H1CH99ZZnmB/9f9wXSRAdAFKkhJjgdM7/1OQ4aCAnHQWgH4FGb7iXZuFXrR5YAsFuJqAc0h697cdAxiOp58nwBDUp3fO0t7/fk8ZiAQ8VpKRc0PsSMfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492784; c=relaxed/simple;
	bh=u0DwIdv5Q0LC3i7GMDCjqhk6wXf4CoZ6Rdfjx53JnRw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IhvJ2Krcf6hDFtZlAzV6wRQsphTI8wXUHFP8embSTgRhPaoEV5ldYOAmIf4fToE0Bh6P87S1X99JPPTaLMoBMGfdcoocpH83KkGK1VgC8hHNK8YGX3lh9JsWP4IHBXZrcBTUnSNXbZWEoliqKtbt0uZ7mc4nHXKtv66aUY0CDAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Laf97Z1e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22222C4AF09;
	Thu,  1 Aug 2024 06:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492784;
	bh=u0DwIdv5Q0LC3i7GMDCjqhk6wXf4CoZ6Rdfjx53JnRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Laf97Z1e4hcu9PBv68jQasZmlcl44jxPkm5qsqBEaVcHPy1G/5p4hKyAOv+GaZ0cR
	 YzGEBoSsm6ig7pKVD9TjO3YNDG12FuhrWOfM1+LkJPNNGqnc92putV4qJJm07pe0Jk
	 LkllUlfZzz+53zk09otVS6H6hBwgc1BL4Qyegx5TvwtRxCPrtBIksSg00eK9Vzkhyc
	 Ink899LpOi3D7p4U/+xT33YUBQNQq7ixjxSEIEeqox4fLTYDyVmqpNc/IT8slRHXis
	 DjPDz1cL0BiU3e2k2Vtc4UuiwWZ3fpIzM/UbIqLOnh+wePPY4zbYTedpRY4xDGv1r4
	 +GfsBnftVLYvQ==
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
Subject: [PATCH v3 22/26] mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing meminfo
Date: Thu,  1 Aug 2024 09:08:22 +0300
Message-ID: <20240801060826.559858-23-rppt@kernel.org>
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

numa_cleanup_meminfo() moves blocks outside system RAM to
numa_reserved_meminfo and it uses 0 and PFN_PHYS(max_pfn) to determine
the memory boundaries.

Replace the memory range boundaries with more portable
memblock_start_of_DRAM() and memblock_end_of_DRAM().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
---
 mm/numa_memblks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/numa_memblks.c b/mm/numa_memblks.c
index e97665a5e8ce..e4358ad92233 100644
--- a/mm/numa_memblks.c
+++ b/mm/numa_memblks.c
@@ -212,8 +212,8 @@ int __init numa_add_memblk(int nid, u64 start, u64 end)
  */
 int __init numa_cleanup_meminfo(struct numa_meminfo *mi)
 {
-	const u64 low = 0;
-	const u64 high = PFN_PHYS(max_pfn);
+	const u64 low = memblock_start_of_DRAM();
+	const u64 high = memblock_end_of_DRAM();
 	int i, j, k;
 
 	/* first, trim all entries */
-- 
2.43.0


