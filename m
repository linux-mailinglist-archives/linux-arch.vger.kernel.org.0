Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5A019EC27
	for <lists+linux-arch@lfdr.de>; Sun,  5 Apr 2020 16:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgDEOtb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 5 Apr 2020 10:49:31 -0400
Received: from foss.arm.com ([217.140.110.172]:39588 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726598AbgDEOtb (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 5 Apr 2020 10:49:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6F6331B;
        Sun,  5 Apr 2020 07:49:30 -0700 (PDT)
Received: from [10.163.1.2] (unknown [10.163.1.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7CCD73F52E;
        Sun,  5 Apr 2020 07:49:21 -0700 (PDT)
Subject: Re: [mm/debug] f675f2f91d:
 WARNING:at_mm/debug_vm_pgtable.c:#debug_vm_pgtable
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     linux-mm@kvack.org, christophe.leroy@c-s.fr,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-riscv@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        lkp@lists.01.org
References: <20200330085636.GG11705@shao2-debian>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <282deb38-8ce1-3980-2549-4413c33b6062@arm.com>
Date:   Sun, 5 Apr 2020 20:19:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200330085636.GG11705@shao2-debian>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/30/2020 02:26 PM, kernel test robot wrote:
> [  283.486118] WARNING: CPU: 1 PID: 1 at mm/debug_vm_pgtable.c:371 debug_vm_pgtable+0x4dc/0x7e3
> [  283.487342] Modules linked in:
> [  283.487752] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.6.0-rc7-next-20200323-00001-gf675f2f91d045 #1
> [  283.488817] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
> [  283.489794] RIP: 0010:debug_vm_pgtable+0x4dc/0x7e3
> [  283.490361] Code: b5 fd 48 8b 7d d0 be 20 01 00 00 e8 3d 9f b5 fd 48 8b 75 c8 48 8b 7d d0 e8 30 9f b5 fd 48 8b 75 c8 48 8b 7d d0 e8 23 9f b5 fd <0f> 0b 48 8b 75 c8 48 8b 7d d0 e8 14 9f b5 fd 0f 0b 48 8b 75 c8 48
> [  283.492577] RSP: 0000:ffff888236493ed8 EFLAGS: 00010202
> [  283.493235] RAX: 00000001e1d31025 RBX: ffff88823e7f6cd8 RCX: ffffffffffffffff
> [  283.494135] RDX: 0000000000000000 RSI: 0000000000000025 RDI: 00000001e1d31000
> [  283.495002] RBP: ffff888236493f38 R08: 0000000000000001 R09: 0000000000000001
> [  283.495858] R10: 0000000000000001 R11: 0000000000000000 R12: ffff88821d907000
> [  283.496748] R13: ffff88821d8fc498 R14: ffff88821d8fda90 R15: ffff88821d8fc000
> [  283.497614] FS:  0000000000000000(0000) GS:ffff888237800000(0000) knlGS:0000000000000000
> [  283.498585] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  283.499290] CR2: 00000000ffffffff CR3: 00000001e1222000 CR4: 00000000000406e0
> [  283.500165] Call Trace:
> [  283.500499]  ? rest_init+0x240/0x240
> [  283.500985]  kernel_init+0x13/0x110
> [  283.501433]  ret_from_fork+0x24/0x30
> [  283.501907] irq event stamp: 4760776
> [  283.502366] hardirqs last  enabled at (4760775): [<ffffffffb481e34d>] _raw_spin_unlock_irqrestore+0x4d/0x60
> [  283.511686] hardirqs last disabled at (4760776): [<ffffffffb3c038d4>] trace_hardirqs_off_thunk+0x1a/0x1c
> [  283.512914] softirqs last  enabled at (4760748): [<ffffffffb4c002cf>] __do_softirq+0x2cf/0x4ad
> [  283.514086] softirqs last disabled at (4760741): [<ffffffffb3cf4f4d>] irq_exit+0xcd/0xe0
> [  283.515114] ---[ end trace 7e3383c4261f8faa ]---

The above failure here and the one on the other thread can be solved with
the following change. The failure is caused by the fact that even though
the soft dirty helpers are defined within CONFIG_HAVE_ARCH_SOFT_DIRTY, the
required PTE bits (_PAGE_SOFT_DIRTY and _PAGE_SWP_SOFT_DIRTY) are available
only when CONFIG_MEM_SOFT_DIRTY is enabled. Hence these tests should not
proceed unless CONFIG_MEM_SOFT_DIRTY is enabled. Similar situation exists
in s390 (_PAGE_SOFT_DIRTY and _SEGMENT_ENTRY_SOFT_DIRTY) and powerpc (at
least with _PAGE_SWP_SOFT_DIRTY).

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index 87b4b495333b..2a75a51fed06 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -589,7 +589,7 @@ static void __init pte_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
        pte_t pte = pfn_pte(pfn, prot);
 
-       if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
+       if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
                return;
 
        WARN_ON(!pte_soft_dirty(pte_mksoft_dirty(pte)));
@@ -600,7 +600,7 @@ static void __init pte_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
        pte_t pte = pfn_pte(pfn, prot);
 
-       if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
+       if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
                return;
 
        WARN_ON(!pte_swp_soft_dirty(pte_swp_mksoft_dirty(pte)));
@@ -612,7 +612,7 @@ static void __init pmd_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
        pmd_t pmd = pfn_pmd(pfn, prot);
 
-       if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY))
+       if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY))
                return;
 
        WARN_ON(!pmd_soft_dirty(pmd_mksoft_dirty(pmd)));
@@ -623,7 +623,7 @@ static void __init pmd_swap_soft_dirty_tests(unsigned long pfn, pgprot_t prot)
 {
        pmd_t pmd = pfn_pmd(pfn, prot);
 
-       if (!IS_ENABLED(CONFIG_HAVE_ARCH_SOFT_DIRTY) ||
+       if (!IS_ENABLED(CONFIG_MEM_SOFT_DIRTY) ||
                !IS_ENABLED(CONFIG_ARCH_ENABLE_THP_MIGRATION))
                return;
