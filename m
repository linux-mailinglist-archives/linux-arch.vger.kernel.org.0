Return-Path: <linux-arch+bounces-5799-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B894432D
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB646B21C26
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BA99158203;
	Thu,  1 Aug 2024 06:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bucdLnSW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63C0157464;
	Thu,  1 Aug 2024 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492563; cv=none; b=bNKcXlWRBUv7qH0mXDzeq7WFdyiuSus+MV6vLVMKSVdANkDTYU2YNCuueVBxvtbvq3PB3bbQVAYWZHOzAO/tBSO7Jk2fS52BYw/rxpK1u/L9Gs5S7+YLHlPWTOl5xu3N5k+sYqW7RP82iOamBwTm6dXrucgqeDdmNZo6b/9lnGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492563; c=relaxed/simple;
	bh=mRZLqq2N2ryJ5ZO7g59g+rrLvkwOpPlbSt8yNKJxh4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwV6fsacgGwlOn7PRGPBMBdi4Paf0AbEqxwqnxcBn/cRjRZWlMPkM/GEy/Gm83ghi5MykjS6wEl1jRHFPeLERH4fvZnmp/e+avLswuM5lxVGJve/RrHsZPRW3FNqA/gBeuFfZ/iKiPX3UwwJFoXAc63Kx2cSYgStSaKpjke+KrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bucdLnSW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A06DC4AF14;
	Thu,  1 Aug 2024 06:09:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492562;
	bh=mRZLqq2N2ryJ5ZO7g59g+rrLvkwOpPlbSt8yNKJxh4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bucdLnSWpcdcRT5+EXB/9Vj9t5MS7Qn5CSNmaKRNv6NvVMt0IwHITPfQUHQKw5W4m
	 KADunInG9ypv2EkiXb1dRp15PO6S9ZkhHC5orlcNDwZxNq0LAq7vdXnHs51UeN8XC1
	 qCCdGkD+IwBfa9Dhu62NGSOzskzofKuRJmzlYh8EWIjKqjsCMlnSFjv0suv/LWA7bE
	 /v17MsWN6GsK6hkUk2PpkklVDGARhQKEyYhJxEEdEsm6jaYBM6ERY08yC3+8fZvikl
	 QSv5CNmiG7++F2AcsgKSBHXAeR922kJ8/hbCjc1GagkI6K0Ok0uQtB2agu2yqJ1ylk
	 Nz7e1f94h+Kfg==
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
Subject: [PATCH v3 03/26] MIPS: sgi-ip27: ensure node_possible_map only contains valid nodes
Date: Thu,  1 Aug 2024 09:08:03 +0300
Message-ID: <20240801060826.559858-4-rppt@kernel.org>
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

For SGI IP27 machines node_possible_map is statically set to
NODE_MASK_ALL and it is not updated during NUMA initialization.

Ensure that it only contains nodes present in the system.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
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


