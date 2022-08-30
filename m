Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A595A6EEE
	for <lists+linux-arch@lfdr.de>; Tue, 30 Aug 2022 23:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbiH3VMk (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 30 Aug 2022 17:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiH3VMh (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 30 Aug 2022 17:12:37 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248ED86FEA
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:12:36 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b2so9448696qkh.12
        for <linux-arch@vger.kernel.org>; Tue, 30 Aug 2022 14:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=2S/gPzbn70K9n2kENTZuMHMg0rHkBn7eRQ2xitbAkvQ=;
        b=l31XDqgcVa767LbJ/esQ54hvux+TzmouIJhDZQLPDm+jHDp6aO13ixM8EB1+UP+wNd
         subtyvz4u5a7FNkB7FgjTmEkkK8CYQ7ZYdUbM9HEiA0rwwLz9Fq781zz5SFzmIToEhiN
         J3PWrV7LeUp6my/1B6xgSfEeksh8eNgTyV5U4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=2S/gPzbn70K9n2kENTZuMHMg0rHkBn7eRQ2xitbAkvQ=;
        b=2+iqB33HOLOfuP3Qo0jxyjA1J0WYdPH/3KcDJVvmeIGY9iQVukJ1wkkJSioiJ3bCH6
         Rc/4QtCQbCI5B9sg44GMWnqgyITFdteYczx2pAmOufZIOv1SbNGNn6L8ymIqERYuXZ4Q
         0VDOsrrTcVoRKYNstgtTSX4qyXyPFlrQ8o/WPN4vDTOkfrq+ZDqfGooNswRgW1f00iIp
         +0anr6uZE0WmH7VJ3QU+YdQ1uve8OgUw4ErVqCp9gYnSb2e0C1vevfhOjWOFWwN/QEDU
         ke/lgs/ayb8hpTkZfsiEGH3Ega9eaLZsYiDU+bENouCYU+m+g/djq56BJgspw61qB7H5
         r6QA==
X-Gm-Message-State: ACgBeo1ZsbmXIeXE9LUhoEz74BDWnrdO1KMPNDCpJnqjXeBVWAVm6elQ
        0J5y4w4/YxqooeAbG0vbUsbrFA==
X-Google-Smtp-Source: AA6agR5Fysxg3xWrlOzGO2qBXwoKrx8axP3/frxLtEAid18xOVogn75KthGHW4lns7Nv9j+ALb60rA==
X-Received: by 2002:a05:620a:2585:b0:6b6:66b2:d40c with SMTP id x5-20020a05620a258500b006b666b2d40cmr13458668qko.710.1661893955222;
        Tue, 30 Aug 2022 14:12:35 -0700 (PDT)
Received: from [10.0.0.40] (c-73-148-104-166.hsd1.va.comcast.net. [73.148.104.166])
        by smtp.gmail.com with ESMTPSA id v17-20020a05620a0f1100b006b58d8f6181sm8654958qkl.72.2022.08.30.14.12.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 14:12:34 -0700 (PDT)
Message-ID: <98f2b194-1fe6-3cd8-36cf-da017c35198f@joelfernandes.org>
Date:   Tue, 30 Aug 2022 17:12:33 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] tools/memory-model: Weaken ctrl dependency definition in
 explanation.txt
Content-Language: en-US
From:   Joel Fernandes <joel@joelfernandes.org>
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
 <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
In-Reply-To: <663d568d-a343-d44b-d33d-29998bff8f70@joelfernandes.org>
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



On 8/30/2022 5:08 PM, Joel Fernandes wrote:
> 
> 
> On 8/30/2022 4:44 PM, Paul Heidekrüger wrote:
>> The current informal control dependency definition in explanation.txt is
>> too broad and, as dicsussed, needs to be updated.
>>
>> Consider the following example:
>>
>>> if(READ_ONCE(x))
>>> 	return 42;
>>>
>>> 	WRITE_ONCE(y, 42);
>>>
>>> 	return 21;
>>
>> The read event determines whether the write event will be executed "at
>> all" - as per the current definition - but the formal LKMM does not
>> recognize this as a control dependency.
>>
>> Introduce a new defintion which includes the requirement for the second
>> memory access event to syntactically lie within the arm of a non-loop
>> conditional.
>>
>> Link: https://lore.kernel.org/all/20220615114330.2573952-1-paul.heidekrueger@in.tum.de/
>> Cc: Marco Elver <elver@google.com>
>> Cc: Charalampos Mainas <charalampos.mainas@gmail.com>
>> Cc: Pramod Bhatotia <pramod.bhatotia@in.tum.de>
>> Cc: Soham Chakraborty <s.s.chakraborty@tudelft.nl>
>> Cc: Martin Fink <martin.fink@in.tum.de>
>> Signed-off-by: Paul Heidekrüger <paul.heidekrueger@in.tum.de>
>> Co-developed-by: Alan Stern <stern@rowland.harvard.edu>
>> ---
>>
>> @Alan:
>>
>> Since I got it wrong the last time, I'm adding you as a co-developer after my
>> SOB. I'm sorry if this creates extra work on your side due to you having to
>> resubmit the patch now with your SOB if I understand correctly, but since it's
>> based on your wording from the other thread, I definitely wanted to give you
>> credit.
>>
>>  tools/memory-model/Documentation/explanation.txt | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/memory-model/Documentation/explanation.txt b/tools/memory-model/Documentation/explanation.txt
>> index ee819a402b69..0bca50cac5f4 100644
>> --- a/tools/memory-model/Documentation/explanation.txt
>> +++ b/tools/memory-model/Documentation/explanation.txt
>> @@ -464,9 +464,10 @@ to address dependencies, since the address of a location accessed
>>  through a pointer will depend on the value read earlier from that
>>  pointer.
>>
>> -Finally, a read event and another memory access event are linked by a
>> -control dependency if the value obtained by the read affects whether
>> -the second event is executed at all.  Simple example:
>> +Finally, a read event X and another memory access event Y are linked by
>> +a control dependency if Y syntactically lies within an arm of an if,
>> +else or switch statement and the condition guarding Y is either data or
>> +address-dependent on X.  Simple example:
> 
> 'conditioning guarding Y' sounds confusing to me as it implies to me that the
> condition's evaluation depends on Y. I much prefer Alan's wording from the
> linked post saying something like 'the branch condition is data or address
> dependent on X, and Y lies in one of the arms'.
> 
> I have to ask though, why doesn't this imply that the second instruction never
> executes at all? I believe that would break the MP-pattern if it were not true.

About my last statement, I believe your patch does not disagree with the
correctness of the earlier text but just wants to improve it. If that's case
then that's fine.

 - Joel
