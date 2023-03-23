Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A696C7406
	for <lists+linux-arch@lfdr.de>; Fri, 24 Mar 2023 00:30:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjCWXaq (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 23 Mar 2023 19:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjCWXap (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 23 Mar 2023 19:30:45 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC0225BBF;
        Thu, 23 Mar 2023 16:30:45 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id i15so226808pfo.8;
        Thu, 23 Mar 2023 16:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679614244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gGnK9kK6rwPE9Cig9j09DuEmiYA9Kj1n7jjctGAB9Ic=;
        b=GJ9VeSHvJENNkSlhS1vvDkzUudpQA2ONvLrGRjvUl+P+nTPj111yCwQTUUY8z9+rZ2
         +F10vAsuqJs5k5sA7jOkFPTzeu4eaZxDZAWOsnXmU0HnLD0kMuxoSPGBjkqAS5St/47P
         EW34fnL1WzJ43qrq4NC4MKQfzXfBx1zKJNDLbxKbf5GF+FYwaUtKkNoAQCUawdn8SZEl
         cGNZwdnf7DQeco3xpS9AjeCNr/IStf7BQGcQUjNBkVpmfrSoqMjaghqeECzdF2PIbCEe
         QW5nO+e5EeQ2tL3TkVhTld07oFfa13mzRi1BAq9R9RXmZDUKNeyYzdjPe8pJR/TQ/kcd
         LDwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679614244;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gGnK9kK6rwPE9Cig9j09DuEmiYA9Kj1n7jjctGAB9Ic=;
        b=l7Ba6OCxuPhQ2q2SivKZCrUF3UZFANi+WIO7puKnCYAFweiOM6ghobwiVxxi8Agirh
         Yc8Ro3BMK0f2W6mxjDpevCr4qyuMVMf1HK6Mnst6ejUUGVg5nF91WEDeznlfksba01X9
         71uP/KHUZPMQqIKIGhmxTyW+Luvj75gXE0lmlvbVv1otMBYUWTjrHiETn/b7vJ1Q+Vye
         kGkmgpQ8FR/fmn1ScZmADToLKkFpWqB7uQRRr+SmwtdanQ79JEpZZrsem2ZsJYIwFQb9
         /hsISfa7cNBaerkG7qYZrq6C2mctvQdbnfzDYOEikRlOegpCByES6kILZF/SlIPVZ6pA
         S/kg==
X-Gm-Message-State: AAQBX9dmGDgQJvz6mSI7C/TGuHudS7v+DU4jslgVn7nUlri7wLHomA4J
        PZpY3ZVTO7KSaanx9Tsc5GI=
X-Google-Smtp-Source: AKy350arDXi1ErMT2avja0wJVTL1MaLBvhcDLtF6L3fuVg0w3KNh4LAvc+sBGxh+PzdedZWiyOuaJA==
X-Received: by 2002:a62:1d95:0:b0:627:e577:4326 with SMTP id d143-20020a621d95000000b00627e5774326mr716072pfd.17.1679614244499;
        Thu, 23 Mar 2023 16:30:44 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 22-20020aa79216000000b005fdf8c06320sm12874003pfo.175.2023.03.23.16.30.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 16:30:44 -0700 (PDT)
Message-ID: <2d26aad2-a1d5-649c-86ec-9457c577333f@gmail.com>
Date:   Fri, 24 Mar 2023 08:30:38 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH memory-model scripts 01/31] tools/memory-model: Document
 locking corner cases
To:     paulmck@kernel.org
Cc:     parri.andrea@gmail.com, stern@rowland.harvard.edu, will@kernel.org,
        peterz@infradead.org, boqun.feng@gmail.com, npiggin@gmail.com,
        dhowells@redhat.com, j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        kernel-team@meta.com, mingo@kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <4e5839bb-e980-4931-a550-3548d025a32a@paulmck-laptop>
 <20230321010549.51296-1-paulmck@kernel.org>
 <f940cb6c-4aa6-41a4-d9d7-330becd5427a@gmail.com>
 <cd356db2-1643-4b01-bb13-16a7f92cf980@paulmck-laptop>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <cd356db2-1643-4b01-bb13-16a7f92cf980@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, 23 Mar 2023 11:52:15 -0700, Paul E. McKenney wrote:
> On Thu, Mar 23, 2023 at 11:52:57AM +0900, Akira Yokosawa wrote:
>> Hi Paul,
>>
>> On Mon, 20 Mar 2023 18:05:19 -0700, Paul E. McKenney wrote:
>>> Most Linux-kernel uses of locking are straightforward, but there are
>>> corner-case uses that rely on less well-known aspects of the lock and
>>> unlock primitives.  This commit therefore adds a locking.txt and litmus
>>> tests in Documentation/litmus-tests/locking to explain these corner-case
>>> uses.
>>>
>>> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
>>> ---
>>>  .../litmus-tests/locking/DCL-broken.litmus    |  55 +++
>>>  .../litmus-tests/locking/DCL-fixed.litmus     |  56 +++
>>>  .../litmus-tests/locking/RM-broken.litmus     |  42 +++
>>>  .../litmus-tests/locking/RM-fixed.litmus      |  42 +++
>>>  tools/memory-model/Documentation/locking.txt  | 320 ++++++++++++++++++
>>
>> I think the documentation needs adjustment to cope with Andrea's change
>> of litmus tests.
>>
>> Also, coding style of code snippets taken from litmus tests look somewhat
>> inconsistent with other snippets taken from MP+... litmus tests:
>>
>>   - Simple function signature such as "void CPU0(void)".
>>   - No declaration of local variables.
>>   - Indirection level of global variables.
>>   - No "locations" clause
>>
>> How about applying the diff below?
> 
> Good eyes, thank you!  I will fold this in with attribution.

Feel free to add

Reviewed-by: Akira Yokosawa <akiyks@gmail.com>

        Thanks, Akira
> 
> 							Thanx, Paul
> 
>>         Thanks, Akira

