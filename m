Return-Path: <linux-arch+bounces-3589-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 958B18A1C06
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 19:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362471F22415
	for <lists+linux-arch@lfdr.de>; Thu, 11 Apr 2024 17:38:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F961509A0;
	Thu, 11 Apr 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRW/q4WS"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AF97FBA3;
	Thu, 11 Apr 2024 16:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712851602; cv=none; b=V/K1vI+am7Y8kCauY9pTpBX+Om3gt9c5tt46y7Ip6Gx8NmtN+faaxarKNqH2513WFGe4w1ouZZC1ORBMt+rk3UsMjuREp9KytQPgKV2v18/X5+bUJ5RntWqyCX17B5Ou3pQWOAUta9E706JGUejVuslra31I3Sczi0DKKjvgi6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712851602; c=relaxed/simple;
	bh=GpS8ytfjSzE76nC42qU8VRxGL9fjdKFDqm8vIE1x4YY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sDyMGJeu7DcHah/asI4jkO2BprdRBal/6loYPrbVOPgZtXSYSnd7RFTy+MCl8G0R/cgt9qcqkJ5XW4MpPfow+Bl6Bpfu38M1FE70Bs8Mtx0jegngxw83p1tSRtSZOmEwy6HgbS1MiBG/XUOuAj+xcGIp51hPyGs8uU+bkfHUg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRW/q4WS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A810C4AF09;
	Thu, 11 Apr 2024 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712851602;
	bh=GpS8ytfjSzE76nC42qU8VRxGL9fjdKFDqm8vIE1x4YY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eRW/q4WS++c0r4pBuIO3O4Xg4RhucjdHqnNZoi79AHoLhQPJWC7o5buwGGFBPvniC
	 VKRspPAvG+oxGO/Mu52T5QZWLHipAdpse5TDkTXl4UCRQQbTzoV2tVhPjQUCAlmNo0
	 NG232/NssiPa7JNKn0tv4mghHev6HdVbKr+LbbRCokaCTTwVdChPLdcxxCtgfIMnpO
	 Z1hyZ7UoVGi2N4el/7GuNUEzPhXZ5vzgMOKVlVVadMtRh3z+39u712GiPM9IWHw2qe
	 adjgDWeIItjJVb1bdKVNluXidKTvt1LLI9M1CnLR4urws3bFChygnRYjAkvNDCL/IG
	 2uw/kGGX3wdrg==
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
Subject: [RFC PATCH 7/7] x86/module: enable ROX caches for module text
Date: Thu, 11 Apr 2024 19:05:26 +0300
Message-ID: <20240411160526.2093408-8-rppt@kernel.org>
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

Enable execmem's cache of PMD_SIZE'ed pages mapped as ROX for module
text allocations.

Signed-off-by: Mike Rapoport (IBM) <rppt@kernel.org>
---
 arch/x86/mm/init.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8e8cd0de3af6..049a8b4c64e2 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -1102,9 +1102,23 @@ unsigned long arch_max_swapfile_size(void)
 #endif
 
 #ifdef CONFIG_EXECMEM
+static void execmem_invalidate(void *ptr, size_t size, bool writeable)
+{
+	/* fill memory with INT3 instructions */
+	if (writeable)
+		memset(ptr, 0xcc, size);
+	else
+		text_poke_set(ptr, 0xcc, size);
+}
+
 static struct execmem_info execmem_info __ro_after_init = {
+	.invalidate = execmem_invalidate,
 	.ranges = {
-		[EXECMEM_DEFAULT] = {
+		[EXECMEM_MODULE_TEXT] = {
+			.flags = EXECMEM_KASAN_SHADOW | EXECMEM_ROX_CACHE,
+			.alignment = MODULE_ALIGN,
+		},
+		[EXECMEM_KPROBES...EXECMEM_MODULE_DATA] = {
 			.flags = EXECMEM_KASAN_SHADOW,
 			.alignment = MODULE_ALIGN,
 		},
@@ -1119,9 +1133,16 @@ struct execmem_info __init *execmem_arch_setup(void)
 		offset = get_random_u32_inclusive(1, 1024) * PAGE_SIZE;
 
 	start = MODULES_VADDR + offset;
-	execmem_info.ranges[EXECMEM_DEFAULT].start = start;
-	execmem_info.ranges[EXECMEM_DEFAULT].end = MODULES_END;
-	execmem_info.ranges[EXECMEM_DEFAULT].pgprot = PAGE_KERNEL;
+
+	for (int i = EXECMEM_MODULE_TEXT; i < EXECMEM_TYPE_MAX; i++) {
+		struct execmem_range *r = &execmem_info.ranges[i];
+
+		r->start = start;
+		r->end = MODULES_END;
+		r->pgprot = PAGE_KERNEL;
+	}
+
+	execmem_info.ranges[EXECMEM_MODULE_TEXT].pgprot = PAGE_KERNEL_ROX;
 
 	return &execmem_info;
 }
-- 
2.43.0


