Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76D267F0ED
	for <lists+linux-arch@lfdr.de>; Fri, 27 Jan 2023 23:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjA0WKh (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 27 Jan 2023 17:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231945AbjA0WKf (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 27 Jan 2023 17:10:35 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9C023310;
        Fri, 27 Jan 2023 14:10:34 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id h24so5291407qta.12;
        Fri, 27 Jan 2023 14:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZLmfJMC28tXt+sGHzZ5Z2Y6DK9vpc4DYDueqKPsdJY=;
        b=cuSCnx1306BDvmvMa/lQuqvGBSxZAg/B9bIDYhAy+BHIobj3tfenExV/lS55V5fknO
         BFVufAJW88d0hRo5qNv/3Cj/5WKRlJV8jqQIkDML5mSqjIXN4oqGsD4jZwF2v27bYQ2c
         sM+Vv+KhYW0Qbg2JIU5Ep+4+a13/s29/YjZzUPY3eDgEqZ8QcjqE4TU0cf5SJ8RB/r9e
         wPG+ZbhOhyQ/67L537tLdbL/25Q2GXpgvD76/tcj7Hk44LEhP7EvOfMtmqsyBWpaIszZ
         5PYNEqDptHT4ckBd82IwheMgUh1ikYoX5wO2ym5jRI6jlbaaY/HgEmx8tzHBZ0+ISNCJ
         IQxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZLmfJMC28tXt+sGHzZ5Z2Y6DK9vpc4DYDueqKPsdJY=;
        b=52NVyS2STL3I+o7EUYokoauCqYFqSsJ81+ReG/JRlYL/4Ixga9pVydLBSUV3rP6fxe
         nHpFuMs1aOSslsQ/sno1ku4wyaeyhMDmkx2Zs7ENO9kdcUOP8Uc8xl1NGe4x9dPWBKh4
         UcvG09mFW8/u2CFBu0ATIJK8hcOsabB6bfK8uvJCR1qP9xnKC4RcUrmLHgFNdw5cuc6r
         lCIWQw8im38z/3FoV1whlRHvNFV9+dMS5vrHaBLpJMXM3AjjpcxhqiphRkJmFvQvq9Ez
         dBisSpHpwgzON43RnpaDkAakXuIWvAU3q5CVqHa85Vs9FKccjy9v+sa5vA8S5j4Wf7jw
         GIbQ==
X-Gm-Message-State: AFqh2kpRaaAVqOBtfeK9wJTDpcwTsuq6KTJywsS5ekgv+qyNDNT9qTFo
        byzdd5UePL9gQzWniOZPoJU=
X-Google-Smtp-Source: AMrXdXuaf6ymtpumT6wT3hHq4hE5I6IgbvXFbj6nhtc7tFhAQ1FUkYURQrDHiAY3ZIqDTuZx8Zypog==
X-Received: by 2002:a05:622a:2519:b0:3b6:31e2:f53c with SMTP id cm25-20020a05622a251900b003b631e2f53cmr55849011qtb.3.1674857433750;
        Fri, 27 Jan 2023 14:10:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id b1-20020ac85bc1000000b003b6325dfc4esm3525603qtb.67.2023.01.27.14.10.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 14:10:32 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 39D6527C0054;
        Fri, 27 Jan 2023 17:10:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 27 Jan 2023 17:10:31 -0500
X-ME-Sender: <xms:1UvUYzBtR2_vwCoKR0L_crza-US5_weopUfFW-r6ORptvHAO_69eqA>
    <xme:1UvUY5i5uB2hEXsbxU7qjWv3WmL8aWCIVt6cWyO1dtBcCHsSIBF1NNvDM9Ym7ynST
    TsjAeeR_gfoQrpPmg>
X-ME-Received: <xmr:1UvUY-nt5X2ebgtJE0vNlgzRc7JgEc0j1YQtg7nolL1ZmnTdfdxNqQNP3Ss>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddviedgudehkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptefghedviefhheffteegffffledvhedukeegkedtudehhfeluefhveeu
    tdejfffgnecuffhomhgrihhnpehophgvnhdqshhtugdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:1UvUY1wOVdRwqNBGxyNAY1cOfCrmcC1iddthOZF63Ns4bNEnYfaE8g>
    <xmx:1UvUY4SJMRRypuOJqlwoRt-Lm-0QPlAdPxttB4254oZ70V-iGZ1SSw>
    <xmx:1UvUY4bBOtlb8VAlyc9xqBbXcGPljxD66JeujRC6Efvt01ktvzYpeA>
    <xmx:1kvUY0ryhrUNAZCUYH6WWaHUh44EBCsd05skl16Q5CnIRrJE5q6Z3g>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 27 Jan 2023 17:10:29 -0500 (EST)
Date:   Fri, 27 Jan 2023 14:09:41 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jules Maselbas <jmaselbas@kalray.eu>,
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
        Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>,
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
Message-ID: <Y9RLpYGmzW1KPksE@boqun-archlinux>
References: <20230126173354.13250-1-jmaselbas@kalray.eu>
 <Y9Oy9ZAj/DQ7O+6e@hirez.programming.kicks-ass.net>
 <20230127134946.GJ5952@tellis.lin.mbt.kalray.eu>
 <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9Pg+aNM9f48SY5Z@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jan 27, 2023 at 03:34:33PM +0100, Peter Zijlstra wrote:
> > I also noticed that GCC has some builtin/extension to do such things,
> > __atomic_OP_fetch and __atomic_fetch_OP, but I do not know if this
> > can be used in the kernel.
> 
> On a per-architecture basis only, the C/C++ memory model does not match
> the Linux Kernel memory model so using the compiler to generate the
> atomic ops is somewhat tricky and needs architecture audits.

Hijack this thread a little bit, but while we are at it, do you think it
makes sense that we have a config option that allows archs to
implement LKMM atomics via C11 (volatile) atomics? I know there are gaps
between two memory models, but the option is only for fallback/generic
implementation so we can put extra barriers/orderings to make things
guaranteed to work.

It'll be a code version of this document:

	https://www.open-std.org/jtc1/sc22/wg21/docs/papers/2020/p0124r7.html

(although I realise there may be a few mistakes in that doc since I
wasn't familiar with C11 memory model when I wrote part of the doc, but
these can be fixed)

Another reason I ask is that since Rust is coming, we need to provide
our LKMM atomics in Rust so that C code and Rust code can talk via same
atomic variables, since both sides need to use the same memory model.
My choices are:

1.	Using FFI to call Linux atomic APIs: not inline therefore not
	efficient.

2.	Implementing Rust LKMM atomics in asm: much more work although
	I'm OK if we have to do it.

3.	Implementing Rust LKMM atomics with standard atomics (i.e. C/C++
	atomics):

	*	Requires Rust has "volatile" atomics, which is WIP but
		looks promising
	
	*	Less efficient compared to choice #2 but more efficient
		compared to choice #1

Ideally, choice #2 is the best option for all architectures, however, if
we have the generic implementation based on choice #3, for some archs it
may be good enough.

Thoughts?

[Cc LKMM and Rust people]

Regards,
Boqun
