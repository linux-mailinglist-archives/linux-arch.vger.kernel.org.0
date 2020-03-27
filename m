Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 321D219517A
	for <lists+linux-arch@lfdr.de>; Fri, 27 Mar 2020 07:46:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbgC0Gqw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Mar 2020 02:46:52 -0400
Received: from foss.arm.com ([217.140.110.172]:41054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgC0Gqw (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 27 Mar 2020 02:46:52 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EC7317FA;
        Thu, 26 Mar 2020 23:46:50 -0700 (PDT)
Received: from [10.163.1.31] (unknown [10.163.1.31])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B53F3F71F;
        Thu, 26 Mar 2020 23:50:47 -0700 (PDT)
Subject: Re: [PATCH V2 0/3] mm/debug: Add more arch page table helper tests
To:     Christophe Leroy <christophe.leroy@c-s.fr>, linux-mm@kvack.org
Cc:     Jonathan Corbet <corbet@lwn.net>,
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
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1585027375-9997-1-git-send-email-anshuman.khandual@arm.com>
 <2bb4badc-2b7a-e15d-a99b-b1bd38c9d9bf@arm.com>
 <a46d18ed-8911-1ec3-c32f-58b6e0d959d7@c-s.fr>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <9675882f-0ec5-5e46-551f-dd3aa38bf8d8@arm.com>
Date:   Fri, 27 Mar 2020 12:16:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <a46d18ed-8911-1ec3-c32f-58b6e0d959d7@c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org


On 03/26/2020 08:53 PM, Christophe Leroy wrote:
> 
> 
> Le 26/03/2020 à 03:23, Anshuman Khandual a écrit :
>>
>>
>> On 03/24/2020 10:52 AM, Anshuman Khandual wrote:
>>> This series adds more arch page table helper tests. The new tests here are
>>> either related to core memory functions and advanced arch pgtable helpers.
>>> This also creates a documentation file enlisting all expected semantics as
>>> suggested by Mike Rapoport (https://lkml.org/lkml/2020/1/30/40).
>>>
>>> This series has been tested on arm64 and x86 platforms.
>>
>> If folks can test these patches out on remaining ARCH_HAS_DEBUG_VM_PGTABLE
>> enabled platforms i.e s390, arc, powerpc (32 and 64), that will be really
>> appreciated. Thank you.
>>
> 
> On powerpc 8xx (PPC32), I get:
> 
> [   53.338368] debug_vm_pgtable: debug_vm_pgtable: Validating architecture page table helpers
> [   53.347403] ------------[ cut here ]------------
> [   53.351832] WARNING: CPU: 0 PID: 1 at mm/debug_vm_pgtable.c:647 debug_vm_pgtable+0x280/0x3f4

mm/debug_vm_pgtable.c:647 ?

With the following commits in place

53a8338ce (HEAD) Documentation/mm: Add descriptions for arch page table helper
5d4913fc1 mm/debug: Add tests validating arch advanced page table helpers
bcaf120a7 mm/debug: Add tests validating arch page table helpers for core features
d6ed5a4a5 x86/memory: Drop pud_mknotpresent()
0739d1f8d mm/debug: Add tests validating architecture page table helpers
16fbf79b0 (tag: v5.6-rc7) Linux 5.6-rc7

mm/debug_vm_pgtable.c:647 is here.

#ifdef CONFIG_ARCH_ENABLE_THP_MIGRATION
static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot)
{
        swp_entry_t swp;
        pmd_t pmd;  -----------------------------> Line #647

        pmd = pfn_pmd(pfn, prot);
        swp = __pmd_to_swp_entry(pmd);
        WARN_ON(!pmd_same(pmd, __swp_entry_to_pmd(swp)));
}
#else
static void __init pmd_swap_tests(unsigned long pfn, pgprot_t prot) { }
#end

Did I miss something ?

> [   53.360140] CPU: 0 PID: 1 Comm: swapper Not tainted 5.6.0-rc7-s3k-dev-01090-g92710e99881f #3544
> [   53.368718] NIP:  c0777c04 LR: c0777bb8 CTR: 00000000
> [   53.373720] REGS: c9023df0 TRAP: 0700   Not tainted (5.6.0-rc7-s3k-dev-01090-g92710e99881f)
> [   53.382042] MSR:  00029032 <EE,ME,IR,DR,RI>  CR: 22000222  XER: 20000000
> [   53.388667]
> [   53.388667] GPR00: c0777bb8 c9023ea8 c6120000 00000001 1e410000 00000000 00000000 007641c9
> [   53.388667] GPR08: 00000000 00000001 00000000 ffffffff 82000222 00000000 c00039b8 00000000
> [   53.388667] GPR16: 00000000 00000000 00000000 fffffff0 065fc000 1e410000 c6600000 000001e4
> [   53.388667] GPR24: 000001d9 c062d14c c65fc000 c642d448 000006c9 00000000 c65f8000 c65fc040
> [   53.423400] NIP [c0777c04] debug_vm_pgtable+0x280/0x3f4
> [   53.428559] LR [c0777bb8] debug_vm_pgtable+0x234/0x3f4
> [   53.433593] Call Trace:
> [   53.436048] [c9023ea8] [c0777bb8] debug_vm_pgtable+0x234/0x3f4 (unreliable)
> [   53.442936] [c9023f28] [c00039e0] kernel_init+0x28/0x124
> [   53.448184] [c9023f38] [c000f174] ret_from_kernel_thread+0x14/0x1c
> [   53.454245] Instruction dump:
> [   53.457180] 41a20008 4bea3ed9 62890021 7d36b92e 7d36b82e 71290fd0 3149ffff 7d2a4910
> [   53.464838] 0f090000 5789077e 3149ffff 7d2a4910 <0f090000> 38c00000 38a00000 38800000
> [   53.472671] ---[ end trace fd5dd92744dc0065 ]---
Could you please point me to the exact test which is failing ?

> [   53.519778] Freeing unused kernel memory: 608K
> 
> 
So I assume that the system should have come till runtime just fine apart from
the above warning message because.
