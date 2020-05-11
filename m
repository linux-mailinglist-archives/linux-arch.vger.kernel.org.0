Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A794B1CD041
	for <lists+linux-arch@lfdr.de>; Mon, 11 May 2020 05:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgEKDPV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 10 May 2020 23:15:21 -0400
Received: from foss.arm.com ([217.140.110.172]:50292 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726013AbgEKDPV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 10 May 2020 23:15:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B3601FB;
        Sun, 10 May 2020 20:15:20 -0700 (PDT)
Received: from [10.163.72.179] (unknown [10.163.72.179])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F18C63F305;
        Sun, 10 May 2020 20:15:09 -0700 (PDT)
Subject: Re: [PATCH V3 2/3] mm/hugetlb: Define a generic fallback for
 is_hugepage_only_range()
To:     Mike Kravetz <mike.kravetz@oracle.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org
Cc:     Russell King <linux@armlinux.org.uk>,
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
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1588907271-11920-1-git-send-email-anshuman.khandual@arm.com>
 <1588907271-11920-3-git-send-email-anshuman.khandual@arm.com>
 <9fc622e1-45ff-b79f-ebe0-35614837456c@oracle.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c21ab871-da06-baf6-ba31-80b13402b8c9@arm.com>
Date:   Mon, 11 May 2020 08:44:39 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <9fc622e1-45ff-b79f-ebe0-35614837456c@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 05/09/2020 03:52 AM, Mike Kravetz wrote:
> On 5/7/20 8:07 PM, Anshuman Khandual wrote:
>> There are multiple similar definitions for is_hugepage_only_range() on
>> various platforms. Lets just add it's generic fallback definition for
>> platforms that do not override. This help reduce code duplication.
>>
>> Cc: Russell King <linux@armlinux.org.uk>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Tony Luck <tony.luck@intel.com>
>> Cc: Fenghua Yu <fenghua.yu@intel.com>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
>> Cc: Vasily Gorbik <gor@linux.ibm.com>
>> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: Rich Felker <dalias@libc.org>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Ingo Molnar <mingo@redhat.com>
>> Cc: Borislav Petkov <bp@alien8.de>
>> Cc: "H. Peter Anvin" <hpa@zytor.com>
>> Cc: Mike Kravetz <mike.kravetz@oracle.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: x86@kernel.org
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-ia64@vger.kernel.org
>> Cc: linux-mips@vger.kernel.org
>> Cc: linux-parisc@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-riscv@lists.infradead.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: linux-sh@vger.kernel.org
>> Cc: sparclinux@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>  arch/arm/include/asm/hugetlb.h     | 6 ------
>>  arch/arm64/include/asm/hugetlb.h   | 6 ------
>>  arch/ia64/include/asm/hugetlb.h    | 1 +
>>  arch/mips/include/asm/hugetlb.h    | 7 -------
>>  arch/parisc/include/asm/hugetlb.h  | 6 ------
>>  arch/powerpc/include/asm/hugetlb.h | 1 +
>>  arch/riscv/include/asm/hugetlb.h   | 6 ------
>>  arch/s390/include/asm/hugetlb.h    | 7 -------
>>  arch/sh/include/asm/hugetlb.h      | 6 ------
>>  arch/sparc/include/asm/hugetlb.h   | 6 ------
>>  arch/x86/include/asm/hugetlb.h     | 6 ------
>>  include/linux/hugetlb.h            | 9 +++++++++
>>  12 files changed, 11 insertions(+), 56 deletions(-)
>>
> <snip>
>> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
>> index 43a1cef8f0f1..c01c0c6f7fd4 100644
>> --- a/include/linux/hugetlb.h
>> +++ b/include/linux/hugetlb.h
>> @@ -591,6 +591,15 @@ static inline unsigned int blocks_per_huge_page(struct hstate *h)
>>  
>>  #include <asm/hugetlb.h>
>>  
>> +#ifndef is_hugepage_only_range
>> +static inline int is_hugepage_only_range(struct mm_struct *mm,
>> +					unsigned long addr, unsigned long len)
>> +{
>> +	return 0;
>> +}
>> +#define is_hugepage_only_range is_hugepage_only_range
>> +#endif
>> +
>>  #ifndef arch_make_huge_pte
>>  static inline pte_t arch_make_huge_pte(pte_t entry, struct vm_area_struct *vma,
>>  				       struct page *page, int writable)
>>
> 
> Did you try building without CONFIG_HUGETLB_PAGE defined?  I'm guessing

Yes I did for multiple platforms (s390, arm64, ia64, x86, powerpc etc).

> that you need a stub for is_hugepage_only_range().  Or, perhaps add this
> to asm-generic/hugetlb.h?
> 
There is already a stub (include/linux/hugetlb.h) when !CONFIG_HUGETLB_PAGE.
