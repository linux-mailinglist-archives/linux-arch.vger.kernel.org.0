Return-Path: <linux-arch+bounces-3584-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AA68A1BF0
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E798C1F23341
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D0113A88D;
	Thu, 11 Apr 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ovFpkGfx"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1A313A87E;
	Thu, 11 Apr 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851561; cv=none; b=kOsX2bvZOKTVgTUsp0XNSZQfko5X1BsEdN8y6GhnXujxbkKyPhmCfvWxg8P+X9wX+FPoPn+pkbI5bc3ltS1nEuoNN0OWnEbAGZXuYZicoPHMIYtrmtkzJQ0/aytOm53whRPUUscnEO3BT/YtM2tugC4kLoDvIpCHc6MS+nM0Dh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851561; c=relaxed/simple;
	bh=iSP5sYQTC9lwrdkyTRCMZ/AI3wIT9Uf2038HZsTjvAE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZTZqUl1e3tpe4rZdVfX6kwTQpYOg7090X128yYX4V9nbRtx6aXps1y0MdCKnIx6QByB1cXCQRh7StM/Oi0oXUqLB+F/1iVlZUu7DafHw6aQMkh2YqoXz4TStgbVTWhS0YNNODmyECJFzeEqkw3qYvErmEVqTTe4SgWINE+om63E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ovFpkGfx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 949B2C072AA;
	Thu, 11 Apr 2024 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851561;
	bh=iSP5sYQTC9lwrdkyTRCMZ/AI3wIT9Uf2038HZsTjvAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ovFpkGfxLq3VLtK3zTiOpRiMUuHSj2aiPSN6C/2SRNq664nlaPNpFsB86F1602l7u
	 7x9tXroJeTOj2P3kWXEbf0cNKeCKXlL5Z4Sc5pYnmQqjo7nYylppKAmPrsG84c3xFC
	 9NLRnLJz/65Ix26qDiSIpHtq5GstadUuAmNfpX4ftuviQzf7kPayNTFCmqVcxekiXu
	 tOnqW1WH/Bp8QN30gHTwPwqzQE4VIoI2pDvfSao52LnJ/WtUsvjtbqmKqzdjt5jtR4
	 PNYlFSwbj57Sxuy4SqIdHL9SF2Awen6ZrBqp2ySRFhA1gGw1GOyPWd71dNY53aHmAL
	 ytLAFgcoDjD+A==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Christoph Hellwig <hch@infradead.org>,
	Helge Deller <deller@gmx.de>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Russell King <linux@armlinux.org.uk>,
	Song Liu <song@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Uladzislau Rezki <urezki@gmail.com>,
	Will Deacon <will@kernel.org>,
	bpf@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mm@kvack.org,
	linux-modules@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	x86@kernel.org
Subject: [RFC PATCH 2/7] mm: vmalloc: don't account for number of nodes for HUGE_VMAP allocations
Date: Thu, 11 Apr 2024 19:05:21 +0300
Message-ID: <20240411160526.2093408-3-rppt@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411160526.2093408-1-rppt@kernel.org>
References: <20240411160526.2093408-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (IBM)" <rppt@kernel.org>

vmalloc allocations with VM_ALLOW_HUGE_VMAP that do not explictly
specify node ID will use huge pages only if size_per_node is larger than
PMD_SIZE.
Still the actual allocated memory is not distributed between nodes and
there is no advantage in such approach.
On the contrary, BPF allocates PMD_SIZE * num_possible_nodes() for each
new bpf_prog_pack, while it could do with PMD_SIZE'ed packs.

Don't account for number of nodes for VM_ALLOW_HUGE_VMAP with
NUMA_NO_NODE and use huge pages whenever the requested allocation size
is larger than PMD_SIZE.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 mm/vmalloc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 22aa63f4ef63..5fc8b514e457 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3737,8 +3737,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	}
 
 	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
-		unsigned long size_per_node;
-
 		/*
 		 * Try huge pages. Only try for PAGE_KERNEL allocations,
 		 * others like modules don't yet expect huge pages in
@@ -3746,13 +3744,10 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
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


