Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68983683906
	for <lists+linux-arch@lfdr.de>; Tue, 31 Jan 2023 23:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbjAaWFN (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 31 Jan 2023 17:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231220AbjAaWFM (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Tue, 31 Jan 2023 17:05:12 -0500
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC7C5A821;
        Tue, 31 Jan 2023 14:04:44 -0800 (PST)
Received: by mail-qt1-x836.google.com with SMTP id g8so2070060qtq.13;
        Tue, 31 Jan 2023 14:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MMMEUEVltqpkhgX3Kjutpryf6MbBtm1Jhz+7EncfC3g=;
        b=CEyuvDcLtt0JpgnTKkraMuo0YZDx8veO3i4l5T14RYnOvTeSZmoJF8S9tK96DdnHY9
         6hQTUxl5f05pg9VsIp0Rs9ZeTx5aHpabZY1epm0u43ZVX0xrbu/ZIu/jNj3TUNSdjtMN
         CEhnzuajVVSO6t7fCr6jH1/JLC/xlkg2Dpmc+4YPxeVDStg6gof/r6MJ7cF5moiD17r+
         C5BR5HzRFfkzn08DfRVA+Jri8g7MywQnMQbWUTg5VXqE/TZN3FENg3g9EVCOqGCwfhxt
         qdHRMfuu1IMFbhCcVuJ/aWHqLXn3SAqlaWzlYcu71x4BtVnj782LOCIM0S0H37HHFD4H
         m5TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MMMEUEVltqpkhgX3Kjutpryf6MbBtm1Jhz+7EncfC3g=;
        b=h/5BEl6EtS4iF9APaw8xj7Z5Q9DRwAjxc2sWby/ItV3SvXD35wyx4HtqiI1XNfSAw7
         feZstHhCvPsnf2lHdikA3j0rXStPGnTteEVLDrhudswMZpPyrtW/QeQvp2i9nMAZ+m7Q
         Ac5Vb6mR57BdhMpljdqr2kW4eLXziThlXn68lG8TraGZqdJ6gipRUbDb+e9Elnk92vqo
         NZft+sgXQcRBAP6gmAD7ackq+vGehehf2WLDuYIKFj0tvNlbSxhP9wD6AHtkBmDSZncg
         FGoYBNDS0qsI3k0gg/wlzMjnzS/gemb3tUpabnnxncMwWa6Vd9CH+wgMya9ceCY4zgsN
         37fA==
X-Gm-Message-State: AO0yUKW1rKuweeLmXaNIfx59LPtewH7UUfCT1WQCWla2raorZ9UP8wxp
        l4cji/IIvqhLK9ct+BAOMSE=
X-Google-Smtp-Source: AK7set+Wqugp46Wl+FqKZxsegT45Z3haMQeI1wvyJCwjmTMin1eBNmWgyEBBOI6ZPZOwGcmNA8oRtw==
X-Received: by 2002:a05:622a:138b:b0:3b8:6c08:21f1 with SMTP id o11-20020a05622a138b00b003b86c0821f1mr386409qtk.51.1675202674477;
        Tue, 31 Jan 2023 14:04:34 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id a17-20020ac86111000000b003b0766cd169sm10686207qtm.2.2023.01.31.14.04.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 14:04:33 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0141427C005B;
        Tue, 31 Jan 2023 17:04:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 31 Jan 2023 17:04:33 -0500
X-ME-Sender: <xms:b5DZY2KzSgNny5Ilweqiqwt6M35nsjqa9M-5ol2Kcn1v-CQl99Uyfg>
    <xme:b5DZY-KIRib6qdaAlxAO3F_27BM01d4CMyXoL-as_Y4oYIRFOy5GW_0I4-zGB75gZ
    B2Lwu42qbcs0yB6wA>
X-ME-Received: <xmr:b5DZY2usu85QVxVkux7it3uuqcJl4hLzEjdPlBADsvOoH4uW4ECKkd54Tp0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudefgedgudehjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfedtvefhveettedtgfffiefgkeeitedujefgudekiefhffehheeuveel
    ffekfedvnecuffhomhgrihhnpehlphgtrdgvvhgvnhhtshenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhht
    hhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquh
    hnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:b5DZY7b3V6QyWJt3tvySuQ-Z00vWWqQAxt9RQGQVdToOWSbddIZBSA>
    <xmx:b5DZY9bADW43mdclG9hMiwz4lUFSoMuL_Fz8SWD93nEiKf888ivGDg>
    <xmx:b5DZY3D7SRGaUFBlrs-DIZKgcIbMXv2j1iRi2Fk6-B_tGxCycflbMg>
    <xmx:cJDZY6SQi82tTMrHPdpMb_Iaq8eLMme_V5yhFBa--l7q6mrR_Jy_NQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Jan 2023 17:04:30 -0500 (EST)
Date:   Tue, 31 Jan 2023 14:03:32 -0800
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
Message-ID: <Y9mQNNhzkOF/+uuC@boqun-archlinux>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
 <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
 <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
 <Y9RLpYGmzW1KPksE@boqun-archlinux>
 <2f4717b3-268f-8db3-e380-4af0a5479901@huaweicloud.com>
 <Y9gOjzGaWy2hIAmu@boqun-archlinux>
 <2f121e2d-8e4c-de99-5672-93350fbb52af@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2f121e2d-8e4c-de99-5672-93350fbb52af@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jan 31, 2023 at 04:08:29PM +0100, Jonas Oberhauser wrote:
> 
> 
> On 1/30/2023 7:38 PM, Boqun Feng wrote:
> > On Mon, Jan 30, 2023 at 01:23:28PM +0100, Jonas Oberhauser wrote:
> > > 
> > > On 1/27/2023 11:09 PM, Boqun Feng wrote:
> > > > On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
> > > > > > I also noticed that GCC has some builtin/extension to do such things,
> > > > > > __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
> > > > > > can be used in the kernel.
> > > > > On a per-architecture basis only, the C/C++ memory model does not match
> > > > > the Linux Kernel memory model so using the compiler to generate the
> > > > > atomic ops is somewhat tricky and needs architecture audits.
> > > > Hijack this thread a little bit, but while we are at it, do you think it
> > > > makes sense that we have a config option that allows archs to
> > > > implement LKMM atomics via C11 (volatile) atomics? I know there are gaps
> > > > between two memory models, but the option is only for fallback/generic
> > > > implementation so we can put extra barriers/orderings to make things
> > > > guaranteed to work.
> > > Another is that the C11 model is more about atomic locations than atomic
> > > accesses, and there are several places in the kernel where a location is
> > > accessed both atomically and non-atomically. This API mismatch is more
> > > severe than the semantic differences in my opinion, since you don't have
> > > guarantees of what the layout of atomics is going to be.
> > > 
> > True, but the same problem for our asm implemented atomics, right? My
> > plan is to do (volatile atomic_int *) casts on these locations.
> 
> Do you? I think LKMM atomic types are always exactly as big as the
> underlying types.
> With C you might get into a case where the atomic_int is actually [lock ;
> non-atomic int] and when you access the location in a mixed way, you will
> non-atomically read the lock part but the atomic accesses modify the int
> part (protected by the lock).
> 

Well, I plan is to check ATOMIC_*_LOCK_FREE and have Static_assert() on
the side of atomic_int ;-)

> > 
> > > Perhaps you could instead rely on the compiler builtins? Note that this may
> > These are less formal/defined to me, and not much research on them I
> > assume, I'd rather not use them.
> 
> I think that it's easy enough to define a formal model of these that is a
> bit conservative, and then just add mb()s to make them safe.
> 

I actually have a similar idea about the communication betweet Rust and
kernel C with atomic variables: Rust can use its standard atomics (i.e.
C11/LLVM atomics) but with mb()s to make them safe when talking with C.

Of course, no problem about pure Rust code using pure LLVM atomics.

> > 
> > > invalidate some progress properties, e.g., ticket locks become unfair if the
> > > increment (for taking a ticket) is implemented with a CAS loop (because a
> > > thread can fail forever to get a ticket if the ticket counter is contended,
> > > and thus starve). There may be some linux atomics that don't map to any
> > > compiler builtins and need to implemented with such CAS loops, potentially
> > > leading to such problems.
> > > 
> > > I'm also curious whether link time optimization can resolve the inlining
> > > issue?
> > > 
> > For Rust case, cross-language LTO is needed I think, and last time I
> > tried, it didn't work.
> 
> In German we say "Was noch nicht ist kann ja noch werden", translated as
> "what isn't can yet become", I don't feel like putting too much effort into

Not too much compared to wrapping LKMM atomics with Rust using FFI,

Using FFI:

	impl Atomic {
		fn read_acquire(&self) -> i32 {
			// SAFTEY:
			unsafe { atomic_read_acquire(self as _) }
		}
	}

Using standard atomics:

	impl Atomic {
		fn read_acquire(&self) -> i32 {
			// self.0 is a Rust AtomicI32
			compiler_fence(SeqCst); // Rust not support volatile atomic yet
			self.0.load(Acquire)
		}
	}

Needless to say, if we really need LKMM atomics in Rust, it's kinda my
job to implement these, so not much different for me ;-) Of course, any
help is appreciate!

> something that hardly affects performance and will hopefully become obsolete
> at some point in the near future.
> 
> > 
> > > I think another big question for me is to which extent it makes sense
> > > anyways to have shared memory concurrency between the Rust code and the C
> > > code. It seems all the bad concurrency stuff from the C world would flow
> > > into the Rust world, right?
> > What do you mean by "bad" ;-) ;-) ;-)
> 
> Uh oh. Let's pretend I didn't say anything :D
> 
> > > If you can live without shared Rust & C concurrency, then perhaps you can
> > > get away without using LKMM in Rust at all, and just rely on its (C11-like)
> > > memory model internally and talk to the C code through synchronous, safer
> > > ways.
> > > 
> > First I don't think I can avoid using LKMM in Rust, besides the
> > communication from two sides, what if kernel developers just want to
> > use the memory model they learn and understand (i.e. LKMM) in a new Rust
> > driver?
> 
> I'd rather people think 10 times before relying on atomics to write Rust
> code.
> There may be cases where it can't be avoided because of performance reasons,
> but Rust has a much more convenient concurrency model to offer than atomics.
> I think a lot more people understand Rust mutexes or channels compared to
> atomics.

C also has more convenient concurrency tools in kernel, and I'm happy
that people use them. But there are also people (including me) working
on building these tools/models, inevitably we need to use atomics. And
when we use the atomics, the biggest question is which one to use?
Right, it seems that I'm responsible for the answer because I have
multiple hats on. Trust me, it's not something I like to think about but
I have to ;-)

> Unfortunately I haven't written much driver code so I don't have experience
> to what extent it's generally necessary to rely on atomics :(
> 
> 

[snip some good tech inputs, I will reply later]

> 
> > > But I currently don't see that this implementation would be noticeably
> > > faster than paying the overhead of lack of inline.
> > > 
> > You are not wrong, surely we will need to real benchmark to know. But my
> > rationale is 1) in theory this is faster, 2) we also get a chance to try
> > out code based on LKMM with C11 atomics to see where it hurts. Therefore
> > I asked ;-)
> 
> I think one beautiful thing about open source is that nobody can stop you
> from trying it out yourself :D

I wish this is a personal side project that I can give up whenever I
want ;-)

The key question is that when building something in Rust for Linux using
atomics, and also talking with C side with atomics, how do we handle the
different between two memory models? A few options I can think of:

1.	Use Rust standard atomics and pretend different memory models
	work together (do we have model tools to handle code in
	different models communicating with each other?)

2.	Use Rust standard atomics and add extra mb()s to enforce more
	ordering guarantee.

3.	Implement LKMM atomics in Rust and use them with caution when
	comes to implicit ordering guarantees such as ppo. In fact lots
	of implicit ordering guarantees are available since the compiler
	won't exploit the potential reordering to "optimize", we also
	kinda have tools to check:

		https://lpc.events/event/16/contributions/1174/attachments/1108/2121/Status%20Report%20-%20Broken%20Dependency%20Orderings%20in%20the%20Linux%20Kernel.pdf

	A good part of using Rust is that we may try out a few tricks
	(with proc-macro, compiler plugs, etc) to express some ordering
	expection, e.g. control dependencies.

	Two suboptions are:

	3.1	Implement LKMM atomics in Rust with FFI
	3.2	Implement LKMM atomics in Rust with Rust standard
		atomics

I'm happy to figure out pros and cons behind each option.

Regards,
Boqun

> It's currently not something I would personally put resources into though.
> You could pick a DPDK or CK algorithm and port it to a version using FFI
> instead of using atomics directly, and measure the impact on some
> microbenchmarks.
> Then consider that the end-to-end impact on Linux will probably be at least
> one or two orders of magnitude less.
> 
> Have fun, jonas
> 
