Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACA074C1D04
	for <lists+linux-arch@lfdr.de>; Wed, 23 Feb 2022 21:19:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240933AbiBWUTl (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 23 Feb 2022 15:19:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiBWUTl (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 23 Feb 2022 15:19:41 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFBF4D24F
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:19:12 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id vz16so54946970ejb.0
        for <linux-arch@vger.kernel.org>; Wed, 23 Feb 2022 12:19:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=GdkY3M62yIVmTzJXmW8Tv6uSUCyx3HMUgy8EElsRQGw=;
        b=iRVIee/D0Fm0ps9q1X9MwfXDkJB4+SExL4xljvwtV3AsH9EVSQ+VFqZQ3mCxSGZfww
         UVPPrVyNjOUCTuWMkiz5qjWWzK62fbW0QTPs5LAaxJ1+/ED121d7fVp4oxKCyp94r2E3
         ZU3Fij+rNc96PCK8laa85QdA6tWxN8CnSzUtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=GdkY3M62yIVmTzJXmW8Tv6uSUCyx3HMUgy8EElsRQGw=;
        b=LRghO8qqMJLaakAiCO9ULt4vfSdB4tyozp5M9skkBNpzXQfv+xhTjRPF4oB87wBVpy
         HLYYOYrhaUiSI9rV+VYMjnS30iGHRL0poqrknkOUepjvxMYse8t0jWWbtwClYVok6ufP
         6X+UtwIbffedm6lm8fQHY4+Y4gGRKSOcyWKz2iGBoca54JQDPzPBWnCfovZTmA3p1KLF
         IkMZwPkpppOTeO6AYnoTHQ8E5sJpTBTs+z5wObn8A5/9i/eMHQS0cLxfOW93eMcf5Kv3
         LpDuNwCWJsXOsfJwymEhQReRooevwQLwO5wbAaVazWvrMfKpa7bGKbOK7saLIEUzRP6r
         rlAg==
X-Gm-Message-State: AOAM532h2PndWJGfwrwcfPmatXc3WMQvdTadZRppFL/vyWOqzvz8gRKB
        /Ponx37xyRurnWunuSN3WBx1zQ==
X-Google-Smtp-Source: ABdhPJxiroB+LBTYcAC2nMyY4lhGwkeFaTzFTOsz1EBU5yww37Z1l4LUqQyplGXWwNQtr24P+O+2lw==
X-Received: by 2002:a17:906:564d:b0:6cf:54ec:72ca with SMTP id v13-20020a170906564d00b006cf54ec72camr1065989ejr.110.1645647550603;
        Wed, 23 Feb 2022 12:19:10 -0800 (PST)
Received: from [192.168.1.149] ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id v8sm372463edc.0.2022.02.23.12.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Feb 2022 12:19:10 -0800 (PST)
Message-ID: <5a476b24-0f34-91d4-84a4-699e8c374abe@rasmusvillemoes.dk>
Date:   Wed, 23 Feb 2022 21:19:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC PATCH 04/13] vfio/mdev: remove the usage of the list
 iterator after the loop
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Jakob <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Arnd Bergman <arnd@arndb.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Mike Rapoport <rppt@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
References: <20220217184829.1991035-1-jakobkoschel@gmail.com>
 <20220217184829.1991035-5-jakobkoschel@gmail.com>
 <20220218151216.GE1037534@ziepe.ca>
 <6BA40980-554F-45E2-914D-5E4CD02FF21C@gmail.com>
 <CAHk-=wir=xabJ73Upk1dsuoMKWTTjTfeLFJ=p2S0yRYYaxW4fA@mail.gmail.com>
 <20220223191222.GC10361@ziepe.ca>
 <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
In-Reply-To: <CAHk-=widDQUjQS2tpaw3j_+Yz8rAY3P0qdqpz+nTNu4-3LaU3w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 23/02/2022 20.31, Linus Torvalds wrote:
> On Wed, Feb 23, 2022 at 11:12 AM Jason Gunthorpe <jgg@ziepe.ca> wrote:
>>
>> Yes, this is what I had put together as well about this patch, and I
>> think it is OK as-is. In this case the list head is in the .bss of a
>> module so I don't think it is very likely that the type confused
>> container_of() will alias a kalloc result, but it is certainly
>> technically wrong as-is.
> 
> I think that the pattern we should strive to use is not top use a
> 'bool' with the
> 
>  - initialize to false, and then in loop: do 'found = true;' if found
> 
>  - use the iterator variable if 'found'.
> 
> but instead strive to
> 
>  - either only use the iterator variable inside the loop
> 
>  - if you want to use it after the loop, have a externally visible
> separate pointer initialized to NULL, and set it to the iterator
> variable inside the loop
> 
> IOW, instead of having a variable that is a 'bool', just make that
> variable _be_ the pointer you want. It's clearer, and it avoids using
> the iterator variable outside the loop.
> 
> It also is likely to generate better code, because there are fewer
> live variables - outside the loop now only uses that one variable,
> rather than using the 'bool' variable _and_ the iterator variable.

I have often wished that the iterator macros would consistently set the
loop variable to NULL upon reaching the end. It could be done by
changing the stop condition from

  i != HEAD

to

  i != HEAD || (i = NULL, 0)

[the comma operator mostly for clarity, we want the side effect of the
assignment but the whole RHS to still evaluate to false, which "i=NULL"
by itself of course would].

In the vast majority of cases where the iterator variable is not used
after the loop, the compiler should see through it and just drop the
dead assignment. And it would make the test for "did we break out early
finding what we looked for, or did we iterate till the end" quite
natural, without any auxiliary bool or extra 'struct foo*' variable. But
it will probably break too much existing code.

Rasmus
