Return-Path: <linux-arch+bounces-5564-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9832B939A3F
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C97F21C21AB6
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C09713D89A;
	Tue, 23 Jul 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODt+aK2h"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566A013CF85;
	Tue, 23 Jul 2024 06:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717007; cv=none; b=csRi0eW0J2dctCYqk1SrA/v2MKJtnqrVhXYwSBXRyuvnQ7yWH1aH7iw0U/BGUDnOlpaMBZWSnvu925mEi7KCUi4QiIPRE+9Q9iL80bV+JOXplzzICLk0+lwtHlIxzD02R1KRKhMgmPV+8mBJp8hfO1QfMT3NyDzteahdJGcwDK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717007; c=relaxed/simple;
	bh=V+dgSsdkLeaynaNLrjIFS/zeTuKNf5COhGBjma8zEGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ljrn4b1fNSCJgYbstbQnZEjxk/T+hz5eTIvlo0G8efXJ6wADM4+lcTmDuH81B9EqgG7Avtx6XUX4+kcOa/TWolyrSYPepNgeyppAI9rxZJ5beA12JopZTcE5PFF2pA0fyzLY4J3z00zv9TfzXwkr+DFY8HRTiuLTq/HZyHk3tDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODt+aK2h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7754C4AF09;
	Tue, 23 Jul 2024 06:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721717006;
	bh=V+dgSsdkLeaynaNLrjIFS/zeTuKNf5COhGBjma8zEGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ODt+aK2hntJ4K/DgO09RgcVQDVlgQib7Wv18s95VxuIsyiapHrjR7UpxaSrWvMh/B
	 pj3Df2JE3Wp1haN0UUedtmKxV3QLcnwsj0QgyWl9r7C+gnNnLt38Yzqwv1j7beSwg5
	 aH2rb9R5eYKrpG2YqG8XS3aPxzV8glDHV5NMOCllzocifqXGs4uVkaHjHX768pSxWO
	 Z25iFtRytazM4PcLalHwExjd1r6Tv/naAwgXnuZ5/yXhkY5HpR+cvHkuCkRX2imv3e
	 +ecyEpCYd8FvvUZv/y821Qk4J0ZBS9qM1kFYRI+35C+c6GuPpt12bRmNQgnF1uSmwF
	 vpeO54BCZmIOg==
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
Subject: [PATCH v2 06/25] MIPS: loongson64: drop HAVE_ARCH_NODEDATA_EXTENSION
Date: Tue, 23 Jul 2024 09:41:37 +0300
Message-ID: <20240723064156.4009477-7-rppt@kernel.org>
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

Commit f8f9f21c7848 ("MIPS: Fix build error for loongson64 and
sgi-ip27") added HAVE_ARCH_NODEDATA_EXTENSION to loongson64 to silence a
compilation error that happened because loongson64 didn't define array
of pg_data_t as node_data like most other architectures did.

After rename of __node_data to node_data arch_alloc_nodedata() and
HAVE_ARCH_NODEDATA_EXTENSION can be dropped from loongson64.

Since it was the only user of HAVE_ARCH_NODEDATA_EXTENSION config option
also remove this option from arch/mips/Kconfig.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/Kconfig           |  4 ----
 arch/mips/loongson64/numa.c | 10 ----------
 2 files changed, 14 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 954f12a9e669..8221e47457aa 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -501,7 +501,6 @@ config MACH_LOONGSON64
 	select USE_OF
 	select BUILTIN_DTB
 	select PCI_HOST_GENERIC
-	select HAVE_ARCH_NODEDATA_EXTENSION if NUMA
 	help
 	  This enables the support of Loongson-2/3 family of machines.
 
@@ -2608,9 +2607,6 @@ config NUMA
 config SYS_SUPPORTS_NUMA
 	bool
 
-config HAVE_ARCH_NODEDATA_EXTENSION
-	bool
-
 config RELOCATABLE
 	bool "Relocatable kernel"
 	depends on SYS_SUPPORTS_RELOCATABLE
diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index b50ce28d2741..64fcfaa885b6 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -198,13 +198,3 @@ void __init prom_init_numa_memory(void)
 	pr_info("CP0_PageGrain: CP0 5.1 (0x%x)\n", read_c0_pagegrain());
 	prom_meminit();
 }
-
-pg_data_t * __init arch_alloc_nodedata(int nid)
-{
-	return memblock_alloc(sizeof(pg_data_t), SMP_CACHE_BYTES);
-}
-
-void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-	node_data[nid] = pgdat;
-}
-- 
2.43.0


