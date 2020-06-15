Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966141F8DAB
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 08:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728343AbgFOGWw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jun 2020 02:22:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:54086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728223AbgFOGWv (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jun 2020 02:22:51 -0400
Received: from kernel.org (unknown [87.70.26.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B91020679;
        Mon, 15 Jun 2020 06:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592202170;
        bh=IKJvBvjeDqS8XxYjcYKMghfxByCgZw7vR9AeiQrgnp8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=S3UP8AeeMsW+v5i18Wx1TbAZ8Ci6uCYg9fR4ByYtTpOdS7/JA4RJHwdk/5UC+Ci6O
         KVADb/LwUMXlZyQ1/wXlmdBnhEry8xB5YILPg9s3jHQ+IqKIE1ZBXLOg7MWig6SY9w
         Mm31hVNJqLf3PP+UItsGUlwES2gS+vhdSe8ZCWkU=
Date:   Mon, 15 Jun 2020 09:22:34 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Greg Ungerer <gerg@linux-m68k.org>
Cc:     Hoan@os.amperecomputing.com, James.Bottomley@hansenpartnership.com,
        akpm@linux-foundation.org, bcain@codeaurora.org, bhe@redhat.com,
        catalin.marinas@arm.com, corbet@lwn.net, dalias@libc.org,
        davem@davemloft.net, deller@gmx.de, geert@linux-m68k.org,
        green.hu@gmail.com, guoren@kernel.org, gxt@pku.edu.cn,
        heiko.carstens@de.ibm.com, jcmvbkbc@gmail.com,
        ley.foon.tan@intel.com, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-c6x-dev@linux-c6x.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-mm@kvack.org, linux-parisc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, linux-xtensa@linux-xtensa.org,
        linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
        mattst88@gmail.com, mhocko@kernel.org, monstr@monstr.eu,
        mpe@ellerman.id.au, msalter@redhat.com, nickhu@andestech.com,
        openrisc@lists.librecores.org, paul.walmsley@sifive.com,
        richard@nod.at, rppt@linux.ibm.com, shorne@gmail.com,
        sparclinux@vger.kernel.org, tony.luck@intel.com,
        tsbogend@alpha.franken.de, uclinux-h8-devel@lists.sourceforge.jp,
        vgupta@synopsys.com, x86@kernel.org, ysato@users.sourceforge.jp
Subject: Re: [PATCH 04/21] mm: free_area_init: use maximal zone PFNs rather
 than zone sizes
Message-ID: <20200615062234.GA7882@kernel.org>
References: <20200412194859.12663-5-rppt@kernel.org>
 <f53e68db-ed81-6ef6-5087-c7246d010ea2@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f53e68db-ed81-6ef6-5087-c7246d010ea2@linux-m68k.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Greg,

On Mon, Jun 15, 2020 at 01:53:42PM +1000, Greg Ungerer wrote:
> Hi Mike,
> 
> From: Mike Rapoport <rppt@linux.ibm.com>
> > Currently, architectures that use free_area_init() to initialize memory map
> > and node and zone structures need to calculate zone and hole sizes. We can
> > use free_area_init_nodes() instead and let it detect the zone boundaries
> > while the architectures will only have to supply the possible limits for
> > the zones.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> 
> This is causing some new warnings for me on boot on at least one non-MMU m68k target:

There were a couple of changes that cause this. The free_area_init()
now relies on memblock data and architectural limits for zone sizes
rather than on explisit pfns calculated by the arch code. I've update
motorola variant and missed coldfire. Angelo sent a fix for mcfmmu.c
[1] and I've updated it to include nommu as well

[1] https://lore.kernel.org/linux-m68k/20200614225119.777702-1-angelo.dureghello@timesys.com

From 55b8523df2a5c4565b132c0691990f0821040fec Mon Sep 17 00:00:00 2001
From: Angelo Dureghello <angelo.dureghello@timesys.com>
Date: Mon, 15 Jun 2020 00:51:19 +0200
Subject: [PATCH] m68k: fix registration of memory regions with memblock

Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
introduced assumption that UMA systems have their memory at node 0 and
updated most of them, but it forgot nommu and coldfire variants of m68k.

The later change in free area initialization in commit fa3354e4ea39 ("mm:
free_area_init: use maximal zone PFNs rather than zone sizes") exposed that
and caused a lot of "BUG: Bad page state in process swapper" reports.

Using memblock_add_node() with nid = 0 to register memory banks solves the
problem.

Fixes: 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
Fixes: fa3354e4ea39 ("mm: free_area_init: use maximal zone PFNs rather than zone sizes")
Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
Co-developed-by: Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/m68k/kernel/setup_no.c | 2 +-
 arch/m68k/mm/mcfmmu.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
index e779b19e0193..0c4589a39ba9 100644
--- a/arch/m68k/kernel/setup_no.c
+++ b/arch/m68k/kernel/setup_no.c
@@ -138,7 +138,7 @@ void __init setup_arch(char **cmdline_p)
 	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
 		 __bss_stop, memory_start, memory_start, memory_end);
 
-	memblock_add(memory_start, memory_end - memory_start);
+	memblock_add_node(memory_start, memory_end - memory_start, 0);
 
 	/* Keep a copy of command line */
 	*cmdline_p = &command_line[0];
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 29f47923aa46..7d04210d34f0 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -174,7 +174,7 @@ void __init cf_bootmem_alloc(void)
 	m68k_memory[0].addr = _rambase;
 	m68k_memory[0].size = _ramend - _rambase;
 
-	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
+	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
 
 	/* compute total pages in system */
 	num_pages = PFN_DOWN(_ramend - _rambase);
-- 
2.26.2


> ...
> NET: Registered protocol family 17
> BUG: Bad page state in process swapper  pfn:20165
> page:41fe0ca0 refcount:0 mapcount:1 mapping:00000000 index:0x0
> flags: 0x0()
> raw: 00000000 00000100 00000122 00000000 00000000 00000000 00000000 00000000
> page dumped because: nonzero mapcount
> CPU: 0 PID: 1 Comm: swapper Not tainted 5.8.0-rc1-00001-g3a38f8a60c65-dirty #1
> Stack from 404c9ebc:
>         404c9ebc 4029ab28 4029ab28 40088470 41fe0ca0 40299e21 40299df1 404ba2a4
>         00020165 00000000 41fd2c10 402c7ba0 41fd2c04 40088504 41fe0ca0 40299e21
>         00000000 40088a12 41fe0ca0 41fe0ca4 0000020a 00000000 00000001 402ca000
>         00000000 41fe0ca0 41fd2c10 41fd2c10 00000000 00000000 402b2388 00000001

...

> 
> System boots pretty much as normal through user space after this.
> Seems to be fully operational despite all those BUGONs.
> 
> Specifically this is a M5208EVB target (arch/m68k/configs/m5208evb).
> 
> 
> [snip]
> > diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
> > index b88d510d4fe3..6d3147662ff2 100644
> > --- a/arch/m68k/mm/init.c
> > +++ b/arch/m68k/mm/init.c
> > @@ -84,7 +84,7 @@ void __init paging_init(void)
> >  	 * page_alloc get different views of the world.
> >  	 */
> >  	unsigned long end_mem = memory_end & PAGE_MASK;
> > -	unsigned long zones_size[MAX_NR_ZONES] = { 0, };
> > +	unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0, };
> >  	high_memory = (void *) end_mem;
> > @@ -98,8 +98,8 @@ void __init paging_init(void)
> >  	 */
> >  	set_fs (USER_DS);
> > -	zones_size[ZONE_DMA] = (end_mem - PAGE_OFFSET) >> PAGE_SHIFT;
> > -	free_area_init(zones_size);
> > +	max_zone_pfn[ZONE_DMA] = end_mem >> PAGE_SHIFT;
> > +	free_area_init(max_zone_pfn);
> 
> This worries me a little. On this target PAGE_OFFSET will be non-0.
> Thoughts?

The initialization in free_area_init() takes into account the actual
physical memory sizing from memblock and max_zone_pfn as the
architectural limit for possible zone extents. This (and the patch
above) is enough to properly setup node and zones. 

> Regards
> Greg
> 
> 
> 

-- 
Sincerely yours,
Mike.
