Return-Path: <linux-arch+bounces-5800-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF544944332
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 08:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAFC7283CA8
	for <lists+linux-arch@lfdr.de>; Thu,  1 Aug 2024 06:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E04158529;
	Thu,  1 Aug 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr1CiLPN"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B0115748E;
	Thu,  1 Aug 2024 06:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722492574; cv=none; b=KUzqacLNv/ni0+AL/KHO0h9Fncws/09suRjldEwXdf+0FqBkf9yO6hlPG1FTK1U7XyuTq69g5rVgoalkwiHa3RjJzvUA2lkAO0bzkYfBdMYE4MfCjzngrUbq9S69VEJ0QQ1JvHPFDnwfwUut8kMfCnI7UNkEVJ5qj+Dd8kgM7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722492574; c=relaxed/simple;
	bh=mmhHQYCETRJBHfScnhlLv4Zo+WisPGGfSJnH6vP+xjc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEJhFIENbQ4dNJRBh7KfAy3C+RKKoW9TKEnA+iZSlmlr53/FFFMkV4hLraMeu8xFlhA87iGo2XwfG8m485jQQHB20/BfAxdppEm11Uic/LnqUXiW1no0w2swzmNtdgUDQDpt11prC6uw0FWd9njMml+osr82EwKtyqLdk4AS2QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr1CiLPN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0025DC4AF09;
	Thu,  1 Aug 2024 06:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722492574;
	bh=mmhHQYCETRJBHfScnhlLv4Zo+WisPGGfSJnH6vP+xjc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cr1CiLPN8Njdras4Btqnv341rMINjlqlnS1idBt/fsGeA4aaKp/Ea7yaeCTLRW+OD
	 SLPSIWQWQGJwKbXyYy0pIWVIzgViSpnkqTQGdGOGlErfpLRWbytg7pgdYGk+qx62Zh
	 vYO75yHA7yY/Uy0nBoxrtxxpTUVILgIgN/WYcr56R6lmrJ6AHRlpmtU1yA6AtLKxrM
	 ZMeWtHyXc0v0Y5TlxT1McUabePfZDEmVQfqH5OPEDQwG1SfJboJ8M8tXb85NcwNlTk
	 yRFhOlgDBqiScu3LsYNIWwFXmfZDKp8obRgWw9/g6qXMgFBNCRXgedXGkmX7WEaQAO
	 2ahFkgooeohiw==
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
Subject: [PATCH v3 04/26] MIPS: sgi-ip27: drop HAVE_ARCH_NODEDATA_EXTENSION
Date: Thu,  1 Aug 2024 09:08:04 +0300
Message-ID: <20240801060826.559858-5-rppt@kernel.org>
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

Commit f8f9f21c7848 ("MIPS: Fix build error for loongson64 and
sgi-ip27") added HAVE_ARCH_NODEDATA_EXTENSION to sgi-ip27 to silence a
compilation error that happened because sgi-ip27 didn't define array of
pg_data_t as node_data like most other architectures did.

After addition of node_data array that matches other architectures and
after ensuring that offline nodes do not appear on node_possible_map, it
is safe to drop arch_alloc_nodedata() and HAVE_ARCH_NODEDATA_EXTENSION
from sgi-ip27.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/mips/Kconfig                |  1 -
 arch/mips/sgi-ip27/ip27-memory.c | 10 ----------
 2 files changed, 11 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 60077e576935..ea5f3c3c31f6 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -735,7 +735,6 @@ config SGI_IP27
 	select WAR_R10000_LLSC
 	select MIPS_L1_CACHE_SHIFT_7
 	select NUMA
-	select HAVE_ARCH_NODEDATA_EXTENSION
 	help
 	  This are the SGI Origin 200, Origin 2000 and Onyx 2 Graphics
 	  workstations.  To compile a Linux kernel that runs on these, say Y
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index c30ef6958b97..eb6d2fa41a8a 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -426,13 +426,3 @@ void __init mem_init(void)
 	memblock_free_all();
 	setup_zero_pages();	/* This comes from node 0 */
 }
-
-pg_data_t * __init arch_alloc_nodedata(int nid)
-{
-	return memblock_alloc(sizeof(pg_data_t), SMP_CACHE_BYTES);
-}
-
-void arch_refresh_nodedata(int nid, pg_data_t *pgdat)
-{
-	__node_data[nid] = (struct node_data *)pgdat;
-}
-- 
2.43.0


