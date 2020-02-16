Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC101601E9
	for <lists+linux-arch@lfdr.de>; Sun, 16 Feb 2020 06:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725951AbgBPFnv (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 00:43:51 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:42329 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725858AbgBPFnv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Feb 2020 00:43:51 -0500
Received: by mail-qv1-f66.google.com with SMTP id dc14so6217047qvb.9;
        Sat, 15 Feb 2020 21:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PAEIL2OSy7fVYAw+2opLQp645UQcZziDpgahnhOwtXQ=;
        b=pvRjD1vVR/ISbqNCAblwPNkm+pD0nOqcKQa/wR5MXir/iIcfu2ns/TctiW6ZudEmPW
         ADg37+6zsBqirBfsJXO9TA0ePCZ9uCZbT6zEBsYb7qsIjro3BM6EPu/gTxcqQ7e5n6xf
         giIj7t7wJaJvyDpUeRdClXrvEmII3L0M+TjNq94llNATIYUaa+vGnYVfgGO79ccCoqiv
         0lXd76RkNvzTJYOFKbqykxGYl6tlU4Uje7HvW3DUKfDabTMc8tDe+NiTfR6XAyARwurT
         sjWh+kOWeYr2D319Kms8AG4TEnxf13+F6gjWeQ157bGvYnXGR6zUNuTW0aLtHlMF5HkY
         L2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PAEIL2OSy7fVYAw+2opLQp645UQcZziDpgahnhOwtXQ=;
        b=cyoS77LvVMv5NTjbHAFnTSSP/khj44CAOb23psYU3qbcl7ws7xGc+L3Qq9ZppKjSci
         fzH5qOIqzqPIzU0BBKK2FxKzRw84G7Lavd8Mdov6sfU3EOILLGhY559xO7ctl56bp5i8
         KNDqTIVCOeNugvpjUR2xrHVjkHpdo7THEL5L1pIg5BqcGADojN6vog8ch6/XD0HcT9Q5
         72H4npS6LHgnu0yd8ndYCbOVO0gxuP7uNm6fUO1jvGHxMdi8oYezdohAABA6xJgHlf0+
         xUff0BIB1CNjDklGtUrMxHgsWnp/OnTEiBwMc0r+2ZEQ2a1QUb6eC1b6lLk18jGdJeaU
         5z9w==
X-Gm-Message-State: APjAAAVH8GCi0HO3RrvqBanh/ePNJm2r8kqhS6jwbuWTFoylYClrSXLr
        dhFHS80rEQgcNYp28iwN6vA=
X-Google-Smtp-Source: APXvYqz8xvP8XXFvXqq43AZ4+ENh4hmQ4W+38NwcHKK8ef5peZ6uwVkQVIX6Y5KWQ+KctdaXH9Eszg==
X-Received: by 2002:ad4:42aa:: with SMTP id e10mr8261865qvr.92.1581831829747;
        Sat, 15 Feb 2020 21:43:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id x126sm6838714qkc.42.2020.02.15.21.43.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 Feb 2020 21:43:49 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 20D6C20FBE;
        Sun, 16 Feb 2020 00:43:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 16 Feb 2020 00:43:48 -0500
X-ME-Sender: <xms:ktZIXuX9D4QnXWKOQROUChDwslj1o68uwYnerou-XV6_H8k_EJIAwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeefgdeklecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpuggvfhdrshhonecukfhppeeh
    vddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:k9ZIXt3ghHKGf1mmzeCe6cgLdRMfYUnjddm1AKD947pe1iOW8fzo0A>
    <xmx:k9ZIXr3PIP82z987qSa5ASWasGWiTN_qxxnTuBcJ88Zf0y-q_rEm-Q>
    <xmx:k9ZIXg-9Oe742Zx_0lGk9nyLNDaF1Zb6HWoLGDKEmMEwWmsHSGqbcQ>
    <xmx:lNZIXiWJKAOl1BI37pevq8gxRHdljNO_E68eJBv8LL9kA1QuSx1BgtUr0Ow>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D3E5328005D;
        Sun, 16 Feb 2020 00:43:46 -0500 (EST)
Date:   Sun, 16 Feb 2020 13:43:45 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org,
        Andrea Parri <parri.andrea@gmail.com>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [RFC 0/3] tools/memory-model: Add litmus tests for atomic APIs
Message-ID: <20200216054345.GA69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200214040132.91934-1-boqun.feng@gmail.com>
 <Pine.LNX.4.44L0.2002141024141.1579-100000@iolanthe.rowland.org>
 <20200215152550.GA13636@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200215152550.GA13636@paulmck-ThinkPad-P72>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Feb 15, 2020 at 07:25:50AM -0800, Paul E. McKenney wrote:
> On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> > On Fri, 14 Feb 2020, Boqun Feng wrote:
> > 
> > > A recent discussion raises up the requirement for having test cases for
> > > atomic APIs:
> > > 
> > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > 
> > > , and since we already have a way to generate a test module from a
> > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > tests for atomic APIs into memory-model.
> > 
> > It might be worth discussing this point a little more fully.  The 
> > set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> > limited.  Paul has a vastly more expansive set of litmus tests in a 
> > GitHub repository, and I am doubtful about how many new tests we want 
> > to keep in the kernel source.
> 
> Indeed, the current view is that the litmus tests in the kernel source
> tree are intended to provide examples of C-litmus-test-language features
> and functions, as opposed to exercising the full cross-product of
> Linux-kernel synchronization primitives.
> 
> For a semi-reasonable subset of that cross-product, as Alan says, please
> see https://github.com/paulmckrcu/litmus.
> 
> For a list of the Linux-kernel synchronization primitives currently
> supported by LKMM, please see tools/memory-model/linux-kernel.def.
> 

So how about I put those atomic API tests into a separate directory, say
Documentation/atomic/ ?

The problem I want to solve here is that people (usually who implements
the atomic APIs for new archs) may want some examples, which can help
them understand the API requirements and test the implementation. And
litmus tests are the perfect tool here (given that them can be
translated to test modules with klitmus). And I personally really think
this is something the LKMM group should maintain, that's why I put them
in the tools/memory-model/litmus-tests/. But I'm OK if we end up
deciding those should be put outside that directory.

Regards,
Boqun

> > Perhaps it makes sense to have tests corresponding to all the examples
> > in Documentation/, perhaps not.  How do people feel about this?
> 
> Agreed, we don't want to say that the set of litmus tests in the kernel
> source tree is limited for all time to the set currently present, but
> rather that the justification for adding more would involve useful and
> educational examples of litmus-test features and techniques rather than
> being a full-up LKMM test suite.
> 
> I would guess that there are litmus-test tricks that could usefully
> be added to tools/memory-model/litmus-tests.  Any nomination?  Perhaps
> handling CAS loops while maintaining finite state space?  Something else?
> 
> 							Thanx, Paul
