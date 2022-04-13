Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749734FEFC1
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 08:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiDMGY0 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Apr 2022 02:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiDMGY0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 13 Apr 2022 02:24:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E6714BFD1;
        Tue, 12 Apr 2022 23:22:06 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1BB61150C;
        Tue, 12 Apr 2022 23:22:06 -0700 (PDT)
Received: from [10.163.39.141] (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A73273F70D;
        Tue, 12 Apr 2022 23:22:00 -0700 (PDT)
Message-ID: <e0efde60-625c-fa58-79c4-5e8a86ddf203@arm.com>
Date:   Wed, 13 Apr 2022 11:52:36 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V6 4/7] sparc/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        khalid.aziz@oracle.com
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Khalid Aziz <khalid.aziz@oracle.com>
References: <20220413055840.392628-1-anshuman.khandual@arm.com>
 <20220413055840.392628-5-anshuman.khandual@arm.com>
 <c3619877-32db-aaa3-5dd9-4917c067bc42@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <c3619877-32db-aaa3-5dd9-4917c067bc42@csgroup.eu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 4/13/22 11:43, Christophe Leroy wrote:
> 
> 
> Le 13/04/2022 à 07:58, Anshuman Khandual a écrit :
>> This defines and exports a platform specific custom vm_get_page_prot() via
>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. It localizes arch_vm_get_page_prot()
>> as sparc_vm_get_page_prot() and moves near vm_get_page_prot().
>>
>> Cc: "David S. Miller" <davem@davemloft.net>
>> Cc: Khalid Aziz <khalid.aziz@oracle.com>
>> Cc: sparclinux@vger.kernel.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   arch/sparc/Kconfig            |  1 +
>>   arch/sparc/include/asm/mman.h |  6 ------
>>   arch/sparc/mm/init_64.c       | 13 +++++++++++++
>>   3 files changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>> index 9200bc04701c..85b573643af6 100644
>> --- a/arch/sparc/Kconfig
>> +++ b/arch/sparc/Kconfig
>> @@ -84,6 +84,7 @@ config SPARC64
>>   	select PERF_USE_VMALLOC
>>   	select ARCH_HAVE_NMI_SAFE_CMPXCHG
>>   	select HAVE_C_RECORDMCOUNT
>> +	select ARCH_HAS_VM_GET_PAGE_PROT
>>   	select HAVE_ARCH_AUDITSYSCALL
>>   	select ARCH_SUPPORTS_ATOMIC_RMW
>>   	select ARCH_SUPPORTS_DEBUG_PAGEALLOC
>> diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
>> index 274217e7ed70..af9c10c83dc5 100644
>> --- a/arch/sparc/include/asm/mman.h
>> +++ b/arch/sparc/include/asm/mman.h
>> @@ -46,12 +46,6 @@ static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
>>   	}
>>   }
>>   
>> -#define arch_vm_get_page_prot(vm_flags) sparc_vm_get_page_prot(vm_flags)
>> -static inline pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
>> -{
>> -	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
>> -}
>> -
>>   #define arch_validate_prot(prot, addr) sparc_validate_prot(prot, addr)
>>   static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
>>   {
>> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
>> index 8b1911591581..dcb17763c1f2 100644
>> --- a/arch/sparc/mm/init_64.c
>> +++ b/arch/sparc/mm/init_64.c
>> @@ -3184,3 +3184,16 @@ void copy_highpage(struct page *to, struct page *from)
>>   	}
>>   }
>>   EXPORT_SYMBOL(copy_highpage);
>> +
>> +static pgprot_t sparc_vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	return (vm_flags & VM_SPARC_ADI) ? __pgprot(_PAGE_MCD_4V) : __pgprot(0);
>> +}
>> +
>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>> +{
>> +	return __pgprot(pgprot_val(protection_map[vm_flags &
>> +			(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>> +			pgprot_val(sparc_vm_get_page_prot(vm_flags)));
>> +}
>> +EXPORT_SYMBOL(vm_get_page_prot);
> 
> 
> sparc is now the only one with two functions. You can most likely do 
> like you did for ARM and POWERPC: merge into a single function:

I was almost about to do this one as well but as this patch has already been
reviewed with a tag, just skipped it. I will respin the series once more :)

Khalid,

Could I keep your review tag after the following change ?

> 
> pgprot_t vm_get_page_prot(unsigned long vm_flags)
> {
> 	unsigned long prot = pgprot_val(protection_map[vm_flags &
> 		(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]);
> 
> 	if (vm_flags & VM_SPARC_ADI)
> 		prot |= _PAGE_MCD_4V;
> 
> 	return __pgprot(prot);
> }
> EXPORT_SYMBOL(vm_get_page_prot);

- Anshuman
