Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6167ADC9
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 10:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbjAYJ17 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 04:27:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbjAYJ16 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 04:27:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF66245F4C
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 01:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674638830;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gBtAUTCWfw4ajbScdY9ziQC/mtBYAVVDyx4SSrAQ6CM=;
        b=ZX0hSaSquxfbqBf42kDm1+kaMIfCZHzzWbh0yW+rLSMNJ+OTwEGNKBqD9RfvTtqvl9HWkc
        j2ik6pfeK0PR9+DMdc6GiKFiJRJ+E6XK94e3/lKGw2EwqYCK6i/naF3ZsnB+GXTGOS31Pq
        M0ACMhcaJVdPFnQsrkl2SWWEDKWven0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-625-NH49KMQUNWa7Tvk5hep3iA-1; Wed, 25 Jan 2023 04:27:08 -0500
X-MC-Unique: NH49KMQUNWa7Tvk5hep3iA-1
Received: by mail-wr1-f72.google.com with SMTP id y2-20020adfee02000000b002bfb44f286dso580016wrn.11
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 01:27:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gBtAUTCWfw4ajbScdY9ziQC/mtBYAVVDyx4SSrAQ6CM=;
        b=qU81YOrCBduP+siTdNiBouyobR6nmQ4F6b9g9pKzH8O0pspJ93yVhhvfd3e2N+sMFh
         SX+GX/5R6RZBC9zH9DLL6RYyjoWERnUMpUNjPAvmEyMQ9Ml+e2VNks/XQtYKO2xqbYdR
         VfgKEtNktLsMr0MwvJ3r1XV3eZ/sjwZAITaBimGSVuUoT0M69DXJMcIfdX1hNbiE/yHD
         QbxWM/c1HqgowIe9TCS9bI6sz25UOSQFy8Zo5QgqX8uTYE3P/a3+TlTkAUZNdY1m76jk
         lnXrjEu6WgGZBwJKQ8ZOO7NFrykJxRgBRC5uEp5RCyIB+MVX0zcoyJjEVOe8RlAoHemA
         Iuhw==
X-Gm-Message-State: AFqh2kopVxRQEwcq1s16+6/hyjbLUJEwsC5R7vnGtKEpZHZ94nO5uB6e
        eYRIsUjwOq47zFEKQtYLkFFI87+GHP/1Rkzy3kdCm9L1c/Bkiqgt4KFInPealLzQimEa1JkyJBb
        u0rEUGOLSn/KLIESGvK8jMA==
X-Received: by 2002:a05:600c:1d8e:b0:3d1:ebdf:d586 with SMTP id p14-20020a05600c1d8e00b003d1ebdfd586mr30109263wms.29.1674638827475;
        Wed, 25 Jan 2023 01:27:07 -0800 (PST)
X-Google-Smtp-Source: AMrXdXt3I5ugL1L1S0w6an2fdSANTczn3IPM30D9smTkSjnVGxpx9rTFmh3kLNk4pToJoqtfXEhpIg==
X-Received: by 2002:a05:600c:1d8e:b0:3d1:ebdf:d586 with SMTP id p14-20020a05600c1d8e00b003d1ebdfd586mr30109212wms.29.1674638827056;
        Wed, 25 Jan 2023 01:27:07 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4c00:486:38e2:8ff8:a135? (p200300cbc7054c00048638e28ff8a135.dip0.t-ipconnect.de. [2003:cb:c705:4c00:486:38e2:8ff8:a135])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c511100b003dc0d5b4fa6sm5924346wms.3.2023.01.25.01.27.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:27:06 -0800 (PST)
Message-ID: <4d224020-f26f-60a4-c7ab-721a024c7a6d@redhat.com>
Date:   Wed, 25 Jan 2023 10:27:04 +0100
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
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
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
In-Reply-To: <8c3820ae1448de4baffe7c476b4b5d9ba0a309ff.camel@intel.com>
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

On 24.01.23 19:14, Edgecombe, Rick P wrote:
> On Tue, 2023-01-24 at 17:24 +0100, David Hildenbrand wrote:
>> On 23.01.23 21:47, Edgecombe, Rick P wrote:
>>> On Mon, 2023-01-23 at 10:50 +0100, David Hildenbrand wrote:
>>>> On 19.01.23 22:22, Rick Edgecombe wrote:
>>>>> The x86 Control-flow Enforcement Technology (CET) feature
>>>>> includes
>>>>> a new
>>>>> type of memory called shadow stack. This shadow stack memory
>>>>> has
>>>>> some
>>>>> unusual properties, which requires some core mm changes to
>>>>> function
>>>>> properly.
>>>>>
>>>>> Since shadow stack memory can be changed from userspace, is
>>>>> both
>>>>> VM_SHADOW_STACK and VM_WRITE. But it should not be made
>>>>> conventionally
>>>>> writable (i.e. pte_mkwrite()). So some code that calls
>>>>> pte_mkwrite() needs
>>>>> to be adjusted.
>>>>>
>>>>> One such case is when memory is made writable without an actual
>>>>> write
>>>>> fault. This happens in some mprotect operations, and also
>>>>> prot_numa
>>>>> faults.
>>>>> In both cases code checks whether it should be made
>>>>> (conventionally)
>>>>> writable by calling vma_wants_manual_pte_write_upgrade().
>>>>>
>>>>> One way to fix this would be have code actually check if memory
>>>>> is
>>>>> also
>>>>> VM_SHADOW_STACK and in that case call pte_mkwrite_shstk(). But
>>>>> since
>>>>> most memory won't be shadow stack, just have simpler logic and
>>>>> skip
>>>>> this
>>>>> optimization by changing vma_wants_manual_pte_write_upgrade()
>>>>> to
>>>>> not
>>>>> return true for VM_SHADOW_STACK_MEMORY. This will simply handle
>>>>> all
>>>>> cases of this type.
>>>>>
>>>>> Cc: David Hildenbrand <david@redhat.com>
>>>>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>>>>> Tested-by: John Allen <john.allen@amd.com>
>>>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>>> Reviewed-by: Kirill A. Shutemov <
>>>>> kirill.shutemov@linux.intel.com>
>>>>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>>>> ---
>>>>
>>>> Instead of having these x86-shadow stack details all over the MM
>>>> space,
>>>> was the option explored to handle this more in arch specific
>>>> code?
>>>>
>>>> IIUC, one way to get it working would be
>>>>
>>>> 1) Have a SW "shadowstack" PTE flag.
>>>> 2) Have an "SW-dirty" PTE flag, to store "dirty=1" when
>>>> "write=0".
>>>
>>> I don't think that idea came up. So vma->vm_page_prot would have
>>> the SW
>>> shadow stack flag for VM_SHADOW_STACK, and pte_mkwrite() could do
>>> Write=0,Dirty=1 part. It seems like it should work.
>>>
>>
>> Right, if we include it in vma->vm_page_prot, we'd immediately let
>> mk_pte() just handle that.
>>
>> Otherwise, we'd have to refactor e.g., mk_pte() to consume a vma
>> instead
>> of the vma->vm_page_prot. Let's see if we can avoid that for now.
>>
>>>>
>>>> pte_mkwrite(), pte_write(), pte_dirty ... can then make decisions
>>>> based
>>>> on the "shadowstack" PTE flag and hide all these details from
>>>> core-
>>>> mm.
>>>>
>>>> When mapping a shadowstack page (new page, migration, swapin,
>>>> ...),
>>>> which can be obtained by looking at the VMA flags, the first
>>>> thing
>>>> you'd
>>>> do is set the "shadowstack" PTE flag.
>>>
>>> I guess the downside is that it uses an extra software bit. But the
>>> other positive is that it's less error prone, so that someone
>>> writing
>>> core-mm code won't introduce a change that makes shadow stack VMAs
>>> Write=1 if they don't know to also check for VM_SHADOW_STACK.
>>
>> Right. And I think this mimics the what I would have expected HW to
>> provide: a dedicated HW bit, not somehow mangling this into semantics
>> of
>> existing bits.
> 
> Yea.
> 
>>
>> Roughly speaking: if we abstract it that way and get all of the "how
>> to
>> set it writable now?" out of core-MM, it not only is cleaner and
>> less
>> error prone, it might even allow other architectures that implement
>> something comparable (e.g., using a dedicated HW bit) to actually
>> reuse
>> some of that work. Otherwise most of that "shstk" is really just x86
>> specific ...
>>
>> I guess the only cases we have to special case would be page pinning
>> code where pte_write() would indicate that the PTE is writable (well,
>> it
>> is, just not by "ordinary CPU instruction" context directly): but you
>> do
>> that already, so ... :)
>>
>> Sorry for stumbling over that this late, I only started looking into
>> this when you CCed me on that one patch.
> 
> Sorry for not calling more attention to it earlier. Appreciate your
> comments.
> 
> Previously versions of this series had changed some of these
> pte_mkwrite() calls to maybe_mkwrite(), which of course takes a vma.
> This way an x86 implementation could use the VM_SHADOW_STACK vma flag
> to decide between pte_mkwrite() and pte_mkwrite_shstk(). The feedback
> was that in some of these code paths "maybe" isn't really an option, it
> *needs* to make it writable. Even though the logic was the same, the
> name of the function made it look wrong.
> 
> But another option could be to change pte_mkwrite() to take a vma. This
> would save using another software bit on x86, but instead requires a
> small change to each arch's pte_mkwrite().

I played with that idea shortly as well, but discarded it. I was not 
able to convince myself that it wouldn't be required to pass in the VMA 
as well for things like pte_dirty(), pte_mkdirty(), pte_write(), ... 
which would end up fairly ugly (or even impossible in thing slike GUP-fast).

For example, I wonder how we'd be handling stuff like do_numa_page() 
cleanly correctly, where we use pte_modify() + pte_mkwrite(), and either 
call might set the PTE writable and maintain dirty bit ...

Having that said, maybe it could work with only a single saved-dirty bit 
and passing in the VMA for pte_mkwrite() only.

pte_wrprotect() would detect "writable=0,dirty=1" and move the dirty bit 
to the soft-dirty bit instead, resulting in 
"writable=0,dirty=0,saved-dirty=1",

pte_dirty() would return dirty==1||saved-dirty==1.

pte_mkdirty() would set either set dirty=1 or saved-dirty=1, depending 
on the writable bit.

pte_mkclean() would clean both bits.

pte_write() would detect "writable == 1 || (writable==0 && dirty==1)"

pte_mkwrite() would act according to the VMA, and in addition, merge the 
saved-dirty bit into the dirty bit.

pte_modify() and mk_pte() .... would require more thought ...


Further, ptep_modify_prot_commit() might have to be adjusted to properly 
flush in all relevant cases IIRC.

> 
> x86's pte_mkwrite() would then be pretty close to maybe_mkwrite(), but
> maybe it could additionally warn if the vma is not writable. It also
> seems more aligned with your changes to stop taking hints from PTE bits
> and just look at the VMA? (I'm thinking about the dropping of the dirty
> check in GUP and dropping pte_saved_write())

The soft-shstk bit wouldn't be a hint, it would be logically changing 
the "type" of the PTE such that any other PTE functions can do the right 
thing without having to consume the VMA.


-- 
Thanks,

David / dhildenb

