Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D9C5A6EDC
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbiH3VIU (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:08:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiH3VIT (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:08:19 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303908673C
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:08:18 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id h21so9598963qta.3
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:08:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=YnMPi8S/rmzftaQJdnwQOkJ/FK3B4YCgHwvUmwZNUOY=;
        b=W1TkrN40e7YmmGfiyZ9+TO2XuGUSCuaHtVqqW6ECmbsaOvBWLc7WjWn/2wAvg95xoq
         a/9Mfhw40R792rRpcMLWlsiujFayibkHs4KGArB7fDXRRhigmP2Zu1xV0uX97wVr8N3o
         jqad79DGL0xMxExjk5tab/QwmXpL7D8i/ZVR0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=YnMPi8S/rmzftaQJdnwQOkJ/FK3B4YCgHwvUmwZNUOY=;
        b=kmB3D75MYX7vRZHNBRmAn/awYUIaLSHl+m9WY5/6c3TSvoH6rglEepEwNHMf3mAwS6
         5uinWyfbc8I5Pm2I2koK/IueS1yIst1QCkea9lVneo7fuIahpDS+oMgjNLBYJL46W1eL
         IWKmJqljGPio2+7SRF87dpWX1QVlJDLmWEKM7fVm3Yh9OHAyZXvxk+kXRsTs5nKh3W7m
         ysxCivleoFdLPbH3eaPba3XcELnnN/XQJCKXWMXTHaykIUjcxynwB2qFvGSq5NgHXu2A
         +W+R8CXQMMv+mGy3ME9n56aLfOJ1hzQ2MK+TlT2dwVvtQY5NxUTkNl58XwyZyBextGRP
         K7eQ==
X-Gm-Message-State: ACgBeo35i11hMCVgRDi2dQw8WpqMEkyr7+NWQGcXgHFQEvmirTTIRjsm
        X6J0NxEyAVCXtPlYsi9LeJ7oxw==
X-Google-Smtp-Source: AA6agR4tYyICEu+LzWKkcWiW7bKYlEEOF+VmXrjBrxsYNYg+yfuHnhe8j0tt6oTweVybWEhMDm2yVw==
X-Received: by 2002:a05:622a:11d6:b0:343:5e19:7488 with SMTP id n22-20020a05622a11d600b003435e197488mr16456868qtk.476.1661893697348;
        Tue, 30 Aug 2022 14:08:17 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id l17-20020a37f911000000b006b629f86244sm8432968qkj.50.2022.08.30.14.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 14:08:17 -0700 (PDT)
Message-ID: <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
Date:   Tue, 30 Aug 2022 17:08:15 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tools/memory-model: Weaken ctrl dependency definition in
 explanation.txt
Content-Language: en-US
To:     =?UTF-8?Q?Paul_Heidekr=c3=bcger?= <paul.heidekrueger@in.tum.de>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     Marco Elver <elver@google.com>,
        Charalampos Mainas <charalampos.mainas@gmail.com>,
        Pramod Bhatotia <pramod.bhatotia@in.tum.de>,
        Soham Chakraborty <s.s.chakraborty@tudelft.nl>,
        Martin Fink <martin.fink@in.tum.de>
References: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
From:   Joel Fernandes <joel@joelfernandes.org>
In-Reply-To: <20220830204446.3590197-1-paul.heidekrueger@in.tum.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org



On 8/30/2022 4:44 PM, Paul Heidekrüger wrote:
> The current informal control dependency definition in explanation.txt is
> too broad and, as dicsussed, needs to be updated.
> 
> Consider the following example:
> 
>> if(READ_ONCE(x))
>> 	return 42;
>>
>> 	WRITE_ONCE(y, 42);
>>
>> 	return 21;
> 
> The read event determines whether the write event will be executed "at
> all" - as per the current definition - but the formal LKMM does not
> recognize this as a control dependency.
> 
> Introduce a new defintion which includes the requirement for the second
> memory access event to syntactically lie within the arm of a non-loop
> conditional.
> 
> Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
> Cc: Marco Elver <elver@google.com>
> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
> Cc: Martin Fink <martin.fink@in.tum.de>
> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
> ---
> 
> @Alan:
> 
> Since I got it wrong the last time, I'm adding you as a co-developer after my
> SOB. I'm sorry if this creates extra work on your side due to you having to
> resubmit the patch now with your SOB if I understand correctly, but since it's
> based on your wording from the other thread, I definitely wanted to give you
> credit.
> 
>  tools/memory-model/Documentation/explanation.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
> index ee819a402b69..0bca50cac5f4 100644
> --- a/tools/memory-model/Documentation/explanation.txt
> +++ b/tools/memory-model/Documentation/explanation.txt
> @@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
>  through a pointer will depend on the value read earlier from that
>  pointer.
> 
> -Finally, a read event and another memory access event are linked by a
> -control dependency if the value obtained by the read affects whether
> -the second event is executed at all.  Simple example:
> +Finally, a read event X and another memory access event Y are linked by
> +a control dependency if Y syntactically lies within an arm of an if,
> +else or switch statement and the condition guarding Y is either data or
> +address-dependent on X.  Simple example:

'conditioning guarding Y' sounds confusing to me as it implies to me that the
condition's evaluation depends on Y. I much prefer Alan's wording from the
linked post saying something like 'the branch condition is data or address
dependent on X, and Y lies in one of the arms'.

I have to ask though, why doesn't this imply that the second instruction never
executes at all? I believe that would break the MP-pattern if it were not true.

cheers,

 - Joel



