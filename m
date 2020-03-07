Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 440BE17C9F7
	for <lists+linux-arch@lfdr.de>; Sat,  7 Mar 2020 01:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726533AbgCGA4u (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 6 Mar 2020 19:56:50 -0500
Received: from foss.arm.com ([217.140.110.172]:39878 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726237AbgCGA4u (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Fri, 6 Mar 2020 19:56:50 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7192C30E;
        Fri,  6 Mar 2020 16:56:49 -0800 (PST)
Received: from [10.163.1.59] (unknown [10.163.1.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D25853F237;
        Fri,  6 Mar 2020 16:56:41 -0800 (PST)
Subject: Re: [PATCH V15] mm/debug: Add tests validating architecture page
 table helpers
To:     Qian Cai <cai@lca.pw>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
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
        Christophe Leroy <christophe.leroy@c-s.fr>
References: <61250cdc-f80b-2e50-5168-2ec67ec6f1e6@arm.com>
 <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <a45834bc-e6f2-ac21-de9e-1aff67d12797@arm.com>
Date:   Sat, 7 Mar 2020 06:26:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CEEAD95E-D468-4C58-A65B-7E8AED91168A@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 03/07/2020 06:04 AM, Qian Cai wrote:
> 
> 
>> On Mar 6, 2020, at 7:03 PM, Anshuman Khandual <Anshuman.Khandual@arm.com> wrote:
>>
>> Hmm, set_pte_at() function is not preferred here for these tests. The idea
>> is to avoid or atleast minimize TLB/cache flushes triggered from these sort
>> of 'static' tests. set_pte_at() is platform provided and could/might trigger
>> these flushes or some other platform specific synchronization stuff. Just
> 
> Why is that important for this debugging option?

Primarily reason is to avoid TLB/cache flush instructions on the system
during these tests that only involve transforming different page table
level entries through helpers. Unless really necessary, why should it
emit any TLB/cache flush instructions ?

> 
>> wondering is there specific reason with respect to the soft lock up problem
>> making it necessary to use set_pte_at() rather than a simple WRITE_ONCE() ?
> 
> Looks at the s390 version of set_pte_at(), it has this comment,
> vmaddr);
> 
> /*
>  * Certain architectures need to do special things when PTEs
>  * within a page table are directly modified.  Thus, the following
>  * hook is made available.
>  */
> 
> I can only guess that powerpc  could be the same here.

This comment is present in multiple platforms while defining set_pte_at().
Is not 'barrier()' here alone good enough ? Else what exactly set_pte_at()
does as compared to WRITE_ONCE() that avoids the soft lock up, just trying
to understand.
