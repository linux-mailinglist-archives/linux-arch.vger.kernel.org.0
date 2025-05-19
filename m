Return-Path: <linux-arch+bounces-11993-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE370ABC56D
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 683947A47F5
	for <lists+linux-arch@lfdr.de>; Mon, 19 May 2025 17:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835F31F0E56;
	Mon, 19 May 2025 17:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cLJfzyvO"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1D01E0E14;
	Mon, 19 May 2025 17:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747675092; cv=none; b=ABUUy75VxLnB6LQnYnmdoY53zx2CUMp6zlu3l/R/ROhJAtmK+7VyKuS6y955NhQk9bqC/34jrV41dlplvb/eNJ74xJOsm2E2gHsH1VkqFyVxQymT7bugbTLdXMVhwejclKPkmSpbWdyFoNOYr7gAYWOQSG/du4kMr6Tf2sXQc4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747675092; c=relaxed/simple;
	bh=+AKUnVKrN6BeAF4sfIZhOk6FcTofkxdDkE/rzNDDYT0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OQJpyb5AxNXToKBmVUNuj8uX9066PVgHM4MpDTXoPh0zQiAfhRrlNfXDQeLEzGq6vI3bgMJU0BTiNv9RgLsvlEQXVfEme2bWMI9eNovUAyscvLM91eyPiQVR/c0gENGngx2iyYNISRL4YZNb1uEZ5kay218d0+z7MEuU0i2CC64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLJfzyvO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD3E7C4CEE9;
	Mon, 19 May 2025 17:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747675091;
	bh=+AKUnVKrN6BeAF4sfIZhOk6FcTofkxdDkE/rzNDDYT0=;
	h=From:To:Cc:Subject:Date:From;
	b=cLJfzyvOj9LiXyRKKySMpCuRl4rLhZeRKMh/B4RieFAr3l7IP/SyyE7A3To2M5RoN
	 pIQmQLZSE2mLRFehJX0hoVFHGH+sJFmX8U88YnWyOJ+zikB15X1EDNeyJbUoTz56vP
	 AKMg32x88KcZ/STBTQ2Fl2FSrz6WNsnRDE3TEFs1AopcntMaHml0tZcPY+pbV2Inxb
	 cPkUfVwd+W+xUoFeoimp3e4W6TbQVWkOf9Ru5G0ZpIz6aVUNBWj3aX9tNNjuQy5Y4h
	 zZhsGBZKtNex2mk1VY2DFnO5NHyF2KY9h6sWKDmFCG7qHLm99sOAMjfmoR1fjASDhD
	 jw2O9O2mwep6g==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexandre Ghiti <alexghiti@rivosinc.com>,
	Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <ptyadav@amazon.de>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH] mm/cma: make detection of highmem_start more robust
Date: Mon, 19 May 2025 20:18:05 +0300
Message-ID: <20250519171805.1288393-1-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Pratyush Yadav reports the following crash:

    ------------[ cut here ]------------
    kernel BUG at arch/x86/mm/physaddr.c:23!
    ception 0x06 IP 10:ffffffff812ebbf8 error 0 cr2 0xffff88903ffff000
    CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.15.0-rc6+ #231 PREEMPT(undef)
    Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Arch Linux 1.16.3-1-1 04/01/2014
    RIP: 0010:__phys_addr+0x58/0x60
    Code: 01 48 89 c2 48 d3 ea 48 85 d2 75 05 e9 91 52 cf 00 0f 0b 48 3d ff ff ff 1f 77 0f 48 8b 05 20 54 55 01 48 01 d0 e9 78 52 cf 00 <0f> 0b 90 0f 1f 44 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90
    RSP: 0000:ffffffff82803dd8 EFLAGS: 00010006 ORIG_RAX: 0000000000000000
    RAX: 000000007fffffff RBX: 00000000ffffffff RCX: 0000000000000000
    RDX: 000000007fffffff RSI: 0000000280000000 RDI: ffffffffffffffff
    RBP: ffffffff82803e68 R08: 0000000000000000 R09: 0000000000000000
    R10: ffffffff83153180 R11: ffffffff82803e48 R12: ffffffff83c9aed0
    R13: 0000000000000000 R14: 0000001040000000 R15: 0000000000000000
    FS:  0000000000000000(0000) GS:0000000000000000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: ffff88903ffff000 CR3: 0000000002838000 CR4: 00000000000000b0
    Call Trace:
     <TASK>
     ? __cma_declare_contiguous_nid+0x6e/0x340
     ? cma_declare_contiguous_nid+0x33/0x70
     ? dma_contiguous_reserve_area+0x2f/0x70
     ? setup_arch+0x6f1/0x870
     ? start_kernel+0x52/0x4b0
     ? x86_64_start_reservations+0x29/0x30
     ? x86_64_start_kernel+0x7c/0x80
     ? common_startup_64+0x13e/0x141

  The reason is that __cma_declare_contiguous_nid() does:

          highmem_start = __pa(high_memory - 1) + 1;

  If dma_contiguous_reserve_area() (or any other CMA declaration) is
  called before free_area_init(), high_memory is uninitialized. Without
  CONFIG_DEBUG_VIRTUAL, it will likely work but use the wrong value for
  highmem_start.

The issue occurs because commit e120d1bc12da ("arch, mm: set high_memory in
free_area_init()") moved initialization of high_memory after the call to
dma_contiguous_reserve() -> __cma_declare_contiguous_nid() on several
architectures.

In the case CONFIG_HIGHMEM is enabled, some architectures that actually
support HIGHMEM (arm, powerpc and x86) have initialization of high_memory
before a possible call to __cma_declare_contiguous_nid() and some
initialized high_memory late anyway (arc, csky, microblase, mips, sparc,
xtensa) even before the commit e120d1bc12da so they are fine with using
uninitialized value of high_memory.

And in the case CONFIG_HIGHMEM is disabled high_memory essentially becomes
the first address after memory end, so instead of relying on high_memory to
calculate highmem_start use memblock_end_of_DRAM() and eliminate the
dependency of CMA area creation on high_memory in majority of
configurations.

Reported-by: Pratyush Yadav <ptyadav@amazon.de>
Tested-by: Alexandre Ghiti <alexghiti@rivosinc.com>
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/cma.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/mm/cma.c b/mm/cma.c
index 15632939f20a..c04be488b099 100644
--- a/mm/cma.c
+++ b/mm/cma.c
@@ -608,7 +608,10 @@ static int __init __cma_declare_contiguous_nid(phys_addr_t *basep,
 	 * complain. Find the boundary by adding one to the last valid
 	 * address.
 	 */
-	highmem_start = __pa(high_memory - 1) + 1;
+	if (IS_ENABLED(CONFIG_HIGHMEM))
+		highmem_start = __pa(high_memory - 1) + 1;
+	else
+		highmem_start = memblock_end_of_DRAM();
 	pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
 		__func__, &size, &base, &limit, &alignment);
 
-- 
2.47.2


