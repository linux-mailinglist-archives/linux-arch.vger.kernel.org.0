Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F133A2320
	for <lists+linux-arch@lfdr.de>; Thu, 10 Jun 2021 06:15:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFJERa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 10 Jun 2021 00:17:30 -0400
Received: from foss.arm.com ([217.140.110.172]:49190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229529AbhFJER3 (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 10 Jun 2021 00:17:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 794C46D;
        Wed,  9 Jun 2021 21:15:33 -0700 (PDT)
Received: from [10.163.83.16] (unknown [10.163.83.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C198E3F694;
        Wed,  9 Jun 2021 21:15:24 -0700 (PDT)
Subject: Re: [PATCH V2] mm/thp: Define default pmd_pgtable()
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Nick Hu <nickhu@andestech.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Michal Simek <monstr@monstr.eu>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Ley Foon Tan <ley.foon.tan@intel.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        "David S. Miller" <davem@davemloft.net>,
        Jeff Dike <jdike@addtoit.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Chris Zankel <chris@zankel.net>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1623214799-29817-1-git-send-email-anshuman.khandual@arm.com>
 <YMCA6Nsuu26k1746@kernel.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <2fde44aa-f74a-3948-d444-d04bc1f839eb@arm.com>
Date:   Thu, 10 Jun 2021 09:46:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YMCA6Nsuu26k1746@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 6/9/21 2:20 PM, Mike Rapoport wrote:
> Hi Anshuman,
> 
> On Wed, Jun 09, 2021 at 10:29:59AM +0530, Anshuman Khandual wrote:
>> Currently most platforms define pmd_pgtable() as pmd_page() duplicating the
>> same code all over. Instead just define a default value i.e pmd_page() for
>> pmd_pgtable() and let platforms override when required via <asm/pgtable.h>.
>> All the existing platform that override pmd_pgtable() have been moved into
>> their respective <asm/pgtable.h> header in order to precede before the new
>> generic definition. This makes it much cleaner with reduced code.
>>
>> Cc: Nick Hu <nickhu@andestech.com>
>> Cc: Richard Henderson <rth@twiddle.net>
>> Cc: Vineet Gupta <vgupta@synopsys.com>
>> Cc: Catalin Marinas <catalin.marinas@arm.com>
>> Cc: Will Deacon <will@kernel.org>
>> Cc: Guo Ren <guoren@kernel.org>
>> Cc: Brian Cain <bcain@codeaurora.org>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Cc: Michal Simek <monstr@monstr.eu>
>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>> Cc: Ley Foon Tan <ley.foon.tan@intel.com>
>> Cc: Jonas Bonn <jonas@southpole.se>
>> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
>> Cc: Stafford Horne <shorne@gmail.com>
>> Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
>> Cc: Paul Walmsley <paul.walmsley@sifive.com>
>> Cc: Palmer Dabbelt <palmer@dabbelt.com>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Jeff Dike <jdike@addtoit.com>
>> Cc: Thomas Gleixner <tglx@linutronix.de>
>> Cc: Chris Zankel <chris@zankel.net>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-arch@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> One nit below, otherwise
> 
> Acked-by: Mike Rapoport <rppt@linux.ibm.com>
> 
>> ---
>> This patch applies on linux-next (20210608) as there is a merge conflict
>> dependency on the following commit.
>>
>> 40762590e8be ("mm: define default value for FIRST_USER_ADDRESS").
>>
>> This patch has been built tested across multiple platforms.
>>
>> Changes in V2:
>>
>> - Changed m68k per Geert
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/linux-arch/1623130327-13325-1-git-send-email-anshuman.khandual@arm.com/
> ...
> 
>> diff --git a/arch/m68k/include/asm/sun3_pgalloc.h b/arch/m68k/include/asm/sun3_pgalloc.h
>> index 000f64869b91..198036aff519 100644
>> --- a/arch/m68k/include/asm/sun3_pgalloc.h
>> +++ b/arch/m68k/include/asm/sun3_pgalloc.h
>> @@ -32,7 +32,6 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd, pgtable_t page
>>  {
>>  	pmd_val(*pmd) = __pa((unsigned long)page_address(page));
>>  }
>> -#define pmd_pgtable(pmd) pmd_page(pmd)
>>  
>>  /*
>>   * allocating and freeing a pmd is trivial: the 1-entry pmd is
>> diff --git a/arch/m68k/include/asm/sun3_pgtable.h b/arch/m68k/include/asm/sun3_pgtable.h
>> index 5b24283a0a42..127282bd8b96 100644
>> --- a/arch/m68k/include/asm/sun3_pgtable.h
>> +++ b/arch/m68k/include/asm/sun3_pgtable.h
>> @@ -96,6 +96,8 @@
>>  
>>  #ifndef __ASSEMBLY__
>>  
>> +#define pmd_pgtable(pmd) pmd_page(pmd)
>> +
> Is this one really needed? Won't the generic definition work instead?
> 

It should, sun3_defconfig builds without problem. Will drop pmd_pgtable() here.
