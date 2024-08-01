Return-Path: <linux-arch+bounces-5819-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E78A944414
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECF2CB24BBB
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70490192B97;
	Thu,  1 Aug 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pqPSECnC"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2916116C86D;
	Thu,  1 Aug 2024 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492796; cv=none; b=oJfKPVQvsl0H1thUBBgFBJ0eI6WUy6pdhjoua0/NjItjh8bUHJ0OdF4mcMUomTHolBsASedmUe71Mbg7zYrwGhWEggkthqd6oUFxGXLdrf0WeIA9ZUpXrHkuaP46LBUVSUUwGWKLC2jPJ6LdU1q6Zv0PCbEvXBQ/QPa8kobcgTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492796; c=relaxed/simple;
	bh=wgBkv6gb0pPzoMRiWhD0EVSQTy0zZwrH+GjPrFy0JG0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fJHH34xQeXMSHl48oRCa2GE9BeLTrgM7l9jG/mMxB/FXpS0t99X7FMmpYCi2XvPQoLwWkAE3ZyRIkZf6OeOs31Pxk9BLRwM39Uz46TMxv1RVoaOLcCfPuEVpbtVo5IuiBC0Bt8uDw7Y6IngQP0iAR11p4YwZELjCH6GkSNFFUBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pqPSECnC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FA9C4AF0A;
	Thu,  1 Aug 2024 06:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492795;
	bh=wgBkv6gb0pPzoMRiWhD0EVSQTy0zZwrH+GjPrFy0JG0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pqPSECnC0eM5g/zSNnOAmjrOasiIzwPA6z/+g6VkF4/et9bbVvssBzCmMrT2fH2FH
	 s8h76/CNsq3n19tI98+vSyv3i90mhkvLpBDaWko03EvTXamnFlNQgmpdo+G83yUOyx
	 QyLtENSdzXa9vkqCaNUDnt/UF6i2lx9sq7bccco42lDyUnUu3rXB+g1cBh06tVNc9Z
	 O/TqPVS7+0XmmBYN3tsp7y8r/0t3RnE/Zo1cRWYh4hXoZOIuKMzLdquIzKitbNSpQR
	 n3IeWHly9yw4naiZQqSAl7QY2ittG7QUqkHNN9dFTUw1WtpMMeCmArHNdljr08O4Fn
	 RoQH6f0HaoqCg==
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
Subject: [PATCH v3 23/26] of, numa: return -EINVAL when no numa-node-id is found
Date: Thu,  1 Aug 2024 09:08:23 +0300
Message-ID: <20240801060826.559858-24-rppt@kernel.org>
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

Currently of_numa_parse_memory_nodes() returns 0 if no "memory" node in
device tree contains "numa-node-id" property. This makes of_numa_init()
to return "success" despite no NUMA nodes were actually parsed and set
up.

arch_numa workarounds this by returning an error if numa_nodes_parsed is
empty.

numa_memblks however would WARN() in such case and since it will be used
by arch_numa shortly, such warning is not desirable.

Make sure of_numa_init() returns -EINVAL when no NUMA node information
was found in the device tree.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 drivers/of/of_numa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/of/of_numa.c b/drivers/of/of_numa.c
index 838747e319a2..2ec20886d176 100644
--- a/drivers/of/of_numa.c
+++ b/drivers/of/of_numa.c
@@ -45,7 +45,7 @@ static int __init of_numa_parse_memory_nodes(void)
 	struct device_node *np = NULL;
 	struct resource rsrc;
 	u32 nid;
-	int i, r;
+	int i, r = -EINVAL;
 
 	for_each_node_by_type(np, "memory") {
 		r = of_property_read_u32(np, "numa-node-id", &nid);
@@ -72,7 +72,7 @@ static int __init of_numa_parse_memory_nodes(void)
 		}
 	}
 
-	return 0;
+	return r;
 }
 
 static int __init of_numa_parse_distance_map_v1(struct device_node *map)
-- 
2.43.0


