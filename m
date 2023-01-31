Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17757682780
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjAaIwE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 03:52:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjAaIvf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 03:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4634F874
        for <linux-arch@vger.kernel.org>; Tue, 31 Jan 2023 00:46:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675154794;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RT0be17qJU4YrT6BGLBw4plPJpfNOohspNBXSp02x6k=;
        b=Zb0txdNmkI6msqnIx8u2aYCjm6uPrPp3ULYqd5d8xkpUFdqB1odtxJEmAb27yr1pD7vOti
        ktF7k0FvtynPcvc55NSB80I/a01/25cuJ0IHTEWnt7Sd4MtZJU1Rrb+lDia1EI9M4bZJeE
        Ev6h6gNHhYkGiC38Wm37xAZCLU+VJW4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-645-uQaxoZZ7M5OMQ_0DaXSCBw-1; Tue, 31 Jan 2023 03:46:31 -0500
X-MC-Unique: uQaxoZZ7M5OMQ_0DaXSCBw-1
Received: by mail-wm1-f72.google.com with SMTP id h9-20020a1ccc09000000b003db1c488826so10941670wmb.3
        for <linux-arch@vger.kernel.org>; Tue, 31 Jan 2023 00:46:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RT0be17qJU4YrT6BGLBw4plPJpfNOohspNBXSp02x6k=;
        b=DJZJJ7AZLjLSKui6P+vbb2ftpWaIFmpOZGGhxBwTDP1JG0QeBhpTT41y8DkKyMyaCv
         KQAY5GtBo0CAuMLJg5297KSvFLHL+FtLLUR2iYphzgDRi7kvuOCX4Cuyu/3jTXpI2Q1u
         Vdp0ZDhoc68FdEtDDxUMRZlYRbj+MsCntOz7UoBOsbeKIj8waTvRuoxExSht+rQSpY10
         i+NvWyySYGOLNF1PYN/qFq8oZ8TXmbbv3bGxxVsVT4XFLTPfiM3j2AzMSh/n5ptwEojI
         XAYPJtqj6K8dJNR+0sN1JQkcX0YiGh+eqdSJe6q6Acl3+MqTTFFA+StEFYyqMbZW0x6I
         PEQg==
X-Gm-Message-State: AO0yUKWce9/7QsEgViW0v9angsdBpB0ipWVU4xYipwd5ozRp8x+qqZB6
        RQi1jJdzTb4Kfp4cdmm4njlSSYNhotj7yglCsBjl4L0gH2M5sICscxTuzZ9lApa0UqLcLw4VKXQ
        nsMuhpELaAD0zaxC58ixQVQ==
X-Received: by 2002:a05:600c:350a:b0:3dd:1c45:a36d with SMTP id h10-20020a05600c350a00b003dd1c45a36dmr2228067wmq.27.1675154790679;
        Tue, 31 Jan 2023 00:46:30 -0800 (PST)
X-Google-Smtp-Source: AK7set8QpCOBeSom0P3EMkkVT3iDxdmU57NVBunEGbit/G8Vzfu/HJ8buwXfm2TF7WWfzUVYQ1crOw==
X-Received: by 2002:a05:600c:350a:b0:3dd:1c45:a36d with SMTP id h10-20020a05600c350a00b003dd1c45a36dmr2228038wmq.27.1675154790214;
        Tue, 31 Jan 2023 00:46:30 -0800 (PST)
Received: from ?IPV6:2003:d8:2f0a:ca00:f74f:2017:1617:3ec3? (p200300d82f0aca00f74f201716173ec3.dip0.t-ipconnect.de. [2003:d8:2f0a:ca00:f74f:2017:1617:3ec3])
        by smtp.gmail.com with ESMTPSA id o16-20020a05600c379000b003dc49e0132asm9751166wmr.1.2023.01.31.00.46.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:46:29 -0800 (PST)
Message-ID: <0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com>
Date:   Tue, 31 Jan 2023 09:46:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
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
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
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
 <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
 <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
 <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
 <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
 <6a38779c1539c2bcfeb6bc8251ed04aa9b06802e.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <6a38779c1539c2bcfeb6bc8251ed04aa9b06802e.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 28.01.23 01:51, Edgecombe, Rick P wrote:
> On Fri, 2023-01-27 at 17:12 +0100, David Hildenbrand wrote:
>> On 26.01.23 21:19, Edgecombe, Rick P wrote:
>>> On Thu, 2023-01-26 at 09:46 +0100, David Hildenbrand wrote:
>>>> On 26.01.23 01:59, Edgecombe, Rick P wrote:
>>>>> On Wed, 2023-01-25 at 10:43 -0800, Rick Edgecombe wrote:
>>>>>> Thanks for your comments and ideas here, I'll give the:
>>>>>> pte_t pte_mkwrite(struct vm_area_struct *vma, pte_t pte)
>>>>>> ...solution a try.
>>>>>
>>>>> Well, it turns out there are some pte_mkwrite() callers in
>>>>> other
>>>>> arch's
>>>>> that operate on kernel memory and don't have a VMA. So it
>>>>> needed a
>>>>> new
>>>>
>>>> Why not pass in NULL as VMA then and document the semantics? The
>>>> less
>>>> similarly named but slightly different functions, the better :)
>>>
>>> Hmm. The x86 and generic versions should probably have the same
>>> semantics, so then if you pass a NULL, it would do a regular
>>> pte_mkwrite() I guess?
>>>
>>> I see another benefit of requiring the vma argument, such that raw
>>> pte_mkwrite()s are less likely to appear in core MM code. But I
>>> think
>>> the NULL is awkward because it's not obvious, to me at least, what
>>> the
>>> implications of that should be.
>>>
>>> So it will be confusing to read in the NULL cases for the other
>>> archs.
>>> We also have some warnings to catch miss cases in the PTE tear down
>>> code, so the scenario of new code accidentally marking shadow stack
>>> PTEs as writable is not totally unchecked.
>>>
>>> The three functions that do slightly different things are:
>>>
>>> pte_mkwrite():
>>> Makes a PTE conventionally writable, only takes a PTE. Very clear
>>> that
>>> it is a low level helper and what it does.
>>>
>>> maybe_mkwrite():
>>> Might make a PTE writable if the VMA allows it.
>>>
>>> pte_mkwrite_vma():
>>> Makes a PTE writable in a specific way depending on the VMA
>>>
>>> I wonder if the name pte_mkwrite_vma() is maybe just not clear
>>> enough.
>>> It takes a VMA, yes, but what does it do with it?
>>>
>>> What if it was called pte_mkwrite_type() instead? Some arch's have
>>> additional types of writable memory and this function creates them.
>>> Of
>>> course they also have the normal type of writable memory, and
>>> pte_mkwrite() creates that like usual. Doesn't it seem more
>>> readable?
>>
>> The issue is, the more variants we provide the easier it is to make
>> mistakes and introduce new buggy code.
>>
>> It's tempting to simply use pte_mkwrite() and call it a day, where
>> people actually should use pte_mkwrite_vma().
>>
>> Then, they at least have to investigate what to do about the second
>> VMA
>> parameter.
> 
> Ok, I'll give it a spin. So far it looks ok. The downside is the giant
> tree-wide pte_mkwrite() signature change, but once that is over with
> there are other advantages. Like getting rid of maybe_mkwrite()'s
> awareness of shadow stack so the logic is more centralized. Please let
> me know if you don't feel comfortable with a suggested-by credit tag.

Sure ...

but I reconsidered :)

Maybe there is a cleaner way to do it and avoid the "NULL" argument.

What about having (while you're going over everything already):

pte_mkwrite(pte, vma)
pte_mkwrite_kernel(pte)

The latter would only be used in that arch code where we're working on 
kernel pgtables. We already have pte_offset_kernel() and 
pte_alloc_kernel_track(), so it's not too weird.

-- 
Thanks,

David / dhildenb

