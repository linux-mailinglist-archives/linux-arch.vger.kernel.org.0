Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53685679E9D
	for <lists+linux-arch@lfdr.de>; Tue, 24 Jan 2023 17:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjAXQ1f (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 24 Jan 2023 11:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjAXQ1e (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 24 Jan 2023 11:27:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F7030C8
        for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2023 08:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674577608;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i7Pw8HLyonCZeA68egrmyo7nTJgPIzxf4MWuoam80Xs=;
        b=Ft4y85zMq2WhjpISQQYHr3FkOgjqBXSoX+O0ExdeDbBjV1k4tg6VU1Doj7E/xYlptJvoO3
        yPgHE4pXXomlPTCvVHW2RV+0rgeRMCkG+QuQuluXpnrcBammWSuxjkw66dpqoWAaD+nOtD
        7cvOkjzg04LTorkn4lunz7m1dFthmqY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-277-8CRAldgINz2zq-Ms1xrFcw-1; Tue, 24 Jan 2023 11:26:47 -0500
X-MC-Unique: 8CRAldgINz2zq-Ms1xrFcw-1
Received: by mail-wr1-f72.google.com with SMTP id i28-20020adfa51c000000b002ba26dfcd08so2732300wrb.18
        for <linux-arch@vger.kernel.org>; Tue, 24 Jan 2023 08:26:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i7Pw8HLyonCZeA68egrmyo7nTJgPIzxf4MWuoam80Xs=;
        b=7eoZWpV54tmSTILtYw46kf8snQUlf0KyUjR8/yEBgW+B0f3VgJPAC/Ge7f33rf6Na3
         cBFX1pBfAU4k4zFB985vevgCj2KAk+ciRGkumdM2gDBXVllA5fpn5HqujjaG80c3zH0d
         ptWtdb33lxNKsYt/GFjKhR+GDO87/9p4UG5Ts9ZBn1+ovVzPwF8B899Ume+dkSh4zAt8
         28zGNF9/r8o5iq7e8E7NPr329m6T/QicPxHcESjBjkW7dNotorEGpHNuXml/JcZeSreF
         +n/7rknLWcrXRz61FShesKjEXqOY9SkdO2WtbY2+8+jYPuScb6bukfqKyyw3y5yzp/9A
         /xoA==
X-Gm-Message-State: AFqh2kopNCxBSgZABvYHsoYooD8Rl37gyp9piy1P++Taoy9+W2p1LG0V
        FeHRM8rpL06I3/FZpSkJ8MNmgxelWODG8kgRPlJuNkEh4V2MqQhqBB9ywYSXryQINClooodYFfw
        AtliYY3+0NvBc1WMDWfNDxQ==
X-Received: by 2002:a05:6000:10c6:b0:2bd:e33e:c04b with SMTP id b6-20020a05600010c600b002bde33ec04bmr23891384wrx.22.1674577606153;
        Tue, 24 Jan 2023 08:26:46 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtQ9TD2bnXMPy82nhP127kncrzx3y56M6S5Ht8LsvTwDvmKsGRFx5R/aF94Ts9iBIA/bwn/sg==
X-Received: by 2002:a05:6000:10c6:b0:2bd:e33e:c04b with SMTP id b6-20020a05600010c600b002bde33ec04bmr23891359wrx.22.1674577605843;
        Tue, 24 Jan 2023 08:26:45 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:9d00:9303:90ce:6dcb:2bc9? (p200300cbc7079d00930390ce6dcb2bc9.dip0.t-ipconnect.de. [2003:cb:c707:9d00:9303:90ce:6dcb:2bc9])
        by smtp.gmail.com with ESMTPSA id t16-20020a5d49d0000000b002bfb0c5527esm1691618wrs.109.2023.01.24.08.26.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:26:45 -0800 (PST)
Message-ID: <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
Date:   Tue, 24 Jan 2023 17:26:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
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
References: <20230119212317.8324-1-rick.p.edgecombe@intel.com>
 <20230119212317.8324-24-rick.p.edgecombe@intel.com>
 <aa973c0f-5d90-36df-01b2-db9d9182910e@redhat.com>
 <87fsc1il73.fsf@oldenburg.str.redhat.com>
 <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <c6dc94eb193634fa27e1715ab2978a3ce4b6c544.camel@intel.com>
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

On 23.01.23 21:46, Edgecombe, Rick P wrote:
> On Mon, 2023-01-23 at 11:45 +0100, Florian Weimer wrote:
>> * David Hildenbrand:
>>
>>> On 19.01.23 22:23, Rick Edgecombe wrote:
>>>> The x86 Control-flow Enforcement Technology (CET) feature
>>>> includes a new
>>>> type of memory called shadow stack. This shadow stack memory has
>>>> some
>>>> unusual properties, which requires some core mm changes to
>>>> function
>>>> properly.
>>>> Shadow stack memory is writable only in very specific, controlled
>>>> ways.
>>>> However, since it is writable, the kernel treats it as such. As a
>>>> result
>>>> there remain many ways for userspace to trigger the kernel to
>>>> write to
>>>> shadow stack's via get_user_pages(, FOLL_WRITE) operations. To
>>>> make this a
>>>> little less exposed, block writable GUPs for shadow stack VMAs.
>>>> Still allow FOLL_FORCE to write through shadow stack protections,
>>>> as
>>>> it
>>>> does for read-only protections.
>>>
>>> So an app can simply modify the shadow stack itself by writing to
>>> /proc/self/mem ?
>>>
>>> Is that really intended? Looks like security hole to me at first
>>> sight, but maybe I am missing something important.
>>
>> Isn't it possible to overwrite GOT pointers using the same vector?
>> So I think it's merely reflecting the status quo.
> 
> There was some debate on this. /proc/self/mem can currently write
> through read-only memory which protects executable code. So should
> shadow stack get separate rules? Is ROP a worry when you can overwrite
> executable code?
> 

The question is, if there is reasonable debugging reason to keep it. I 
assume if a debugger would adjust the ordinary stack, it would have to 
adjust the shadow stack as well (oh my ...). So it sounds reasonable to 
have it in theory at least ... not sure when debugger would support 
that, but maybe they already do.

> The consensus seemed to lean towards not making special rules for this
> case, and there was some discussion that /proc/self/mem should maybe be
> hardened generally.

I agree with that. It's a debugging mechanism that a process can abuse 
to do nasty stuff to its memory that it maybe shouldn't be able to do ...

-- 
Thanks,

David / dhildenb

