Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2AF5258C31
	for <lists+linux-arch@lfdr.de>; Tue,  1 Sep 2020 11:59:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726140AbgIAJ7L (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 1 Sep 2020 05:59:11 -0400
Received: from foss.arm.com ([217.140.110.172]:39678 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725848AbgIAJ7K (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 1 Sep 2020 05:59:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC11630E;
        Tue,  1 Sep 2020 02:59:09 -0700 (PDT)
Received: from [10.163.69.134] (unknown [10.163.69.134])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1711B3F71F;
        Tue,  1 Sep 2020 02:59:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH v3 09/13] mm/debug_vm_pgtable/locks: Move non page table
 modifying test together
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        linux-mm@kvack.org, akpm@linux-foundation.org
Cc:     mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
        linux-snps-arc@lists.infradead.org, x86@kernel.org,
        linux-arch@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Vineet Gupta <vgupta@synopsys.com>,
        Mike Rapoport <rppt@linux.ibm.com>, Qian Cai <cai@lca.pw>
References: <20200827080438.315345-1-aneesh.kumar@linux.ibm.com>
 <20200827080438.315345-10-aneesh.kumar@linux.ibm.com>
 <d0a0a50c-702b-c63a-edf2-263e4e7bd4a5@arm.com>
 <b6240372-4554-8c17-186a-cdc0b0a9089c@linux.ibm.com>
 <9b75b175-f319-d40e-a95e-b323b3db654a@arm.com>
 <58a5280f-4882-4a36-c52d-15ad879209d6@linux.ibm.com>
Message-ID: <4fad7c4b-14ca-b558-504b-6b20a6c85ec3@arm.com>
Date:   Tue, 1 Sep 2020 15:28:32 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <58a5280f-4882-4a36-c52d-15ad879209d6@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 09/01/2020 03:06 PM, Aneesh Kumar K.V wrote:
> 
>>>>
>>>> [   17.080644] ------------[ cut here ]------------
>>>> [   17.081342] kernel BUG at mm/pgtable-generic.c:164!
>>>> [   17.082091] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
>>>> [   17.082977] Modules linked in:
>>>> [   17.083481] CPU: 79 PID: 1 Comm: swapper/0 Tainted: G        W         5.9.0-rc2-00105-g740e72cd6717 #14
>>>> [   17.084998] Hardware name: linux,dummy-virt (DT)
>>>> [   17.085745] pstate: 60400005 (nZCv daif +PAN -UAO BTYPE=--)
>>>> [   17.086645] pc : pgtable_trans_huge_deposit+0x58/0x60
>>>> [   17.087462] lr : debug_vm_pgtable+0x4dc/0x8f0
>>>> [   17.088168] sp : ffff80001219bcf0
>>>> [   17.088710] x29: ffff80001219bcf0 x28: ffff8000114ac000
>>>> [   17.089574] x27: ffff8000114ac000 x26: 0020000000000fd3
>>>> [   17.090431] x25: 0020000081400fd3 x24: fffffe00175c12c0
>>>> [   17.091286] x23: ffff0005df04d1a8 x22: 0000f18d6e035000
>>>> [   17.092143] x21: ffff0005dd790000 x20: ffff0005df18e1a8
>>>> [   17.093003] x19: ffff0005df04cb80 x18: 0000000000000014
>>>> [   17.093859] x17: 00000000b76667d0 x16: 00000000fd4e6611
>>>> [   17.094716] x15: 0000000000000001 x14: 0000000000000002
>>>> [   17.095572] x13: 000000000055d966 x12: fffffe001755e400
>>>> [   17.096429] x11: 0000000000000008 x10: ffff0005fcb6e210
>>>> [   17.097292] x9 : ffff0005fcb6e210 x8 : 0020000081590fd3
>>>> [   17.098149] x7 : ffff0005dd71e0c0 x6 : ffff0005df18e1a8
>>>> [   17.099006] x5 : 0020000081590fd3 x4 : 0020000081590fd3
>>>> [   17.099862] x3 : ffff0005df18e1a8 x2 : fffffe00175c12c0
>>>> [   17.100718] x1 : fffffe00175c1300 x0 : 0000000000000000
>>>> [   17.101583] Call trace:
>>>> [   17.101993]  pgtable_trans_huge_deposit+0x58/0x60
>>>> [   17.102754]  do_one_initcall+0x74/0x1cc
>>>> [   17.103381]  kernel_init_freeable+0x1d0/0x238
>>>> [   17.104089]  kernel_init+0x14/0x118
>>>> [   17.104658]  ret_from_fork+0x10/0x34
>>>> [   17.105251] Code: f9000443 f9000843 f9000822 d65f03c0 (d4210000)
>>>> [   17.106303] ---[ end trace e63471e00f8c147f ]---
>>>>
>>>
>>> IIUC, this should happen even without the series right? This is
>>>
>>>      assert_spin_locked(pmd_lockptr(mm, pmdp));
>>
>> Crash does not happen without this series. A previous patch [PATCH v3 08/13]
>> added pgtable_trans_huge_deposit/withdraw() in pmd_advanced_tests(). arm64
>> does not define __HAVE_ARCH_PGTABLE_DEPOSIT and hence falls back on generic
>> pgtable_trans_huge_deposit() which the asserts the lock.
>>
> 
> 
> I fixed that by moving the pgtable deposit after adding the pmd locks correctly.
> 
> mm/debug_vm_pgtable/locks: Move non page table modifying test together
> mm/debug_vm_pgtable/locks: Take correct page table lock
> mm/debug_vm_pgtable/thp: Use page table depost/withdraw with THP

Right, it does fix. But then both those patches should be folded/merged in
order to preserve git bisect ability, besides test classification reasons
as mentioned in a previous response and a possible redundant movement of
hugetlb_basic_tests().
