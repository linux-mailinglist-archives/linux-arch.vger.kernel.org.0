Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91B73711E5C
	for <lists+linux-arch@lfdr.de>; Fri, 26 May 2023 05:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbjEZDSK (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 25 May 2023 23:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbjEZDSI (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 25 May 2023 23:18:08 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46CE9D9;
        Thu, 25 May 2023 20:18:06 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-52c30fbccd4so257396a12.0;
        Thu, 25 May 2023 20:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685071086; x=1687663086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jsjw9Ts67Jqfv6XXWLXerd9RQvwEUf28jEcwqGb2fdw=;
        b=gexCS8Bucjz3Z4WbP/cpIHUOR439P4Q994LuD2CCpy7L+gSF/BRKP7netVGXM1eP5D
         CuD/ZmGYKGCQdqlyzN6V+zKSsT40LV9qGfTrcZzWDwdkPNE1Qndw2xUq4ooeDV4Sg8pV
         xH4SN9kxzYmetBMN9Ka4GjSUwhFTPnRykw/cSN+qQ26xq+0UbHIiYFQGnt+t10rFN3ly
         QSzBRWxK/TRVozTO4uf6um94n3YXld7vdqtjXMoYRKizcntufSy22F7w8+yFyYdE/cEj
         WTLF1WUKl3BUtEy5v4s6u0638kaW+QbFubvrA7c928f9m1TGaySGkLfj4y20a/IJkXMM
         /Cpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685071086; x=1687663086;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jsjw9Ts67Jqfv6XXWLXerd9RQvwEUf28jEcwqGb2fdw=;
        b=LRtmf9eUlzD/L2tOiR9Htd34eG5peYsZ1mooAwftCL/HatRt5IK04VRwjyE467soPe
         D/zneVozNU8jzc/n9iRUJ90EicFeGSfd0XGZkhffDSWks7WaRb3pbZvULKBQV/fL+EyR
         DqOoGh1TGyO1F/5q8Bjfgw5cuWEYj/bKmmVdD8ZN+tq66k3uZG0gSTwyW7P6/xgUojRM
         SgNgyBbE4PmtLnAilEuVAFT0wMDA/Sj99wERzuSL4TUQSsmlrUR8NqsUbZ0w692KCMOf
         I4T4MbB8U8a3Tmgu5+487KumicOd9JbeE4+VvjEdiYytvrp5E/eEgn7XCdprU2u4UmUo
         akWA==
X-Gm-Message-State: AC+VfDyBueOARTdBP0+PT2pNIauQOr0md0EuskW8QYNHqqjVMgwmUA60
        cQfLsF64Zl9AqekEnYpsQLk=
X-Google-Smtp-Source: ACHHUZ7W91vx9B8kfPZwWxoy0ntwxBUG8uRfLEDBytstBe0lo+0P/5xIXooZizZfy70yRI+/7GNDxg==
X-Received: by 2002:a05:6a21:9713:b0:f4:fd7:db9f with SMTP id ub19-20020a056a21971300b000f40fd7db9fmr463073pzb.17.1685071085696;
        Thu, 25 May 2023 20:18:05 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id r6-20020a632b06000000b0053f2037d639sm1800082pgr.81.2023.05.25.20.18.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 May 2023 20:18:05 -0700 (PDT)
Message-ID: <e76c924a-762c-061d-02b8-13be884ab344@gmail.com>
Date:   Fri, 26 May 2023 12:17:59 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 24/26] locking/atomic: scripts: generate kerneldoc
 comments
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        boqun.feng@gmail.com, corbet@lwn.net, keescook@chromium.org,
        linux-arch@vger.kernel.org, linux@armlinux.org.uk,
        linux-doc@vger.kernel.org, paulmck@kernel.org,
        sstabellini@kernel.org, will@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20230522122429.1915021-1-mark.rutland@arm.com>
 <20230522122429.1915021-25-mark.rutland@arm.com>
 <96d6930b-78b1-4b4c-63e3-c385a764d6e3@gmail.com>
 <20230524141152.GL4253@hirez.programming.kicks-ass.net>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20230524141152.GL4253@hirez.programming.kicks-ass.net>
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

On Wed, 24 May 2023 16:11:52 +0200, Peter Zijlstra wrote:
> On Wed, May 24, 2023 at 11:03:58PM +0900, Akira Yokosawa wrote:
> 
>>> * All ops are described as an expression using their usual C operator.
>>>   For example:
>>>
>>>   andnot: "Atomically updates @v to (@v & ~@i)"
>>
>> The kernel-doc script converts "~@i" into reST source of "~**i**",
>> where the emphasis of i is not recognized by Sphinx.
>>
>> For the "@" to work as expected, please say "~(@i)" or "~ @i".
>> My preference is the former.
> 
> And here we start :-/ making the actual comment less readable because
> retarded tooling.
> 
>>>   inc:    "Atomically updates @v to (@v + 1)"
>>>
>>>   Which may be clearer to non-naative English speakers, and allows all
>>                             non-native
>>
>>>   the operations to be described in the same style.
>>>
>>> * All conditional ops have their condition described as an expression
>>>   using the usual C operators. For example:
>>>
>>>   add_unless: "If (@v != @u), atomically updates @v to (@v + @i)"
>>>   cmpxchg:    "If (@v == @old), atomically updates @v to @new"
>>>
>>>   Which may be clearer to non-naative English speakers, and allows all
>>
>> Ditto.
> 
> How about we just keep it as is, and all the rst and html weenies learn
> to use a text editor to read code comments?

:-) :-) :-)

It turns out that kernel-doc is aware of !@var [1].
Similar tricks can be added for ~@var.
So let's keep it as is!

I'll ask documentation forks for updating kernel-doc when this change
is merged eventually.

[1]: ee2aa7590398 ("scripts: kernel-doc: accept negation like !@var")

        Thanks, Akira

