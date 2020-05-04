Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAB11C39F1
	for <lists+linux-arch@lfdr.de>; Mon,  4 May 2020 14:53:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728145AbgEDMxa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 4 May 2020 08:53:30 -0400
Received: from foss.arm.com ([217.140.110.172]:43816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725941AbgEDMxa (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 4 May 2020 08:53:30 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6B5E1FB;
        Mon,  4 May 2020 05:53:29 -0700 (PDT)
Received: from [192.168.1.84] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85DBD3F71F;
        Mon,  4 May 2020 05:53:28 -0700 (PDT)
Subject: Re: [PATCH 3/4] arm64: mte: Enable swap of tagged pages
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Hugh Dickins <hughd@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>
References: <20200422142530.32619-1-steven.price@arm.com>
 <20200422142530.32619-4-steven.price@arm.com> <20200503152858.GA11959@gaia>
From:   Steven Price <steven.price@arm.com>
Message-ID: <2ef10bcf-e019-beaf-10fb-b342f96e188c@arm.com>
Date:   Mon, 4 May 2020 13:53:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200503152858.GA11959@gaia>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 03/05/2020 16:29, Catalin Marinas wrote:
> On Wed, Apr 22, 2020 at 03:25:29PM +0100, Steven Price wrote:
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index 39a372bf8afc..a4ad1b75a1a7 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -80,6 +80,8 @@ extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
>>   #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>>   #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
>>   #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
>> +#define pte_tagged(pte)		(!!((pte_val(pte) & PTE_ATTRINDX_MASK) == \
>> +				    PTE_ATTRINDX(MT_NORMAL_TAGGED)))
>>   
>>   #define pte_cont_addr_end(addr, end)						\
>>   ({	unsigned long __boundary = ((addr) + CONT_PTE_SIZE) & CONT_PTE_MASK;	\
>> @@ -268,12 +270,17 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>>   		     __func__, pte_val(old_pte), pte_val(pte));
>>   }
>>   
>> +void mte_sync_tags(pte_t *ptep, pte_t pte);
>> +
>>   static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   			      pte_t *ptep, pte_t pte)
>>   {
>>   	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>>   		__sync_icache_dcache(pte);
>>   
>> +	if (system_supports_mte() && pte_tagged(pte))
>> +		mte_sync_tags(ptep, pte);
> 
> I think this needs a pte_present() check as well, otherwise pte_tagged()
> could match some random swap entry.

Good spot - mte_sync_tags() bails out fairly early in this case (which 
explains why I didn't see any problems). But it's *after* PG_mte_tagged 
is set which will lead to incorrectly flagging pages.

Thanks,

Steve
