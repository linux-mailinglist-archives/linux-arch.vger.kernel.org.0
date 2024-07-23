Return-Path: <linux-arch+bounces-5571-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C16B6939A8D
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:46:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BCE91F2275E
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800314B075;
	Tue, 23 Jul 2024 06:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j35xuHfu"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2835E14A606;
	Tue, 23 Jul 2024 06:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717089; cv=none; b=HZbuu0aB8K21Y+DhU9Kn0AT8l7t2MTOYlUgkX+u+AHcAVc1TbGJPGcRDgwqj1tDPzWtREFl9E6LGsIZ+8WTeBDPdX3H524y9naJekjlFCC7qliwRrfDAQ4e1nJI3Fig+8POzudSURGuIir8OuXqFYCyjm89ZKJO4s1KQ/MEQqsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717089; c=relaxed/simple;
	bh=UMRR3QRNDoHU23r5jw2deXNa43lw6nj2o1uMl8WO5EY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WWJbL26AKG2BNTmicJTUC9yAmyT6SeJ4BiR/62K3mPXBLiZVsHvR5KAtwSAazU/tz+2afTjeyBn/AQsxSQR8nY1reqzMKGjBV04oXLbKVF7ULv/EhTxSZJXyc9pC5si18HG2kwwGXpeVy/UVPyiJmQ/okpcnmYQGz9S6SyMPQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j35xuHfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DE2C4AF0C;
	Tue, 23 Jul 2024 06:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717088;
	bh=UMRR3QRNDoHU23r5jw2deXNa43lw6nj2o1uMl8WO5EY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=j35xuHfuNJnQeqb7veAbB9mttyDh+negQYCVoPrqp5oqP0zJLv/BXespI7J//nCIr
	 Sc5hLZUbxIz7818WwGcqoz5uRApIPm6FTsS8D2xgtV/3QhZq/vSHjbyYQFteCdX9J/
	 Z0Q1q+EAiONG8IXS2KIYvn9ZTZrI3rN/ZDXZYtg5Ba0JDP5j1rydPiw07EDLRjnfzj
	 pgm5ToFUGkUK44WCFFrLfRGFLEUz96+/NIboNOkbTCMEuxXkQqulA5vFQFBYRFoA+V
	 bDUooind5lcDC0gKC+UTC2cNByUYBIjZr44sdbkDnMkyVdXJiz8oVeerB9hf/6EipM
	 zivkL/l1N+MSA==
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
Subject: [PATCH v2 13/25] x86/numa_emu: simplify allocation of phys_dist
Date: Tue, 23 Jul 2024 09:41:44 +0300
Message-ID: <20240723064156.4009477-14-rppt@kernel.org>
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

By the time numa_emulation() is called, all physical memory is already
mapped in the direct map and there is no need to define limits for
memblock allocation.

Replace memblock_phys_alloc_range() with memblock_alloc().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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


