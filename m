Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E965B9EA4
	for <lists+linux-arch@lfdr.de>; Thu, 15 Sep 2022 17:21:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiIOPVs (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 15 Sep 2022 11:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiIOPVK (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 15 Sep 2022 11:21:10 -0400
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58A1A9F8F5;
        Thu, 15 Sep 2022 08:16:49 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id A87445802F7;
        Thu, 15 Sep 2022 11:16:46 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Thu, 15 Sep 2022 11:16:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1663255006; x=1663258606; bh=iyfcgLT49L
        WSRff5Kts3C38d2554ZyUqP/64q59S5es=; b=W4TR4q+Dd0PqyZ/30nmu36Fr7i
        TSksvzLjmVIjZ+CSNgQdnADbEKSPqivzfMvKx6Bod07yFXxuIJVr2oz7v02ed130
        8znPURVzseoVO3T/aUfoRUcV6M6x8VXtVG84PvMfX25FxRDv94nw9VdLu1U3tJLp
        UGKIA0TIidS5y1QxDVjpTP2bzsMnz/ElL+N9QT0dWnvrZUoYw8u0aceIjKvuXVUF
        ZTzJeCuiv+BbF0j9uhkK0UcZeVRoCUP89Wl6xcqbfXq6sCcZNpvFoKUjEMkcUxW0
        ebz+nEmLHkObmKDmG/cfXcdPA8Q8z5h/TFBEnwDQ3zUWyFDS4lgHqOC1YGOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1663255006; x=1663258606; bh=iyfcgLT49LWSRff5Kts3C38d2554
        ZyUqP/64q59S5es=; b=DXOEfnQrCvp+dWZ0aS1+kLO+aXvqp4oHRwqiR0UJJsbu
        WRyMDwQHtJrMvHpObfPrH6rWG2+mawyUyQiLS2PVYGZgB9VM8f51Zj89U96w6jFt
        IfK23yDXab185lAGsbSZc8yeAohlhNk9jhUqLkQNPeOVRnOBSjmQJtYspfiPsEmr
        DdDte64EyF8l98PljFHTKn/NcgM863PfO0VACcWybNQ4Vl+wHJfV1Qen8XOPQC6X
        XDZDKX5Qs2f4wg6QH1YUAZdvhYDkB6TSOjH23pYoevULaLPr9waNuSA9O34Vd2pR
        CEQH3L0uN6fNpir/k7x1r5vRKq3zjPRxwZAqsgaFJA==
X-ME-Sender: <xms:3UEjY09qQYbq2GKMLRt7VQKM6kdkLzSrgY6lrcp4POVR68WGZRX5wQ>
    <xme:3UEjY8tZJ7rpdhsu7Q_zlAhEABhEzexTXM5ZH7d0sYEredBiBBGiI8Agk7ySdreys
    yc-0KMmIwFKk7G9wOk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedukedgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvffutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffgeffuddtvdehffefleethfejjeegvdelffejieegueetledvtedtudelgfdu
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:3UEjY6D18WUTQxnHEpy3Lbd6vBH6lKBQJANfA0EBFD21gaJlfPHvSQ>
    <xmx:3UEjY0fBFj8fliwQPArf20JI9bQ-a9c9_AdV7SyiA4TbN-eiwNCKcA>
    <xmx:3UEjY5PZDUo3q16ogJEDGuALwDQnK7E5lTllcoBOA2e6hp8xgx431A>
    <xmx:3kEjY6sqpQ6DgGZds5TQPZPEA4soUV9HpsQXsLzBUFoqyZUIqc8gAA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1CE8CB60086; Thu, 15 Sep 2022 11:16:45 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-935-ge4ccd4c47b-fm-20220914.001-ge4ccd4c4
Mime-Version: 1.0
Message-Id: <a8ee97f5-b92f-47a6-9b50-197974738ff7@www.fastmail.com>
In-Reply-To: <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20220915050106.650813-1-parav@nvidia.com>
 <96457b14-e196-4f29-be9a-7fa25ac805d9@www.fastmail.com>
 <PH0PR12MB5481192DB7B5C6E19683D514DC499@PH0PR12MB5481.namprd12.prod.outlook.com>
Date:   Thu, 15 Sep 2022 17:16:24 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Parav Pandit" <parav@nvidia.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "parri.andrea@gmail.com" <parri.andrea@gmail.com>,
        "Will Deacon" <will@kernel.org>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "boqun.feng@gmail.com" <boqun.feng@gmail.com>,
        "Nicholas Piggin" <npiggin@gmail.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "j.alglave@ucl.ac.uk" <j.alglave@ucl.ac.uk>,
        "luc.maranget@inria.fr" <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "akiyks@gmail.com" <akiyks@gmail.com>,
        "Dan Lustig" <dlustig@nvidia.com>,
        "joel@joelfernandes.org" <joel@joelfernandes.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH] locking/memory-barriers.txt: Improve documentation for writel()
 usage
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Sep 15, 2022, at 4:18 PM, Parav Pandit wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> Sent: Thursday, September 15, 2022 8:38 AM
>> 
>> On Thu, Sep 15, 2022, at 7:01 AM, Parav Pandit wrote:
>> > The cited commit [1] describes that when using writel(), explcit wmb()
>> > is not needed. However, it should have said that dma_wmb() is not
>> > needed.
>> 
>> Are you sure? As I understand it, the dma_wmb() only serializes a set of
>> memory accesses, but does not serialized against an MMIO access, which
>> depending on the CPU architecture may require a different type of barrier.
>> 
>> E.g. on arm, writel() uses __iowmb(), which like wmb() is defined as "dsb(x);
>> arm_heavy_mb();", while dma_wmb() is a "dmb(oshst)".
>
> You are right, on arm heavy barrier dsb() is needed, while on arm64, 
> dmb(oshst) is sufficient.
>
> So more accurate documentation is to say that 
> 'when using writel() a prior IO barrier is not needed ...'
>
> How about that?

That's probably fine, not sure if it's worth changing.

> It started with my cleanup efforts to two drivers [1] and [2] that had 
> difficulty in using writel() on 32-bit system, and it ended up open 
> coding writel() as wmb() + mlx5_write64().
>
> I am cleaning up the repetitive pattern of, 
> wmb();
> mlx5_write64()
>
> Before I fix drivers, I thought to improve the documentation that I can 
> follow. :)

Right, that is definitely a good idea.

I see that there is more going on with that function, at least
the loop in post_send_nop() probably just wants to use
__iowrite64_copy(), but that also has no barrier in it, while
changing mlx5_write64() to use iowrite64be() or similar would
of course add excessive barriers inside of the loop.

       Arnd
