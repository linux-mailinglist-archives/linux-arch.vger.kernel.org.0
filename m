Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4289567ADDD
	for <lists+linux-arch@lfdr.de>; Wed, 25 Jan 2023 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbjAYJaX (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 25 Jan 2023 04:30:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233965AbjAYJaS (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 25 Jan 2023 04:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F11448F
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 01:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674638975;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TjE3MFK73jMeqX5iFxpax2sxTvtsTUXIevN9S/ssTM8=;
        b=GxcZ9WaXjRHC1KhxiZrbJ1B42qtElt9hMu/7b6mP832hvgL+EsABKu0935kzPwpIyujXyo
        wP1JRVloqHqWmEdo+RLO+t45Y2BgpeVXcLHUx6kuO6mB9L+KwyfxdRTSS1sygDP4OoYLgM
        ZPkHFYsu6KursgAZDkOfVEY6B/ppi0E=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-627-3Ui6bLHRPbqLxNudk_lSbw-1; Wed, 25 Jan 2023 04:29:24 -0500
X-MC-Unique: 3Ui6bLHRPbqLxNudk_lSbw-1
Received: by mail-wr1-f69.google.com with SMTP id e37-20020a5d5965000000b002bfb4cab735so536232wri.5
        for <linux-arch@vger.kernel.org>; Wed, 25 Jan 2023 01:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TjE3MFK73jMeqX5iFxpax2sxTvtsTUXIevN9S/ssTM8=;
        b=rPiSri3jopVmmVrJDGnpXuL5Pmcb/hncL8b6pktRmdf532oxA6WdHCDpVRBnubXMXH
         WnhmCFUvrTvEgfWf3Jrhg93J4iUJuNnWxmea0/4fz7nTjjIOSm8tIhYwJmiywtyOQQTB
         raJKptYS472HidsRXfy8Z/uyaoppR0sWylgpo3y6i8T3ZzieQOjDrVHs8uho6lSz2lbj
         Tp4faS/EBt86LfaMdQtS4brxOxCFZZRVtDLSLQhe3MivI4vLMG4Vgm2neyDotpMecVeN
         onU8+HqJwqyyo/RoZ6skybtnIflmexlBbyDgRUWCPVTEzeikX46FzY1S9fCNvyht+wc3
         5n+g==
X-Gm-Message-State: AFqh2komVVIvqBtcEn1GK12hbgd+FNDGdRnpZMFe4GJxxuoZ5mpf7371
        6a1yEr1P5zmjgC8v7ela1WjNlARxXx5RbzRy1mzhhn9meJanqplxbFhJ2cBiR5OxNNvJdG7O2d8
        JlhPZyDrF9tBHOtp7Lu7+ew==
X-Received: by 2002:adf:fb86:0:b0:2b6:7876:3cd4 with SMTP id a6-20020adffb86000000b002b678763cd4mr25258745wrr.16.1674638963417;
        Wed, 25 Jan 2023 01:29:23 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsLivmPABRiZvHHfGmnyR69nY5+HViCF4rvX0glv7Y5M6gJXrX848D3l9+TwkCsYm87blrEGw==
X-Received: by 2002:adf:fb86:0:b0:2b6:7876:3cd4 with SMTP id a6-20020adffb86000000b002b678763cd4mr25258727wrr.16.1674638963093;
        Wed, 25 Jan 2023 01:29:23 -0800 (PST)
Received: from ?IPV6:2003:cb:c705:4c00:486:38e2:8ff8:a135? (p200300cbc7054c00048638e28ff8a135.dip0.t-ipconnect.de. [2003:cb:c705:4c00:486:38e2:8ff8:a135])
        by smtp.gmail.com with ESMTPSA id d9-20020adff2c9000000b002be34f87a34sm4166170wrp.1.2023.01.25.01.29.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Jan 2023 01:29:22 -0800 (PST)
Message-ID: <716d9e97-b08f-eb0f-101a-be6eaf36f184@redhat.com>
Date:   Wed, 25 Jan 2023 10:29:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v5 23/39] mm: Don't allow write GUPs to shadow stack
 memory
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "kees@kernel.org" <kees@kernel.org>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Eranian, Stephane" <eranian@google.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
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
 <fd741ac9-8214-a375-00b2-a652a7ef27ea@redhat.com>
 <6adfa0b5c38a9362f819fcc364e02c37d99a7f4a.camel@intel.com>
 <5B29D7A0-385A-41E8-AA56-EF726E6906BF@kernel.org>
 <19ff6ea3b96d027defb548fb6b7f89de17905a4b.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <19ff6ea3b96d027defb548fb6b7f89de17905a4b.camel@intel.com>
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

On 25.01.23 00:41, Edgecombe, Rick P wrote:
> On Tue, 2023-01-24 at 15:08 -0800, Kees Cook wrote:
>>> GDB support for shadow stack is queued up for whenever the kernel
>>> interface settles. I believe it just uses ptrace, and not this
>>> proc.
>>> But yea ptrace poke will still need to use FOLL_FORCE and be able
>>> to
>>> write through shadow stacks.
>>
>> I'd prefer to avoid adding more FOLL_FORCE if we can. If gdb can do
>> stack manipulations through a ptrace interface then let's leave off
>> FOLL_FORCE.
> 
> Ptrace and /proc/self/mem both use FOLL_FORCE. I think ptrace will
> always need it or something like it for debugging.
> 
> To jog your memory, this series doesn't change what uses FOLL_FORCE. It
> just sets the shadow stack rules to be the same as read-only memory. So
> even though shadow stack memory is sort of writable, it's a bit more
> locked down and FOLL_FORCE is required to write to it with GUP.
> 
> If we just remove FOLL_FORCE from /proc/self/mem, something will
> probably break right? How do we do this? Some sort of opt-in?

I don't think removing that is an option. It's another debug interface 
that has been allowing such access for ever ...

Blocking /proc/self/mem access completely for selected processes might 
be the better alternative.

-- 
Thanks,

David / dhildenb

