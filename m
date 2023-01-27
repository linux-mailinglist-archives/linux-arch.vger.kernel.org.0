Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F59E67EA84
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 17:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjA0QNU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 11:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbjA0QNR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 11:13:17 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73AF3E617
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 08:12:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674835952;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SwogfK/xLNDHbbwXO1sIym9vY9/jCFhsud5wbKcvQaU=;
        b=MvkDhpC60BEksuWrQlrG0YhuNwEfwWEQ4Ydn/2F3+tZb9mPK4FJghmtnfhsGbXuJfsOWgM
        hg1xZsNBJ8tnV1ZCYfFkhPYeAOKovrmysSYrr3FGaIUkH26ghpcwh6UuhF7He1BLTk8X1n
        RX/y0daxFpnfb8F4OUGWzyvlnGCObKc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-597-00SKtRSvM7W-i3RH4AwoYA-1; Fri, 27 Jan 2023 11:12:30 -0500
X-MC-Unique: 00SKtRSvM7W-i3RH4AwoYA-1
Received: by mail-wm1-f70.google.com with SMTP id o5-20020a05600c4fc500b003db0b3230efso4898675wmq.9
        for <linux-arch@vger.kernel.org>; Fri, 27 Jan 2023 08:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SwogfK/xLNDHbbwXO1sIym9vY9/jCFhsud5wbKcvQaU=;
        b=7dHpqEVD85DK8SWAe1OQiOTf6yLf0xRbFFh5z/CsphHqYCa5voRbdKysQJg2YjnpS8
         ZZVef9V9goB0lkRJvKXUJMCigXSGWnXGY+ofjgXHY3nnPpgnIYBoGLwNdFXI4Dkvi4fU
         bsebGq6da1C0LwCVIdOQOE8OYAIV2471NozhnhfCaak1myW3AIhCBQbsT/S31fQNM2wA
         xMNZ9U4L7dQ4jZQbZ1KTA+qG7747yxfl//tokYWq2NYRjauTgdsTrtBpN1y5xQbxyRCe
         QjEOeNtSfLXVq5wDI6nKNxFZRSKACRLIYWPA+GaGU2Ni/ZBj4SqaqrZfQ4hw4jow5vVI
         KNig==
X-Gm-Message-State: AO0yUKUpqLjMPmyg0aqv1YP07hLaKDSEVqs2xvmVTfkn0zcd2AWCSYQu
        DSK2v/ILSl2jThU3ADqVdfgVmuvbiyhfkOl6au9hATmyPw+1VAMk/J/+aRypPFfe4VgeWFQ8GvI
        HBXqB3jbVMWmA+P+Md1YiPw==
X-Received: by 2002:a05:6000:1f05:b0:2bf:bc38:17c1 with SMTP id bv5-20020a0560001f0500b002bfbc3817c1mr9332018wrb.4.1674835949251;
        Fri, 27 Jan 2023 08:12:29 -0800 (PST)
X-Google-Smtp-Source: AK7set9xHxRFMELkql7GhWmWFY9SeZNG8Y1DmSr6SFxhFl3Z+1haelg4X8dDIm2uqRediNz9/rRjDw==
X-Received: by 2002:a05:6000:1f05:b0:2bf:bc38:17c1 with SMTP id bv5-20020a0560001f0500b002bfbc3817c1mr9331981wrb.4.1674835948989;
        Fri, 27 Jan 2023 08:12:28 -0800 (PST)
Received: from ?IPV6:2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a? (p200300d82f161800a9b41776c5d91d9a.dip0.t-ipconnect.de. [2003:d8:2f16:1800:a9b4:1776:c5d9:1d9a])
        by smtp.gmail.com with ESMTPSA id e21-20020a5d5955000000b002b57bae7174sm4283915wri.5.2023.01.27.08.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 08:12:28 -0800 (PST)
Message-ID: <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
Date:   Fri, 27 Jan 2023 17:12:26 +0100
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
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
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
 <899d8f3baaf45b896cf335dec2143cd0969a2d8a.camel@intel.com>
 <ad7d94dd-f0aa-bf21-38c3-58ef1e9e46dc@redhat.com>
 <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <27b141c06c37da78afca7214ec7efeaf730162d9.camel@intel.com>
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

On 26.01.23 21:19, Edgecombe, Rick P wrote:
> On Thu, 2023-01-26 at 09:46 +0100, David Hildenbrand wrote:
>> On 26.01.23 01:59, Edgecombe, Rick P wrote:
>>> On Wed, 2023-01-25 at 10:43 -0800, Rick Edgecombe wrote:
>>>> Thanks for your comments and ideas here, I'll give the:
>>>> pte_t pte_mkwrite(struct vm_area_struct *vma, pte_t pte)
>>>> ...solution a try.
>>>
>>> Well, it turns out there are some pte_mkwrite() callers in other
>>> arch's
>>> that operate on kernel memory and don't have a VMA. So it needed a
>>> new
>>
>> Why not pass in NULL as VMA then and document the semantics? The
>> less
>> similarly named but slightly different functions, the better :)
> 
> Hmm. The x86 and generic versions should probably have the same
> semantics, so then if you pass a NULL, it would do a regular
> pte_mkwrite() I guess?
> 
> I see another benefit of requiring the vma argument, such that raw
> pte_mkwrite()s are less likely to appear in core MM code. But I think
> the NULL is awkward because it's not obvious, to me at least, what the
> implications of that should be.
> 
> So it will be confusing to read in the NULL cases for the other archs.
> We also have some warnings to catch miss cases in the PTE tear down
> code, so the scenario of new code accidentally marking shadow stack
> PTEs as writable is not totally unchecked.
> 
> The three functions that do slightly different things are:
> 
> pte_mkwrite():
> Makes a PTE conventionally writable, only takes a PTE. Very clear that
> it is a low level helper and what it does.
> 
> maybe_mkwrite():
> Might make a PTE writable if the VMA allows it.
> 
> pte_mkwrite_vma():
> Makes a PTE writable in a specific way depending on the VMA
> 
> I wonder if the name pte_mkwrite_vma() is maybe just not clear enough.
> It takes a VMA, yes, but what does it do with it?
> 
> What if it was called pte_mkwrite_type() instead? Some arch's have
> additional types of writable memory and this function creates them. Of
> course they also have the normal type of writable memory, and
> pte_mkwrite() creates that like usual. Doesn't it seem more readable?

The issue is, the more variants we provide the easier it is to make 
mistakes and introduce new buggy code.

It's tempting to simply use pte_mkwrite() and call it a day, where 
people actually should use pte_mkwrite_vma().

Then, they at least have to investigate what to do about the second VMA 
parameter.

-- 
Thanks,

David / dhildenb

