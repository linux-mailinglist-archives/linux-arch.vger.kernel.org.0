Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B71E671249F
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 12:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236409AbjEZK2N (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 May 2023 06:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243149AbjEZK2K (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 May 2023 06:28:10 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4688712F;
        Fri, 26 May 2023 03:28:02 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1b01dac1a82so241075ad.2;
        Fri, 26 May 2023 03:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685096882; x=1687688882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aZO0rJalJeJGbkGsp4THesp5QJNmk1G4UdTf0ECue4c=;
        b=XhH0D0v1D/gUuJkfVBmEkCkn/0BSN48AWwvSmsd+5pVdMFtBBLC/dvLZnlBouhnPju
         9yeJO6EJs/28rK/qxSILPALQbfmLRr5TNmhdLjrTl1FfwLQa83GSujmXyXH0zxaWqJHk
         7ggmKZX3lEo+puMyDfNTDXxmhq24wueKtHN01UmJ5FqeC1Pf1GcDQMY4oT7mh1B7MDlv
         +rOYfgl0VMjRT6xpUdn07HoVVgUF/MdDVY5JmP7PccYq3+XDeGfEubQ7xSn4T1VVlP5l
         k/7xETTehE74AE+xQvqz31C3LiFnqWO2ZqCj4cF6jpYxqj7vbpoZN0JD6hb6LvElsE7C
         ghsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685096882; x=1687688882;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aZO0rJalJeJGbkGsp4THesp5QJNmk1G4UdTf0ECue4c=;
        b=ic88I3WwiyU7vNIQw1gRws1hHEYHaYU2orGJ2HBXW5Bvt+juWJlmkkGReP/DXcz429
         /UjKz1ARZReWrxMfkrRRX4o1fpT36k+0scUyGvGvi2uVNdIACzcTfWgFH/eP4+LHP88W
         rAAhieyCdk/laUaKJh45EQCuDWnxKWNxiTlO4kZ06OE+BoFwJ/5Z0x19YSuwTXLwFVRP
         xIXR+OIXuHtttvHR1795PkJQ8j4lGcz6bUner+T9oQy6/hB6hTgCbDyTKa/MS8MCVRT2
         RJgCQ4btqrECX3fqqo/c8qhytEbEh1XEuB8mKPLrZC3I5o6Wwqru8rJBqOFn5aTrHDp/
         Y0WQ==
X-Gm-Message-State: AC+VfDwVw5+gDtqfBVzXSFQZqPUTt69MCm/8NHp6UgYO68HbFcQois//
        JUA2RNcnmeoyWf4O6G/O5ZY=
X-Google-Smtp-Source: ACHHUZ7Z98CHq6GRXCmsrPlmgwgS2hYtAkiYLAcZOxn45HkkIC+P8mR6M1Tvt3fDPIJZvnVBfa5AoA==
X-Received: by 2002:a17:902:cecd:b0:1af:f751:1be9 with SMTP id d13-20020a170902cecd00b001aff7511be9mr2156719plg.32.1685096881595;
        Fri, 26 May 2023 03:28:01 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id n2-20020a170902e54200b001ae268978cfsm2929008plf.259.2023.05.26.03.27.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 03:28:01 -0700 (PDT)
Message-ID: <a5405368-d04c-f95c-ad18-95f429120dbe@gmail.com>
Date:   Fri, 26 May 2023 19:27:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
 <20230524141152.GL4253@hirez.programming.kicks-ass.net>
 <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
 <c9399722-b2df-52ee-cefe-338b118aeb1e@infradead.org>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <c9399722-b2df-52ee-cefe-338b118aeb1e@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Randy,

On 2023/05/26 13:51, Randy Dunlap wrote:
> Hi Akira,
> 
> On 5/25/23 20:17, Akira Yokosawa wrote:
>> On Wed, 24 May 2023 16:11:52 +0200, Peter Zijlstra wrote:
>>> On Wed, May 24, 2023 at 11:03:58PM +0900, Akira Yokosawa wrote:
>>>
>>>>> * All ops are described as an expression using their usual C operator.
>>>>>   For example:
>>>>>
>>>>>   andnot: "Atomically updates @v to (@v & ~@i)"
>>>>
>>>> The kernel-doc script converts "~@i" into reST source of "~**i**",
>>>> where the emphasis of i is not recognized by Sphinx.
>>>>
>>>> For the "@" to work as expected, please say "~(@i)" or "~ @i".
>>>> My preference is the former.
>>>
>>> And here we start :-/ making the actual comment less readable because
>>> retarded tooling.
>>>
>>>>>   inc:    "Atomically updates @v to (@v + 1)"
>>>>>
>>>>>   Which may be clearer to non-naative English speakers, and allows all
>>>>                             non-native
>>>>
>>>>>   the operations to be described in the same style.
>>>>>
>>>>> * All conditional ops have their condition described as an expression
>>>>>   using the usual C operators. For example:
>>>>>
>>>>>   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
>>>>>   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
>>>>>
>>>>>   Which may be clearer to non-naative English speakers, and allows all
>>>>
>>>> Ditto.
>>>
>>> How about we just keep it as is, and all the rst and html weenies learn
>>> to use a text editor to read code comments?
>>
>> :-) :-) :-)
>>
>> It turns out that kernel-doc is aware of !@var [1].
>> Similar tricks can be added for ~@var.
>> So let's keep it as is!
>>
>> I'll ask documentation forks for updating kernel-doc when this change
>> is merged eventually.
> 
> What do you mean by that?
> What needs to be updated and how?
 
I mean, scripts/kernel-doc needs to be updated so that "~@var"
is converted into "**~var**".

I think adding "~" to the substitution pattern added in [1] as follows
should do the trick (not well tested):

diff --git a/scripts/kernel-doc b/scripts/kernel-doc
index 2486689ffc7b..eb70c1fd4e86 100755
--- a/scripts/kernel-doc
+++ b/scripts/kernel-doc
@@ -64,7 +64,7 @@ my $type_constant = '\b``([^\`]+)``\b';
 my $type_constant2 = '\%([-_\w]+)';
 my $type_func = '(\w+)\(\)';
 my $type_param = '\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
-my $type_param_ref = '([\!]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
+my $type_param_ref = '([\!~]?)\@(\w*((\.\w+)|(->\w+))*(\.\.\.)?)';
 my $type_fp_param = '\@(\w+)\(\)';  # Special RST handling for func ptr params
 my $type_fp_param2 = '\@(\w+->\S+)\(\)';  # Special RST handling for structs with func ptr params
 my $type_env = '(\$\w+)';

Thoughts?

        Thanks, Akira

> 
> 
>> [1]: ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")
> 
> thanks.
