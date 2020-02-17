Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A5151607C1
	for <lists+linux-arch@lfdr.de>; Mon, 17 Feb 2020 02:27:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726560AbgBQB1q (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 16 Feb 2020 20:27:46 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34790 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbgBQB1q (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sun, 16 Feb 2020 20:27:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id c20so14780417qkm.1;
        Sun, 16 Feb 2020 17:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pIJUz3o4BsZGq1UIMsmYwN7b8ilICIwNhuoVh3JXiCY=;
        b=ma+QHFqFrc9AuZgbISiDDrvyIWMA/cPNT0roCMfoM/VrgPEp+1Ov/ODLR2agNyvKfy
         Nw2Ec225uxFgP3HH/MUGjKxYM3g43Xij/EDtCxdqxSVnIBX91JCBhzcLnur3sFa2+uU7
         XgJX6360S1TQV0GB9M1ClN7McbZGoBI1uYyuD33KTeLE677m40YuET4kUnQymfKQ6hMp
         +QBrmBO5Sx2Rtn/kQxiiXoNxMgume4ktzsd5pwRfyqjpHU7X6PB1y/A/Fwz3GjACcnQz
         lySvxqze4lmVOlx3AbQywsKK0McifSwhoIEZQNQ8pavKoLCB3chNMIHkq21bb8WwrqnU
         Oe7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pIJUz3o4BsZGq1UIMsmYwN7b8ilICIwNhuoVh3JXiCY=;
        b=LM6XSoUcd7D296u5mW/2qSYRwyC0dp1RpsA/4oFuhiPJ18txpfaU+X0HQAqB67C43/
         QPg0S36NLl2udzOphoozpw8YR49i2Vh6C0GskKb93RYKl9aPbmR9g9Vvjp56F8NmCx9w
         YK+MCn0hINjDq4sdoRVK3Jz5bpmvYpn3GmFUPAYEKz3nlOis3OCZgAUl/ahcO4lOlLUl
         j3hkPFt5jNtGbw2piBDqkDwYQM/XL2zQ4YrPML4GMnrHwNbKQwCOqDTNqmwrg7H2jMhX
         XkS50+KUkC6KLn9imQk+7Z4qNl07HKPOCl+y+8hJUrBQHdiRmm93IIrI4+l4hFr0LH/t
         Y29w==
X-Gm-Message-State: APjAAAVpRpSFbJcYW4r8U02WxgM0e0RE5AaOka459tvZ7XMWiJpL8Jbw
        7njQ+LxpkxWP5ljKwe5KeXg=
X-Google-Smtp-Source: APXvYqw7YymbkCgKPOWCbG0hZGa5MXni5FoRtswSMjOxxNhzwMV5+BoSOvrkB+SHh4c5J2cqqdFh+g==
X-Received: by 2002:a37:a08f:: with SMTP id j137mr12017923qke.467.1581902863525;
        Sun, 16 Feb 2020 17:27:43 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id z1sm8012011qtq.69.2020.02.16.17.27.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Feb 2020 17:27:42 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 302BD21CDA;
        Sun, 16 Feb 2020 20:27:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 16 Feb 2020 20:27:41 -0500
X-ME-Sender: <xms:COxJXmIw1-pyWWVY1hthefmj6_6_iPBYlGkxhIhRRwh_vpLslDSa_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrjeehgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucffohhmrghinh
    epkhgvrhhnvghlrdhorhhgpdhgihhthhhusgdrtghomhdpuggvfhdrshhonecukfhppeeh
    vddrudehhedrudduuddrjedunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihht
    hidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrg
    hilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:COxJXgCDxNHdNHdKHEAyXq2Wew6jvGP2y-nzEF49FK23VVFgpvk-hA>
    <xmx:COxJXgHNggHU2Y2u3cwAjY6EK133nV7byMTZgNpqWy4tt4n4cQw7Lw>
    <xmx:COxJXk4HacxfFi3KhCFnrdNHzGwnRjsr1PUSH3Ciy7osCyAhC5mt2w>
    <xmx:DexJXj-dtYYk8r_9P9jDQkvJbzvAHPQ4XcO4KNnfLKdN9IdDVNv4d1Fs1ag>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0358F30606E9;
        Sun, 16 Feb 2020 20:27:35 -0500 (EST)
Date:   Mon, 17 Feb 2020 09:27:34 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20200217012734.GB69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200216120625.GF2935@paulmck-ThinkPad-P72>
 <Pine.LNX.4.44L0.2002161113320.30459-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.2002161113320.30459-100000@netrider.rowland.org>
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Feb 16, 2020 at 11:16:50AM -0500, Alan Stern wrote:
> On Sun, 16 Feb 2020, Paul E. McKenney wrote:
> 
> > On Sun, Feb 16, 2020 at 01:43:45PM +0800, Boqun Feng wrote:
> > > On Sat, Feb 15, 2020 at 07:25:50AM -0800, Paul E. McKenney wrote:
> > > > On Fri, Feb 14, 2020 at 10:27:44AM -0500, Alan Stern wrote:
> > > > > On Fri, 14 Feb 2020, Boqun Feng wrote:
> > > > > 
> > > > > > A recent discussion raises up the requirement for having test cases for
> > > > > > atomic APIs:
> > > > > > 
> > > > > > 	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/
> > > > > > 
> > > > > > , and since we already have a way to generate a test module from a
> > > > > > litmus test with klitmus[1]. It makes sense that we add more litmus
> > > > > > tests for atomic APIs into memory-model.
> > > > > 
> > > > > It might be worth discussing this point a little more fully.  The 
> > > > > set of tests in tools/memory-model/litmus-tests/ is deliberately rather 
> > > > > limited.  Paul has a vastly more expansive set of litmus tests in a 
> > > > > GitHub repository, and I am doubtful about how many new tests we want 
> > > > > to keep in the kernel source.
> > > > 
> > > > Indeed, the current view is that the litmus tests in the kernel source
> > > > tree are intended to provide examples of C-litmus-test-language features
> > > > and functions, as opposed to exercising the full cross-product of
> > > > Linux-kernel synchronization primitives.
> > > > 
> > > > For a semi-reasonable subset of that cross-product, as Alan says, please
> > > > see https://github.com/paulmckrcu/litmus.
> > > > 
> > > > For a list of the Linux-kernel synchronization primitives currently
> > > > supported by LKMM, please see tools/memory-model/linux-kernel.def.
> > > > 
> > > 
> > > So how about I put those atomic API tests into a separate directory, say
> > > Documentation/atomic/ ?
> > > 
> > > The problem I want to solve here is that people (usually who implements
> > > the atomic APIs for new archs) may want some examples, which can help
> > > them understand the API requirements and test the implementation. And
> > > litmus tests are the perfect tool here (given that them can be
> > > translated to test modules with klitmus). And I personally really think
> > > this is something the LKMM group should maintain, that's why I put them
> > > in the tools/memory-model/litmus-tests/. But I'm OK if we end up
> > > deciding those should be put outside that directory.
> > 
> > Good point!
> > 
> > However, we should dicuss this with the proposed beneficiaries, namely
> > the architecture maintainers.  Do they want it?  If so, where would
> > they like it to be?  How should it be organized?
> > 

Paul,

Well, I was simply motivated by the discuss on microblaze's atomic
implementation (which I pasted the link in this cover letter):

	https://lore.kernel.org/lkml/20200213085849.GL14897@hirez.programming.kicks-ass.net/

, please see the last paragraph, Michal asking Peter for some tests. So
I think there is at least some one wanting this ;-)

> > In the meantime, I am more than happy to accept litmus tests into the
> > github archive.
> > 

Thanks ;-)

> > So how would you like to proceed?

I think we are still at the discussion stage, so I'm happy to see
suggestions on where to put the litmus tests and which litmus tests
should be included.

> 
> I think it makes sense to put Boqun's tests under Documentation/ rather
> than tools/.  After all, their point is to document the memory model's
> requirements for operations on atomic_t's.  They aren't meant to be
> examples or demos showing how to use herd or write litmus tests.
> 

Alan,

Got it. I will create the Documentation/atomic directory and put the
litmus tests there in the next version.

Thank you both!

Regards,
Boqun

> Alan
> 
