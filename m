Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE1D4FEDC8
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 05:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231949AbiDMDyo (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 23:54:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbiDMDyl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 23:54:41 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D1B53B03A;
        Tue, 12 Apr 2022 20:52:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 29EA713D5;
        Tue, 12 Apr 2022 20:52:21 -0700 (PDT)
Received: from [10.163.39.141] (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 56BE53F73B;
        Tue, 12 Apr 2022 20:52:15 -0700 (PDT)
Message-ID: <20e0b53c-03a3-78ec-7f3e-eb38d9e91ce6@arm.com>
Date:   Wed, 13 Apr 2022 09:22:52 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 6/7] mm/mmap: Drop arch_filter_pgprot()
Content-Language: en-US
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220412043848.80464-1-anshuman.khandual@arm.com>
 <20220412043848.80464-7-anshuman.khandual@arm.com>
 <71fe7ac2-0b10-56a5-e530-3bcbc60f0e63@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <71fe7ac2-0b10-56a5-e530-3bcbc60f0e63@csgroup.eu>
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



On 4/12/22 17:59, Christophe Leroy wrote:
> 
> 
> Le 12/04/2022 à 06:38, Anshuman Khandual a écrit :
>> There are no platforms left which subscribe ARCH_HAS_FILTER_PGPROT. Hence
>> drop generic arch_filter_pgprot() and also config ARCH_HAS_FILTER_PGPROT.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   mm/Kconfig | 3 ---
>>   mm/mmap.c  | 9 +--------
>>   2 files changed, 1 insertion(+), 11 deletions(-)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index b1f7624276f8..3f7b6d7b69df 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -762,9 +762,6 @@ config ARCH_HAS_CURRENT_STACK_POINTER
>>   	  register alias named "current_stack_pointer", this config can be
>>   	  selected.
>>   
>> -config ARCH_HAS_FILTER_PGPROT
>> -	bool
>> -
>>   config ARCH_HAS_VM_GET_PAGE_PROT
>>   	bool
>>   
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index 87cb2eaf7e1a..edf2a5e38f4d 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -107,20 +107,13 @@ pgprot_t protection_map[16] __ro_after_init = {
>>   };
>>   
>>   #ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
>> -#ifndef CONFIG_ARCH_HAS_FILTER_PGPROT
>> -static inline pgprot_t arch_filter_pgprot(pgprot_t prot)
>> -{
>> -	return prot;
>> -}
>> -#endif
>> -
>>   pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>   {
>>   	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
>>   				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>>   			pgprot_val(arch_vm_get_page_prot(vm_flags)));
>>   
>> -	return arch_filter_pgprot(ret);
>> +	return ret;
> 
> You can drop 'ret' and directly do:
> 
> 	return  __pgprot(pgprot_val(protection_map[vm_flags &
> 			(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
> 			pgprot_val(arch_vm_get_page_prot(vm_flags)));

Sure, will do.

> 
> 
>>   }
>>   EXPORT_SYMBOL(vm_get_page_prot);
>>   #endif	/* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
