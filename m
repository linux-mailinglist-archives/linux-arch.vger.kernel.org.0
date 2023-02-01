Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C8E686250
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 10:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbjBAJE2 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 04:04:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230282AbjBAJE1 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 04:04:27 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40EA301AC
        for <linux-arch@vger.kernel.org>; Wed,  1 Feb 2023 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675242227;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a8vyRUGLmPZw1cx7uiPTXStMX6sS7pJs7SRmtCoOPQ0=;
        b=Lu0QIVDo5qsP/nuVjpMPt/krULE24S0OroVcm69Eo5hwxB9pQDLLXlOI5IAxUFN1TXWhw4
        7b3Pik5hfqucQOzr8+q+odo3oJuXs2D5becMXAkE4ekWV2qR8Uny2bdYTXRBTOTdtkLPrL
        X6gb8yW3bfQPWweD1zs7/WOYJCKcEhg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-397-fKx8ILZeN9Cj7hqdK0Yvfw-1; Wed, 01 Feb 2023 04:03:43 -0500
X-MC-Unique: fKx8ILZeN9Cj7hqdK0Yvfw-1
Received: by mail-wm1-f70.google.com with SMTP id l5-20020a1ced05000000b003db300f2e1cso694240wmh.0
        for <linux-arch@vger.kernel.org>; Wed, 01 Feb 2023 01:03:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a8vyRUGLmPZw1cx7uiPTXStMX6sS7pJs7SRmtCoOPQ0=;
        b=AmBbG0necai3TGc0V9bzwJepb8T+e4PDM8SbrS8MTNbnrb3/rdcBFchNDdcp+MgCfs
         SrTHvk79E8KrqY3YijVhhQLAYRBLwjHSkLnS2jue9rEYism6ZNQ/A6uRKGgf1fb+pL7S
         vd2WmQbRyFLHXw6fU+ialkpIasy2XIAEBXRCHQUXJSlMzEAJoELcXBRBSh7PiYURQGVV
         StsP9PT0Koy19tYU1Aq92MPn8uqK43b37sFz6UdEVdvABuIib9z774AT4bsWz1ZqExXV
         J3QiNZAa/uMGmrG4a+kVWAowrtYL1G7pfoiGNqywreWqEUO0UIVpSwsuykE5N6J/6psI
         jx7g==
X-Gm-Message-State: AO0yUKVKaCG3hbl5SD75Rb8BMWJPyDFGB1W3NL+mrbKJgLxjG0BCBsNP
        aAoVLeF4/pv/DlWXKWAU1ejsmzRmwsMS4jNe/gvmYVfqfhWYoN1m9BVv2bglj7ZNN8ReWTSrQYN
        siw6bmtts0V8Mwwc8DpQgYA==
X-Received: by 2002:a05:600c:3b9d:b0:3d2:3be4:2d9a with SMTP id n29-20020a05600c3b9d00b003d23be42d9amr1322213wms.20.1675242222433;
        Wed, 01 Feb 2023 01:03:42 -0800 (PST)
X-Google-Smtp-Source: AK7set/gMluqZSQ5LKXrgZW/yePv93crC07VbTZ6hjsNCTASxrv++pCMxw86gG10oZFOIcmNhL6zeQ==
X-Received: by 2002:a05:600c:3b9d:b0:3d2:3be4:2d9a with SMTP id n29-20020a05600c3b9d00b003d23be42d9amr1322185wms.20.1675242222113;
        Wed, 01 Feb 2023 01:03:42 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:3100:e20e:4ace:6f25:6a79? (p200300cbc7053100e20e4ace6f256a79.dip0.t-ipconnect.de. [2003:cb:c705:3100:e20e:4ace:6f25:6a79])
        by smtp.gmail.com with ESMTPSA id p16-20020a05600c469000b003a84375d0d1sm1100168wmo.44.2023.02.01.01.03.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 01:03:41 -0800 (PST)
Message-ID: <a4857ccd-1d5f-2169-40bc-e7a75a0c896f@redhat.com>
Date:   Wed, 1 Feb 2023 10:03:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 18/39] mm: Handle faultless write upgrades for shstk
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
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
 <f4b62ed9-21a9-4b23-567e-51b339a643ac@redhat.com>
 <6a38779c1539c2bcfeb6bc8251ed04aa9b06802e.camel@intel.com>
 <0e29a2d0-08d8-bcd6-ff26-4bea0e4037b0@redhat.com>
 <f337d3b0e401c210b67a6465bf35f66f6a46fc3d.camel@intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f337d3b0e401c210b67a6465bf35f66f6a46fc3d.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 01.02.23 00:33, Edgecombe, Rick P wrote:
> On Tue, 2023-01-31 at 09:46 +0100, David Hildenbrand wrote:
>> Sure ...
>>
>> but I reconsidered :)
>>
>> Maybe there is a cleaner way to do it and avoid the "NULL" argument.
>>
>> What about having (while you're going over everything already):
>>
>> pte_mkwrite(pte, vma)
>> pte_mkwrite_kernel(pte)
>>
>> The latter would only be used in that arch code where we're working
>> on
>> kernel pgtables. We already have pte_offset_kernel() and
>> pte_alloc_kernel_track(), so it's not too weird.
> 
> Hmm, one downside is the "mk" part might lead people to guess
> pte_mkwrite_kernel() would make it writable AND a kernel page (like
> U/S=0 on x86). Instead of being a mkwrite() that's useful for setting
> on kernel PTEs.

At least I wouldn't worry about that too much. We handle nowhere in 
common code user vs. supervisor access that way explicitly (e.g., 
mkkernel), and it wouldn't even apply on architectures where we cannot 
make such a decision on a per-PTE basis.

> 
> The other problem is that one of NULL passers is not for kernel memory.
> huge_pte_mkwrite() calls pte_mkwrite(). Shadow stack memory can't be
> created with MAP_HUGETLB, so it is not needed. Using
> pte_mkwrite_kernel() would look weird in this case, but making
> huge_pte_mkwrite() take a VMA would be for no reason. Maybe making
> huge_pte_mkwrite() take a VMA is the better of those two options. Or
> keep the NULL semantics...  Any thoughts?

Well, the reason would be consistency. From a core-mm point of view it 
makes sense to handle this all consistency, even if the single user 
(x86) wouldn't strictly require it right now.

I'd just pass in the VMA and call it a day :)

-- 
Thanks,

David / dhildenb

