Return-Path: <linux-arch+bounces-6094-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D32994A0E1
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:51:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 063F2B21D6E
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D551CCB4C;
	Wed,  7 Aug 2024 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XM950jeC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE1A1B9B25;
	Wed,  7 Aug 2024 06:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013155; cv=none; b=asXMtCrVcAverMICYakXYuYbIDJY7y9B47Dr2PYs9fqJDJae9TxWUmTeCSTMN4f2elLxv0AsLDg7juDKhbJ9qzkzD9FtFpYONjckUshTm/hK9uI41jL9t59r4Z9Z2tIA8wckUPfRJjyr7uvskgVORlR/bLCmwfchJWQ7jKzTQb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013155; c=relaxed/simple;
	bh=OCx7lfgFGjAEeUiwtElmSuqIbdvnm7k92anqfUYoh0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzRJ55ZGWlMHytk9Qiy9KVksvxkEEDZv3Du9AdkJZhwtG3i2z/oXQgKAoFBcoJTIPz70yTofhPtHbbPXX6w83cteNZr7+bAd4Jmm6GPrTJPIQcSft4k9XVTLMpsn01POWIwzswR5SnnMYlNAssE3zzzyvWFsuzU4B9kOXuX2cI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XM950jeC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A373C4AF0B;
	Wed,  7 Aug 2024 06:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723013154;
	bh=OCx7lfgFGjAEeUiwtElmSuqIbdvnm7k92anqfUYoh0s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XM950jeCpSdlu41MPZc1y/9dEq7us9fAO8r71hCEF8iq2a6Uu/JfK6Z/WSllE7rY3
	 FRHRdygvzb0cZTkjbyWJIVnsnTpO/Pdhal4lTxhffbAEa3S+gzZRAIHULPBbMB/LqF
	 rO5vCvkh+DXCCGEIC0aWbMtJndHze4w74zRDtZgd4SAZuCfqTWNRagoFjgSe4DM8U6
	 xTqln8Tha0P1NvvOE1slC2/4bxzh+S/fEiaepYzDVATy6YZnje13MioKLCKJ9V/+dE
	 lhsywFbgxkFBg1/K+/0LFx8WTBgZrXzM5yk3w97PQ6GIiwbgTWOREdkCaZ0pqJsdg7
	 t+Y9qPjzQ4OSg==
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
Subject: [PATCH v4 22/26] mm: numa_memblks: use memblock_{start,end}_of_DRAM() when sanitizing meminfo
Date: Wed,  7 Aug 2024 09:41:06 +0300
Message-ID: <20240807064110.1003856-23-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807064110.1003856-1-rppt@kernel.org>
References: <20240807064110.1003856-1-rppt@kernel.org>
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
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> [arm64 + CXL via QEMU]
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
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


