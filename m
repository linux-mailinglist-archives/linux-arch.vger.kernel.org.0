Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEE9C4B4B52
	for <lists+linux-arch@lfdr.de>; Mon, 14 Feb 2022 11:41:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347569AbiBNKbQ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 14 Feb 2022 05:31:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348082AbiBNKaq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 14 Feb 2022 05:30:46 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 235309BF58;
        Mon, 14 Feb 2022 01:59:20 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C50BB1396;
        Mon, 14 Feb 2022 01:59:02 -0800 (PST)
Received: from [10.163.47.15] (unknown [10.163.47.15])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06C2E3F718;
        Mon, 14 Feb 2022 01:59:00 -0800 (PST)
Subject: Re: [PATCH 30/30] mm/mmap: Drop ARCH_HAS_VM_GET_PAGE_PROT
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arch@vger.kernel.org
References: <1644805853-21338-1-git-send-email-anshuman.khandual@arm.com>
 <1644805853-21338-31-git-send-email-anshuman.khandual@arm.com>
 <CAMuHMdVqeyFhzJHLvE+erA4dO+eqpqzx8hVUj9LDk0iPwR1ByQ@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <b9308a0f-2877-8ef7-dcb8-301b91195d28@arm.com>
Date:   Mon, 14 Feb 2022 15:29:01 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdVqeyFhzJHLvE+erA4dO+eqpqzx8hVUj9LDk0iPwR1ByQ@mail.gmail.com>
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



On 2/14/22 3:18 PM, Geert Uytterhoeven wrote:
> Hi Anshuman,
> 
> On Mon, Feb 14, 2022 at 7:54 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>> All platforms now define their own vm_get_page_prot() and also there is no
>> generic version left to fallback on. Hence drop ARCH_HAS_GET_PAGE_PROT.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Thanks for your patch!
> 
>> -       select ARCH_HAS_VM_GET_PAGE_PROT
> 
> So before, all architectures selected ARCH_HAS_VM_GET_PAGE_PROT...

Right. ARCH_HAS_VM_GET_PAGE_PROT construct is required until all platforms
define their own vm_get_page_prot(). But once defined, this can be dropped
off, as a generic MM fallback is no longer available otherwise.

> 
>> --- a/mm/mmap.c
>> +++ b/mm/mmap.c
>> @@ -81,7 +81,6 @@ static void unmap_region(struct mm_struct *mm,
>>                 struct vm_area_struct *vma, struct vm_area_struct *prev,
>>                 unsigned long start, unsigned long end);
>>
>> -#ifndef CONFIG_ARCH_HAS_VM_GET_PAGE_PROT
> 
> ... hence the block below was not included.
> 
>>  /* description of effects of mapping type and prot in current implementation.
>>   * this is due to the limited x86 page protection hardware.  The expected
>>   * behavior is in parens:
>> @@ -102,8 +101,6 @@ static void unmap_region(struct mm_struct *mm,
>>   *                                                             w: (no) no
>>   *                                                             x: (yes) yes
>>   */
>> -#endif /* CONFIG_ARCH_HAS_VM_GET_PAGE_PROT */
>> -
> 
> So shouldn't the whole block be removed instead?

You are right, will remove the entire comment block here.

> Do I need more coffee??
> 
>>  static pgprot_t vm_pgprot_modify(pgprot_t oldprot, unsigned long vm_flags)
>>  {
>>         return pgprot_modify(oldprot, vm_get_page_prot(vm_flags));
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
> 
