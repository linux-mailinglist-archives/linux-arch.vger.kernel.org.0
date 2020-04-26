Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A79E1B8B66
	for <lists+linux-arch@lfdr.de>; Sun, 26 Apr 2020 04:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbgDZCnl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 25 Apr 2020 22:43:41 -0400
Received: from foss.arm.com ([217.140.110.172]:36906 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgDZCnk (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sat, 25 Apr 2020 22:43:40 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 88A7A31B;
        Sat, 25 Apr 2020 19:43:39 -0700 (PDT)
Received: from [10.163.1.45] (unknown [10.163.1.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61C1D3F73D;
        Sat, 25 Apr 2020 19:43:29 -0700 (PDT)
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
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <87d37591-caa2-b82b-392a-3a29b2c7e9a6@arm.com>
Date:   Sun, 26 Apr 2020 08:13:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200425175511.7a68efb5e2f4436fe0328c1d@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 04/26/2020 06:25 AM, Andrew Morton wrote:
> On Tue, 14 Apr 2020 17:14:30 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:
> 
>> There are multiple similar definitions for arch_clear_hugepage_flags() on
>> various platforms. This introduces HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS for those
>> platforms that need to define their own arch_clear_hugepage_flags() while
>> also providing a generic fallback definition for others to use. This help
>> reduce code duplication.
>>
>> ...
>>
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -544,6 +544,10 @@ static inline int is_hugepage_only_range(struct mm_struct *mm,
>>  }
>>  #endif
>>  
>> +#ifndef HAVE_ARCH_CLEAR_HUGEPAGE_FLAGS
>> +static inline void arch_clear_hugepage_flags(struct page *page) { }
>> +#endif
>> +
>>  #ifndef arch_make_huge_pte
>>  static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>>  				       struct page *page, int writable)
> 
> This is the rather old-school way of doing it.  The Linus-suggested way is
> 
> #ifndef arch_clear_hugepage_flags
> static inline void arch_clear_hugepage_flags(struct page *page)
> {
> }
> #define arch_clear_hugepage_flags arch_clear_hugepage_flags

Do we need that above line here ? Is not that implicit.

> #endif
> 
> And the various arch headers do
> 
> static inline void arch_clear_hugepage_flags(struct page *page)
> {
> 	<some implementation>
> }
> #define arch_clear_hugepage_flags arch_clear_hugepage_flags
> 
> It's a small difference - mainly to avoid adding two variables to the
> overall namespace where one would do.

Understood, will change and resend.

> 
> 
