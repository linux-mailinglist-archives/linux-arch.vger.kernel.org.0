Return-Path: <linux-arch+bounces-5807-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABC4944381
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52E41F23796
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620F616D4EA;
	Thu,  1 Aug 2024 06:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bNC6SBuY"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4AA157A5A;
	Thu,  1 Aug 2024 06:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492656; cv=none; b=Xg/t/42zpK1a+kPue+NUCHnZ5Cvs0jSPNY817ZA2M8t8vdSvH0FL6MKGdIvBkEHOFQtqhwHYNq/SKDgO3I08gz7YF7MkvudM4uCl5LAVdixjg+1Jyt0GSjoeufKVBd2KAKdIp/fFYeO4SSJphzQNLbu++0QFE9JE/XaCAf0YHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492656; c=relaxed/simple;
	bh=Rjf0iRc+VbNov1IXYA1f8/WuGCpuVfgjGuHB5zpeQrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ew2OK0AgYNG7cJbkXQdIXhqOVVn0694gtFXEVx1PWGADJjFuT1ij9Co1xZC7/hDfpotyL9X5+lYLs31ctbKPsIeaAu7X7EDIc9oKht14kEeztJ7JwarlmaNHmtY8lA+wjocaMtEu0SPiaBGXCuM5TZcDscuzgO4CgBLnbhscv7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bNC6SBuY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 959F9C4AF09;
	Thu,  1 Aug 2024 06:10:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492655;
	bh=Rjf0iRc+VbNov1IXYA1f8/WuGCpuVfgjGuHB5zpeQrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bNC6SBuY+2C9vgNv6AmEuNkLzbIiXAVs/wMzl1r36Gs0k8CLoQWb0q62HVoiTSgwA
	 yQRxQAj2MPhJPq0x0p/VUMiIU9P2gj0sy8r4TrFGEl5cblhhm6dYAsyBqUDMFH+X+W
	 +D8Q7EB3niaXdEH17S/n6XfMr5sBAkGSoqR2/AdaFEBFqO95ruILiTWlbyxMwoc2Ih
	 gyipgDPNN380SXng7+cEQlO6DS0+22xe+S8kPgh/BsQ9oW27iWFyuyh5YutwywPGcT
	 LFaiTvhOfihkxBHZNNKH6590ZbIZ1bzu/P7b+HwhiGgpJyPBVSvwX30a7PsrsgvCDJ
	 El5tISvg50iFA==
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
Subject: [PATCH v3 11/26] x86/numa: use get_pfn_range_for_nid to verify that node spans memory
Date: Thu,  1 Aug 2024 09:08:11 +0300
Message-ID: <20240801060826.559858-12-rppt@kernel.org>
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

Instead of looping over numa_meminfo array to detect node's start and
end addresses use get_pfn_range_for_init().

This is shorter and make it easier to lift numa_memblks to generic code.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
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


