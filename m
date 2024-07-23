Return-Path: <linux-arch+bounces-5580-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68DD5939AF0
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:50:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A7CD1C21C2C
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F06F15217A;
	Tue, 23 Jul 2024 06:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GdtNpb5f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D1314D6FC;
	Tue, 23 Jul 2024 06:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717194; cv=none; b=snJACS8PYcwxek1Uk5AKUeMCNgvzqKnXQyPHEFZr5nczQUPENAeZASINwW+2Noq5JNIVvHdGXifWthkhkRLi/BTUY++KZ1HxuMgqAAdw24Y8woZDtfmfzCSm2ifXXf60qsnWwsDFSFVALQLUhBZn8CHKIClQxSFRWQyGaAyxDcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717194; c=relaxed/simple;
	bh=zVDs6WKjT/YvUD2GuaqovEFQsz1PVdi+2wlgjwoVKBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aiu8hoYwrVgd4EaMLjbCaHJXdcuK/OgClX3hWALtmgaBx0J11HiwCeGGhhcd9lnclOnviEElNnkVx4WXB7HQQ83NU2qKeycvS8dRkIFbbNir5G4Q8TeAsJm8u+lgnaNqv3/lejmnOnA56FiGIMrxuFXElB8H01ySTwTc4dD2bvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GdtNpb5f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E983C4AF14;
	Tue, 23 Jul 2024 06:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717193;
	bh=zVDs6WKjT/YvUD2GuaqovEFQsz1PVdi+2wlgjwoVKBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GdtNpb5fUIpXsX9U29NSh04YZWODgndxZxjste8kTAvvVKauwF6UNM6S9Dr3BCKEs
	 yzF3a95E4FDYjaodsPNzYMUIiAFluD4W6BzfRkWMXJaN5mJiDqA0nbhJUlVN8YBreY
	 N8Lfe55rcuYatNFvDLpb1o/ai1cq2a87KFY1vXc2G3PokM+pzDBZiGx1YYc0JvUIwd
	 hD+FxT+d7coc5Nv4te6g48WPgLLOAIBVm7uSHK4G4+cw6nfe/xZpmv2v/wDAZjLxfx
	 maJJGo9Hlb/cksHiz+XhQBIYl3hu/DniwedBxjLUcBhi+OlRUy+RXddlr9a1o66hWz
	 zfdJosOcK+iJA==
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
Subject: [PATCH v2 22/25] mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing meminfo
Date: Tue, 23 Jul 2024 09:41:53 +0300
Message-ID: <20240723064156.4009477-23-rppt@kernel.org>
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

numa_cleanup_meminfo() moves blocks outside system RAM to
numa_reserved_meminfo and it uses 0 and PFN_PHYS(max_pfn) to determine
the memory boundaries.

Replace the memory range boundaries with more portable
memblock_start_of_DRAM() and memblock_end_of_DRAM().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


