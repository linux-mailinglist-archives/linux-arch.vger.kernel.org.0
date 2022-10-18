Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C341602837
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 11:24:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJRJX7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 05:23:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiJRJX4 (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 05:23:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B53CFACA1D;
        Tue, 18 Oct 2022 02:23:45 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n7so13280286plp.1;
        Tue, 18 Oct 2022 02:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nt4xF0sF59aYzJb+0BGH2wGz8PUJGN3YQ/EwsiEsBo0=;
        b=SlJG+7ME4evT99t4F0lDdlNZvSFr4IGijCcaqz12H+hJ+ILxaIvJVbz2+3hDVtLR6Q
         1mOx2qKY5vYxhb6nANmJxtI1lGumEt6T73t7edZ9//f7cLa5FawR6rEZLELX6lEOIWoY
         gbYJ4EesUTRAYB0XPUOUl/TuujyQ56gu8CbyP1/nQRw1R0xwph6Iz/APBghItkfr80hh
         mwYWsIGrqBq2n/2r6Tni6AdliHQOylTKnhMbjajQ4knJh3W5N4AHVTnDM5AgPSrvAcYj
         TMZYitv+Gv4j3tMgWOZwrHGzX400GwTdVflF92nGMvSbEGIEk68PWKSrlBNQozJQEdpB
         ON7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nt4xF0sF59aYzJb+0BGH2wGz8PUJGN3YQ/EwsiEsBo0=;
        b=G4qPm7aMHzASjSQAPl5xKFgQkaG3Y+SUwpc6xfyt2kkZthpgBtf9wVsHi6pYul4JCU
         o6eN9ZQ+Sae2VtZbVUU1F+liii7MYbZf6aJ93dSmkbjZSu470ksYGpTf50IoyyuV2z8w
         CeQjn0zjNvBgM2HG/Z82iWG7ymwt/R4j8a3zRcgzKVr+SgtueaTPI/hFXg5NjNr3F82Y
         +Hkpq1mFU6Ub/y8Y67zC5sNpyORElcO1bJSND+M75bkG9CwdHzH67UoL/Oacq/T4LYsN
         24wgwnM2paQp8viO4FSbjc1JBYsBnfLnzpV9IjRyYxaH4+SO6RThw/Q7iZ17OYldunHy
         OieQ==
X-Gm-Message-State: ACrzQf3t84/DlRDIKNF8HuC54Islgmo/Gb5A1HEc+wNVi18fDNTFycgF
        j6h86DrhhmYMu02RdBo74mI=
X-Google-Smtp-Source: AMsMyM6K9TlFn90QXRWI2S9Cu2nds2zQSAAmn9ap7qNVJ0hA4fS6U3GPKqONoT6Y63C/tkPU85KOCQ==
X-Received: by 2002:a17:90b:4d05:b0:202:ec78:9d73 with SMTP id mw5-20020a17090b4d0500b00202ec789d73mr2506378pjb.103.1666085025186;
        Tue, 18 Oct 2022 02:23:45 -0700 (PDT)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id l8-20020a170903120800b0016c09a0ef87sm8247438plh.255.2022.10.18.02.23.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 02:23:44 -0700 (PDT)
Message-ID: <a9c64b36-9770-1198-7958-3d66b98737c1@gmail.com>
Date:   Tue, 18 Oct 2022 18:23:39 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation for
 writel() example
To:     Arnd Bergmann <arnd@arndb.de>, Parav Pandit <parav@nvidia.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, boqun.feng@gmail.com,
        Nicholas Piggin <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>, dlustig@nvidia.com,
        Joel Fernandes <joel@joelfernandes.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org, Akira Yokosawa <akiyks@gmail.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <59d99be6-f79e-45bd-203c-17972255cc39@gmail.com>
 <12f51033-1461-43f9-8d8d-cd726fbb4758@app.fastmail.com>
 <a91e8216-7767-9126-e1d2-c67846cf32fc@gmail.com>
 <b88e4bd2-5c2e-430a-99f9-18cd43463fd6@app.fastmail.com>
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <b88e4bd2-5c2e-430a-99f9-18cd43463fd6@app.fastmail.com>
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

On Tue, 18 Oct 2022 09:49:34 +0200, Arnd Bergmann wrote:
> On Tue, Oct 18, 2022, at 9:40 AM, Akira Yokosawa wrote:
>> On Tue, 18 Oct 2022 08:44:09 +0200, Arnd Bergmann wrote:
>>>
>>> Anything weaker than a full "wmb()" probably makes the driver calling
>>> the writel() non-portable, so that is both vague and incorrect.
>>
>> Do you mean there is a writel() implementation somewhere in the kernel
>> which doesn't guarantee an implicit wmb() before MMIO write?
> 
> There are lots of those, but that's not what I meant. E.g. on x86,
> writel() does not imply a full wmb() but still guarantees serialization
> between DMA and the register access.
> 
>> Or do you mean my version is confusing because it can imply a weaker
>> write barrier is sufficient before writel_relaxed()?
> 
> That's what I meant, yes. On a lot of architectures, it is sufficient
> to have something weaker than wmb() before writel_relaxed(), especially
> on anything that defines writel_relaxed() to be the same as writel(),
> any barrier would technically work. On arm32, using __iowmb() would be
> sufficient, and this can be less than a full wmb() but again it's
> obviously not portable. These details should not be needed in the
> documentation.
Thanks for the clarification.

I think I was confused by the current wording.
I might be wrong, but I guess Parav's motivation of this change was
to prevent this kind of confusion from the first place.

Parav, may I suggest a reworked changelog? :

    The cited commit describes that when using writel(), explcit wmb()
    is not needed. However, wmb() can be an expensive barrier depending
    on platforms. Arch-specific writel() can use a platform-specific
    weaker barrier needed for the guarantee mentioned in section "KERNEL
    I/O BARRIER EFFECTS".

    Current wording of:
        Note that, when using writel(), a prior wmb() is not needed
        to guarantee that the cache coherent memory writes have completed
        before writing to the MMIO region.

    is confusing because it can be interpreted that writel() always has
    a barrier equivalent to the heavy-weight wmb(), which is not the case.

    Hence stop mentioning wmb() and just call "a prior barrier" in the
    notice.

    commit 5846581e3563 ("locking/memory-barriers.txt: Fix broken DMA vs. MMIO ordering example")

Am I still missing something?

        Thanks, Akira

> 
>       Arnd
