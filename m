Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3C869DC2A
	for <lists+linux-arch@lfdr.de>; Tue, 21 Feb 2023 09:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjBUIh1 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 21 Feb 2023 03:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjBUIh0 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 21 Feb 2023 03:37:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12739241EC
        for <linux-arch@vger.kernel.org>; Tue, 21 Feb 2023 00:36:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1676968481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s3hA7io5oEGOw3xKaHyd+KsM6je8a9BDLLtnwSNoTqc=;
        b=GtvOw71B/sdc67NR8XisOqariHMAhHWxiWTJVzcXx6qp4/JY0zNUrcyvZk61XCqoMDsGrI
        53Q4ibc3t4wq6DZufYV7T7Glcz0mWVIksbadTIX4EboTRbD5xhxgYdteENVsBxzqhwe7/0
        XZDRpRpDk3sISiwPyEKAw9JFnWOR0Eg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-203-FZAuUoi0Pn-kyVrmTALy6g-1; Tue, 21 Feb 2023 03:34:39 -0500
X-MC-Unique: FZAuUoi0Pn-kyVrmTALy6g-1
Received: by mail-wm1-f71.google.com with SMTP id z6-20020a05600c220600b003e222c9c5f4so1837324wml.4
        for <linux-arch@vger.kernel.org>; Tue, 21 Feb 2023 00:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s3hA7io5oEGOw3xKaHyd+KsM6je8a9BDLLtnwSNoTqc=;
        b=Vht9JdEnB4qc8lLWEzdLrBn5TRBHIvJq8oF9Rw7CPzCPnxr5MBFUGn0wOmBTYhkT47
         JJdBuHZwcgtnyygCGt4wdmpl48YSMjAxwf8oZTsWgGwCeYUamldyxg7dITzO+/6FjemE
         LRm3k3UKxfClGVnVj/fV54Tu28UoNvaPe69KgYZdgBDEsDk9N4Ja48WCoX7ALixPA/Ad
         a+/FGVHuqIxSdSLU3zh8MJbM/gf74OCk6tWrdVaYWc6PKhwOt8CthhtlYHFUUy/4dBlX
         +JS6w18WQ0e9yI3vRdovgfv7U9DEToWWyWoKeH9znu+16SqRveti6r1y2MJKtXp94Eju
         +vow==
X-Gm-Message-State: AO0yUKU7RfeSRGZnqcoFumAHsoQLHO0JrIk8D7D7J2q86SRIOALkezUs
        FFwGxQ2IOooxJnNZDbqI3VIOYaJOpbdx4uKqqB6bs6B67k4ZzptvHvcYfFuIqiNymlxaT9jq3Gw
        XIc1+RCk6Ybg5pPn1iQ+Mkg==
X-Received: by 2002:adf:f883:0:b0:2c7:3f9:7053 with SMTP id u3-20020adff883000000b002c703f97053mr1601023wrp.52.1676968478701;
        Tue, 21 Feb 2023 00:34:38 -0800 (PST)
X-Google-Smtp-Source: AK7set/VzopSRLbEFNZlfiqKhL0ooGf/sc8yqRhmWuymXLlPTJDz78LKcQjIJ00MRvJ21tbfpizkTg==
X-Received: by 2002:adf:f883:0:b0:2c7:3f9:7053 with SMTP id u3-20020adff883000000b002c703f97053mr1601006wrp.52.1676968478294;
        Tue, 21 Feb 2023 00:34:38 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:4800:aecc:dadb:40a8:ce81? (p200300cbc7074800aeccdadb40a8ce81.dip0.t-ipconnect.de. [2003:cb:c707:4800:aecc:dadb:40a8:ce81])
        by smtp.gmail.com with ESMTPSA id a15-20020adffb8f000000b002c3f03d8851sm3539769wrr.16.2023.02.21.00.34.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 00:34:37 -0800 (PST)
Message-ID: <ef855af5-6a77-55d4-6e54-1e83d2e112a0@redhat.com>
Date:   Tue, 21 Feb 2023 09:34:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v6 18/41] mm: Introduce VM_SHADOW_STACK for shadow stack
 memory
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
        "debug@rivosinc.com" <debug@rivosinc.com>,
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
References: <20230218211433.26859-1-rick.p.edgecombe@intel.com>
 <20230218211433.26859-19-rick.p.edgecombe@intel.com>
 <366c0af9-850f-24b1-3133-976fa92c51e2@redhat.com>
 <9e25a24f3783f3960e2c1e5e68a6c6fdf3d89442.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9e25a24f3783f3960e2c1e5e68a6c6fdf3d89442.camel@intel.com>
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

On 20.02.23 23:08, Edgecombe, Rick P wrote:
> On Mon, 2023-02-20 at 13:56 +0100, David Hildenbrand wrote:
>> On 18.02.23 22:14, Rick Edgecombe wrote:
>>> From: Yu-cheng Yu <yu-cheng.yu@intel.com>
>>>
>>> The x86 Control-flow Enforcement Technology (CET) feature includes
>>> a new
>>> type of memory called shadow stack. This shadow stack memory has
>>> some
>>> unusual properties, which requires some core mm changes to function
>>> properly.
>>>
>>> A shadow stack PTE must be read-only and have _PAGE_DIRTY set.
>>> However,
>>> read-only and Dirty PTEs also exist for copy-on-write (COW) pages.
>>> These
>>> two cases are handled differently for page faults. Introduce
>>> VM_SHADOW_STACK to track shadow stack VMAs.
>>
>> I suggest simplifying and abstracting that description.
>>
>> "New hardware extensions implement support for shadow stack memory,
>> such
>> as x86 Control-flow Enforcement Technology (CET). Let's add a new VM
>> flag to identify these areas, for example, to be used to properly
>> indicate shadow stack PTEs to the hardware."
> 
> Ah yea, that top blurb was added to all the non-x86 arch patches after
> some feedback from Andrew Morton. He had said basically (in some more
> colorful language) that the changelogs (at the time) were written
> assuming the reader knows what a shadow stack is.

Okay. It's a bit repetitive, though.

Ideally, we'd just explain it in the cover letter in detail and 
Andrews's script would include the cover letter in the first commit. 
IIRC, that's what usually happens.

> 
> So it might be worth keeping a little more info in the log?

Copying the same paragraph into each commit is IMHO a bit repetitive. 
But these are just my 2 cents.

[...]

>> Should we abstract this to CONFIG_ARCH_USER_SHADOW_STACK, seeing
>> that
>> other architectures might similarly need it?
> 
> There was an ARCH_HAS_SHADOW_STACK but it got removed following this
> discussion:
> 
> https://lore.kernel.org/lkml/d09e952d8ae696f687f0787dfeb7be7699c02913.camel@intel.com/
> 
> Now we have this new RFC for riscv as potentially a second
> implementation. But it is still very early, and I'm not sure anyone
> knows exactly what the similarities will be in a mature version. So I
> think it would be better to refactor in an ARCH_HAS_SHADOW_STACK later
> (and similar abstractions) once that series is more mature and we have
> an idea of what pieces will be shared. I don't have a problem in
> principle with an ARCH config, just don't think we should do it yet.

Okay, easy to factor out later.

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

