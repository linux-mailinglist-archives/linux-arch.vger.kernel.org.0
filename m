Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1819A686D96
	for <lists+linux-arch@lfdr.de>; Wed,  1 Feb 2023 19:04:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231676AbjBASEp (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 1 Feb 2023 13:04:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbjBASEm (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 1 Feb 2023 13:04:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D04B4DCDC
        for <linux-arch@vger.kernel.org>; Wed,  1 Feb 2023 10:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675274635;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NHqnRVrVGsH0s7BP5ODEjlWZFmtlmfotNCTTEzO/Y1o=;
        b=ENuUVF4mS0NSpc3hVEh3S49wQw470fIlulGXpRgPygv++IRQvkrPT3UG8MSu0XL9JGP4GU
        LTm+57ajtLxlrXUeBAOF+tP6Bn+eXz284FBEPbhCpbDS98n4rDWu7JJs8xTb8viUbpCtWC
        fEzet9VYkrxNTRG9MHksLtjyfUBw0W4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-182-XPj8zboPMqyIjMOEZb0EjQ-1; Wed, 01 Feb 2023 13:03:53 -0500
X-MC-Unique: XPj8zboPMqyIjMOEZb0EjQ-1
Received: by mail-wm1-f72.google.com with SMTP id k9-20020a05600c1c8900b003dc5dec2ac6so1487242wms.4
        for <linux-arch@vger.kernel.org>; Wed, 01 Feb 2023 10:03:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NHqnRVrVGsH0s7BP5ODEjlWZFmtlmfotNCTTEzO/Y1o=;
        b=yo0AB+WFufPPHuQKBDJ9+0qMaZs1ep/OiEhAz4A4SEe4U3vh0usAwrlKeAfd3eKcd9
         mm4QYUrwXB7GHc2D0lzUCd1Ci2jhdRsrPhmroZfzBG+PY7Q97Ccc3WPpS6yZyupt2ham
         KIRi/MPzs964FMTRmOFDODw8k9NxouE+JEwPXxSB5JA4IDtp2Qe2jTNyBg5BQB+cioYT
         9p6ylxS4hUuRquXBpK0IvENq0EXmNHE0TWklJrIKj/l0bmgjYrUB2UtS/zKeDsBtaZGa
         BVGBYivtMqBWzk3p6tEZHT4TGRRMJwBBXFLWk5NynbwfVrDuhIXn+DXKBvsm1H9BqajG
         H25Q==
X-Gm-Message-State: AO0yUKUlsgxnq2PJkPYPkHaAP5ZdMAySBKH/IG+8Zo4HqXaRFI48j7jQ
        hudQNS04Y1D3hMm6vqoIaf2AKdsD1DzUVjfZXGqQ3wKQnPCwDY7JdOBcwfIvaixyek3saSaqqoy
        alUcWGymGzBo1DJ1R6m71PA==
X-Received: by 2002:a05:600c:4e53:b0:3dc:5390:6499 with SMTP id e19-20020a05600c4e5300b003dc53906499mr2951541wmq.1.1675274632546;
        Wed, 01 Feb 2023 10:03:52 -0800 (PST)
X-Google-Smtp-Source: AK7set8RWgxHAxxme3PCml6Vw4YQkL/Vp0Q30f/GZD4RoMNh8TWXDsQ+OvBtB+e0X6QNaxXSFYW6iA==
X-Received: by 2002:a05:600c:4e53:b0:3dc:5390:6499 with SMTP id e19-20020a05600c4e5300b003dc53906499mr2951490wmq.1.1675274632249;
        Wed, 01 Feb 2023 10:03:52 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:3100:e20e:4ace:6f25:6a79? (p200300cbc7053100e20e4ace6f256a79.dip0.t-ipconnect.de. [2003:cb:c705:3100:e20e:4ace:6f25:6a79])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c544b000000b003dc4fd6e624sm2570630wmi.19.2023.02.01.10.03.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 10:03:51 -0800 (PST)
Message-ID: <fb8446af-fd87-5609-05bf-5064615c7918@redhat.com>
Date:   Wed, 1 Feb 2023 19:03:49 +0100
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
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
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
 <a4857ccd-1d5f-2169-40bc-e7a75a0c896f@redhat.com>
 <f55d9563c432db15f8a768381103abe8e986a42b.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <f55d9563c432db15f8a768381103abe8e986a42b.camel@intel.com>
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

On 01.02.23 18:32, Edgecombe, Rick P wrote:
> On Wed, 2023-02-01 at 10:03 +0100, David Hildenbrand wrote:
>>>
>>> The other problem is that one of NULL passers is not for kernel
>>> memory.
>>> huge_pte_mkwrite() calls pte_mkwrite(). Shadow stack memory can't
>>> be
>>> created with MAP_HUGETLB, so it is not needed. Using
>>> pte_mkwrite_kernel() would look weird in this case, but making
>>> huge_pte_mkwrite() take a VMA would be for no reason. Maybe making
>>> huge_pte_mkwrite() take a VMA is the better of those two options.
>>> Or
>>> keep the NULL semantics...  Any thoughts?
>>
>> Well, the reason would be consistency. From a core-mm point of view
>> it
>> makes sense to handle this all consistency, even if the single user
>> (x86) wouldn't strictly require it right now.
>>
>> I'd just pass in the VMA and call it a day :)
> 
> Ok, I'll give it a spin.

It would be good to get more opinions on that, but I'm afraid we won't 
get more deep down in this thread :)

-- 
Thanks,

David / dhildenb

