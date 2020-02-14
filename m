Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABD515FACB
	for <lists+linux-arch@lfdr.de>; Sat, 15 Feb 2020 00:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgBNXjg (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 14 Feb 2020 18:39:36 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:41088 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728508AbgBNXjg (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 14 Feb 2020 18:39:36 -0500
Received: by mail-qt1-f194.google.com with SMTP id l21so8129944qtr.8;
        Fri, 14 Feb 2020 15:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hoAgCZmN1XpQfzhP7Qb2SDiMGckSqZQxEo33rnXwsdw=;
        b=GiyfG6xCNJtKMIsMrJ0JETDXBBAyOPTCbu/OraMznyUx6FTbJL+P5TOaGb7l8oGWQI
         SXSFn7JcHaSQ+vy8eBzE4Mk1XvnK5pyxO8EhfqvyDtxqihB62wMHfVyjlvTk5MVx8bnY
         EX6Jj55YMmfZXjLqb5KrFLzySRLvkr9LEVTIWpaePjmwccaAjQrH7IW8DU7MBSbSP++J
         dC79e6C+6QcDHEsLoyYbxOBvy7eaYgtHwbzWsfAuD3K2SjMp6CMepOigSXJ0B3NvuwdK
         xYvr/IsSW2s26mQHEC/nhHB/fY21FhfJpwjQGNROMOhHeuO7ZXDzllp0GSVRfiZHacO1
         oMQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hoAgCZmN1XpQfzhP7Qb2SDiMGckSqZQxEo33rnXwsdw=;
        b=ozlqRrbo+kXz6ktM8AfcqR5uv359gfhI3Fvc0fx7Y3lRDToe3ytdu9jyCPZcv2uNJG
         +8MBJAYoSuYWtXVN4w8kKcYoOg0yHwB4wD76w/mJm7/OgHeN2KNaYEavHvIxLG3oGlUn
         4N+5rhmmif4SVzSIzxkkdwyDFoXG6oSlk76ybTFSIdhbxLCaV3tGbr5M7/wv2xNPQUre
         unuqxhIy0c4XoOBcSqvTNkOT+GXRhmHTcyfbg1QF3GHAyOrX7NbHL1nNbMYvmvm9WEkk
         wMgxasaRbTOQ0W6QnktuDXyILjH2S7NoWS60KW/Gp3rrJ7UpwNQ79+1vNNPvBFEAInC8
         lB1A==
X-Gm-Message-State: APjAAAV8vYX0g0JfaBZ0Mdr79JKjn3S5rkpmNavXPzYGDDaLgcrKguzk
        atkGdUt1SoE9J8wfOXJD0ao=
X-Google-Smtp-Source: APXvYqx3BeiZdYbFqiqZThJjhFru01Fhwt+njOg1zUCcKoBB9diaS5ss3OTQymFFbGM+iSitXjNXOw==
X-Received: by 2002:ac8:7309:: with SMTP id x9mr4693926qto.338.1581723575009;
        Fri, 14 Feb 2020 15:39:35 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id o55sm4442553qtf.46.2020.02.14.15.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Feb 2020 15:39:34 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 7471121B62;
        Fri, 14 Feb 2020 18:39:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Feb 2020 18:39:33 -0500
X-ME-Sender: <xms:qy9HXqD7S2_2ZqlYI8eRO9_2pY3jghDRdk8hpj5jZQH-xaS5wqZ_xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjedugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgnecukfhppeehvddrudehhedrudduuddrjedunecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvsh
    hmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheeh
    vddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qy9HXhIviJvlUbTmxaxaQJVvEi3fKVyQeb0RKrzp9lPKCoMYFmfE9Q>
    <xmx:qy9HXj-c_jflPjxVhRRBHFJJRtbhyklgy84Lc_ZKoiH-Msso6xSfDQ>
    <xmx:qy9HXiq3aiESJx3K282WRdsyeyhNprRm-zdquoue6IfvbfgUKUgR1A>
    <xmx:tS9HXm67rBD3WFnBqJcgx0XxstMh1eLdFKLsOBmDDscaGE_zwwCLvUS2b5c>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id D4D7A30606E9;
        Fri, 14 Feb 2020 18:39:22 -0500 (EST)
Date:   Sat, 15 Feb 2020 07:39:21 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Message-ID: <20200214233921.GA110915@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> On Fri, 14 Feb 2020, Boqun Feng wrote:
> 
> > A recent discussion raises up the requirement for having test cases for
> > atomic APIs:
> > 
> > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > 
> > , and since we already have a way to generate a test module from a
> > litmus test with klitmus[1]. It makes sense that we add more litmus
> > tests for atomic APIs into memory-model.
> 
> It might be worth discussing this point a little more fully.  The 

I'm open to any suggestion, and ...

> set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> limited.  Paul has a vastly more expansive set of litmus tests in a 

I'm OK if we want to limit the number of litmus tests in
tools/memory-model/litmus-tests directory. But ...

> GitHub repository, and I am doubtful about how many new tests we want 
> to keep in the kernel source.
> 

I think we all agree we want to use litmus tests as much as possbile for
discussing locking/parallel programming/memory model related problems,
right? This is benefical for both kernel and the herd tool, as they can
improve each other.

Atomic APIs (perhaps even {READ,WRITE}_ONCE(), smp_load_acquire() and
smp_store_release()) have been longing for some more concrete examples
as a complement for the semantics description in the docs, so that
people can check their understandings. Further, with the help of
klitmus, the litmus tests can be a useful tool for testing if a new arch
support is added to kernel. That's why I plan to add litmus tests into
kernel source.

Thoughts?

Regards,
Boqun

> Perhaps it makes sense to have tests corresponding to all the examples
> in Documentation/, perhaps not.  How do people feel about this?
> 
> Alan
> 
