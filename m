Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10692432A90
	for <lists+linux-arch@lfdr.de>; Tue, 19 Oct 2021 01:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbhJRX7I (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 Oct 2021 19:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229524AbhJRX7H (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 18 Oct 2021 19:59:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06478C06161C;
        Mon, 18 Oct 2021 16:56:56 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id y17so16665550ilb.9;
        Mon, 18 Oct 2021 16:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=e4lJzHCjbL40UuRVMeLU7XO3siB1JTUtpasDRh5RGfw=;
        b=AfBGmzCg2COIbh27/ujvvW1HWgDzIC2G7kud2uh1zxpkBNrR6L2ErQMwCdCAE7AWBP
         TxSWIhFeynU5SVeONkVP1Cy5pwo/MHgq4RnlZgAsDREqFwy4KGsXdd4LB+U1SGD+NXCZ
         vvlh/LNxpM5xo6LZ76zsgZn+6s5oTH+If7e+5z5j7BrdTrVmz8ahYvGCCY4RJMn4fJV2
         UJc/O3z8ipThB+XaDo6bHzTLnhPb7qOrlGOUz0wD+HSe04kkZrjGIvno5TVGuVDBPnOC
         JKPL9bt3eCqN/nosuACMBlEGBvrVV7X5g7cImeiKQWvWJB2jRAQ/0AD+6XGyqVtEicTN
         XPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=e4lJzHCjbL40UuRVMeLU7XO3siB1JTUtpasDRh5RGfw=;
        b=IYT7nzYUH52DR7Bnj7T8Z5tbJ2u05tGLgsgLwNBwvSkhkEDcFFlC5pwZPWHtAhgoDH
         8y0X2Jc1IUCC5eol0QDu8hAgDYEz1RlZIDmVmyrsnNx2HycXPyDQ4dAFQyPWYGlTtg2b
         Sl21BRL6cfNPUcSDmZxrCo1ZQ0IEjTl111imOJuuIUZoH2uyZf4e1HoLLgAgOlX4Htd3
         YH06iO/iuklwmdzNMSpm9myJX7ezGofd46hWKAXQpCGMuTf/ABcV20ciQyAaEnCVfLfv
         LyXDKSxU2iMyWLnJFvXTjJBxIqc08KV/+dp4a2J85c/2x/uOq4qygWBaj5/VoerH9j+a
         7eVg==
X-Gm-Message-State: AOAM532EJBTxsa5MtQ0hlQj3o/jfcvNw1zz+sCHHaE4AVplfH7KTVqeD
        +IFZRI7BhMh7MlbVP45LaNk=
X-Google-Smtp-Source: ABdhPJwIA9peed1smVJcMA1U9/fCsc8L6bk4gnlCnxyCfy37JHBhG2qtvAPBCRMliaSDUsJ2E3g4Uw==
X-Received: by 2002:a05:6e02:1be8:: with SMTP id y8mr16115123ilv.24.1634601415443;
        Mon, 18 Oct 2021 16:56:55 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w15sm7952553ill.23.2021.10.18.16.56.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 16:56:54 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9A57227C0054;
        Mon, 18 Oct 2021 19:56:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 18 Oct 2021 19:56:53 -0400
X-ME-Sender: <xms:xQluYdKKD93ED5qelCrZDbDn4blifi7e4UBNB7BTLHhzdRF4CJjK4A>
    <xme:xQluYZLj5HNFNSOFslzt0Bgh5SagwqHJLGnbK9fu8cM3MaQ0tLEdAc1Z5rjWLWH-S
    emlZacDqZy0fHeX8g>
X-ME-Received: <xmr:xQluYVtp4lp0D8NHKlLAYW_lTKD6WhmsSnbPlBiiogl5ppoBnl9XvnnYqgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrvddvuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepfffhvffukfhfgggtuggj
    sehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvg
    hnghesghhmrghilhdrtghomheqnecuggftrfgrthhtvghrnheptdegueevjedufffgvefg
    udefkeevvdejjeeiheduhfelgffhueeitdejueffvefhnecuffhomhgrihhnpehlihhvvg
    hjohhurhhnrghlrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehm
    rghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthi
    dqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghi
    lhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:xQluYeYJ1mtb52ZH92td-36wwE3KTqm0IO4MNLRy1Yu3wI5FpJiMrw>
    <xmx:xQluYUafUgfMSDSAUvNkrz6W8UWauWHz2_8YI7WVt5YEtGevBzUVKg>
    <xmx:xQluYSBRtWLKtUDM-_hLQvls2WGI5C5eRfjfi1yTFxa2oJF5Xgj0uA>
    <xmx:xQluYUpf0Vd713puZyEaNxbvgTByBz0J9aNmeBnb5j9o_W11tkb2lHmqCCg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 18 Oct 2021 19:56:52 -0400 (EDT)
Date:   Tue, 19 Oct 2021 07:56:35 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: Another possible use for LKMM, or a subset (strengthening)
 thereof
Message-ID: <YW4Jsw2y4BWTH5YS@boqun-archlinux>
References: <20211007205621.GA584182@paulmck-ThinkPad-P17-Gen-1>
 <20211018225313.GA855976@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211018225313.GA855976@paulmck-ThinkPad-P17-Gen-1>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

Hi Paul,

On Mon, Oct 18, 2021 at 03:53:13PM -0700, Paul E. McKenney wrote:
> On Thu, Oct 07, 2021 at 01:56:21PM -0700, Paul E. McKenney wrote:
> > Hello!
> > 
> > On the perhaps unlikely chance that this is new news of interest...
> > 
> > I have finally prototyped the full "So You Want to Rust the Linux
> > Kernel?" series (as in marked "under construction").
> > 
> > https://paulmck.livejournal.com/62436.html
> 
> And this blog series is now proclaimed to be feature complete.
> 
> Recommendations (both short- and long-term) may be found in the last post,
> "TL;DR: Memory-Model Recommendations for Rusting the Linux Kernel",
> at https://paulmck.livejournal.com/65341.html.
> 

Thanks for putting this together! For the short-term recommendations, I
think one practical goal would be having the equivalent (or stronger)
litmus tests in Rust for the ones in tools/memory-model/litmus-tests.
The translation of litmus tests may be trivial, but it at least ensure
us that Rust can support the existing patterns widely used in Linux
kernel. Of course, the Rust litmus tests don't have to be able to run
with herd, we just need some code snippest to check our understanding of
Rust memory model. ;-)

Besides, it's interesting to how things react with each if one function
in the litmus test is in Rust and the other is in C ;-) Maybe this is a
long-term goal.

Thoughts?

Regards,
Boqun

> Thoughts?
> 
> 							Thanx, Paul
