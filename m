Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6614432BC5
	for <lists+linux-arch@lfdr.de>; Tue, 19 Oct 2021 04:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbhJSCai (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 22:30:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbhJSCai (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 22:30:38 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118DEC06161C;
        Mon, 18 Oct 2021 19:28:26 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id e144so18670088iof.3;
        Mon, 18 Oct 2021 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MYTy8qhFIbvvo8k/hrkOVgzbZyPvP4OJ7aoxYjQBFn8=;
        b=PVu2oSy/RAVs6uQUP1My29HbWLJJi/TeANy9CRMEgehcJRhZTQ0JPEJVLvxrThf54a
         VHmQKOOGj2NrNEAMQYHJciq8KxdosodPNpu5vHgdZWECrFUzOywjmoXKvBYrCuZHlAn9
         J5YiW1IIWt1K65YT2fEpvGQwAL25gnmKAfoNIFF0MpuItSB4/14or+Bv/0fl6AqjeP4l
         dv73hM2+EBZT4/CJM64xlPYc9XLxGYYUVePvM2pbZDty3wbTWf9zFO1YTcmqZ4bs/vLp
         mWro741NqtulTli3cIU/+Ti1DDMiXPrAl63InQrBsT9mobiMjCJhNzlUSROpapEVOOdJ
         S7Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MYTy8qhFIbvvo8k/hrkOVgzbZyPvP4OJ7aoxYjQBFn8=;
        b=YXR/H+gvTcNLhnT1UlrkMdCryZMlrog1VQjco6fcZo0HuZ5fNO9YPfpU/UzrI1r2/5
         wcBJvwIWZF9zNCRDl1nt18wZ357C5dcG1pW0H4YH8hJvBWZ6D8m+ItxGqsbrfVW6F0wj
         jDAmRWh6FcANkyLZ6HjFr0XFx73kxkOtMl7UnHYjtk3si0zFS1VSlGNVnKltYfaJzbMH
         VpnTlUSxTN4Zw3athy5HBGZRDOSy72FJa6TSeIPqpdMmojJB0+b+iFVOsAPcHEN4fphS
         EWW0fGifUGNDthYaQ6IwANGF1lB8kieziPw1Ej1ZWQ8pOYwMh1oRa0Uqyr8l0y8uqPK2
         k5jA==
X-Gm-Message-State: AOAM531RtxJMcvyye8js8+aE9EZxgPSvpX55PI7zRKH5GsSbaFN+B80u
        OvOcm6gHlUuy98gIHmxvdwM=
X-Google-Smtp-Source: ABdhPJwvPv2pN1MPnRzQKXUrjBbIjVusvKIV66N5vHPdtwSU+54TIhe2N2JtP+vtUataKmuWYMk2Jg==
X-Received: by 2002:a05:6638:1924:: with SMTP id p36mr2281425jal.142.1634610505273;
        Mon, 18 Oct 2021 19:28:25 -0700 (PDT)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t12sm7653286ilp.43.2021.10.18.19.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 19:28:24 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id E50E527C0054;
        Mon, 18 Oct 2021 22:28:22 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 18 Oct 2021 22:28:22 -0400
X-ME-Sender: <xms:Ri1uYTzyKM6MFOR8dd-quACnmPxfbDpWA2APnQr_2Pdqjza8i-cdWQ>
    <xme:Ri1uYbQnVzDMowI3MWOJ3DBYj3xk7JwztVd_V3FK3CckyYD3VkAPompZKvj9PUDY3
    6cuC9PjE3ugtKBagw>
X-ME-Received: <xmr:Ri1uYdX3F4xZDFSUx_ngmZWMbMPw69uBPE4b_vr1voPMTT0QzTNhYO4ZUx4ejw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvuddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvg
    hnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnhephfelledtkeeliedtgedt
    gfdtjeejgeelgfeltdevkeegueehvddtgfeutefhfffgnecuffhomhgrihhnpehlihhvvg
    hjohhurhhnrghlrdgtohhmpdhgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigv
    pedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthh
    hpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhn
    rdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:Ri1uYdhPHaKJR7BHujYqQnIVxLtEupoy7ARRUxaD7ltI5I51kpl7CA>
    <xmx:Ri1uYVDTmoMUZD-rLjzERmdkkBnJwbck6zApBuhC7mi2vHOPBL9Ndg>
    <xmx:Ri1uYWJ1bNFgVKuUJ6-IEkkE76gq7XPwZiIwYVWbzxGkBzHG9bkZtg>
    <xmx:Ri1uYdy6RLDWzQdoo7IJODJtoB9C0gQLvX0ZRE-rQMq8PjYxGxzKdujvVpA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 22:28:22 -0400 (EDT)
Date:   Tue, 19 Oct 2021 10:28:04 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Another possible use for LKMM, or a subset (strengthening)
 thereof
Message-ID: <YW4tNHz42/EbAdHM@boqun-archlinux>
References: <20211007205621.GA584182@paulmck-ThinkPad-P17-Gen-1>
 <20211018225313.GA855976@paulmck-ThinkPad-P17-Gen-1>
 <YW4Jsw2y4BWTH5YS@boqun-archlinux>
 <20211019000729.GY880162@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019000729.GY880162@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Oct 18, 2021 at 05:07:29PM -0700, Paul E. McKenney wrote:
> On Tue, Oct 19, 2021 at 07:56:35AM +0800, Boqun Feng wrote:
> > Hi Paul,
> > 
> > On Mon, Oct 18, 2021 at 03:53:13PM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 07, 2021 at 01:56:21PM -0700, Paul E. McKenney wrote:
> > > > Hello!
> > > > 
> > > > On the perhaps unlikely chance that this is new news of interest...
> > > > 
> > > > I have finally prototyped the full "So You Want to Rust the Linux
> > > > Kernel?" series (as in marked "under construction").
> > > > 
> > > > https://paulmck.livejournal.com/62436.html
> > > 
> > > And this blog series is now proclaimed to be feature complete.
> > > 
> > > Recommendations (both short- and long-term) may be found in the last post,
> > > "TL;DR: Memory-Model Recommendations for Rusting the Linux Kernel",
> > > at https://paulmck.livejournal.com/65341.html.
> > 
> > Thanks for putting this together! For the short-term recommendations, I
> > think one practical goal would be having the equivalent (or stronger)
> > litmus tests in Rust for the ones in tools/memory-model/litmus-tests.
> > The translation of litmus tests may be trivial, but it at least ensure
> > us that Rust can support the existing patterns widely used in Linux
> > kernel. Of course, the Rust litmus tests don't have to be able to run
> > with herd, we just need some code snippest to check our understanding of
> > Rust memory model. ;-)
> 
> It would be very helpful for klitmus to be able to check Rust-code memory
> ordering, now that you mention it!  This would be useful (for example)
> to test the Rust wrappers on weakly ordered systems, such as ARM's.
> 

Right.

> > Besides, it's interesting to how things react with each if one function
> > in the litmus test is in Rust and the other is in C ;-) Maybe this is a
> > long-term goal.
> > 
> > Thoughts?
> 
> These issues are quite important.  How do you feel that they should be
> tracked?
> 

Yep, it's already in my list. I created a small repo to track all issues
I know about LKMM for Rust:

	https://github.com/fbq/lkmm-for-rust

It's still under construction, but I put the litmus test thing in that
list.

Regards,
Boqun

> 							Thanx, Paul
