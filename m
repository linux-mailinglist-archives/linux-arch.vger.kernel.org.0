Return-Path: <linux-arch+bounces-6075-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE89E94A010
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:43:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 750081F2530F
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D679B1B86FC;
	Wed,  7 Aug 2024 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2jRjvea"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880831B86C9;
	Wed,  7 Aug 2024 06:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012928; cv=none; b=NvWK4vU3UaGGu/qGmj8jl9Af+w2garRhdAWJTxXEjRC3qGUf7uNxJuJ28vVXtq5fT5MGiW5FQ0LAUvADMIwBJjFoAPnvpurqFDlPhivPjljbzZeK5t9fEwyLR7YgNqNrpOWeUyVKLOINy2lenp9cACZ1HfFxr3dhtBoaYnUCits=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012928; c=relaxed/simple;
	bh=LVBztKoD4Oos/dRCyJv8IyacBKgi/uP7EFt5SSfn4a0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gMdlo/I8fxxA4A5AaX8EqdbtYORlOUcrtUmZ7cr3DAr4MzN6HVJY7EfUKuwipxSQcq6c+ybwQgRzz9HqZann9iOGjRrPOsWslIjYl8jHG/kWqrWpb+ahJ+QCyC1TB5Nhqf7uBaORb7HgHSW8V6GO4XEYrFISATszwVr7prrAadU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2jRjvea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA56C4AF13;
	Wed,  7 Aug 2024 06:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723012928;
	bh=LVBztKoD4Oos/dRCyJv8IyacBKgi/uP7EFt5SSfn4a0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I2jRjveass/Sr4fsPaQDnFtXj2z4gevpdNEgzGdEseIlHAxuwSuQYPiQfPhhgBWhM
	 rAduvcPbLcK+jxYfsD/mcBzf5Luuu8dvffnfcCgG2muccVvtiPUexZAjpWVgigBcuE
	 1yAEMGDIP5Meo4LzO8aCmhz2kP1X0lNaqqjxLBXfDE4oajhxFMDhUAuuLhXSbK54Nf
	 dGnqC4Z3C4OlwnZoF3cb/FNUSDigkIDjNp17lKazgjaiA8NYGs2rf/3tlMddZhKxC3
	 i5KL8CSmnaYpGL5fSOhpGmNIThyVqRBqjLup++iZAKfZ/eYLpDN28xTOKN3oYQpemE
	 pk3ekebZv23tA==
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
Subject: [PATCH v4 03/26] MIPS: sgi-ip27: ensure node_possible_map only contains valid nodes
Date: Wed,  7 Aug 2024 09:40:47 +0300
Message-ID: <20240807064110.1003856-4-rppt@kernel.org>
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

For SGI IP27 machines node_possible_map is statically set to
NODE_MASK_ALL and it is not updated during NUMA initialization.

Ensure that it only contains nodes present in the system.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> [arm64 + CXL via QEMU]
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/mips/sgi-ip27/ip27-smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 5d2652a1d35a..62733e049570 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -70,11 +70,13 @@ void cpu_node_probe(void)
 	gda_t *gdap = GDA;
 
 	nodes_clear(node_online_map);
+	nodes_clear(node_possible_map);
 	for (i = 0; i < MAX_NUMNODES; i++) {
 		nasid_t nasid = gdap->g_nasidtable[i];
 		if (nasid == INVALID_NASID)
 			break;
 		node_set_online(nasid);
+		node_set(nasid, node_possible_map);
 		highest = node_scan_cpus(nasid, highest);
 	}
 
-- 
2.43.0


