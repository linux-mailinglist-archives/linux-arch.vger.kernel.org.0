Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 459E860207B
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 03:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJRBhd (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 17 Oct 2022 21:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbiJRBhd (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 17 Oct 2022 21:37:33 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBC703E74D;
        Mon, 17 Oct 2022 18:37:31 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id n83so14098814oif.11;
        Mon, 17 Oct 2022 18:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lWnmh28h2aLsD/0ANNQ/ycG5csRGVfEzVy619u1CtWY=;
        b=Q3wgAW6pcf7gEFMG4xEiC7GUskXqWVEz/48HOdsA4QO6rHGXIqYyoMImvJ6OfTY8Sm
         xTQGtW2+MviyEAtTzMbAf0sxbolFd/rJVWavp1dNWDYUxeI6ca+XTlIHXwRqFedIEpn2
         rLzQdNB585dqPE5SHxocV+w0EfTkr8tHhZF0TN2dIRdU1Qji1q4LBkaNSNVPsqxFV5eH
         itGgOs+b/YJwM1wajxX33DYuAiVYQuZwJurPsD3461hLF9z4yZ1MMXGBWeNwLxp37lG9
         7iA1iwIBi83qJ5UeLeOuiaYUo1iSKbd8vvvAoNDO1mwm2iDjd0WsvxUEE/zzEGR+NfLq
         BLzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:cc:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lWnmh28h2aLsD/0ANNQ/ycG5csRGVfEzVy619u1CtWY=;
        b=TD38xYBXNrd8lje7jnoUbynuhXx/aJ7MyJB6fC+mcNuPJ4J+w9pPWMdt1TgT+/NJn6
         mGO6BGgxl+5k/0cCTLKGQqlfxEtaX6oxdBUePPUGXfus3Y1I3eQNSAmDYbdH8tf5gr1t
         2LDmVj/X6h5cUhqn6zT4Ut8EMvem/o8Fu5mTarwqS8f/xPMkOBevNhX6eK9y0v1STvFz
         RkMJZpFHAeqAV3HR7q9pjH1zliinNz7gffsU4NoAjXHi9/UGkwEzLfFmVQrfIMwbHFqT
         CKOkprAm9GTID3RAhQdnda2NDY3nDh6DgiDz5EviRe/ZBvS8vDxtYosQatWmhoEHKnsh
         CPnQ==
X-Gm-Message-State: ACrzQf04MklsXVe2sorxd0uV1l3hrZ+nkckBWq7lMB6B3WJTVHCIshhi
        Oi/ZJrZRVq5SFKiDgefbwKvhfocWSzSYFQ==
X-Google-Smtp-Source: AMsMyM62lbFLtDgzWB25hcG6uvhkrNNyTTE3T3CWrlaD/HteSNE/hKzTuFzt0r1qwSs2qj2fvvGqoQ==
X-Received: by 2002:a17:90b:4a09:b0:20d:5b67:1496 with SMTP id kk9-20020a17090b4a0900b0020d5b671496mr35679427pjb.67.1666057041099;
        Mon, 17 Oct 2022 18:37:21 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id f15-20020a17090a664f00b0020d3662cc77sm10019417pjm.48.2022.10.17.18.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Oct 2022 18:37:20 -0700 (PDT)
Message-ID: <59d99be6-f79e-45bd-203c-17972255cc39@gmail.com>
Date:   Tue, 18 Oct 2022 10:37:15 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation for
 writel() example
To:     Arnd Bergmann <arnd@arndb.de>, Parav Pandit <parav@nvidia.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
Content-Language: en-US
Cc:     bagasdotme@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        parri.andrea@gmail.com, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>, dlustig@nvidia.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On 2022/10/18 5:55, Arnd Bergmann wrote:
> On Mon, Oct 10, 2022, at 12:13 PM, Parav Pandit wrote:
>> The cited commit describes that when using writel(), explcit wmb()
>> is not needed. wmb() is an expensive barrier. writel() uses the needed
>> platform specific barrier instead of expensive wmb().
>>
>> Hence update the example to be more accurate that matches the current
>> implementation.
>>
>> commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. 
>> MMIO ordering example")
>>
>> Signed-off-by: Parav Pandit <parav@nvidia.com>
> 
> I have no objections, though I still don't see a real need to change
> the wording here.

Parav, I think you need a full rewrite of the Changelog as the change
has become a simple substitution of s/wmb()/barrier/.

In second thought, I'm not sure such a substitution is really safe to
make.

"a barrier" can mean "any barrier", which can include a full barrier
in theory.

So I'd rather make the substituted text read something like:

  Note that, when using writel(), a prior wmb() or weaker is not
  needed to guarantee that the cache coherent memory writes have
  completed before writing to the MMIO region.

In my opinion, "or weaker" is redundant for careful readers who are
well aware of context of this example, but won't do no harm.

Thoughts?

        Thanks, Akira

> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
