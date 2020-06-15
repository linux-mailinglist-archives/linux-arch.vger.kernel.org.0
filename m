Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6671F8F37
	for <lists+linux-arch@lfdr.de>; Mon, 15 Jun 2020 09:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728380AbgFOHRy (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 15 Jun 2020 03:17:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:36892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726299AbgFOHRx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 15 Jun 2020 03:17:53 -0400
Received: from [10.44.0.192] (unknown [103.48.210.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFCCF206D7;
        Mon, 15 Jun 2020 07:17:31 +0000 (UTC)
Subject: Re: [PATCH 04/21] mm: free_area_init: use maximal zone PFNs rather
 than zone sizes
To:     Mike Rapoport <rppt@kernel.org>
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
References: <20200412194859.12663-5-rppt@kernel.org>
 <f53e68db-ed81-6ef6-5087-c7246d010ea2@linux-m68k.org>
 <20200615062234.GA7882@kernel.org>
From:   Greg Ungerer <gerg@linux-m68k.org>
Message-ID: <24563231-ed19-6f4f-617e-4d6bfc7553e4@linux-m68k.org>
Date:   Mon, 15 Jun 2020 17:17:28 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200615062234.GA7882@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Mike,

On 15/6/20 4:22 pm, Mike Rapoport wrote:
> On Mon, Jun 15, 2020 at 01:53:42PM +1000, Greg Ungerer wrote:
>> From: Mike Rapoport <rppt@linux.ibm.com>
>>> Currently, architectures that use free_area_init() to initialize memory map
>>> and node and zone structures need to calculate zone and hole sizes. We can
>>> use free_area_init_nodes() instead and let it detect the zone boundaries
>>> while the architectures will only have to supply the possible limits for
>>> the zones.
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
>>
>> This is causing some new warnings for me on boot on at least one non-MMU m68k target:
> 
> There were a couple of changes that cause this. The free_area_init()
> now relies on memblock data and architectural limits for zone sizes
> rather than on explisit pfns calculated by the arch code. I've update
> motorola variant and missed coldfire. Angelo sent a fix for mcfmmu.c
> [1] and I've updated it to include nommu as well
> 
> [1] https://lore.kernel.org/linux-m68k/20200614225119.777702-1-angelo.dureghello@timesys.com
> 
>>From 55b8523df2a5c4565b132c0691990f0821040fec Mon Sep 17 00:00:00 2001
> From: Angelo Dureghello <angelo.dureghello@timesys.com>
> Date: Mon, 15 Jun 2020 00:51:19 +0200
> Subject: [PATCH] m68k: fix registration of memory regions with memblock
> 
> Commit 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
> introduced assumption that UMA systems have their memory at node 0 and
> updated most of them, but it forgot nommu and coldfire variants of m68k.
> 
> The later change in free area initialization in commit fa3354e4ea39 ("mm:
> free_area_init: use maximal zone PFNs rather than zone sizes") exposed that
> and caused a lot of "BUG: Bad page state in process swapper" reports.

Even with this patch applied I am still seeing the same messages.

Regards
Greg



> Using memblock_add_node() with nid = 0 to register memory banks solves the
> problem.
> 
> Fixes: 3f08a302f533 ("mm: remove CONFIG_HAVE_MEMBLOCK_NODE_MAP option")
> Fixes: fa3354e4ea39 ("mm: free_area_init: use maximal zone PFNs rather than zone sizes")
> Signed-off-by: Angelo Dureghello <angelo.dureghello@timesys.com>
> Co-developed-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> ---
>   arch/m68k/kernel/setup_no.c | 2 +-
>   arch/m68k/mm/mcfmmu.c       | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/m68k/kernel/setup_no.c b/arch/m68k/kernel/setup_no.c
> index e779b19e0193..0c4589a39ba9 100644
> --- a/arch/m68k/kernel/setup_no.c
> +++ b/arch/m68k/kernel/setup_no.c
> @@ -138,7 +138,7 @@ void __init setup_arch(char **cmdline_p)
>   	pr_debug("MEMORY -> ROMFS=0x%p-0x%06lx MEM=0x%06lx-0x%06lx\n ",
>   		 __bss_stop, memory_start, memory_start, memory_end);
>   
> -	memblock_add(memory_start, memory_end - memory_start);
> +	memblock_add_node(memory_start, memory_end - memory_start, 0);
>   
>   	/* Keep a copy of command line */
>   	*cmdline_p = &command_line[0];
> diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
> index 29f47923aa46..7d04210d34f0 100644
> --- a/arch/m68k/mm/mcfmmu.c
> +++ b/arch/m68k/mm/mcfmmu.c
> @@ -174,7 +174,7 @@ void __init cf_bootmem_alloc(void)
>   	m68k_memory[0].addr = _rambase;
>   	m68k_memory[0].size = _ramend - _rambase;
>   
> -	memblock_add(m68k_memory[0].addr, m68k_memory[0].size);
> +	memblock_add_node(m68k_memory[0].addr, m68k_memory[0].size, 0);
>   
>   	/* compute total pages in system */
>   	num_pages = PFN_DOWN(_ramend - _rambase);
> 
