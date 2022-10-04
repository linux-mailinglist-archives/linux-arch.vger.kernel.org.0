Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4E35F3B40
	for <lists+linux-arch@lfdr.de>; Tue,  4 Oct 2022 04:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiJDCSP (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 3 Oct 2022 22:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbiJDCRR (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 3 Oct 2022 22:17:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB3A357F4;
        Mon,  3 Oct 2022 19:16:47 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gf8so9077460pjb.5;
        Mon, 03 Oct 2022 19:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CaXno1qEaV74BR47NIHz1H2pJTTUIFFA+A4lpB/mgXA=;
        b=eloCpiVf/0XcI+V+9l2I+AY6JDTwodTaVWUcwJM8+ymYWCbCYU6oBKazVN4ASxEJX6
         kk9rcQNkV9iNEBCEfBpiQL8dJO8Ze5SU5jT+OEylww1Rdoa2cSXdVmfP8YB9ZS+TH1ok
         h98MPxQcbqwHETxS/dd25Mmf0WuqbMHpi/wUbu+ALDMg0/lCf5WzLQTsU9cEs0W/u242
         s0Ymg5MD1aqfX3VyUTM64F0uWzm19iJV4OPDMpgg3sQgr/nMEdZXKUqfcKtchsO3+TO4
         WcxOl4sdDhoTC772r6pirqm5F/HfdZ/bE36pFYNbWNSppnVLW50Yi/HaYpOzQmMfBoy7
         o0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaXno1qEaV74BR47NIHz1H2pJTTUIFFA+A4lpB/mgXA=;
        b=bAccHQpbUdWEuiIUQID8I46Wts5SqvCAgb9SjTuaUJVHO2NxaeoAeF87pkGxwJT7Rp
         Tw0rX1HGGLSGUS0pGPTIVvRhrfzt5MS9ojVOSprPcmfkgYhDtU2cDqXFjqFeTwSw6Zmr
         ObQVp4WLZvtiRshX4N0r518nyVeharmshSWg6NKw3H4NlLTG9O1d0qunGfaypPprDSY3
         r886Mx5ZbMjVDqTDLhIlgvYimLaAiiCFRDkO+JnPSyCn97RLJLXU2uC3IsT7Kkn0NZKe
         9iyNVZR9V6MdBwHT12OcmCYhZp157RpxJwHXw0MnrdEprH+oqTIdVRVPhSr9mOtjuTGR
         OMYw==
X-Gm-Message-State: ACrzQf2uP7/UiNJO9h2zjuyOUqLOwUZN5vCNgviwFj3z3VDPgOXCygr/
        jbYALHcbclqly/R8VXyEY+c=
X-Google-Smtp-Source: AMsMyM7z7mqbqxau9dc5BF4w7ZntoA9ZSL+qDurMSeilS3c8J2q9EzScXlqJREt95R+vDsKYOP4Ufg==
X-Received: by 2002:a17:902:c205:b0:178:5083:f656 with SMTP id 5-20020a170902c20500b001785083f656mr24923647pll.81.1664849802859;
        Mon, 03 Oct 2022 19:16:42 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-17.three.co.id. [180.214.232.17])
        by smtp.gmail.com with ESMTPSA id y5-20020aa79ae5000000b00561382a5a25sm30703pfp.26.2022.10.03.19.16.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 19:16:42 -0700 (PDT)
Message-ID: <5baaba9c-b07d-4d28-9416-217ebed14eb4@gmail.com>
Date:   Tue, 4 Oct 2022 09:16:31 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH v2 01/39] Documentation/x86: Add CET description
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>
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
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "kcc@google.com" <kcc@google.com>, "pavel@ucw.cz" <pavel@ucw.cz>,
        "oleg@redhat.com" <oleg@redhat.com>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "Moreira, Joao" <joao.moreira@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mike.kravetz@oracle.com" <mike.kravetz@oracle.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "Yang, Weijiang" <weijiang.yang@intel.com>,
        "jamorris@linux.microsoft.com" <jamorris@linux.microsoft.com>,
        "john.allen@amd.com" <john.allen@amd.com>,
        "rppt@kernel.org" <rppt@kernel.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
        "gorcunov@gmail.com" <gorcunov@gmail.com>
References: <20220929222936.14584-1-rick.p.edgecombe@intel.com>
 <20220929222936.14584-2-rick.p.edgecombe@intel.com>
 <YzZlT7sO56TzXgNc@debian.me> <87v8p5f0mg.fsf@meer.lwn.net>
 <0eb358ac-068c-d025-07e3-80a3c51ef39c@gmail.com>
 <5832fa687e6da50697a7627d53453b728ed1b7b7.camel@intel.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <5832fa687e6da50697a7627d53453b728ed1b7b7.camel@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 10/3/22 23:56, Edgecombe, Rick P wrote:
> On Fri, 2022-09-30 at 20:41 +0700, Bagas Sanjaya wrote:
>> On 9/30/22 20:33, Jonathan Corbet wrote:
>>>>   CET introduces Shadow Stack and Indirect Branch Tracking.
>>>> Shadow stack is
>>>>   a secondary stack allocated from memory and cannot be directly
>>>> modified by
>>>> -applications. When executing a CALL instruction, the processor
>>>> pushes the
>>>> +applications. When executing a ``CALL`` instruction, the
>>>> processor pushes the
>>>
>>> Just to be clear, not everybody is fond of sprinkling lots of
>>> ``literal
>>> text`` throughout the documentation in this way.  Heavy use of it
>>> will
>>> certainly clutter the plain-text file and can be a net negative
>>> overall.
>>>
>>
>> Actually there is a trade-off between semantic correctness and plain-
>> text
>> clarity. With regards to inline code samples (like identifiers), I
>> fall
>> into the former camp. But when I'm reviewing patches for which the
>> surrounding documentation go latter camp (leave code samples alone
>> without
>> markup), I can adapt to that style as long as it causes no warnings
>> whatsover.
> 
> Thanks. Unless anyone has any objections, I think I'll take all these
> changes, except for the literal-izing of the instructions. They are not
> really being used as code samples in this case.
> 
> Bagas, can you reply with your sign-off and I'll just apply it?

OK, here goes...

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

-- 
An old man doll... just what I always wanted! - Clara
