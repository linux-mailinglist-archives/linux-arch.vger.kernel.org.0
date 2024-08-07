Return-Path: <linux-arch+bounces-6074-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DD4E94A005
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 08:43:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1407A1F24540
	for <lists+linux-arch@lfdr.de>; Wed,  7 Aug 2024 06:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE8451B9B59;
	Wed,  7 Aug 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/6HTsXb"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741DB1B86C9;
	Wed,  7 Aug 2024 06:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723012916; cv=none; b=iStBaZvcTJg1UmGtQSeq/PmN17HC1LRhbWfY8VMIbTkILncHioY+6tCK74XOHUZsMScxgBJ1ZteGuGUKx+Emu+gfDM3mV7gEwiJXQWGEesaKwHTeExzMiyvpOhRO8B7BMGoCHObL//sKAgkxGwfsZ1zjvcHpvL9CI0yZxEnJEkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723012916; c=relaxed/simple;
	bh=MnJNRzTir4c4kkideYaF9K0DolOoIZtSsJtHw0oKjF4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nT6fbN7jR0BDZVeXOlCQjkErAaEqkCl6qBCIEewxZ3dbTs4OzN4rq8l3ltASW1WKA6h7ONzDkSYmwm9gcy7LCZJ123hbYjhZhT7Zh/bXIUwIJBhnYitBan/bKZ6B3cv5fJ9aq9oDLpRCj0XMX8hBo6Jb5XtYwi3ThulG+WIkLQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/6HTsXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3518C32782;
	Wed,  7 Aug 2024 06:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723012916;
	bh=MnJNRzTir4c4kkideYaF9K0DolOoIZtSsJtHw0oKjF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u/6HTsXbawFBe7Hl72eb3Fv4OkQcMobrOhl99riEcgs4wiGHwDDTkdDSTH17vApOV
	 9lZhZhCJiXDKThYkfu1t3tCthjob4fEkdPm4FHQUz8kzZVdDCjhwCcMgLP6oR0ZyuV
	 v4sMPQXcYUWjuwyvthF4ey4dyPEEm7JdeyTd9lgRrRjOYF+0uNiLrs+QoHNbhSj05m
	 PvtayYhdMjtXKolIrQaQ2u+nD3K2x3Nq8c+EmuWgNK1XviMNK/G4VRa+teOpPpf35C
	 e5n12nCa9Q58u6pMb7WUgu9llXT9kIqqGvWCa08d5O4ny9Z4aJ6c+Xxw+JT0MY3Xe9
	 vcfhOfEy5oraA==
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
Subject: [PATCH v4 02/26] MIPS: sgi-ip27: make NODE_DATA() the same as on all other architectures
Date: Wed,  7 Aug 2024 09:40:46 +0300
Message-ID: <20240807064110.1003856-3-rppt@kernel.org>
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

sgi-ip27 is the only system that defines NODE_DATA() differently than
the rest of NUMA machines.

Add node_data array of struct pglist pointers that will point to
__node_data[node]->pglist and redefine NODE_DATA() to use node_data
array.

This will allow pulling declaration of node_data to the generic mm code
in the next commit.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> [arm64 + CXL via QEMU]
Acked-by: Dan Williams <dan.j.williams@intel.com>
Acked-by: David Hildenbrand <david@redhat.com>
---
 arch/mips/include/asm/mach-ip27/mmzone.h | 5 ++++-
 arch/mips/sgi-ip27/ip27-memory.c         | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mach-ip27/mmzone.h b/arch/mips/include/asm/mach-ip27/mmzone.h
index 08c36e50a860..629c3f290203 100644
--- a/arch/mips/include/asm/mach-ip27/mmzone.h
+++ b/arch/mips/include/asm/mach-ip27/mmzone.h
@@ -22,7 +22,10 @@ struct node_data {
 
 extern struct node_data *__node_data[];
 
-#define NODE_DATA(n)		(&__node_data[(n)]->pglist)
 #define hub_data(n)		(&__node_data[(n)]->hub)
 
+extern struct pglist_data *node_data[];
+
+#define NODE_DATA(nid)		(node_data[nid])
+
 #endif /* _ASM_MACH_MMZONE_H */
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index b8ca94cfb4fe..c30ef6958b97 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -34,8 +34,10 @@
 #define SLOT_PFNSHIFT		(SLOT_SHIFT - PAGE_SHIFT)
 #define PFN_NASIDSHFT		(NASID_SHFT - PAGE_SHIFT)
 
-struct node_data *__node_data[MAX_NUMNODES];
+struct pglist_data *node_data[MAX_NUMNODES];
+EXPORT_SYMBOL(node_data);
 
+struct node_data *__node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(__node_data);
 
 static u64 gen_region_mask(void)
@@ -361,6 +363,7 @@ static void __init node_mem_init(nasid_t node)
 	 */
 	__node_data[node] = __va(slot_freepfn << PAGE_SHIFT);
 	memset(__node_data[node], 0, PAGE_SIZE);
+	node_data[node] = &__node_data[node]->pglist;
 
 	NODE_DATA(node)->node_start_pfn = start_pfn;
 	NODE_DATA(node)->node_spanned_pages = end_pfn - start_pfn;
-- 
2.43.0


