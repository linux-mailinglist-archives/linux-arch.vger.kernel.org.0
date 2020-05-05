Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE8AC1C4C5D
	for <lists+linux-arch@lfdr.de>; Tue,  5 May 2020 04:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgEECwS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 22:52:18 -0400
Received: from foss.arm.com ([217.140.110.172]:57846 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726516AbgEECwS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 22:52:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D5C41FB;
        Mon,  4 May 2020 19:52:17 -0700 (PDT)
Received: from [192.168.0.129] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 20A803F71F;
        Mon,  4 May 2020 19:52:04 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH 3/3] mm/hugetlb: Introduce HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Mike Kravetz <mike.kravetz@oracle.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1586864670-21799-1-git-send-email-anshuman.khandual@arm.com>
 <1586864670-21799-4-git-send-email-anshuman.khandual@arm.com>
 <20200425175511.7a68efb5e2f4436fe0328c1d@linux-foundation.org>
 <87d37591-caa2-b82b-392a-3a29b2c7e9a6@arm.com>
 <20200425200124.20d0c75fcaef05d062d3667c@linux-foundation.org>
Message-ID: <21460cbc-8e9a-b956-5797-57b2e1df9fb1@arm.com>
Date:   Tue, 5 May 2020 08:21:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200425200124.20d0c75fcaef05d062d3667c@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 04/26/2020 08:31 AM, Andrew Morton wrote:
> On Sun, 26 Apr 2020 08:13:17 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>>
>>
>> On 04/26/2020 06:25 AM, Andrew Morton wrote:
>>> On Tue, 14 Apr 2020 17:14:30 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
>>>
>>>> There are multiple similar definitions for arch_clear_hugepage_flags() on
>>>> various platforms. This introduces HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS for those
>>>> platforms that need to define their own arch_clear_hugepage_flags() while
>>>> also providing a generic fallback definition for others to use. This help
>>>> reduce code duplication.
>>>>
>>>> ...
>>>>
>>>> --- a/include/linux/hugetlb.h
>>>> +++ b/include/linux/hugetlb.h
>>>> @@ -544,6 +544,10 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>>>>  }
>>>>  #endif
>>>>  
>>>> +#ifndef HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
>>>> +static inline void arch_clear_hugepage_flags(struct page *page) { }
>>>> +#endif
>>>> +
>>>>  #ifndef arch_make_huge_pte
>>>>  static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>>>>  				       struct page *page, int writable)
>>>
>>> This is the rather old-school way of doing it.  The Linus-suggested way is
>>>
>>> #ifndef arch_clear_hugepage_flags
>>> static inline void arch_clear_hugepage_flags(struct page *page)
>>> {
>>> }
>>> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
>>
>> Do we need that above line here ? Is not that implicit.
> 
> It depends if other header files want to test whether
> arch_clear_hugepage_flags is already defined.  If the header heorarchy
> is well-defined and working properly, they shouldn't need to, because
> we're reliably indluding the relevant arch header before (or early
> within) include/linux/hugetlb.h.
> 
> It would be nice if
> 
> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> 
> were to generate an compiler error but it doesn't.  If it did we could
> detect these incorrect inclusion orders.
> 
>>> #endif
>>>
>>> And the various arch headers do
>>>
>>> static inline void arch_clear_hugepage_flags(struct page *page)
>>> {
>>> 	<some implementation>
>>> }
>>> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
>>>
>>> It's a small difference - mainly to avoid adding two variables to the
>>> overall namespace where one would do.
>>
>> Understood, will change and resend.
> 
> That's OK - I've queued up that fix.
>

Hello Andrew,

I might not have searched all the relevant trees or might have just searched
earlier than required. But I dont see these patches (or your proposed fixes)
either in mmotm (2020-04-29-23-04) or in next-20200504. Wondering if you are
waiting on a V2 for this series accommodating the changes you had proposed.

- Anshuman
