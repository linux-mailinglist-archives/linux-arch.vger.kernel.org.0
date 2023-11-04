Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F26E7E0E7E
	for <lists+linux-arch@lfdr.de>; Sat,  4 Nov 2023 10:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229572AbjKDJH4 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 4 Nov 2023 05:07:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjKDJHz (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 4 Nov 2023 05:07:55 -0400
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02831BC;
        Sat,  4 Nov 2023 02:07:51 -0700 (PDT)
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40839652b97so21938795e9.3;
        Sat, 04 Nov 2023 02:07:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699088870; x=1699693670;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uw0UbC01r2LumzFikFRhmVhT04eOp55KldTigg2GWk=;
        b=fBDK1KtVV5Cm2aba1isqxF6XnpvtKcMP/XQcXbWPV7BkvD88b2LlLZ5E0ad6JdCvkK
         xmkSKih5CnbK3dYYsXRRy8qpF1PhfErqXHmzfA3me1Rcqdf3mA9paDot8vyIcURjd8HH
         r7IASh6GDaCqb74/huUNrgktR/7xIIfC66amYAf+J+7+n076xw2AJBGglm4oEIWLsAb+
         MYFXJCagp8XO2kTMO5zyooZV19S+2WJrEcjZy1BB/M3WnGAz2/gdFPdAt7FSAC1i4f4c
         mPmfQIaikqq+cTNnSLYIYEBAb49g3waxaPF8fIB0Z49yIi0BycZRMbBFDraORWsZJ7tx
         nO3A==
X-Gm-Message-State: AOJu0Yx8JmsEi8bQF0KNJgiu/drKKoaqfSwYlugL/SQ55siNiMl+LPfQ
        6nwhnqqECnJHoogepyC28jo=
X-Google-Smtp-Source: AGHT+IH60+TdGy0bAefkdrYqXr7vdxCXbFF+XT5PGZ2H9/HqIVNlhtQo7VMUqOcyKMeO7jkxQWeeBA==
X-Received: by 2002:a05:600c:1d0e:b0:402:8896:bb7b with SMTP id l14-20020a05600c1d0e00b004028896bb7bmr18944996wms.6.1699088869944;
        Sat, 04 Nov 2023 02:07:49 -0700 (PDT)
Received: from [192.168.86.246] (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net. [82.11.51.62])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b004094d4292aesm5053010wmo.18.2023.11.04.02.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 Nov 2023 02:07:49 -0700 (PDT)
Message-ID: <db8f3d12-23d5-498b-ab09-61eede907575@linux.com>
Date:   Sat, 4 Nov 2023 09:07:44 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [TREE] "Fast Kernel Headers" Tree -v3
Content-Language: en-US
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Kari Argillander <kari.argillander@stargateuniverse.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Kari Argillander <kari.argillander@gmail.com>
References: <Ydm7ReZWQPrbIugn@gmail.com> <YjBr10JXLGHfEFfi@gmail.com>
 <CAKBF=pvWzuPx0JB3XZ-v+i7KGbhMQTgH6xtii_Bed+qKRFx+ww@mail.gmail.com>
 <b8095bf8-961f-827c-2bd6-2ffa6298b730@infradead.org>
 <CAC=eVgQCs97N_jkB1LKOdxhd=Yvgf1SZfBWcDbG2dGhsihXLqw@mail.gmail.com>
 <CAC=eVgQeawN4Kr2DSePunCdLr_z9zbE=W72vVcLpHU63_3u4YA@mail.gmail.com>
From:   Lucas Tanure <tanure@linux.com>
In-Reply-To: <CAC=eVgQeawN4Kr2DSePunCdLr_z9zbE=W72vVcLpHU63_3u4YA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 22-03-2022 19:03, Kari Argillander wrote:
> 22.03.2022 18.22 Kari Argillander (kari.argillander@gmail.com) wrote:
>>
>> 22.03.2022 17.37 Randy Dunlap (rdunlap@infradead.org) wrote:
>>>
>>> Hi Kari,
>>>
>>> On 3/22/22 00:59, Kari Argillander wrote:
>>>> 15.3.2022 12.35 Ingo Molnar (mingo@kernel.org) wrote:
>>>>>
>>>>> This is -v3 of the "Fast Kernel Headers" tree, which is an ongoing rework
>>>>> of the Linux kernel's header hierarchy & header dependencies, with the dual
>>>>> goals of:
>>>>>
>>>>>   - speeding up the kernel build (both absolute and incremental build times)
>>>>>
>>>>>   - decoupling subsystem type & API definitions from each other
>>>>>
>>>>> The fast-headers tree consists of over 25 sub-trees internally, spanning
>>>>> over 2,300 commits, which can be found at:
>>>>>
>>>>>      git://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git master
>>>>
>>>> I have had problems to build master branch (defconfig) with gcc9
>>>>      gcc (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
>>>>
>>>> I did also test v2 and problems where there too. I have no problem with gcc10 or
>>>> Clang11. Error I get is:
>>>>
>>>> In file included from ./include/linux/rcuwait_api.h:7,
>>>>                   from ./include/linux/rcuwait.h:6,
>>>>                   from ./include/linux/irq_work.h:7,
>>>>                   from ./include/linux/perf_event_types.h:44,
>>>>                   from ./include/linux/perf_event_api.h:17,
>>>>                   from arch/x86/kernel/kprobes/opt.c:8:
>>>> ./include/linux/rcuwait_api.h: In function ‘rcuwait_active’:
>>>> ./include/linux/rcupdate.h:328:9: error: dereferencing pointer to
>>>> incomplete type ‘struct task_struct’
>>>>    328 |  typeof(*p) *local = (typeof(*p) *__force)READ_ONCE(p); \
>>>>        |         ^
>>>> ./include/linux/rcupdate.h:439:31: note: in expansion of macro
>>>> ‘__rcu_access_pointer’
>>>>    439 | #define rcu_access_pointer(p) __rcu_access_pointer((p),
>>>> __UNIQUE_ID(rcu), __rcu)
>>>>        |                               ^~~~~~~~~~~~~~~~~~~~
>>>> ./include/linux/rcuwait_api.h:15:11: note: in expansion of macro
>>>> ‘rcu_access_pointer’
>>>>     15 |  return !!rcu_access_pointer(w->task);
>>>>
>>>>      Argillander
>>>
>>> You could try the patch here:
>>> https://lore.kernel.org/all/917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org/
>>
>> I have to edit it to <linux/cgroup_types.h> as there is no <linux/cgroup-defs.h>
>> with fast headers. I also tried a couple other things but it didn't
>> seem to make a
>> difference.
>>
>>> although the build error that it fixes doesn't look exactly the same
>>> as yours.
>>
>> Quite close still. Maybe I should try to bisect this and I will also
>> see how bisectable
>> this branch is.
> 
> Ok. I have now bisect first bad to this commit.
> c4ad6fcb67c4 ("sched/headers: Reorganize, clean up and optimize
> kernel/sched/fair.c dependencies")
> Note that this has been also bisect by others.
> 
> With this I get little bit different error:
> 
> In file included from ./arch/x86/include/generated/asm/rwonce.h:1,
>                   from ./include/linux/compiler.h:255,
>                   from ./include/linux/export.h:43,
>                   from ./include/linux/linkage.h:7,
>                   from ./include/linux/kernel.h:17,
>                   from ./include/linux/cpumask.h:10,
>                   from ./include/linux/energy_model.h:4,
>                   from kernel/sched/fair.c:23:
> ./include/linux/psi.h: In function ‘cgroup_move_task’:
> ./include/linux/rcupdate.h:414:36: error: dereferencing pointer to
> incomplete type ‘struct css_set’
>    414 | #define RCU_INITIALIZER(v) (typeof(*(v)) __force __rcu *)(v)
>        |                                    ^~~~
> 
> Which is actually the same error that is in Randy's message. Patch of
> Randy works
> on top of this commit. But I cannot get this patch to work with HEAD,
> but probably
> I'm just missing something obvious. Still nice to see that probably a
> solution is near.
> 
>>>>> There's various changes in -v3, and it's now ported to the latest kernel
>>>>> (v5.17-rc8).
>>>>>
>>>>> Diffstat difference:
>>>>>
>>>>>   -v2: 25332 files changed, 178498 insertions(+), 74790 deletions(-)
>>>>>   -v3: 25513 files changed, 180947 insertions(+), 74572 deletions(-)
>>>
>>>
>>> --
>>> ~Randy
> 
Hi Ingo,

What is the fate of this patch series? Are you going to push this?
If not, can I? My approach would be take one by one, understand, test 
and push.
Would take years, but I have the time.

Thanks
Lucas Tanure
