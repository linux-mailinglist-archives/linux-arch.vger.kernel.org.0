Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168CA602628
	for <lists+linux-arch@lfdr.de>; Tue, 18 Oct 2022 09:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbiJRHuL (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 18 Oct 2022 03:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbiJRHuC (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 18 Oct 2022 03:50:02 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AF06647EC;
        Tue, 18 Oct 2022 00:49:58 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 3057D320098D;
        Tue, 18 Oct 2022 03:49:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Tue, 18 Oct 2022 03:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666079395; x=1666165795; bh=7Md4CAXWfA
        GPDZDdUlTOak4LwDabEftkVgALiP8DKrE=; b=U74au7xDHzjDjkdszgXEg1cw/P
        rvdynF2GR+Je+9j0iT5jHUlBauKTF+zBFHsHwAaQgTgPXTO6g1lGP75xiKd5Y3iS
        I8vA98XaJzA+BjhSszgEPPRXVRP6dpl6+aznmFcXRp12ROq2Wzz6PJ363ob8ETWT
        x+fvGhtUYlJo1K0ltyzIzqYX7gn2PP8clotriYOEyLsfH+rhCYIMgQk9MzPoV8RT
        1ZxFXg5HSGfG7WCnS5L3VcnF8vLMgFpi7gA576sNZbCe+G8b3tveTLBp5X4zhwP4
        e2zBuodHzGq8se34I70JZP3WZSyFvTcG1ud5yLC6avr9yL+OuxA5a5BbQQbQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666079395; x=1666165795; bh=7Md4CAXWfAGPDZDdUlTOak4LwDab
        EftkVgALiP8DKrE=; b=Mbt5W75fgcE+L6232FNCIHzRDQHGFQqduTwF7BwEkAQW
        lJKIh0TlhFltcHN+t1N+ROURDqbxaxkW3kH/hU+nkGHvjJpejrtjuva+g34Ult7w
        sxwdXopO3VA9t+sOX64M+8ttitZQ2qNjUuSaWU4zdZzb/xtFgo8uRRivDVdgil9y
        ckIiCqMLcG/9FvWoh81ma9wBg1Q0/WHgZxCEtNFbvCb6bcL100ijB53ff1+UzuSs
        C6oYQcnub7d55Xa2JOMRFphdfvI2PM0xxWnLY7xI0CQSH299JWvA+zTb7Gif4gsv
        FpWhKNIwqCSH0fa49b/5vjS9Zx1mF6exdcQz3OB61Q==
X-ME-Sender: <xms:o1pOY2DgnGGxz7HLmlQfe3rzaiEPzexx-f64QVCwEBWTTEM_KuMsnA>
    <xme:o1pOYwjl1-G0YZAzgsaGF40BdU3OEL8JKiBhbB22Mf5nMl0uMe2EvVULowaM3ZKUu
    _wq9oCEpOFDK17bnYA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeeltddguddviecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedt
    keetffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:o1pOY5kMciv-8nx_F1AgfiZWtc75JfDfb76Wh9SYa-iDintbSugf5A>
    <xmx:o1pOY0w_0IbEEBzn3-Nym02WaUh5JDy0zSK9gH8okn6abrRiOe2vqQ>
    <xmx:o1pOY7T_3P0CBK65BDUnp8AbaZIEUGpwY82ImZ3rE_060cpHAMcYWA>
    <xmx:o1pOY8Ci9enz_xWGDml7nSw2oJU2GOoUQcKIAekmIgbdjS9jlEeF4A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 79AC6B60089; Tue, 18 Oct 2022 03:49:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <b88e4bd2-5c2e-430a-99f9-18cd43463fd6@app.fastmail.com>
In-Reply-To: <a91e8216-7767-9126-e1d2-c67846cf32fc@gmail.com>
References: <20221010101331.29942-1-parav@nvidia.com>
 <d5faaf6f-7de5-49b0-92d6-9989ffbdbf2e@app.fastmail.com>
 <59d99be6-f79e-45bd-203c-17972255cc39@gmail.com>
 <12f51033-1461-43f9-8d8d-cd726fbb4758@app.fastmail.com>
 <a91e8216-7767-9126-e1d2-c67846cf32fc@gmail.com>
Date:   Tue, 18 Oct 2022 09:49:34 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Akira Yokosawa" <akiyks@gmail.com>,
        "Parav Pandit" <parav@nvidia.com>
Cc:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Alan Stern" <stern@rowland.harvard.edu>, parri.andrea@gmail.com,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>, boqun.feng@gmail.com,
        "Nicholas Piggin" <npiggin@gmail.com>, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr,
        "Paul E. McKenney" <paulmck@kernel.org>, dlustig@nvidia.com,
        "Joel Fernandes" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>, linux-kernel@vger.kernel.org,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH v4] locking/memory-barriers.txt: Improve documentation for writel()
 example
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Oct 18, 2022, at 9:40 AM, Akira Yokosawa wrote:
> On Tue, 18 Oct 2022 08:44:09 +0200, Arnd Bergmann wrote:
>> 
>> Anything weaker than a full "wmb()" probably makes the driver calling
>> the writel() non-portable, so that is both vague and incorrect.
>
> Do you mean there is a writel() implementation somewhere in the kernel
> which doesn't guarantee an implicit wmb() before MMIO write?

There are lots of those, but that's not what I meant. E.g. on x86,
writel() does not imply a full wmb() but still guarantees serialization
between DMA and the register access.

> Or do you mean my version is confusing because it can imply a weaker
> write barrier is sufficient before writel_relaxed()?

That's what I meant, yes. On a lot of architectures, it is sufficient
to have something weaker than wmb() before writel_relaxed(), especially
on anything that defines writel_relaxed() to be the same as writel(),
any barrier would technically work. On arm32, using __iowmb() would be
sufficient, and this can be less than a full wmb() but again it's
obviously not portable. These details should not be needed in the
documentation.

      Arnd
