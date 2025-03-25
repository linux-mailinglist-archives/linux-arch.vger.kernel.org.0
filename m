Return-Path: <linux-arch+bounces-11065-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABB3A6F790
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 12:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA4D33BA040
	for <lists+linux-arch@lfdr.de>; Tue, 25 Mar 2025 11:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC922561CF;
	Tue, 25 Mar 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlmENNuW"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B16E71E7C28;
	Tue, 25 Mar 2025 11:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742903387; cv=none; b=apShQzqU3IdH3e+91TcZikBeqZskBhMnUfXEWw97Y/OFTTGzz9jFnfl4FT8eK4INolIwu9SGrb1y+OtJPvWcc15UBxwkhMO2H2Y8RULyqqXpVU3drlduPbmLgHS/FjYvxJnVadOfWYTfABKtHxBUCxoIvtmMde0CkdBzK6SNbsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742903387; c=relaxed/simple;
	bh=KjXVzwyQVPVG7ZDGogZ7pwFZUzgPV51utp1p2Si+3js=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6/XsKYqaHXV05yqH8Q1vOr2EYNHolUaU27fY5e68aXK4zmk0rv2XCW2//VAqIK93HmccAOg1A7NJaieGMgdbQjktC9cl/88ZN+YDSrfJWHK9Nfzd/RCznr/DIzh+lyS4XmTALfUy9SirdDljZPkTEeWm1kLsVUSpXXRXg7LBgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlmENNuW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B20B9C4CEE9;
	Tue, 25 Mar 2025 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742903387;
	bh=KjXVzwyQVPVG7ZDGogZ7pwFZUzgPV51utp1p2Si+3js=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LlmENNuWOSzOvGs96AushtPG9bBtDl6hM3+nqxlYmmYaE/ThuySmRGQjosM0AUOXR
	 UdMsC0fDvyny1gFz0OogOT/19sg+tiajV7LTCrUIvnePjNqJPGgtDqwfq9VyFsFNYb
	 UBWTyUVwiPNT7wsP63t3xozIA8yWGnfH+hzWYZVAACcabDM603Eo1kIoFMhYzvNFcg
	 gHOAZv3QgU+0gv6cI60MYChaEeRDpKvwij//iW7o4L2MaWDz73Detuybq2YijYvUar
	 7NnKRw3BbGK45V7Kf/NURvWILQbRSsFkFGx3Y9Yo5bXzQhfAfNlbICxS57EgPPbQeV
	 En3tNRx9fZGog==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	kernel test robot <oliver.sang@intel.com>,
	linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 2/2] memblock: don't release high memory to page allocator when HIGHMEM is off
Date: Tue, 25 Mar 2025 13:49:28 +0200
Message-ID: <20250325114928.1791109-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250325114928.1791109-1-rppt@kernel.org>
References: <20250325114928.1791109-1-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Nathan Chancellor reports the following crash on a MIPS system with
CONFIG_HIGHMEM=n:

  Linux version 6.14.0-rc6-00359-g6faea3422e3b (nathan@ax162) (mips-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP Fri Mar 21 08:12:02 MST 2025
  earlycon: uart8250 at I/O port 0x3f8 (options '38400n8')
  printk: legacy bootconsole [uart8250] enabled
  Config serial console: console=ttyS0,38400n8r
  CPU0 revision is: 00019300 (MIPS 24Kc)
  FPU revision is: 00739300
  MIPS: machine is mti,malta
  Software DMA cache coherency enabled
  Initial ramdisk at: 0x8fad0000 (5360128 bytes)
  OF: reserved mem: Reserved memory: No reserved-memory node in the DT
  Primary instruction cache 2kB, VIPT, 2-way, linesize 16 bytes.
  Primary data cache 2kB, 2-way, VIPT, no aliases, linesize 16 bytes
  Zone ranges:
    DMA      [mem 0x0000000000000000-0x0000000000ffffff]
    Normal   [mem 0x0000000001000000-0x000000001fffffff]
  Movable zone start for each node
  Early memory node ranges
    node   0: [mem 0x0000000000000000-0x000000000fffffff]
    node   0: [mem 0x0000000090000000-0x000000009fffffff]
  Initmem setup node 0 [mem 0x0000000000000000-0x000000009fffffff]
  On node 0, zone Normal: 16384 pages in unavailable ranges
  random: crng init done
  percpu: Embedded 3 pages/cpu s18832 r8192 d22128 u49152
  Kernel command line: rd_start=0xffffffff8fad0000 rd_size=5360128  console=ttyS0,38400n8r
  printk: log buffer data + meta data: 32768 + 102400 = 135168 bytes
  Dentry cache hash table entries: 65536 (order: 4, 262144 bytes, linear)
  Inode-cache hash table entries: 32768 (order: 3, 131072 bytes, linear)
  Writing ErrCtl register=00000000
  Readback ErrCtl register=00000000
  Built 1 zonelists, mobility grouping on.  Total pages: 16384
  mem auto-init: stack:all(zero), heap alloc:off, heap free:off
  Unhandled kernel unaligned access[#1]:
  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.14.0-rc6-00359-g6faea3422e3b #1
  Hardware name: mti,malta
  $ 0   : 00000000 00000001 81cb0880 00129027
  $ 4   : 00000001 0000000a 00000002 00129026
  $ 8   : ffffdfff 80101e00 00000002 00000000
  $12   : 81c9c224 81c63e68 00000002 00000000
  $16   : 805b1e00 00025800 81cb0880 00000002
  $20   : 00000000 81c63e64 0000000a 81f10000
  $24   : 81c63e64 81c63e60
  $28   : 81c60000 81c63de0 00000001 81cc9d20
  Hi    : 00000000
  Lo    : 00000000
  epc   : 814a227c __free_pages_ok+0x144/0x3c0
  ra    : 81cc9d20 memblock_free_all+0x1d4/0x27c
  Status: 10000002        KERNEL EXL
  Cause : 00800410 (ExcCode 04)
  BadVA : 00129026
  PrId  : 00019300 (MIPS 24Kc)
  Modules linked in:
  Process swapper (pid: 0, threadinfo=(ptrval), task=(ptrval), tls=00000000)
  Stack : 81f10000 805a9e00 81c80000 00000000 00000002 814aa240 000003ff 00000400
          00000000 81f10000 81c9c224 00003b1f 81c80000 81c63e60 81ca0000 81c63e64
          81f10000 0000000a 0000001f 81cc9d20 81f10000 81cc96d8 00000000 81c80000
          81c9c224 81c63e60 81c63e64 00000000 81f10000 00024000 00028000 00025c00
          90000000 a0000000 00000002 00000017 00000000 00000000 81f10000 81f10000
          ...
  Call Trace:
  [<814a227c>] __free_pages_ok+0x144/0x3c0
  [<81cc9d20>] memblock_free_all+0x1d4/0x27c
  [<81cc6764>] mm_core_init+0x100/0x138
  [<81cb4ba4>] start_kernel+0x4a0/0x6e4

  Code: 1080ffd5  02003825  2467ffff <8ce30000> 7c630500  1060ffd4  00000000  8ce30000  7c630180

The crash happens because commit 6faea3422e3b ("arch, mm: streamline
HIGHMEM freeing") too eagerly frees high memory to the page allocator even
when HIGHMEM is disabled.

Make sure that when CONFIG_HIGHMEM=n the high memory is not released to the
page allocator.

Link: https://lore.kernel.org/all/20250323190647.GA1009914@ax162
Reported-by: Nathan Chancellor <nathan@kernel.org>
Fixes: 6faea3422e3b ("arch, mm: streamline HIGHMEM freeing")
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 mm/memblock.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/memblock.c b/mm/memblock.c
index 64ae678cd1d1..d7ff8dfe5f88 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -2166,6 +2166,9 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
 	unsigned long start_pfn = PFN_UP(start);
 	unsigned long end_pfn = PFN_DOWN(end);
 
+	if (!IS_ENABLED(CONFIG_HIGHMEM) && end_pfn > max_low_pfn)
+		end_pfn = max_low_pfn;
+
 	if (start_pfn >= end_pfn)
 		return 0;
 
-- 
2.47.2


