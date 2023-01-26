Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C3267C66F
	for <lists+linux-arch@lfdr.de>; Thu, 26 Jan 2023 09:58:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbjAZI6V (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 26 Jan 2023 03:58:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236347AbjAZI6U (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 26 Jan 2023 03:58:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A4083EE
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 00:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674723452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tQ5XpzdLsChe3LFjvdvQNZo+jEFVqgRJCqtyNbGXTwY=;
        b=U5UT2Un4CeFA1FoNejJ8pnP6AUkbiDMMe16YmYK77uFeevmlq3ZWrUbnUfUEkU2GhNJzbf
        9X3HZV5GrbB6yfEn45EBx7m2yFhiuopwbaPLmwSzEkESkPLFUatodf34/jgLdWx/PyNlM8
        g1oBH37NOQ0qkkBWRiBY1WDvZjbdINc=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-75-y0ibgkiXPJmJ71riTUI3hw-1; Thu, 26 Jan 2023 03:57:31 -0500
X-MC-Unique: y0ibgkiXPJmJ71riTUI3hw-1
Received: by mail-wm1-f71.google.com with SMTP id 9-20020a05600c228900b003daf72fc827so711300wmf.9
        for <linux-arch@vger.kernel.org>; Thu, 26 Jan 2023 00:57:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tQ5XpzdLsChe3LFjvdvQNZo+jEFVqgRJCqtyNbGXTwY=;
        b=3o3FRZczGQeLhPcNqGjqde/AHz+i/3BBCpAr4XGCTz7bXJsWX+pB9G/LctDakTbtXR
         PoIWvITqKBjQl7C5Li7h/DBG6dcJxVIhbDd2X6wNzxSSMV1q7kjum96ayoT6YPRyMour
         2q/qFz5UD5+jXcKmDfKvaoKm/rejqnwApWZzi61C7qGJd8h5qC9c5UbcYUjjbWP7cLFU
         TX0NLy4x2i05AUqrsMSje5Jlyh+zhyl3rvheB637wrvn4Ng9R2gbuByt65+nusmO3b8d
         ehZ1nSPjWGBcD69z23MhoxWF4Nrhr0d9rl2q8R7S7YfhLvZtIYZqusXvkutiNSza3A+Q
         jTzw==
X-Gm-Message-State: AFqh2koMtKMvzTH5VAOkStFceY2JhQsGUb9mdmLjRPs0yTd6DAD7k4gx
        JyWxh3cOJaRuA5e1Gy37WINr9M6HyKU3gV/TYxyIQ6uZcxnooGL3AMSQEJA+sHdbZFROVLyoVzO
        vPDQbDcgbjCN/zPeNol+a/A==
X-Received: by 2002:a05:6000:549:b0:2be:184a:5d5c with SMTP id b9-20020a056000054900b002be184a5d5cmr26794280wrf.59.1674723450377;
        Thu, 26 Jan 2023 00:57:30 -0800 (PST)
X-Google-Smtp-Source: AMrXdXurqrEs2CtvJH0g9Njs93dDFdHIy3kXW9E9qnzN9h2evMNKxU2yos9hVfmcwU773eh+jNEA6g==
X-Received: by 2002:a05:6000:549:b0:2be:184a:5d5c with SMTP id b9-20020a056000054900b002be184a5d5cmr26794251wrf.59.1674723449956;
        Thu, 26 Jan 2023 00:57:29 -0800 (PST)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7? ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
        by smtp.gmail.com with ESMTPSA id p6-20020a5d48c6000000b002bfc0558ecdsm651607wrs.113.2023.01.26.00.57.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 00:57:29 -0800 (PST)
Message-ID: <79e0a85e-1ec4-e359-649d-618ca79c36f7@redhat.com>
Date:   Thu, 26 Jan 2023 09:57:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-19-rick.p.edgecombe@intel.com>
 <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
 <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
 <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
 <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
 <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
 <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
In-Reply-To: <dd06b54291ad5721da392a42f2d8e5636301ffef.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 25.01.23 19:43, Edgecombe, Rick P wrote:
> On Wed, 2023-01-25 at 10:27 +0100, David Hildenbrand wrote:
>>>> Roughly speaking: if we abstract it that way and get all of the
>>>> "how
>>>> to
>>>> set it writable now?" out of core-MM, it not only is cleaner and
>>>> less
>>>> error prone, it might even allow other architectures that
>>>> implement
>>>> something comparable (e.g., using a dedicated HW bit) to actually
>>>> reuse
>>>> some of that work. Otherwise most of that "shstk" is really just
>>>> x86
>>>> specific ...
>>>>
>>>> I guess the only cases we have to special case would be page
>>>> pinning
>>>> code where pte_write() would indicate that the PTE is writable
>>>> (well,
>>>> it
>>>> is, just not by "ordinary CPU instruction" context directly): but
>>>> you
>>>> do
>>>> that already, so ... :)
>>>>
>>>> Sorry for stumbling over that this late, I only started looking
>>>> into
>>>> this when you CCed me on that one patch.
>>>
>>> Sorry for not calling more attention to it earlier. Appreciate your
>>> comments.
>>>
>>> Previously versions of this series had changed some of these
>>> pte_mkwrite() calls to maybe_mkwrite(), which of course takes a
>>> vma.
>>> This way an x86 implementation could use the VM_SHADOW_STACK vma
>>> flag
>>> to decide between pte_mkwrite() and pte_mkwrite_shstk(). The
>>> feedback
>>> was that in some of these code paths "maybe" isn't really an
>>> option, it
>>> *needs* to make it writable. Even though the logic was the same,
>>> the
>>> name of the function made it look wrong.
>>>
>>> But another option could be to change pte_mkwrite() to take a vma.
>>> This
>>> would save using another software bit on x86, but instead requires
>>> a
>>> small change to each arch's pte_mkwrite().
>>
>> I played with that idea shortly as well, but discarded it. I was not
>> able to convince myself that it wouldn't be required to pass in the
>> VMA
>> as well for things like pte_dirty(), pte_mkdirty(), pte_write(), ...
>> which would end up fairly ugly (or even impossible in thing slike
>> GUP-fast).
>>
>> For example, I wonder how we'd be handling stuff like do_numa_page()
>> cleanly correctly, where we use pte_modify() + pte_mkwrite(), and
>> either
>> call might set the PTE writable and maintain dirty bit ...
> 
> pte_modify() is handled like this currently:
> 
> https://lore.kernel.org/lkml/20230119212317.8324-12-rick.p.edgecombe@intel.com/
> 
> There has been a couple iterations on that. The current solution is to
> do the Dirty->SavedDirty fixup if needed after the new prots are added.
> 
> Of course pte_modify() can't know whether you are are attempting to
> create a shadow stack PTE with the prot you are passing in. But the
> callers today explicitly call pte_mkwrite() after filling in the other
> bits with pte_modify().

See below on my MAP_PRIVATE vs. MAP_SHARED comment.

> Today this patch causes the pte_mkwrite() to be
> skipped and another fault may be required in the mprotect() and numa
> cases, but if we change pte_mkwrite() to take a VMA we can just make it
> shadow stack to start.
> 
> It might be worth mentioning, there was a suggestion in the past to try
> to have the shadow stack bits come out of vm_get_page_prot(), but MM
> code would then try to map the zero page as (shadow stack) writable
> when there was a normal (non-shadow stack) read access. So I had to
> abandon that approach and rely on explicit calls to pte_mkwrite/shstk()
> to make it shadow stack.

Thanks, do you have a pointer?

> 
>>
>> Having that said, maybe it could work with only a single saved-dirty
>> bit
>> and passing in the VMA for pte_mkwrite() only.
>>
>> pte_wrprotect() would detect "writable=0,dirty=1" and move the dirty
>> bit
>> to the soft-dirty bit instead, resulting in
>> "writable=0,dirty=0,saved-dirty=1",
>>
>> pte_dirty() would return dirty==1||saved-dirty==1.
>>
>> pte_mkdirty() would set either set dirty=1 or saved-dirty=1,
>> depending
>> on the writable bit.
>>
>> pte_mkclean() would clean both bits.
>>
>> pte_write() would detect "writable == 1 || (writable==0 && dirty==1)"
>>
>> pte_mkwrite() would act according to the VMA, and in addition, merge
>> the
>> saved-dirty bit into the dirty bit.
>>
>> pte_modify() and mk_pte() .... would require more thought ...
> 
> Not sure I'm following what the mk_pte() problem would be. You mean if
> Write=0,Dirty=1 is manually added to the prot?
> 
> Shouldn't people generally use the pte_mkwrite() helpers unless they
> are drawing from a prot that was already created with the helpers or
> vm_get_page_prot()?

pte_mkwrite() is mostly only used (except for writenotify ...) for 
MAP_PRIVATE memory ("COW-able"). For MAP_SHARED memory, 
vma->vm_page_prot in a VM_WRITE mapping already contains the write 
permissions. pte_mkwrite() is not necessary (again, unless writenotify 
is active).

I assume shstk VMAs don't apply to MAP_SHARED VMAs, which is why you 
didn't stumble over that issue yet? Because I don't see how it could 
work with MAP_SHARED VMAs.


The other thing I had in mind was that we have to make sure that we're 
not accidentally setting "Write=0,Dirty=1" in mk_pte() / pte_modify().

Assume we had a "Write=1,Dirty=1" PTE, and we effectively wrprotect 
using pte_modify(), we have to make sure to move the dirty bit to the 
saved_dirty bit.

> I think they can't manually create prot's from bits
> in core mm code, right? And x86 arch code already has to be aware of
> shadow stack. It's a bit of an assumption I guess, but I think maybe
> not too crazy of one?

I think that's true. Arch code is supposed to deal with that IIRC.

> 
>>
>>
>> Further, ptep_modify_prot_commit() might have to be adjusted to
>> properly
>> flush in all relevant cases IIRC.
> 
> Sorry, I'm not following. Can you elaborate? There is an adjustment
> made in pte_flags_need_flush().

Note that I did not fully review all bits of this patch set, just 
throwing out what was on my mind. If already handled, great.

> 
>>
>>>
>>> x86's pte_mkwrite() would then be pretty close to maybe_mkwrite(),
>>> but
>>> maybe it could additionally warn if the vma is not writable. It
>>> also
>>> seems more aligned with your changes to stop taking hints from PTE
>>> bits
>>> and just look at the VMA? (I'm thinking about the dropping of the
>>> dirty
>>> check in GUP and dropping pte_saved_write())
>>
>> The soft-shstk bit wouldn't be a hint, it would be logically
>> changing
>> the "type" of the PTE such that any other PTE functions can do the
>> right
>> thing without having to consume the VMA.
> 
> Yea, true.
> 
> Thanks for your comments and ideas here, I'll give the:
> pte_t pte_mkwrite(struct vm_area_struct *vma, pte_t pte)
> ...solution a try.

Good!

-- 
Thanks,

David / dhildenb

