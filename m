Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07B2B72E8F3
	for <lists+linux-arch@lfdr.de>; Tue, 13 Jun 2023 19:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231297AbjFMRBK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 13 Jun 2023 13:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbjFMRBH (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 13 Jun 2023 13:01:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4D189
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686675628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N+LdwBzt0uYokh007O/q+HMXZaTU5MnHMEEMsHFG/3Y=;
        b=WkAJ958AEEeLIYjYkDO1gIUTyWFYNlwVNKupG708fekIofIyQ2y6V6ytx8jWWD4NZgohY3
        fJvJlEhHWmt2RpigpHSkyLwGoxXXsGCN+2Qiv2WodBl3yqnHemiHFd7mVzgq8ryryWc4ol
        5E0jdY6B6cymNbNQ0pUDaj/K0R48zN4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-FxzYPij-POaKFZ8wTSWrhw-1; Tue, 13 Jun 2023 13:00:25 -0400
X-MC-Unique: FxzYPij-POaKFZ8wTSWrhw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-3f813609d4eso21715165e9.2
        for <linux-arch@vger.kernel.org>; Tue, 13 Jun 2023 10:00:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686675621; x=1689267621;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N+LdwBzt0uYokh007O/q+HMXZaTU5MnHMEEMsHFG/3Y=;
        b=ReSKZu9sE5LWrQ7jECIt+XDW/K8KESkjrvHJbQilztIRVLyi4v77qEMtRNJqdF/2y8
         Jf1PBg3euUQ26RJMC1a03KduEmUOavd14UYO4LEoIg7iX/ltxCY4rW9W2SdZ2cTbIwYB
         ShU3ETVX7roJtZE+zX1qVJnjQRRLrB7XmARYhxybgxQQf5FM8d5AP2WFdAvWffmZ1s86
         xKhkHgxUv10JH58ITlBLWXb1qyTs7jFoh4VtWaYRn836zFbdj4Eh7sMBNXmZpKsL8IXR
         oZ2aSiRAZ32FzCQvSxAttl8dZKugjDfaYEhRrpT5+dqEgbkBFy7p1cYgm+J0XJ/BiQH8
         5sYA==
X-Gm-Message-State: AC+VfDxvZbOEn/NU4XlUp9sPXIquqpjMFrNg3gwB7h4UoeJOdWAJEYCv
        hpJ6rmew8yvhrCX+1hxWQWLo2CHCDeozdsEerc413NEqdTBaujXx5nxGf7ZbWv5XmF/HjfYyGq4
        4EijSqYWvrIdDvP3LWPkhOg==
X-Received: by 2002:a05:600c:2041:b0:3f8:d0e7:daed with SMTP id p1-20020a05600c204100b003f8d0e7daedmr1651719wmg.19.1686675620854;
        Tue, 13 Jun 2023 10:00:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5DqYDEwXY1aS+T8oevGZM1GGzvu3C6CrpD97OsPgkk4IOclN0QORetIFLX25l+OyKcdC2cGA==
X-Received: by 2002:a05:600c:2041:b0:3f8:d0e7:daed with SMTP id p1-20020a05600c204100b003f8d0e7daedmr1651659wmg.19.1686675620442;
        Tue, 13 Jun 2023 10:00:20 -0700 (PDT)
Received: from ?IPV6:2003:cb:c710:ff00:1a06:80f:733a:e8c6? (p200300cbc710ff001a06080f733ae8c6.dip0.t-ipconnect.de. [2003:cb:c710:ff00:1a06:80f:733a:e8c6])
        by smtp.gmail.com with ESMTPSA id d17-20020adffbd1000000b0030fb4b55c13sm9792662wrs.96.2023.06.13.10.00.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 10:00:19 -0700 (PDT)
Message-ID: <8a053da2-0f26-82ca-f437-9b9de11d4584@redhat.com>
Date:   Tue, 13 Jun 2023 19:00:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v9 02/42] mm: Move pte/pmd_mkwrite() callers with no VMA
 to _novma()
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "rppt@kernel.org" <rppt@kernel.org>
Cc:     "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "Torvalds, Linus" <torvalds@linux-foundation.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "bp@alien8.de" <bp@alien8.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>
References: <20230613001108.3040476-1-rick.p.edgecombe@intel.com>
 <20230613001108.3040476-3-rick.p.edgecombe@intel.com>
 <20230613074428.GS52412@kernel.org>
 <21b0342854b067c241206f422bc5b3254b43c7f5.camel@intel.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <21b0342854b067c241206f422bc5b3254b43c7f5.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 13.06.23 18:19, Edgecombe, Rick P wrote:
> On Tue, 2023-06-13 at 10:44 +0300, Mike Rapoport wrote:
>>> Previous patches have done the first step, so next move the callers
>>> that
>>> don't have a VMA to pte_mkwrite_novma(). Also do the same for
>>
>> I hear x86 maintainers asking to drop "previous patches" ;-)
>>
>> Maybe
>> This is the second step of the conversion that moves the callers ...
> 
> Really? I've not heard that. Just a strong aversion to "this patch".
> I've got feedback to say "previous patches" and not "the last patch" so
> it doesn't get stale. I guess it could be "previous changes".

Talking about patches make sense when discussing literal patches sent to 
the mailing list. In the git log, it's commit, and "future commits" or 
"follow-up work".

Yes, we use "patches" all of the time in commit logs, especially when we 
  include the cover letter in the commit message (as done frequently in 
the -mm tree).

-- 
Cheers,

David / dhildenb

