Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE00F4FEDC5
	for <lists+linux-arch@lfdr.de>; Wed, 13 Apr 2022 05:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231232AbiDMDyF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 12 Apr 2022 23:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231528AbiDMDyE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 12 Apr 2022 23:54:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54988369F9;
        Tue, 12 Apr 2022 20:51:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA25413D5;
        Tue, 12 Apr 2022 20:51:42 -0700 (PDT)
Received: from [10.163.39.141] (unknown [10.163.39.141])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E7D9C3F73B;
        Tue, 12 Apr 2022 20:51:37 -0700 (PDT)
Message-ID: <d45b5adb-e19d-a910-ef03-0b5ba1dfb051@arm.com>
Date:   Wed, 13 Apr 2022 09:22:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V5 7/7] mm/mmap: Drop arch_vm_get_page_pgprot()
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
 <20220412043848.80464-8-anshuman.khandual@arm.com>
 <99d110d7-6c99-c42e-e93a-a6bc7cbde8d8@csgroup.eu>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <99d110d7-6c99-c42e-e93a-a6bc7cbde8d8@csgroup.eu>
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



On 4/12/22 18:00, Christophe Leroy wrote:
> 
> 
> Le 12/04/2022 à 06:38, Anshuman Khandual a écrit :
>> There are no platforms left which use arch_vm_get_page_prot(). Just drop
>> generic arch_vm_get_page_prot().
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>>   include/linux/mman.h | 4 ----
>>   mm/mmap.c            | 3 +--
>>   2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/include/linux/mman.h b/include/linux/mman.h
>> index b66e91b8176c..58b3abd457a3 100644
>> --- a/include/linux/mman.h
>> +++ b/include/linux/mman.h
>> @@ -93,10 +93,6 @@ static inline void vm_unacct_memory(long pages)
>>   #define arch_calc_vm_flag_bits(flags) 0
>>   #endif
>>   
>> -#ifndef arch_vm_get_page_prot
>> -#define arch_vm_get_page_prot(vm_flags) __pgprot(0)
>> -#endif
>> -
>>   #ifndef arch_validate_prot
>>   /*
>>    * This is called from mprotect().  PROT_GROWSDOWN and PROT_GROWSUP have
>> diff --git a/mm/mmap.c b/mm/mmap.c
>> index edf2a5e38f4d..db7f33154206 100644
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -110,8 +110,7 @@ pgprot_t protection_map[16] __ro_after_init = {
>>   pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>   {
>>   	pgprot_t ret = __pgprot(pgprot_val(protection_map[vm_flags &
>> -				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]) |
>> -			pgprot_val(arch_vm_get_page_prot(vm_flags)));
>> +				(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED)]));
>>   
>>   	return ret;
>>   }
> 
> __pgprot(pgprot_val(x)) is a no-op.
> 
> You can simply do:
> 
> 	return protection_map[vm_flags &
> 		(VM_READ|VM_WRITE|VM_EXEC|VM_SHARED);

Sure, will do.
