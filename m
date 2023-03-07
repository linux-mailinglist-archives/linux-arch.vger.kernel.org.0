Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696796ADC3C
	for <lists+linux-arch@lfdr.de>; Tue,  7 Mar 2023 11:45:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjCGKpb (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 7 Mar 2023 05:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231235AbjCGKo7 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 7 Mar 2023 05:44:59 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78EEA50982
        for <linux-arch@vger.kernel.org>; Tue,  7 Mar 2023 02:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678185849;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aDXgYZBLxUfMsLcw1qS/eHbSsPTT2QidbprcFoL7C7U=;
        b=I3bqcONlBQHdEflcT8j5z1I4IN73tIWq1NqxU32oQc03rgy1PJGagm5x6ZJSO3Rnf1HNJK
        SvnHws9xiU2PglE1muwNdJ/xyjO1WUbRSh24OD6OhVEyMG2RQPE2dpSxkxsr1i58RzA7bC
        SoTcXUkhF9eBmeA5LL6ZFO/POzvGT54=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-uYcm5GvhPNeOsEBeZ0yrWQ-1; Tue, 07 Mar 2023 05:44:06 -0500
X-MC-Unique: uYcm5GvhPNeOsEBeZ0yrWQ-1
Received: by mail-wm1-f69.google.com with SMTP id c7-20020a7bc847000000b003e00be23a70so8089673wml.2
        for <linux-arch@vger.kernel.org>; Tue, 07 Mar 2023 02:44:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678185846;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aDXgYZBLxUfMsLcw1qS/eHbSsPTT2QidbprcFoL7C7U=;
        b=pZccBcycmZ1RBFw183VRJLXhT3YCoB9MKE2VaqQYfNv6PyA6RH5rEfG0zqyMdIYHwp
         4jAxs9384Ho+JTHg6PuvlUVqt+svPShg/T5fPzAZ3YLcPxfsrvDS7XhlsXUzOx0IvP/i
         4Q5yX7zpwRrgCofAftZxbO+VA0SFIFm8bBoEK7xWYtmySsoJT/BuNypCfqIbUJCjfiaP
         eWYpjzH2clA8B2Son+A8j55XCG0clso/CZtZtvQEwt+4Uc5lQOFnISBEPYll/0i58A8K
         Oolz1LjVkw4LJ3bKS7e6OSLK260n+AxNfSbWNsNMViGsfBhX9XMyRHMrFhxul6fKD4/6
         G8Bw==
X-Gm-Message-State: AO0yUKV1s+TuaKEd+/v91DT1DKrHoxAWHfzA6Qp9Xaz8VIjXPUE4zE7D
        LccYUe3yt9XSNTHJLG/7kjNqQM3KPRXTxCglJPaFnZ8zrFMct379OfRxx0Lm23BXjDS7r/tkzF1
        WmsJP/8UbnBZ0Te7S7wTmIw==
X-Received: by 2002:a5d:624a:0:b0:2c8:42b5:8022 with SMTP id m10-20020a5d624a000000b002c842b58022mr6952108wrv.59.1678185845847;
        Tue, 07 Mar 2023 02:44:05 -0800 (PST)
X-Google-Smtp-Source: AK7set8rPLXlJpSgekHE+458YNHtAM8ubtbpYEdRQYCtKzuI4JLsz2YQyUNjVRF4VCLQBPbLMtbcAg==
X-Received: by 2002:a5d:624a:0:b0:2c8:42b5:8022 with SMTP id m10-20020a5d624a000000b002c842b58022mr6952069wrv.59.1678185845517;
        Tue, 07 Mar 2023 02:44:05 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:a100:e20:41da:c49b:8974? (p200300cbc707a1000e2041dac49b8974.dip0.t-ipconnect.de. [2003:cb:c707:a100:e20:41da:c49b:8974])
        by smtp.gmail.com with ESMTPSA id w2-20020a5d6802000000b002c7163660a9sm12202423wru.105.2023.03.07.02.44.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 02:44:05 -0800 (PST)
Message-ID: <f31108e7-c862-ace7-23b2-82ae9376ad38@redhat.com>
Date:   Tue, 7 Mar 2023 11:44:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 21/41] mm: Add guard pages around a shadow stack.
Content-Language: en-US
To:     Borislav Petkov <bp@alien8.de>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
Cc:     "bsingharora@gmail.com" <bsingharora@gmail.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "Syromiatnikov, Eugene" <esyr@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "Eranian, Stephane" <eranian@google.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "fweimer@redhat.com" <fweimer@redhat.com>,
        "nadav.amit@gmail.com" <nadav.amit@gmail.com>,
        "jannh@google.com" <jannh@google.com>,
        "dethoma@microsoft.com" <dethoma@microsoft.com>,
        "kcc@google.com" <kcc@google.com>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Schimpe, Christina" <christina.schimpe@intel.com>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "andrew.cooper3@citrix.com" <andrew.cooper3@citrix.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20230227222957.24501-1-rick.p.edgecombe@intel.com>
 <20230227222957.24501-22-rick.p.edgecombe@intel.com>
 <ZAWfZcJLXUfNt1Fs@zn.tnic>
 <f91bbe94b51c0855da921a770685aa17c06c8beb.camel@intel.com>
 <20230307103251.GAZAcS0zpon573Ox3N@fat_crate.local>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230307103251.GAZAcS0zpon573Ox3N@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 07.03.23 11:32, Borislav Petkov wrote:
> On Tue, Mar 07, 2023 at 01:29:50AM +0000, Edgecombe, Rick P wrote:
>> On Mon, 2023-03-06 at 09:08 +0100, Borislav Petkov wrote:
>>> Just typos:
>>
>> All seem reasonable to me. Thanks.
>>
>> For using the log verbiage for the comment, it is quite big. Does
>> something like this seem reasonable?
> 
> Yeah, it does. I wouldn't want to lose that explanation in a commit
> message.
> 
> However, this special aspect pertains to the shstk implementation in x86
> but the code is generic mm and such arch-specific comments are kinda
> unfitting there.
> 
> I wonder if it would be better if you could stick that explanation
> somewhere in arch/x86/ and only refer to it in a short comment above
> VM_SHADOW_STACK check in stack_guard_start_gap()...

+1

-- 
Thanks,

David / dhildenb

