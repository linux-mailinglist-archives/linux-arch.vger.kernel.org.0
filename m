Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9C02B1F40
	for <lists+linux-arch@lfdr.de>; Fri, 13 Nov 2020 16:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgKMPxn (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 13 Nov 2020 10:53:43 -0500
Received: from elvis.franken.de ([193.175.24.41]:58600 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMPxn (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 13 Nov 2020 10:53:43 -0500
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1kdbOK-0007uw-00; Fri, 13 Nov 2020 16:53:36 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
        id A43B8C4DE3; Fri, 13 Nov 2020 16:53:09 +0100 (CET)
Date:   Fri, 13 Nov 2020 16:53:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     linux-mm@kvack.org, linux-arch@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Stefan Agner <stefan@agner.ch>,
        Mike Rapoport <rppt@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Nitin Gupta <ngupta@vflare.org>,
        Minchan Kim <minchan@kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev@lists.ozlabs.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH] arch: pgtable: define MAX_POSSIBLE_PHYSMEM_BITS where
 needed
Message-ID: <20201113155309.GA12146@alpha.franken.de>
References: <20201113145932.10994-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201113145932.10994-1-arnd@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Nov 13, 2020 at 03:59:32PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Stefan Agner reported a bug when using zsram on 32-bit Arm machines
> with RAM above the 4GB address boundary:
> 
>   Unable to handle kernel NULL pointer dereference at virtual address 00000000
>   pgd = a27bd01c
>   [00000000] *pgd=236a0003, *pmd=1ffa64003
>   Internal error: Oops: 207 [#1] SMP ARM
>   Modules linked in: mdio_bcm_unimac(+) brcmfmac cfg80211 brcmutil raspberrypi_hwmon hci_uart crc32_arm_ce bcm2711_thermal phy_generic genet
>   CPU: 0 PID: 123 Comm: mkfs.ext4 Not tainted 5.9.6 #1
>   Hardware name: BCM2711
>   PC is at zs_map_object+0x94/0x338
>   LR is at zram_bvec_rw.constprop.0+0x330/0xa64
>   pc : [<c0602b38>]    lr : [<c0bda6a0>]    psr: 60000013
>   sp : e376bbe0  ip : 00000000  fp : c1e2921c
>   r10: 00000002  r9 : c1dda730  r8 : 00000000
>   r7 : e8ff7a00  r6 : 00000000  r5 : 02f9ffa0  r4 : e3710000
>   r3 : 000fdffe  r2 : c1e0ce80  r1 : ebf979a0  r0 : 00000000
>   Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
>   Control: 30c5383d  Table: 235c2a80  DAC: fffffffd
>   Process mkfs.ext4 (pid: 123, stack limit = 0x495a22e6)
>   Stack: (0xe376bbe0 to 0xe376c000)
> 
> As it turns out, zsram needs to know the maximum memory size, which
> is defined in MAX_PHYSMEM_BITS when CONFIG_SPARSEMEM is set, or in
> MAX_POSSIBLE_PHYSMEM_BITS on the x86 architecture.
> 
> The same problem will be hit on all 32-bit architectures that have a
> physical address space larger than 4GB and happen to not enable sparsemem
> and include asm/sparsemem.h from asm/pgtable.h.
> 
> After the initial discussion, I suggested just always defining
> MAX_POSSIBLE_PHYSMEM_BITS whenever CONFIG_PHYS_ADDR_T_64BIT is
> set, or provoking a build error otherwise. This addresses all
> configurations that can currently have this runtime bug, but
> leaves all other configurations unchanged.
> 
> I looked up the possible number of bits in source code and
> datasheets, here is what I found:
> 
>  - on ARC, CONFIG_ARC_HAS_PAE40 controls whether 32 or 40 bits are used
>  - on ARM, CONFIG_LPAE enables 40 bit addressing, without it we never
>    support more than 32 bits, even though supersections in theory allow
>    up to 40 bits as well.
>  - on MIPS, some MIPS32r1 or later chips support 36 bits, and MIPS32r5
>    XPA supports up to 60 bits in theory, but 40 bits are more than
>    anyone will ever ship
>  - On PowerPC, there are three different implementations of 36 bit
>    addressing, but 32-bit is used without CONFIG_PTE_64BIT
>  - On RISC-V, the normal page table format can support 34 bit
>    addressing. There is no highmem support on RISC-V, so anything
>    above 2GB is unused, but it might be useful to eventually support
>    CONFIG_ZRAM for high pages.
> 
> Fixes: 61989a80fb3a ("staging: zsmalloc: zsmalloc memory allocation library")
> Fixes: 02390b87a945 ("mm/zsmalloc: Prepare to variable MAX_PHYSMEM_BITS")
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Cc: Nitin Gupta <ngupta@vflare.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Vineet Gupta <vgupta@synopsys.com>
> Cc: linux-snps-arc@lists.infradead.org
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Cc: linux-mips@vger.kernel.org
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Paul Walmsley <paul.walmsley@sifive.com>
> Cc: Palmer Dabbelt <palmer@dabbelt.com>
> Cc: Albert Ou <aou@eecs.berkeley.edu>
> Cc: linux-riscv@lists.infradead.org
> Link: https://lore.kernel.org/linux-mm/bdfa44bf1c570b05d6c70898e2bbb0acf234ecdf.1604762181.git.stefan@agner.ch/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
> If everyone is happy with this version, I would suggest merging this as
> a bugfix through my asm-generic tree for linux-5.10. I originally
> said I'd send individual patches for each architecture tree, but
> I now think this is easier and better documents what is going on.
> ---
>  arch/mips/include/asm/pgtable-32.h           |  3 +++

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
