Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7A169F0EA
	for <lists+linux-arch@lfdr.de>; Wed, 22 Feb 2023 10:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjBVJGN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 22 Feb 2023 04:06:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231589AbjBVJGK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 22 Feb 2023 04:06:10 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 875C72CC73
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 01:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677056723;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LjUQ9O0HnvcxKh2XAsUTz7YC8LaZ/FmXdZBrCkpK+Q=;
        b=XR9b0fi9KvAiaDE5BTpc8TIOo/qeHDi/6bFhI2uNFW5uWGqpkfgvQAMrEKbV0W/KPpWkN3
        9IniZuquw6W2gHT+DX86O89ZNADBkd0SalosCPceq+edugj7/xobyiZfJQ2Sqvkvshwhdb
        RzzLiGVMmu8xLawJ6umYmi7w8Q02jEQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-586-tyqJIBfEOa687qVSM9tfmA-1; Wed, 22 Feb 2023 04:05:22 -0500
X-MC-Unique: tyqJIBfEOa687qVSM9tfmA-1
Received: by mail-wr1-f71.google.com with SMTP id c14-20020adffb0e000000b002bfda39265aso1641513wrr.13
        for <linux-arch@vger.kernel.org>; Wed, 22 Feb 2023 01:05:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9LjUQ9O0HnvcxKh2XAsUTz7YC8LaZ/FmXdZBrCkpK+Q=;
        b=EaNLE+ceNGaCjB36fWcSrYhCMwqgaTctnGAWlU6dTTDwwdiIkF4RAdnBPqmXeybVXF
         eWLK1/NM4gPWXb4KRuG0fhDXIPpo84UKLXOhleZurGW96pq3LDu3SXjpmEU6otyErEt9
         sfLm8fqqL0k1ydTtARPw8BWHK6QevfJO/9tOEPuQX07YyB7e9dRboEy7gxJHWnydUT+7
         PIH32szopz3SjU6P9fa3LUEI7jHkZ4TgJVL6osvqnIWiHRxXZmZP9KGlR2rn43pbXCsG
         gLluMpSupWrPLTbYeak/FEVs1EcTOv3ncz5elLpWB/IL/YSwUJcqd3DmhL2kpZPsuSW3
         fncw==
X-Gm-Message-State: AO0yUKXqGapgzvZ1Oxq0rvx6TPEQVaZwp33iIpnRsbVJ16rhgyYAytbY
        2nlNAMGEMSNrrmV8tffWjZrKjXxlUaEViANPnHo8HrmHmYuAGDLNOSl5B192xSMcBj2Y44tulLu
        lTTHcsZHA5DNdmliulDx5uQ==
X-Received: by 2002:a05:600c:80f:b0:3db:fc3:6de4 with SMTP id k15-20020a05600c080f00b003db0fc36de4mr5069721wmp.35.1677056721241;
        Wed, 22 Feb 2023 01:05:21 -0800 (PST)
X-Google-Smtp-Source: AK7set9SGBIryzMFukKmMVx5ow2JjCNOU/7I00r/woNcU3wsCpyUfsO529XXrVJjBQAVq81y0YSzRQ==
X-Received: by 2002:a05:600c:80f:b0:3db:fc3:6de4 with SMTP id k15-20020a05600c080f00b003db0fc36de4mr5069668wmp.35.1677056720798;
        Wed, 22 Feb 2023 01:05:20 -0800 (PST)
Received: from ?IPV6:2003:cb:c704:a100:95ad:6325:131:6b1d? (p200300cbc704a10095ad632501316b1d.dip0.t-ipconnect.de. [2003:cb:c704:a100:95ad:6325:131:6b1d])
        by smtp.gmail.com with ESMTPSA id c22-20020a7bc856000000b003e01493b136sm7194166wml.43.2023.02.22.01.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 01:05:20 -0800 (PST)
Message-ID: <52f001ef-a409-4f33-f28f-02e806ef305a@redhat.com>
Date:   Wed, 22 Feb 2023 10:05:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
To:     Dave Hansen <dave.hansen@intel.com>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
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
 <20230218211433.26859-15-rick.p.edgecombe@intel.com>
 <70681787-0d33-a9ed-7f2a-747be1490932@redhat.com>
 <6f19d7c7ad9f61fa8f6c9bd09d24524dbe17463f.camel@intel.com>
 <6e1201f5-da25-6040-8230-c84856221838@redhat.com>
 <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v6 14/41] x86/mm: Introduce _PAGE_SAVED_DIRTY
In-Reply-To: <273414f5-2a7c-3cc0-dc27-d07baaa5787b@intel.com>
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

On 21.02.23 21:13, Dave Hansen wrote:
> On 2/21/23 00:38, David Hildenbrand wrote:> Sure, for my taste this is
> (1) too repetitive (2) too verbose (3) to
>> specialized. But whatever x86 maintainers prefer.
> 
> At this point, I'm not going to be too nitpicky.  I personally think we
> need to get _something_ merged.  We can then nitpick it to death once
> its in the tree.

Yes, but ... do we have to rush right now?

This series wasn't in -next and we're in the merge window. Is the plan 
to still include it into this merge window?

Also, I think concise patch descriptions and comments are not 
necessarily nitpicking like "please rename that variable".

> 
> So I prefer whatever will move the set along. ;)

If the plan is to merge it in the next merge window (which I suspect, 
but I might be wrong), I suggest including it in -next fairly soonish, 
and in the meantime, polish the remaining bits.

Knowing the plan would be good ;)

-- 
Thanks,

David / dhildenb

