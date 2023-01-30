Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7E9681980
	for <lists+linux-arch@lfdr.de>; Mon, 30 Jan 2023 19:40:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbjA3Sj6 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 30 Jan 2023 13:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238256AbjA3Sji (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 30 Jan 2023 13:39:38 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9679714212;
        Mon, 30 Jan 2023 10:39:06 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id j9so11029437qtv.4;
        Mon, 30 Jan 2023 10:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1w+tbBWEaA0E2RmuugzUMyNc2sljY7KRsFQbXG9DuEY=;
        b=Zc/g1ZDm0jtFAYTeTbkjvU+lEAgWm79NKe3IDDJp+FYozoxjHpxfHUDVNTijMA8Sgi
         LCQoAAV1oXxRTFsF8NMROne0DHf1wmKdKPlJvOqry6aNTkROGn34Cbe4Vj/0hC+ZdSus
         ZTcJl9/tUVcDg7nvkioI1NBl5fDNjvQeJIAwiRBZM/FCafiJOvzSWs+PPdeisXFRZFQ7
         FIhup5g8Fs3HiHuE2FkgCgOzcp4Im3TE0+HweoV9hI+csba0TZTWjIhNLCH/+doAVi33
         hRFZhTL/41yUCS7ZXacoqNQ1HBFP6F+eN7W50Rsejz7INRCjCEvAgJ1j+7UKwOfciCYp
         PN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1w+tbBWEaA0E2RmuugzUMyNc2sljY7KRsFQbXG9DuEY=;
        b=pPdThLBWsT8lV/koiyWK+GZofCEi50pwrJYq+hp0ZvyE+7eHlrLz9Ib8qCsaQx3yJS
         ITbuzxqKn6vWVTDSax/VCkrXDM3ng+s4MavJsQAJdlgPIGxCTrYqwcECglDnEwpq4n8i
         v1MMr0TNl6CCuclCBOada/gfavIdigDWPcSXLytB3lKEa/R1OFsMXhB7ZeZ1bIkwDZZv
         ZeQBZDZjjNmkb6Aiyu1K2X5o5MofPMFRnwCV/NTdYhRP6fZ66ZxsjQCFiQGESoRvheqc
         4JqPjdOjeE1Exb6v2hyagQtOMiQES8VvMotjdPLJ/3l7r6Ui/1JXNsFH5miKaeFkqmFc
         PO5w==
X-Gm-Message-State: AFqh2kpbkkdpZExgBoi8aOHmAuHekyVFeQtzftOpl3z1w6fB+8xpZeNG
        63/IqFXbMsFXv8XQtpeNprwI85+Xdoc=
X-Google-Smtp-Source: AMrXdXsaFlF4Z/8mfUnxqPOn6QGTEg1RtZFEBW6V5bpVS4uopngy3sXy1dd/ilvC4WwuW4ece/ZeOQ==
X-Received: by 2002:ac8:454e:0:b0:3a8:fdf:8ff8 with SMTP id z14-20020ac8454e000000b003a80fdf8ff8mr68979799qtn.36.1675103945541;
        Mon, 30 Jan 2023 10:39:05 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id t9-20020a05620a034900b007194ea5c715sm6287166qkm.77.2023.01.30.10.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:39:04 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id AC2D827C0054;
        Mon, 30 Jan 2023 13:39:03 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Jan 2023 13:39:03 -0500
X-ME-Sender: <xms:xg7YYwUJIhe2a_K64a9c4TTrwqY2SmTRM-4yW8QJzBVkVfCXFrm_Xg>
    <xme:xg7YY0lxKlw9bVgwDq8LzWPYxl5908dx4zhCCLOuHPnu4LWf63kc4h3GAPN3eXrTH
    j9X_VymMbPMAnsPLQ>
X-ME-Received: <xmr:xg7YY0YqhhRtdPR3P2GNbRGPvMwU8ePuxBDJZY3nhZ5mW6yuJXFtWV5JlJ8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefvddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddtudenucfhrhhomhepueho
    qhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtf
    frrghtthgvrhhnpeeftddvudetgfettdevfeekgfevleetjeduhffgleefhfdtheeuueet
    jeehhfdtfeenucffohhmrghinhepohhpvghnqdhsthgurdhorhhgpdhgihhthhhusgdrtg
    homhenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegs
    ohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeige
    dqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihig
    mhgvrdhnrghmvg
X-ME-Proxy: <xmx:xw7YY_VPhjjnLEAQATj1T39g61JWVIF_k9_YcKw-mBxE5Rc20XYA8Q>
    <xmx:xw7YY6ntJSX8TNltxvNfYPjc8Xno3kUbj7kBKCygzovhUHq_KL9GBQ>
    <xmx:xw7YY0ejXgsW4TDqKvPZULKCRpbey6KI5H9p7g4Lwga4GuZgjIUzMQ>
    <xmx:xw7YY2P0HYBkuKiD4t_1nAWAE1zjdyTtlNFJmHudnmUQXLl5-gG0lw>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 13:39:02 -0500 (EST)
Date:   Mon, 30 Jan 2023 10:38:07 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jules Maselbas <jmaselbas@kalray.eu>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Daniel Lustig <dlustig@nvidia.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hernan Ponce de Leon <hernan.poncedeleon@huaweicloud.com>,
        Paul =?iso-8859-1?Q?Heidekr=FCger?= <paul.heidekrueger@in.tum.de>,
        Marco Elver <elver@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>
Subject: Re: [PATCH] locking/atomic: atomic: Use arch_atomic_{read,set} in
 generic atomic ops
Message-ID: <Y9gOjzGaWy2hIAmu@boqun-archlinux>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
 <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
 <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
 <Y9RLpYGmzW1KPksE@boqun-archlinux>
 <2f4717b3-268f-8db3-e380-4af0a5479901@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f4717b3-268f-8db3-e380-4af0a5479901@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jan 30, 2023 at 01:23:28PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/27/2023 11:09 PM, Boqun Feng wrote:
> > On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
> > > > I also noticed that GCC has some builtin/extension to do such things,
> > > > __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
> > > > can be used in the kernel.
> > > On a per-architecture basis only, the C/C++ memory model does not match
> > > the Linux Kernel memory model so using the compiler to generate the
> > > atomic ops is somewhat tricky and needs architecture audits.
> > Hijack this thread a little bit, but while we are at it, do you think it
> > makes sense that we have a config option that allows archs to
> > implement LKMM atomics via C11 (volatile) atomics? I know there are gaps
> > between two memory models, but the option is only for fallback/generic
> > implementation so we can put extra barriers/orderings to make things
> > guaranteed to work.
> > 
> > It'll be a code version of this document:
> > 
> > 	https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html
> > 
> > (although I realise there may be a few mistakes in that doc since I
> > wasn't familiar with C11 memory model when I wrote part of the doc, but
> > these can be fixed)
> > 
> > Another reason I ask is that since Rust is coming, we need to provide
> > our LKMM atomics in Rust so that C code and Rust code can talk via same
> > atomic variables, since both sides need to use the same memory model.
> > My choices are:
> > 
> > 1.	Using FFI to call Linux atomic APIs: not inline therefore not
> > 	efficient.
> > 
> > 2.	Implementing Rust LKMM atomics in asm: much more work although
> > 	I'm OK if we have to do it.
> > 
> > 3.	Implementing Rust LKMM atomics with standard atomics (i.e. C/C++
> > 	atomics):
> > 
> > 	*	Requires Rust has "volatile" atomics, which is WIP but
> > 		looks promising
> > 	
> > 	*	Less efficient compared to choice #2 but more efficient
> > 		compared to choice #1
> > 
> > Ideally, choice #2 is the best option for all architectures, however, if
> > we have the generic implementation based on choice #3, for some archs it
> > may be good enough.
> > 
> > Thoughts?
> 
> Thanks for adding me to the discussion!
> 
> One reason not to rely on C11 is that old compilers don't support it, and
> there may be application scenarios in which new compilers haven't been
> certified.
> I don't know if this is something that affects linux, but linux is so big
> and versatile I'd be surprised if that's irrelevant.
> 

We are gnu11 since last year:

	e8c07082a810 ("Kbuild: move to -std=gnu11")

, so at least for mainline I don't see a problem to use c11 atomics.

> Another is that the C11 model is more about atomic locations than atomic
> accesses, and there are several places in the kernel where a location is
> accessed both atomically and non-atomically. This API mismatch is more
> severe than the semantic differences in my opinion, since you don't have
> guarantees of what the layout of atomics is going to be.
> 

True, but the same problem for our asm implemented atomics, right? My
plan is to do (volatile atomic_int *) casts on these locations.

> Perhaps you could instead rely on the compiler builtins? Note that this may

These are less formal/defined to me, and not much research on them I
assume, I'd rather not use them.

> invalidate some progress properties, e.g., ticket locks become unfair if the
> increment (for taking a ticket) is implemented with a CAS loop (because a
> thread can fail forever to get a ticket if the ticket counter is contended,
> and thus starve). There may be some linux atomics that don't map to any
> compiler builtins and need to implemented with such CAS loops, potentially
> leading to such problems.
> 
> I'm also curious whether link time optimization can resolve the inlining
> issue?
> 

For Rust case, cross-language LTO is needed I think, and last time I
tried, it didn't work.

> I think another big question for me is to which extent it makes sense
> anyways to have shared memory concurrency between the Rust code and the C
> code. It seems all the bad concurrency stuff from the C world would flow
> into the Rust world, right?

What do you mean by "bad" ;-) ;-) ;-)

> If you can live without shared Rust & C concurrency, then perhaps you can
> get away without using LKMM in Rust at all, and just rely on its (C11-like)
> memory model internally and talk to the C code through synchronous, safer
> ways.
> 

First I don't think I can avoid using LKMM in Rust, besides the
communication from two sides, what if kernel developers just want to
use the memory model they learn and understand (i.e. LKMM) in a new Rust
driver? They probably already have a working parallel algorithm based on
LKMM.

Further, let's say we make C and Rust talk without shared memory
concurrency, what would that be? Will it more defined/formal the LKMM?
How's the cost if we use synchronous ways? I personally think there are
places in core kernel where Rust can be tried, whatever the mechanism is
used, it cannot sarcrifed.

> I'm not against having a fallback builtin-based implementation of LKMM, and
> I don't think that it really needs architecture audits. What it needs is

Fun fact, there exist some "optimizations" that don't generate the asm
code as you want:

	https://github.com/llvm/llvm-project/issues/56450

Needless to say, they are bugs, and will be fixed, besides making atomic
volatile seems to avoid these "optimizations"

> some additional compiler barriers and memory barriers, to ensure that the
> arguments about dependencies and non-atomics still hold. E.g., a release
> store may not just be "builtin release store" but may need to have a
> compiler barrier to prevent the release store being moved in program order.
> And a "full barrier" exchange may need an mb() infront of the operation to
> avoid "roach motel ordering" (i.e.,  x=1 ; "full barrier exchange"; y = 1
> allows y=1 to execute before x=1 in the compiler builtins as far as I
> remember). And there may be some other cases like this.
> 

Agreed. And this is another reason I want to do it: I'm curious about
how far C11 memory model and LKMM are different, and whether there is a
way to implement one by another, what are the gaps (theorical and
pratical), whether the ordering we have in LKMM can be implemented by
compilers (mostly dependencies). More importantly, we could improve both
to get something better? With the ability to exactly express the
programmers' intention yet still allow optimization by the compilers.

> But I currently don't see that this implementation would be noticeably
> faster than paying the overhead of lack of inline.
> 

You are not wrong, surely we will need to real benchmark to know. But my
rationale is 1) in theory this is faster, 2) we also get a chance to try
out code based on LKMM with C11 atomics to see where it hurts. Therefore
I asked ;-)

Regards,
Boqun

> Best wishes, jonas
> 
