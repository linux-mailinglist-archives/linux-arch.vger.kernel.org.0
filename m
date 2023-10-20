Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F2437D1290
	for <lists+linux-arch@lfdr.de>; Fri, 20 Oct 2023 17:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377653AbjJTPY7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 20 Oct 2023 11:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377690AbjJTPY6 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 20 Oct 2023 11:24:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89C61D68;
        Fri, 20 Oct 2023 08:24:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c434c33ec0so6962225ad.3;
        Fri, 20 Oct 2023 08:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697815496; x=1698420296; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wgN1mj8c6EZWDC3ZEHwwRowF28sUxV0wDoYjbnDz+iI=;
        b=KNQu2C+C/PwT1Po2uvIlCtVy7Rv36tVcherSgsNGY04oPcBY+5ZPD0Cg3HQ4FPwssT
         0SjY6nYSY7lNSSQEt7Ya5lW4hlH2NPzVG2+qrnwCxaZrAuS+itxVOgIeeuHQ+4Rdtq8B
         1OFvfaGsnfBswdDo3O3I73QWds9sQRH0uEm48PdlgIuyuQZ2DowYCfmGbNxIW9awlQpM
         IbFINF0ZcrUwptUUbLqqPgFruEuwbDBo7bfZHVAMCUx/MmsiZMqgV+/dSX0ZgsPAxC2d
         9U/PlR3lAgMTRmAma2AU/M0glXh0Zc4t94xohAoAYFVePyQlPf5xCApc6TMFBDRRr/Qk
         McXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697815496; x=1698420296;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wgN1mj8c6EZWDC3ZEHwwRowF28sUxV0wDoYjbnDz+iI=;
        b=hIgPi5CU0eCaJ89efb3XZnU1KU5k0lGPnoq2gpXNowubv+/oQuv0tbJ8jlpwszxuSa
         B3IPqCNnOoj9ruUXlNw5+fvqb5LgZeleudA6Xu3+f+5Xgc/XDyAbEuJfbd8xk6Cq73PS
         z0vQE6QHH6M5/bSkNeiZCaq2JOooGrQeouV/6njJrX0H/Kj8rjDK+C0tIXweYbeerY6J
         XdIvILXaMDwiFl9Z/OjWDjRz+rqMP0KaE9y+7tr18O0BINzwVdxHu9+UUOMDOSOgY+pd
         eOX+WW0UrSEcmQpTqaEp1r+j0+DozuMQ58DPGodhP+/GBYNj6nmcp/HHlRIY7Q6mICK5
         Gm3g==
X-Gm-Message-State: AOJu0YyNiTNzVPosdSVITLvE9yc9gnaPzrY6rZhUsUeZMFmnqvhLvbI7
        7DagFFRH3NhhtjJqXPqtKO4=
X-Google-Smtp-Source: AGHT+IFE0UruAloN0VBEzLeUYFquXcIsWvwxZFPYD+C/W4shhWwnVrqYZl0qht+0IgwDemPXaXeMCw==
X-Received: by 2002:a17:902:ce8d:b0:1ca:c490:8539 with SMTP id f13-20020a170902ce8d00b001cac4908539mr2758754plg.18.1697815495808;
        Fri, 20 Oct 2023 08:24:55 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id c24-20020a170902d91800b001c9ab91d3d7sm1657340plz.37.2023.10.20.08.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 08:24:55 -0700 (PDT)
Message-ID: <03ea8aea-2d0c-48ab-bb0d-e585571f1926@gmail.com>
Date:   Sat, 21 Oct 2023 00:24:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH memory-model] docs: memory-barriers: Add note on compiler
 transformation and address deps
To:     paulmck@kernel.org,
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>
References: <ceaeba0a-fc30-4635-802a-668c859a58b2@paulmck-laptop>
 <4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com>
 <1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com>
 <f363d6e0-5682-43e7-9a3f-6b896c3cd920@paulmck-laptop>
 <b96cfbc1-f6b0-2fa6-b72d-d57c34bbf14b@huaweicloud.com>
 <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <2694e6e1-3282-4a69-b955-06afd7d7f87f@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On 2023/10/20 22:57, Paul E. McKenney wrote:
> On Fri, Oct 20, 2023 at 11:29:24AM +0200, Jonas Oberhauser wrote:
>>
>> Am 10/19/2023 um 6:39 PM schrieb Paul E. McKenney:
>>> On Wed, Oct 18, 2023 at 12:11:58PM +0200, Jonas Oberhauser wrote:
[...]
>>>> Am 10/6/2023 um 6:39 PM schrieb Jonas Oberhauser:
>>>>> Hi Paul,
>>>>>
>>>>> The "more up-to-date information" makes it sound like (some of) the
>>>>> information in this section is out-of-date/no longer valid.
>>> The old smp_read_barrier_depends() that these section cover really
>>> does no longer exist.
>>
>> You mean that they *intend to* cover? smp_read_barrier_depends never appears
>> in the text, so anyone reading this section without prior knowledge has no
>> way of realizing that this is what the sections are talking about.
> 
> It also doesn't appear in the kernel anymore.
> 
>> On the other hand the implicit address dependency barriers that do exist are
>> mentioned in the text. And that part is still true.
> 
> And this relevant discussion is moving to rcu_dereference.rst, and the
> current text is just for people who read memory-barriers.txt some time
> back and are expecting to find the same information in the same place.
> 
> So if there are things that rcu_dereference.rst is missing, they do
> need to be added.

As far as I can see, there is no mention of "address dependency"
in rcu_dereference.rst.
Yes, I see the discussion in rcu_dereference.rst is all about how
not to break address dependency by proper uses of rcu_dereference()
and its friends.  But that might not be obvious for readers who
followed the references placed in memory-barriers.txt.

Using the term "address dependency" somewhere in rcu_dereference.rst
should help such readers, I guess.

[...]
>>
>> Thanks for the response, I started thinking my mails aren't getting through
>> again.

Jonas, FWIW, your email archived at

    https://lore.kernel.org/linux-doc/1c731fdc-9383-21f2-b2d0-2c879b382687@huaweicloud.com/

didn't reach my gmail inbox.  I looked for it in the spam folder,
but couldn't find it there either.

Your first reply on Oct 6, which is archived at

    https://lore.kernel.org/linux-doc/4110a58a-8db5-57c4-2f5a-e09ee054baaa@huaweicloud.com/

ended up in my spam folder.

I have no idea why gmail has trouble with your emails so often ...

Anyway, LKML did accept your mails this time.

HTH,
        Akira
    

