Return-Path: <linux-arch+bounces-7143-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 721AE970E47
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 08:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2CA09281E03
	for <lists+linux-arch@lfdr.de>; Mon,  9 Sep 2024 06:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCC81AE039;
	Mon,  9 Sep 2024 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYI0f7XX"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27A31AE02A;
	Mon,  9 Sep 2024 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725864506; cv=none; b=B01eYLKu9TUgiCw6ocLhcOMAfikej+BbWY6JPmPyMyYGquwtWbXnMayWaxoDriA2wSOHwxt2ZBGXpT9H5ngqgVoeZ2/NqmTSMCfejljqEGw3VFCPDbqTKLemS8AXPzUQG/0knzPujIVvEER9ACCKb0S2nuuV81Jh5vWehlHytUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725864506; c=relaxed/simple;
	bh=diG+Fv3wDftGRjrnWBdO8lGUovRExvU5pHk1HsKnyW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gusmNpiQqRElKyJ+YYx0xNZJ0aJ6wjxOye1x8JG3S+3GE93KofaTYx07x1RFYuH+1jepRWEoiL3E2DXHDxBSLHsWgcaTsNJYiFIbgnM0z2iHzfKYZphKoZR0sHtehLqG/1JzL2a3HkGwBQJQkXoSqFtcijiLsCk1ZytfeIVwr+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PYI0f7XX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFF6CC4CECE;
	Mon,  9 Sep 2024 06:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725864505;
	bh=diG+Fv3wDftGRjrnWBdO8lGUovRExvU5pHk1HsKnyW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PYI0f7XXtb9IXPNGiea/h4fGD99CF60HMjieaexM2yoL8zPpSzdFJvOzXcPM4ZbW+
	 qW1DYS4dRYAl9aSVOznmi4EFI2YlU8K2WiL8DUJlTfcjmi8tmSSZvhRqpII5qUqDgF
	 ByEKU1W4ipty5gGX3a0TnMk4aQWv/199I8KqIfZbMMpuWvdU9erJQljQ2oBiAX1G6f
	 kDiZQKFgamrltHXyLuUJb54e2pwXGqtqjb8p9DIQ+kHnakm7bY5jN/JvrwXzm8g1/m
	 oXBQM/zWx+TDu4QNrUJ9GPMzxJHJFfbGHnKF76P9WbIutT29m8MSW6aLdsPfJU0Ojk
	 ej4bByKdSLxyw==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Stafford Horne <shorne@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org,
	x86@kernel.org
Subject: [PATCH v3 2/8] mm: vmalloc: don't account for number of nodes for HUGE_VMAP allocations
Date: Mon,  9 Sep 2024 09:47:24 +0300
Message-ID: <20240909064730.3290724-3-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240909064730.3290724-1-rppt@kernel.org>
References: <20240909064730.3290724-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

vmalloc allocations with VM_ALLOW_HUGE_VMAP that do not explicitly
specify node ID will use huge pages only if size_per_node is larger than
a huge page.
Still the actual allocated memory is not distributed between nodes and
there is no advantage in such approach.
On the contrary, BPF allocates SZ_2M * num_possible_nodes() for each
new bpf_prog_pack, while it could do with a single huge page per pack.

Don't account for number of nodes for VM_ALLOW_HUGE_VMAP with
NUMA_NO_NODE and use huge pages whenever the requested allocation size
is larger than a huge page.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/vmalloc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index af2de36549d6..d0fbe6b2b73c 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3769,8 +3769,6 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	}
 
 	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
-		unsigned long size_per_node;
-
 		/*
 		 * Try huge pages. Only try for PAGE_KERNEL allocations,
 		 * others like modules don't yet expect huge pages in
@@ -3778,13 +3776,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		 * supporting them.
 		 */
 
-		size_per_node = size;
-		if (node == NUMA_NO_NODE)
-			size_per_node /= num_online_nodes();
-		if (arch_vmap_pmd_supported(prot) && size_per_node >= PMD_SIZE)
+		if (arch_vmap_pmd_supported(prot) && size >= PMD_SIZE)
 			shift = PMD_SHIFT;
 		else
-			shift = arch_vmap_pte_supported_shift(size_per_node);
+			shift = arch_vmap_pte_supported_shift(size);
 
 		align = max(real_align, 1UL << shift);
 		size = ALIGN(real_size, 1UL << shift);
-- 
2.43.0


