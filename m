Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E27124C418A
	for <lists+linux-arch@lfdr.de>; Fri, 25 Feb 2022 10:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbiBYJgN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 25 Feb 2022 04:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234262AbiBYJgM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 25 Feb 2022 04:36:12 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 20DE71F7679;
        Fri, 25 Feb 2022 01:35:41 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF2EF106F;
        Fri, 25 Feb 2022 01:35:40 -0800 (PST)
Received: from [10.163.51.16] (unknown [10.163.51.16])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A5E803F70D;
        Fri, 25 Feb 2022 01:35:38 -0800 (PST)
Subject: Re: [PATCH V2 08/30] m68k/mm: Enable ARCH_HAS_VM_GET_PAGE_PROT
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>
References: <1645425519-9034-1-git-send-email-anshuman.khandual@arm.com>
 <1645425519-9034-9-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdUrA4u5BTRuqTSn++vXFNn0w=HRmp9ZD_8SNZ1wMUKwwQ@mail.gmail.com>
 <CAMuHMdXRO5dph1m21=V3bVyniVvKfhDLbMoEHQzwPgvSesXj6A@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <d417c0e7-8a47-4f40-6eb1-161797d16cef@arm.com>
Date:   Fri, 25 Feb 2022 15:05:36 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXRO5dph1m21=V3bVyniVvKfhDLbMoEHQzwPgvSesXj6A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 2/25/22 2:32 PM, Geert Uytterhoeven wrote:
> Hi Anshuman, Andrew,
> 
> On Mon, Feb 21, 2022 at 12:54 PM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Mon, Feb 21, 2022 at 9:45 AM Anshuman Khandual
>> <anshuman.khandual@arm.com> wrote:
>>> This defines and exports a platform specific custom vm_get_page_prot() via
>>> subscribing ARCH_HAS_VM_GET_PAGE_PROT. Subsequently all __SXXX and __PXXX
>>> macros can be dropped which are no longer needed.
>>>
>>> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>>> Cc: linux-m68k@lists.linux-m68k.org
>>> Cc: linux-kernel@vger.kernel.org
>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>
>> Thanks for your patch!
>>
>>> --- a/arch/m68k/mm/init.c
>>> +++ b/arch/m68k/mm/init.c
>>> @@ -128,3 +128,107 @@ void __init mem_init(void)
>>>         memblock_free_all();
>>>         init_pointer_tables();
>>>  }
>>> +
>>> +#ifdef CONFIG_COLDFIRE
>>> +/*
>>> + * Page protections for initialising protection_map. See mm/mmap.c
>>> + * for use. In general, the bit positions are xwr, and P-items are
>>> + * private, the S-items are shared.
>>> + */
>>> +pgprot_t vm_get_page_prot(unsigned long vm_flags)
>>
>> Wouldn't it make more sense to add this to arch/m68k/mm/mcfmmu.c?
> 
> It's not just about sense, but also about correctness.
> The CF_PAGE_* definitions below exist only if CONFIG_MMU=y,
> thus causing breakage for cfnommu in today's linux-next.
> http://kisskb.ellerman.id.au/kisskb/buildresult/14701640/

As mentioned before, will do all these necessary changes in the next
version probably sometime earlier next week. I was waiting for other
reviews (if any) till now.
