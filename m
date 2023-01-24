Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5B679E93
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 17:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233709AbjAXQZU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 11:25:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233453AbjAXQZU (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 11:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A53814B8B0
        for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2023 08:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674577448;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bX9IT7xjfbuY2NTWDjty1xoUFXXw0P63GK85NclMpJ4=;
        b=iz3bv4v6WrgEffwcLDCXBf81T/N5RYMTVFWRzls2qJdGPuv6nAxmXG/j3G25UBVy8N/PMJ
        Ka2DHUtal6IBiY+XnALR/2PdwJPNuagndy6g+nLmdmYK8qvfyoi6VIsAfRJOlSg/1EP+XC
        KpLXY1pgzwmUTln+t+xvRm2ZLLSoG6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-574-gJUWGeAUPeWPjzA7O2EYKw-1; Tue, 24 Jan 2023 11:24:07 -0500
X-MC-Unique: gJUWGeAUPeWPjzA7O2EYKw-1
Received: by mail-wr1-f72.google.com with SMTP id k11-20020adfe3cb000000b002be503e7f28so2432292wrm.2
        for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2023 08:24:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bX9IT7xjfbuY2NTWDjty1xoUFXXw0P63GK85NclMpJ4=;
        b=KNG1+oIMhkHfECwSext1RQrCeJ0QCyHa6lR/I8Pw+uGhsDwUD9LpD1lodGgTh4VB/g
         A6aC33LYJPTvkYOTYZXLwdcQ9cjh5vbxVh4Z82uVd9GDkTmcCm0hftN1qF5fsl2IJNrV
         Y0nR7WmNpUq4laNSTZ1v5u6t9GpHcfiMk6CY6VLrcJTp4rwvlfjEKM7kltNmL+M2Txjv
         Fou5sQ8v+H9jFRL2GoY1rWeWviZls3xsE2InSe+N/E2oNJ6G56aguiCSZ3X1DkkIDW4I
         PZTTwal4rtOA0/kADQPRZTOy5b++yoX+sKyoL1FnCD8NozAJ7AU/bKu/s0YH63GiiHg/
         +QEQ==
X-Gm-Message-State: AFqh2kqPj13N2dPsqgI4IZC3ABTUUFxmrS8f4jpKxRiR0hhAt1JsPfUs
        n6m0v4O0X3wEYzCFFfFAnpb7WRc9wzhaJfSbNl3Dl77XlTzQBZ2C4ZouvT11208U9gRJk72UIb1
        dwIe+BL9KwubBCnnsITz8DA==
X-Received: by 2002:a7b:cbcb:0:b0:3db:2ad:e330 with SMTP id n11-20020a7bcbcb000000b003db02ade330mr28272715wmi.5.1674577445827;
        Tue, 24 Jan 2023 08:24:05 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvVa2+1egZlhr/xt2amqGJknvYkEtFYGQNyqzp/aYD39jd9aby4xdRXSty3HU8zkUSOb5cmTg==
X-Received: by 2002:a7b:cbcb:0:b0:3db:2ad:e330 with SMTP id n11-20020a7bcbcb000000b003db02ade330mr28272696wmi.5.1674577445575;
        Tue, 24 Jan 2023 08:24:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id l36-20020a05600c08a400b003da28dfdedcsm2868528wmp.5.2023.01.24.08.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:24:05 -0800 (PST)
Message-ID: <1327c608-1473-af4f-d962-c24f04f3952c@redhat.com>
Date:   Tue, 24 Jan 2023 17:24:02 +0100
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
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
Cc:     "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-19-rick.p.edgecombe@intel.com>
 <7f63d13d-7940-afb6-8b25-26fdf3804e00@redhat.com>
 <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
In-Reply-To: <50cf64932507ba60639eca28692e7df285bcc0a7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23.01.23 21:47, Edgecombe, Rick P wrote:
> On Mon, 2023-01-23 at 10:50 +0100, David Hildenbrand wrote:
>> On 19.01.23 22:22, Rick Edgecombe wrote:
>>> The x86 Control-flow Enforcement Technology (CET) feature includes
>>> a new
>>> type of memory called shadow stack. This shadow stack memory has
>>> some
>>> unusual properties, which requires some core mm changes to function
>>> properly.
>>>
>>> Since shadow stack memory can be changed from userspace, is both
>>> VM_SHADOW_STACK and VM_WRITE. But it should not be made
>>> conventionally
>>> writable (i.e. pte_mkwrite()). So some code that calls
>>> pte_mkwrite() needs
>>> to be adjusted.
>>>
>>> One such case is when memory is made writable without an actual
>>> write
>>> fault. This happens in some mprotect operations, and also prot_numa
>>> faults.
>>> In both cases code checks whether it should be made
>>> (conventionally)
>>> writable by calling vma_wants_manual_pte_write_upgrade().
>>>
>>> One way to fix this would be have code actually check if memory is
>>> also
>>> VM_SHADOW_STACK and in that case call pte_mkwrite_shstk(). But
>>> since
>>> most memory won't be shadow stack, just have simpler logic and skip
>>> this
>>> optimization by changing vma_wants_manual_pte_write_upgrade() to
>>> not
>>> return true for VM_SHADOW_STACK_MEMORY. This will simply handle all
>>> cases of this type.
>>>
>>> Cc: David Hildenbrand <david@redhat.com>
>>> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
>>> Tested-by: John Allen <john.allen@amd.com>
>>> Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
>>> ---
>>
>> Instead of having these x86-shadow stack details all over the MM
>> space,
>> was the option explored to handle this more in arch specific code?
>>
>> IIUC, one way to get it working would be
>>
>> 1) Have a SW "shadowstack" PTE flag.
>> 2) Have an "SW-dirty" PTE flag, to store "dirty=1" when "write=0".
> 
> I don't think that idea came up. So vma->vm_page_prot would have the SW
> shadow stack flag for VM_SHADOW_STACK, and pte_mkwrite() could do
> Write=0,Dirty=1 part. It seems like it should work.
> 

Right, if we include it in vma->vm_page_prot, we'd immediately let 
mk_pte() just handle that.

Otherwise, we'd have to refactor e.g., mk_pte() to consume a vma instead 
of the vma->vm_page_prot. Let's see if we can avoid that for now.

>>
>> pte_mkwrite(), pte_write(), pte_dirty ... can then make decisions
>> based
>> on the "shadowstack" PTE flag and hide all these details from core-
>> mm.
>>
>> When mapping a shadowstack page (new page, migration, swapin, ...),
>> which can be obtained by looking at the VMA flags, the first thing
>> you'd
>> do is set the "shadowstack" PTE flag.
> 
> I guess the downside is that it uses an extra software bit. But the
> other positive is that it's less error prone, so that someone writing
> core-mm code won't introduce a change that makes shadow stack VMAs
> Write=1 if they don't know to also check for VM_SHADOW_STACK.

Right. And I think this mimics the what I would have expected HW to 
provide: a dedicated HW bit, not somehow mangling this into semantics of 
existing bits.

Roughly speaking: if we abstract it that way and get all of the "how to 
set it writable now?" out of core-MM, it not only is cleaner and less 
error prone, it might even allow other architectures that implement 
something comparable (e.g., using a dedicated HW bit) to actually reuse 
some of that work. Otherwise most of that "shstk" is really just x86 
specific ...

I guess the only cases we have to special case would be page pinning 
code where pte_write() would indicate that the PTE is writable (well, it 
is, just not by "ordinary CPU instruction" context directly): but you do 
that already, so ... :)

Sorry for stumbling over that this late, I only started looking into 
this when you CCed me on that one patch.

-- 
Thanks,

David / dhildenb

