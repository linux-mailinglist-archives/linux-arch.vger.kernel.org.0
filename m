Return-Path: <linux-arch+bounces-5569-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A40F9939A79
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 587811F216EB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE5014AD25;
	Tue, 23 Jul 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za5Jhcet"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8307213D89A;
	Tue, 23 Jul 2024 06:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717065; cv=none; b=f+DE6T+A0wrhGXwhnU+TVmmwY8qBD0DpSt1RFvz2jXcE2uLCWHlQnSFo1Nj3gIKREIAyW6lmgrYpC938IHJbZZm3jwyTD1PsigdfpSvJPpePVj2RJXVNOOnKO5ipRXY825UdQCVrVvR20CxxgtcDCTYOvanS5V3OLv7fmRKYOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717065; c=relaxed/simple;
	bh=c6DgXq0zS+r3QhZ5flAVfEs4FfALF1+j15wi2hevr+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=okj/HxvC14Oha2LJOEBJjG9ec4ZSB7U+HfPIJEtpxCRU5tu8zkBQz22+iHCcXB3UzUWQHsQrA1nE+/KhLWnigJxCuRQSgl1R3ksmL1ja+FzcMiC4WH1/tYxKdHqTR9TTLXWXgvv1k0iE/901kUFSeutFZlSpUKF+hbgTAdZpDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za5Jhcet; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F62DC4AF09;
	Tue, 23 Jul 2024 06:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717065;
	bh=c6DgXq0zS+r3QhZ5flAVfEs4FfALF1+j15wi2hevr+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Za5JhcetTAfLRbJccTWeAUNIxgrg96br5y87BwWzZPLzZYM5IjOw4ndfZ4nIfWM9a
	 0kYpHEGaCq6sHARpYneu6wGWScDkDxMY9UcV7dpRLzFycumSP2BoGDaLlTOqcZLXTy
	 MhVwp5rCs8e2OGmBS9+/Gn4wMTzHhc60AFxKa0ONJzfcOahicEDT4gok1reEmHY3m/
	 yJ8eHIgkq+6rm34FFaAF6eeeqrWyvK1zv4CjW5ghkagLShm8uJGUIM4w2FQQtbu2np
	 +gfe1coXyBC8uzt0RQsU4ls3le21w36/2yCPFPHrBIKqMRwOZM2lnaFEnBfBxNNJvK
	 Lhh8CDiwUIDtw==
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
Subject: [PATCH v2 11/25] x86/numa: use get_pfn_range_for_nid to verify that node spans memory
Date: Tue, 23 Jul 2024 09:41:42 +0300
Message-ID: <20240723064156.4009477-12-rppt@kernel.org>
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

Instead of looping over numa_meminfo array to detect node's start and
end addresses use get_pfn_range_for_init().

This is shorter and make it easier to lift numa_memblks to generic code.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/x86/mm/numa.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index edfc38803779..cfe7e5477cf8 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -521,17 +521,10 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 
 	/* Finally register nodes. */
 	for_each_node_mask(nid, node_possible_map) {
-		u64 start = PFN_PHYS(max_pfn);
-		u64 end = 0;
+		unsigned long start_pfn, end_pfn;
 
-		for (i = 0; i < mi->nr_blks; i++) {
-			if (nid != mi->blk[i].nid)
-				continue;
-			start = min(mi->blk[i].start, start);
-			end = max(mi->blk[i].end, end);
-		}
-
-		if (start >= end)
+		get_pfn_range_for_nid(nid, &start_pfn, &end_pfn);
+		if (start_pfn >= end_pfn)
 			continue;
 
 		alloc_node_data(nid);
-- 
2.43.0


