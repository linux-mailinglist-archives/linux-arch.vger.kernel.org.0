Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361396BE26C
	for <lists+linux-arch@lfdr.de>; Fri, 17 Mar 2023 09:00:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231145AbjCQIAv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 17 Mar 2023 04:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCQIAr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 17 Mar 2023 04:00:47 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CB74AEC7C;
        Fri, 17 Mar 2023 01:00:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7831480;
        Fri, 17 Mar 2023 01:01:26 -0700 (PDT)
Received: from [10.57.64.98] (unknown [10.57.64.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E52CC3F64C;
        Fri, 17 Mar 2023 01:00:41 -0700 (PDT)
Message-ID: <25bf8e75-cc2e-7d08-dbba-41c53ab751b0@arm.com>
Date:   Fri, 17 Mar 2023 08:00:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH v4 35/36] mm: Convert do_set_pte() to set_pte_range()
Content-Language: en-US
To:     "Yin, Fengwei" <fengwei.yin@intel.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     linux-arch@vger.kernel.org, will@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-36-willy@infradead.org>
 <6dd5cdf8-400e-8378-22be-994f0ada5cc2@arm.com>
 <b39f4816-2064-e402-4e02-908f40c396d4@intel.com>
 <2fa5a911-8432-2fce-c6e1-de4e592219d8@arm.com>
 <ZBNXcmOrrOS4Rydg@casper.infradead.org>
 <b2c00aab-82ad-ea7a-df9d-c816b216b0f1@intel.com>
 <ZBPiOgYDLYBmVwOc@casper.infradead.org>
 <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <12d7564f-5b33-bdcc-1a06-504ad8487aca@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 17/03/2023 06:33, Yin, Fengwei wrote:
> 
> 
> On 3/17/2023 11:44 AM, Matthew Wilcox wrote:
>> On Fri, Mar 17, 2023 at 09:58:17AM +0800, Yin, Fengwei wrote:
>>>
>>>
>>> On 3/17/2023 1:52 AM, Matthew Wilcox wrote:
>>>> On Thu, Mar 16, 2023 at 04:38:58PM +0000, Ryan Roberts wrote:
>>>>> On 16/03/2023 16:23, Yin, Fengwei wrote:
>>>>>>> I think you are changing behavior here - is this intentional? Previously this
>>>>>>> would be evaluated per page, now its evaluated once for the whole range. The
>>>>>>> intention below is that directly faulted pages are mapped young and prefaulted
>>>>>>> pages are mapped old. But now a whole range will be mapped the same.
>>>>>>
>>>>>> Yes. You are right here.
>>>>>>
>>>>>> Look at the prefault and cpu_has_hw_af for ARM64, it looks like we
>>>>>> can avoid to handle vmf->address == addr specially. It's OK to 
>>>>>> drop prefault and change the logic here a little bit to:
>>>>>>   if (arch_wants_old_prefaulted_pte())
>>>>>>       entry = pte_mkold(entry);
>>>>>>   else
>>>>>>       entry = pte_sw_mkyong(entry);
>>>>>>
>>>>>> It's not necessary to use pte_sw_mkyong for vmf->address == addr
>>>>>> because HW will set the ACCESS bit in page table entry.
>>>>>>
>>>>>> Add Will Deacon in case I missed something here. Thanks.
>>>>>
>>>>> I'll defer to Will's response, but not all arm HW supports HW access flag
>>>>> management. In that case it's done by SW, so I would imagine that by setting
>>>>> this to old initially, we will get a second fault to set the access bit, which
>>>>> will slow things down. I wonder if you will need to split this into (up to) 3
>>>>> calls to set_ptes()?
>>>>
>>>> I don't think we should do that.  The limited information I have from
>>>> various microarchitectures is that the PTEs must differ only in their
>>>> PFN bits in order to use larger TLB entries.  That includes the Accessed
>>>> bit (or equivalent).  So we should mkyoung all the PTEs in the same
>>>> folio, at least initially.
>>>>
>>>> That said, we should still do this conditionally.  We'll prefault some
>>>> other folios too.  So I think this should be:
>>>>
>>>>         bool prefault = (addr > vmf->address) || ((addr + nr) < vmf->address);
>>>>
>>> According to commit 46bdb4277f98e70d0c91f4289897ade533fe9e80, if hardware access
>>> flag is supported on ARM64, there is benefit if prefault PTEs is set as "old".
>>> If we change prefault like above, the PTEs is set as "yong" which loose benefit
>>> on ARM64 with hardware access flag.
>>>
>>> ITOH, if from "old" to "yong" is cheap, why not leave all PTEs of folio as "old"
>>> and let hardware to update it to "yong"?
>>
>> Because we're tracking the entire folio as a single entity.  So we're
>> better off avoiding the extra pagefaults to update the accessed bit,
>> which won't actually give us any information (vmscan needs to know "were
>> any of the accessed bits set", not "how many of them were set").
> There is no extra pagefaults to update the accessed bit. There are three cases here:
> 1. hardware support access flag and cheap from "old" to "yong" without extra fault
> 2. hardware support access flag and expensive from "old" to "yong" without extra fault
> 3. no hardware support access flag (extra pagefaults from "old" to "yong". Expensive)
> 
> For #2 and #3, it's expensive from "old" to "yong", so we always set PTEs "yong" in
> page fault.
> For #1, It's cheap from "old" to "yong", so it's OK to set PTEs "old" in page fault.
> And hardware will set it to "yong" when access memory. Actually, ARM64 with hardware
> access bit requires to set PTEs "old".

Your logic makes sense, but it doesn't take into account the HPA
micro-architectural feature present in some ARM CPUs. HPA can transparently
coalesce multiple pages into a single TLB entry when certain conditions are met
(roughly; upto 4 pages physically and virtually contiguous and all within a
4-page natural alignment). But as Matthew says, this works out better when all
pte attributes (including access and dirty) match. Given the reason for setting
the prefault pages to old is so that vmscan can do a better job of finding cold
pages, and given vmscan will now be looking for folios and not individual pages
(I assume?), I agree with Matthew that we should make whole folios young or old.
It will marginally increase our chances of the access and dirty bits being
consistent across the whole 4-page block that the HW tries to coalesce. If we
unconditionally make everything old, the hw will set accessed for the single
page that faulted, and we therefore don't have consistency for that 4-page block.

> 
>>
>> Anyway, hopefully Ryan can test this and let us know if it fixes the
>> regression he sees.
> I highly suspect the regression Ryan saw is not related with this but another my
> stupid work. I will send out the testing patch soon. Thanks.

I tested a version of this where I made everything unconditionally young,
thinking it might be the source of the perf regression, before I reported it. It
doesn't make any difference. So I agree the regression is somewhere else.

Thanks,
Ryan

> 
> 
> Regards
> Yin, Fengwei

