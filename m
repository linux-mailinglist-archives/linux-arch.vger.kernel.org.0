Return-Path: <linux-arch+bounces-5559-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB9A939A0A
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 08:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CB5D1C21ADB
	for <lists+linux-arch@lfdr.de>; Tue, 23 Jul 2024 06:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F03214A0B6;
	Tue, 23 Jul 2024 06:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b6kFqW4f"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7013D89A;
	Tue, 23 Jul 2024 06:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721716949; cv=none; b=Xn5mgaBwwDKIUgc+uVHDb+6m63L5yP5+hdNqgr0f3x7M3ZhBG3OsKe9dzMdXacqUICEaQtNhfimrv81Nl/08KSx+V2S8rR2Zo5ix3VvPEse8h/KYD6t3pksK28kjL4LoxKjeFpb2MqODm3d78f47awAPATrkDuhxPEYU+GYMNYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721716949; c=relaxed/simple;
	bh=MOsy21Nh9Bn3Vq+Q4UEQvGTzwylkpR0+vopd3cmOc8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKiuM6wWNqrFHbq+bKlSxzUsKCtGmt3nLLWdlXyWN5ZnujlgSewDScTyDjb5rrEPoPbQdaO7f1UwjA3HpjIGHhxR6EnwJkYnCbkRH26Opw1lTgwzXaoUFJ8yfIeGC6RIeIluXxtfxJOf8ksCprPmRek93ZIYFXXUdSoruiLHLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b6kFqW4f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B906C4AF14;
	Tue, 23 Jul 2024 06:42:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721716948;
	bh=MOsy21Nh9Bn3Vq+Q4UEQvGTzwylkpR0+vopd3cmOc8o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=b6kFqW4fzlXewzWkdUPTd5wHONXKf4PwHJ7rcvwCrxdIEdWmza/QKg9b1mM5EEx1b
	 txHRwjYCnReOXccINfBSu63YgvwYTo4m938vTFiVPXindhW0+nt4L4nhySFkUjjYtJ
	 QEnY12RVSXU4gmWybse3Akv7f+RuyOn/3e9yX5FpIPA4vnbnAxyIxN9d59MClKPT7y
	 Wjb/LLqkF23TTVUf6ys9+IrvUVK7kMuO2WDzcj9pjvVf0MPSjX1Rq5xUVWFOrxw6By
	 JbcMkFH9uNNmsftEA7Zq2i3mE+5SycQW1IyHwYhtsk2+LjCI19lIx+RUoBTZ0SDGUW
	 LpVc7vZrknebw==
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
Subject: [PATCH v2 01/25] mm: move kernel/numa.c to mm/
Date: Tue, 23 Jul 2024 09:41:32 +0300
Message-ID: <20240723064156.4009477-2-rppt@kernel.org>
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

The stub functions in kernel/numa.c belong to mm/ rather than to kernel/

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Acked-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index 8fb85acda1b1..773b3b267438 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -139,3 +139,4 @@ obj-$(CONFIG_HAVE_BOOTMEM_INFO_NODE) += bootmem_info.o
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


