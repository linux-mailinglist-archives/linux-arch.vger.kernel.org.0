Return-Path: <linux-arch+bounces-5413-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0320A932508
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 13:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A23781F24067
	for <lists+linux-arch@lfdr.de>; Tue, 16 Jul 2024 11:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D32AA19AD93;
	Tue, 16 Jul 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="URbAiLv8"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAF119AD87;
	Tue, 16 Jul 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721128527; cv=none; b=WRM6rzJvTuNB9w+8eGvlfLJSkWiI0akJ1c/J62/Xg8UMEFKCZE9vkC9E53RIp4wfPjbD0I3PtJUid2w7JOlqtQFJ2ryaWEOzPtenbpsFB2SsBAbYtFMNLpSEPT/p50qsq3uGQkwoClhKCW6Ot0/J/iXalW0YPdjgvznfQpFXz4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721128527; c=relaxed/simple;
	bh=R1HYu/q0PoN2gQIJtANqh+F+EoZWMXY7KpfVYIoY6/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9b3tZWqMER6SDgrjFq6OqfWJrEGn12iT3gQrl5NbTOXKBKieUkOoBJ0si64LTvvKsylxXwfqlNkAIT9AqvfJImDMjKWsjjsCrbtACvAumMWJpY7WThfw7pz/+rQl5h4+KZ/rKMYz12UX+q3gdEfSzoADn9UQ4vP56Czp+qfdns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=URbAiLv8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEF0EC4AF09;
	Tue, 16 Jul 2024 11:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721128527;
	bh=R1HYu/q0PoN2gQIJtANqh+F+EoZWMXY7KpfVYIoY6/Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=URbAiLv88ym2VS9Q58AhtnAFyrGYaubMDdKwbWkdIbHr3INoicWooyiqij2rcGTHT
	 +4uVloqcrFWaKgkSVLwOi2GKWFYn79atdQgv0rNsp4t3HskUvXzhm0udxqwJRAWgrE
	 O98eH7xSow5aI9/ojq/n8x1XfHWRoi+5IFptPwgYdPgBmnR3VVIouaFE6RZYlnzcCQ
	 nzJbMcAu8TmI6JplcHPmnjMiIGd3JROQVFdBUnF9BTZoKr7zwu+DlOC00OgoRrCDFF
	 SUZ+vTsVTP+36B1NwfZzzR2+vh+gCVMYEJgMrxrB5OWAAMROR5TkqKDI5IJqTrTnED
	 8D9sGaOuF7KRA==
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
Subject: [PATCH 08/17] x86/numa_emu: simplify allocation of phys_dist
Date: Tue, 16 Jul 2024 14:13:37 +0300
Message-ID: <20240716111346.3676969-9-rppt@kernel.org>
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

By the time numa_emulation() is called, all physical memory is already
mapped in the direct map and there is no need to define limits for
memblock allocation.

Replace memblock_phys_alloc_range() with memblock_alloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


