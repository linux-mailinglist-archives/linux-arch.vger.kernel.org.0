Return-Path: <linux-arch+bounces-5797-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32706944311
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:09:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB2EF1F2207F
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14C86157488;
	Thu,  1 Aug 2024 06:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnYRQTD4"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1128379;
	Thu,  1 Aug 2024 06:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492540; cv=none; b=Re45k6ZPVU4kyCkyW1wwJWTEAFqHP5LjOYNuWCXHV8oV1AtGR28dD4egyQJ+web4ThQ48uR9fgxiPVUWyKCRWasGq6lZM1gm57VzqrDZuwJpMJzy+pj6/LURwoAUYG/6zb5rNGPUECT1gG1YfATH+TKkIBOs27BXmED2OdNn1cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492540; c=relaxed/simple;
	bh=ahZO7HcpjJfu28QyxaeMh/IeX+F8/tsP9+GBaY7P+JU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LeZPkEvIQUhKc5lvIXci8W+b4jjRTEcAQ7JthAiolOQSoPlN+rXrdOq88IAVZJx7DHnJ8N9ErrmiXL2zDUb1EbkoSdm20X4poVAqjDx6gnIuWA6ZOnBCf3c8uc8sEjx8tTJep6M9L259ngwaHWIs53RbuZngu4wRcdXMd0BrAc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnYRQTD4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160B6C4AF0D;
	Thu,  1 Aug 2024 06:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492539;
	bh=ahZO7HcpjJfu28QyxaeMh/IeX+F8/tsP9+GBaY7P+JU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jnYRQTD4LOi6UYgIg7wnq6U4iqrnpuP08zjDaKgtXu3WJUYa/E097kuxH2aeK5VY/
	 Bcq+eK7GU5lblfPhzlOYIPo3Arzk4E40wMmg3gN1FTZ2TxhvcvhTRw68CsZTvioJTn
	 Wk3ISPON95CHAcboKkfATHNIu6XwkVsh4264IZAISjY8p9ijm4bYlQ+mnOeh5hZziE
	 RPlKjD3veB4BttqTLV9MIi8S0/XpTfL9SupmvL01R3UMwD8Xz5dAC7pERBZLD3bqkX
	 W9+XZrhHYiJ2Mids5IYyn3anSkKL5z5ZYL4TiQyrUAV2GaerVPAbMpNy9iVuloAcq2
	 f8gJBIb48MQag==
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
Subject: [PATCH v3 01/26] mm: move kernel/numa.c to mm/
Date: Thu,  1 Aug 2024 09:08:01 +0300
Message-ID: <20240801060826.559858-2-rppt@kernel.org>
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

The stub functions in kernel/numa.c belong to mm/ rather than to kernel/

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Zi Yan <ziy@nvidia.com> # for x86_64 and arm64
---
 kernel/Makefile       | 1 -
 mm/Makefile           | 1 +
 {kernel => mm}/numa.c | 0
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename {kernel => mm}/numa.c (100%)

diff --git a/kernel/Makefile b/kernel/Makefile
index 3c13240dfc9f..87866b037fbe 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -116,7 +116,6 @@ obj-$(CONFIG_SHADOW_CALL_STACK) += scs.o
 obj-$(CONFIG_HAVE_STATIC_CALL) += static_call.o
 obj-$(CONFIG_HAVE_STATIC_CALL_INLINE) += static_call_inline.o
 obj-$(CONFIG_CFI_CLANG) += cfi.o
-obj-$(CONFIG_NUMA) += numa.o
 
 obj-$(CONFIG_PERF_EVENTS) += events/
 
diff --git a/mm/Makefile b/mm/Makefile
index d2915f8c9dc0..4e668be85f0b 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -141,3 +141,4 @@ obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
 obj-$(CONFIG_GENERIC_IOREMAP) += ioremap.o
 obj-$(CONFIG_SHRINKER_DEBUG) += shrinker_debug.o
 obj-$(CONFIG_EXECMEM) += execmem.o
+obj-$(CONFIG_NUMA) += numa.o
diff --git a/kernel/numa.c b/mm/numa.c
similarity index 100%
rename from kernel/numa.c
rename to mm/numa.c
-- 
2.43.0


