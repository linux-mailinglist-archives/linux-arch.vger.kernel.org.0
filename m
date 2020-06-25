Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D44209BB3
	for <lists+linux-arch@lfdr.de>; Thu, 25 Jun 2020 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390815AbgFYJFS (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 Jun 2020 05:05:18 -0400
Received: from foss.arm.com ([217.140.110.172]:50212 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389473AbgFYJFS (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 25 Jun 2020 05:05:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E916CC0A;
        Thu, 25 Jun 2020 02:05:16 -0700 (PDT)
Received: from [192.168.1.179] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BB5F3F6CF;
        Thu, 25 Jun 2020 02:05:15 -0700 (PDT)
Subject: Re: [PATCH v5 21/25] mm: Add arch hooks for saving/restoring tags
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, Will Deacon <will@kernel.org>,
        Dave P Martin <Dave.Martin@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Peter Collingbourne <pcc@google.com>
References: <20200624175244.25837-1-catalin.marinas@arm.com>
 <20200624175244.25837-22-catalin.marinas@arm.com>
 <20200624114534.9520ba5ed235bc32bf1af3a2@linux-foundation.org>
From:   Steven Price <steven.price@arm.com>
Message-ID: <40250ed8-50fe-3945-d7d3-331e03b2abe8@arm.com>
Date:   Thu, 25 Jun 2020 10:04:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200624114534.9520ba5ed235bc32bf1af3a2@linux-foundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 24/06/2020 19:45, Andrew Morton wrote:
> On Wed, 24 Jun 2020 18:52:40 +0100 Catalin Marinas <catalin.marinas@arm.com> wrote:
> 
>> From: Steven Price <steven.price@arm.com>
>>
>> Arm's Memory Tagging Extension (MTE) adds some metadata (tags) to
>> every physical page, when swapping pages out to disk it is necessary to
>> save these tags, and later restore them when reading the pages back.
>>
>> Add some hooks along with dummy implementations to enable the
>> arch code to handle this.
>>
>> Three new hooks are added to the swap code:
>>   * arch_prepare_to_swap() and
>>   * arch_swap_invalidate_page() / arch_swap_invalidate_area().
>> One new hook is added to shmem:
>>   * arch_swap_restore_tags()
>>
>> ...
>>
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -631,6 +631,29 @@ static inline int arch_unmap_one(struct mm_struct *mm,
>>   }
>>   #endif
>>   
>> +#ifndef __HAVE_ARCH_PREPARE_TO_SWAP
>> +static inline int arch_prepare_to_swap(struct page *page)
>> +{
>> +	return 0;
>> +}
>> +#endif
>> +
>> +#ifndef __HAVE_ARCH_SWAP_INVALIDATE
>> +static inline void arch_swap_invalidate_page(int type, pgoff_t offset)
>> +{
>> +}
>> +
>> +static inline void arch_swap_invalidate_area(int type)
>> +{
>> +}
>> +#endif
>> +
>> +#ifndef __HAVE_ARCH_SWAP_RESTORE_TAGS
>> +static inline void arch_swap_restore_tags(swp_entry_t entry, struct page *page)
>> +{
>> +}
>> +#endif
> 
> Presumably these three __HAVE_ARCH_ macros are to be defined in asm/pgtable.h?

That would be the idea (see patch 22). However:

Catalin - you've renamed __HAVE_ARCH_SWAP_RESTORE_TAGS in patch 22, but 
not here!

Steve
