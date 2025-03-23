Return-Path: <linux-arch+bounces-11052-lists+linux-arch=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA7A6D0AC
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 20:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 031273AF200
	for <lists+linux-arch@lfdr.de>; Sun, 23 Mar 2025 19:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E3213B5AE;
	Sun, 23 Mar 2025 19:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQL7TQcT"
X-Original-To: linux-arch@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0621B2E3399;
	Sun, 23 Mar 2025 19:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742756812; cv=none; b=O/878XjKEXwd4vI0TCnI1VDqAicIUVoc+YBJePknyDsCXg3KXR+Of5FaC62OIadKlkKwriDxqTate6Sv0LuWH7h9ujLtodbDxpDssVgIDt6u5cDJJAl9R6jxIyJiyEZTFWQdPZBkHcaThB3Tj0+vmpAs5nvrjHjoP46U9kGi7t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742756812; c=relaxed/simple;
	bh=gSiVK54BaFE1wEuUqKWSMj5BQvcJRmD5TNSAbSLcb4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaLF8VMBPHB+5lZjzrxQ9T9HWNLxnLCGRDa6SKJHWppE7gh29rCDkgQJ0a4arWECI013xU1ljt6FrnMUnyXr0/cZlHBIgf1eV2vdaisgWIM3fsIlnkrKQ3zI3fjWjHhPMiH9FL67SIjOd3ac3O6jveRRgrnv7fXXhizFv/J522U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQL7TQcT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D155BC4CEE2;
	Sun, 23 Mar 2025 19:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742756811;
	bh=gSiVK54BaFE1wEuUqKWSMj5BQvcJRmD5TNSAbSLcb4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jQL7TQcTZyLVxNaZanp8w7PAPcRH4eXRTp+zwa1fVLvF5RNXfwHOQMan+IZ/480BS
	 J36iXtpvREPwHVbh+S0noYAmNgCjR0kF1d2InQsgzYc5STtc7o4YXlSsCioVzZrYiz
	 wIf23ykcDVmXGQyA8PbN3cdvxQtwJ+DhU7qgnWnhod18nN8OQXj5/DlHIDG31v1ix4
	 qElFiWBy334oaPSIFMcVa3Pz1GsZEnOcU2yqrYgQzBS4cBE5q2FuDJvZK0u+8MITH8
	 Ebxhb99rOts9V9P2wMGpPU/1elBbVfhSMTDHxVLWiyN+WYJigvM3R1o2xALK9VHvdT
	 vc0VfAUr5yPag==
Date: Sun, 23 Mar 2025 14:06:47 -0500
From: Nathan Chancellor <nathan@kernel.org>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2 11/13] arch, mm: streamline HIGHMEM freeing
Message-ID: <20250323190647.GA1009914@ax162>
References: <20250313135003.836600-1-rppt@kernel.org>
 <20250313135003.836600-12-rppt@kernel.org>
Precedence: bulk
X-Mailing-List: linux-arch@vger.kernel.org
List-Id: <linux-arch.vger.kernel.org>
List-Subscribe: <mailto:linux-arch+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-arch+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250313135003.836600-12-rppt@kernel.org>

Hi Mike,

On Thu, Mar 13, 2025 at 03:50:01PM +0200, Mike Rapoport wrote:
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> All architectures that support HIGHMEM have their code that frees high
> memory pages to the buddy allocator while __free_memory_core() is limited
> to freeing only low memory.
> 
> There is no actual reason for that. The memory map is completely ready
> by the time memblock_free_all() is called and high pages can be released to
> the buddy allocator along with low memory.
> 
> Remove low memory limit from __free_memory_core() and drop per-architecture
> code that frees high memory pages.
> 
> Acked-by: Dave Hansen <dave.hansen@linux.intel.com>	# x86
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
...
> diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
> index ed9dde6a00f7..075177e817ac 100644
> --- a/arch/mips/mm/init.c
> +++ b/arch/mips/mm/init.c
> @@ -425,25 +425,6 @@ void __init paging_init(void)
>  static struct kcore_list kcore_kseg0;
>  #endif
>  
> -static inline void __init mem_init_free_highmem(void)
> -{
> -#ifdef CONFIG_HIGHMEM
> -	unsigned long tmp;
> -
> -	if (cpu_has_dc_aliases)
> -		return;
> -
> -	for (tmp = highstart_pfn; tmp < highend_pfn; tmp++) {
> -		struct page *page = pfn_to_page(tmp);
> -
> -		if (!memblock_is_memory(PFN_PHYS(tmp)))
> -			SetPageReserved(page);
> -		else
> -			free_highmem_page(page);
> -	}
> -#endif
> -}
> -
>  void __init mem_init(void)
>  {
>  	/*
> @@ -454,7 +435,6 @@ void __init mem_init(void)
>  
>  	maar_init();
>  	setup_zero_pages();	/* Setup zeroed pages.  */
> -	mem_init_free_highmem();
>  	memblock_free_all();
>  
>  #ifdef CONFIG_64BIT
...
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index fdf20503850e..6fccd3b3248c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3172,7 +3172,6 @@ extern void reserve_bootmem_region(phys_addr_t start,
>  
>  /* Free the reserved page into the buddy system, so it gets managed. */
>  void free_reserved_page(struct page *page);
> -#define free_highmem_page(page) free_reserved_page(page)
>  
>  static inline void mark_page_reserved(struct page *page)
>  {
> diff --git a/mm/memblock.c b/mm/memblock.c
> index 95af35fd1389..64ae678cd1d1 100644
> --- a/mm/memblock.c
> +++ b/mm/memblock.c
> @@ -2164,8 +2164,7 @@ static unsigned long __init __free_memory_core(phys_addr_t start,
>  				 phys_addr_t end)
>  {
>  	unsigned long start_pfn = PFN_UP(start);
> -	unsigned long end_pfn = min_t(unsigned long,
> -				      PFN_DOWN(end), max_low_pfn);
> +	unsigned long end_pfn = PFN_DOWN(end);
>  
>  	if (start_pfn >= end_pfn)
>  		return 0;

I bisected a crash that I see to this change as commit 6faea3422e3b
("arch, mm: streamline HIGHMEM freeing") in -next.

  $ cat arch/mips/configs/repro.config
  CONFIG_RELOCATABLE=y
  CONFIG_RELOCATION_TABLE_SIZE=0x00200000
  CONFIG_RANDOMIZE_BASE=y

  $ make -skj"$(nproc)" ARCH=mips CROSS_COMPILE=mips-linux- mrproper malta_defconfig repro.config vmlinux

  $ qemu-system-mipsel \
      -display none \
      -nodefaults \
      -cpu 24Kf \
      -machine malta \
      -kernel vmlinux \
      -initrd rootfs.cpio \
      -m 512m \
      -serial mon:stdio
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

  ---[ end trace 0000000000000000 ]---
  Kernel panic - not syncing: Attempted to kill the idle task!
  ---[ end Kernel panic - not syncing: Attempted to kill the idle task! ]---

At the immediate parent of that change, the boot completes fine.

  Linux version 6.14.0-rc6-00358-ge120d1bc12da (nathan@ax162) (mips-linux-gcc (GCC) 14.2.0, GNU ld (GNU Binutils) 2.42) #1 SMP Sun Mar 23 13:57:15 CDT 2025
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
  SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
  rcu: Hierarchical RCU implementation.
  rcu:    RCU event tracing is enabled.
  rcu:    RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=1.
  rcu: RCU calculated value of scheduler-enlistment delay is 10 jiffies.
  rcu: Adjusting geometry for rcu_fanout_leaf=16, nr_cpu_ids=1
  NR_IRQS: 256
  rcu: srcu_init: Setting srcu_struct sizes based on contention.
  CPU frequency 320.00 MHz
  clocksource: MIPS: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 11945390257 ns
  sched_clock: 32 bits at 160MHz, resolution 6ns, wraps every 13421787132ns
  Console: colour dummy device 80x25
  Calibrating delay loop... 1895.62 BogoMIPS (lpj=9478144)
  pid_max: default: 32768 minimum: 301
  Mount-cache hash table entries: 4096 (order: 0, 16384 bytes, linear)
  Mountpoint-cache hash table entries: 4096 (order: 0, 16384 bytes, linear)
  rcu: Hierarchical SRCU implementation.
  rcu:    Max phase no-delay instances is 1000.
  smp: Bringing up secondary CPUs ...
  smp: Brought up 1 node, 1 CPU
  Memory: 241200K/262144K available (7844K kernel code, 330K rwdata, 1424K rodata, 2352K init, 224K bss, 19984K reserved, 0K cma-reserved)
  devtmpfs: initialized
  ...

If there is any additional information I can provide or patches I can
test, I am more than happy to do so.

Cheers,
Nathan

