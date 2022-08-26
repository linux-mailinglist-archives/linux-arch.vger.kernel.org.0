Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBBE05A2C33
	for <lists+linux-arch@lfdr.de>; Fri, 26 Aug 2022 18:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbiHZQV7 (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 26 Aug 2022 12:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344718AbiHZQVy (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 26 Aug 2022 12:21:54 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B9E3DDB46;
        Fri, 26 Aug 2022 09:21:50 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id c20so1605410qtw.8;
        Fri, 26 Aug 2022 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc;
        bh=VncAiJs3fU8NB8r44n3zEWCd5Faxj89/Rf22hgTlUOo=;
        b=GdcFrVcX0tHzJNMmPnJBh29Eu8eXvtnc/nk0jaZpfSm8VtTybgkKuR6+zFcXkJT1uc
         mzsIyw8/Z/hOswnVNh6XLU3zkJpWiFHedDEKZnwtw4H3XH4d400iYNiclA1P4Agy3X0v
         ymEyP0Afa5ZNttzFwaz2EH4gB6RqRQ1EQkWDtQGAxoLASAvcVomWoFLBT+R/R8cCJNVp
         9LweW/FnJ0tkG+1s1ZjVdLJUYRNVFbfrHNjsG9QoX/EUEUHYhwIt8H6BrGCLH36trmHi
         DsWeFMYMALbfQQuE7SxzO+H2DcLTEjJk0TEDN+ivnH+xhmQkWJU8k1rWK9r9Ppmf0Tlm
         69ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc;
        bh=VncAiJs3fU8NB8r44n3zEWCd5Faxj89/Rf22hgTlUOo=;
        b=WXPDLzlg7CKYDp4Tg/rFBxNxvJazh6nUt2q9WxSPb7s5XcBkjFhppNKbI/6dMGWRiW
         M6aG7rs2BAvtE4Nndd7aeDV9Jr0g2FE4jk3oEQCiQUv6Yj9EHgiPAPPmZMiCbbyWLLcL
         wAACNvN9Zl4NW+bi17C+hkF/OHi//NnChxyhYp+OPQilCpuEW9n55cJOic/TEd+LAC70
         W38mUd/Pd5dfaHeVVwfXh8b3P1wMhqEgYsdsPdxTzWhVMCP+y/k0J8qKWBLfwvcNwNA0
         9oEIQnaqVnR9hl6dAA274JgRQX3gZB23TIUFrMhZGUspNtK1r9YLEAzZ7Z4QroMNfNbP
         bPvA==
X-Gm-Message-State: ACgBeo1ujj462yNFoXkiUMt4GkiaI2HrajrkmsBEhAJpy4DkikCphYZ0
        raBCjaT4crHXC5iyWkWlpFw=
X-Google-Smtp-Source: AA6agR4EgecDTl6UI+p25R1waF7AZbUZYxE05m4vulln0wVhvm63zGP+4CzeGIGoTJiO4AQ6fMliFQ==
X-Received: by 2002:ac8:5a4b:0:b0:344:92b0:9d88 with SMTP id o11-20020ac85a4b000000b0034492b09d88mr440238qta.284.1661530909785;
        Fri, 26 Aug 2022 09:21:49 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id i13-20020a05620a248d00b006baed8f3a2esm15640qkn.103.2022.08.26.09.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Aug 2022 09:21:49 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailauth.nyi.internal (Postfix) with ESMTP id A28F027C005A;
        Fri, 26 Aug 2022 12:21:48 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Fri, 26 Aug 2022 12:21:48 -0400
X-ME-Sender: <xms:HPMIY9EzZ435EZ7iXnVPHI-_sz9I3ELV_i-zdcoWUvH0acZnkEBJ7w>
    <xme:HPMIYyXyIDiuNH4ISRM3yjJUxzoo970VCHTRECBp9TT4K9g6BiFJFF0-L9DeIgu1Q
    30cFoiZUKFCfuR_Ag>
X-ME-Received: <xmr:HPMIY_KvEMdV4qnDYorjZiRxU1OmO7Px854u8j12a0skhfd9uJk0Xg4QnYI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejhedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtkeertddttddunecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepleeggfehieeggfevveeuvdfgledtkeethedvveejffdugfevtdevudej
    heeljedtnecuffhomhgrihhnpegrrhigihhvrdhorhhgpdhgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:HPMIYzHCKRQxdSqFJwx2fBYZPOVTyl1GRyI7nGF191RHwT9N62PfyQ>
    <xmx:HPMIYzV5r9kSz6L9VfkW-HZlZ6oueWFecKDFEInpClJBYIRIOjIYag>
    <xmx:HPMIY-PVXor9ZCfYir0ry-JCM_dH01zFVZVV8gEPv4FRR39n45C44Q>
    <xmx:HPMIYwXmTEp0o0QoI1ky9vR8APvBYIuC89mq_K-1kcJI5LA0r-gDoA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 Aug 2022 12:21:47 -0400 (EDT)
Date:   Fri, 26 Aug 2022 09:21:03 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     stern@rowland.harvard.edu, parri.andrea@gmail.com, will@kernel.org,
        peterz@infradead.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <Ywjy71aazWmNUHbJ@boqun-archlinux>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Aug 26, 2022 at 05:48:12AM -0700, Paul E. McKenney wrote:
> Hello!
> 
> I have not yet done more than glance at this one, but figured I should
> send it along sooner rather than later.
> 
> "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
> Memory Models", Antonio Paolillo, Hernán Ponce-de-León, Thomas
> Haas, Diogo Behrens, Rafael Chehab, Ming Fu, and Roland Meyer.
> https://arxiv.org/abs/2111.15240
> 
> The claim is that the queued spinlocks implementation with CNA violates
> LKMM but actually works on all architectures having a formal hardware
> memory model.
> 

Translate one of their litmus test into a runnable one (there is a typo
in it):

	C queued-spin-lock

	(*
	 * P0 is lock-release
	 * P1 is xchg_tail()
	 * P2 is lock-acquire
	 *)

	{}

	P0(int *x, atomic_t *l)
	{
	  WRITE_ONCE(*x, 1);
	  atomic_set_release(l, 1);
	}

	P1(int *x, atomic_t *l)
	{
	 int val;
	 int new;
	 int old;
	 
	 val = atomic_read(l);
	 new = val + 2;
	 old = atomic_cmpxchg_relaxed(l, val, new);
	}

	P2(int *x, atomic_t *l)
	{
	 int r0 = atomic_read_acquire(l);
	 int r1 = READ_ONCE(*x);
	}

	exists (2:r0=3 /\ 2:r1=0)

According to LKMM, the exist-clause could be triggered because:

	po-rel; coe: rfe; acq-po

is not happen-before in LKMM. Alan actually explain why at a response to
a GitHub issue:

	https://github.com/paulmckrcu/litmus/issues/11#issuecomment-1115235860

(Paste Alan's reply)

"""
As for why the LKMM doesn't require ordering for this test...  I do not
believe this is related to 2+2W.  Think instead in terms of the LKMM's
operational model:

	The store-release in P0 means that the x=1 write will propagate
	to each CPU before the y=1 write does.

	Since y=3 at the end, we know that y=1 (and hence x=1 too)
	propagates to P1 before the addition occurs.  And we know that
	y=3 propagates to P2 before the load-acquire executes.

	But we _don't_ know that either y=1 or x=1 propagates to P2
	before y=3 does!  If the store in P1 were a store-release then
	this would have to be true (as you saw in your tests), but it
	isn't.

In other words, the litmus test could execute with the following
temporal ordering:

	P0		P1		P2
	----------	---------	----------
	Write x=1
	Write y=1

		[x=1 and y=1 propagate to P1]

			Read y=1
			Write y=3

		[y=3 propagates to P2]

					Read y=3
					Read x=0

		[x=1 and y=1 propagate to P2]

(Note that when y=1 propagates to P2, it doesn't do anything because it
won't overwrite the coherence-later store y=3.)

It may be true that none of the architectures supported by Linux will
allow this outcome for the test (although I suspect that the PPC-weird
version _would_ be allowed if you fixed it).  At any rate, disallowing
this result in the memory model would probably require more effort than
would be worthwhile.

Alan
"""

The question is that whether we "fix" LKMM because of this, or we
mention explicitly this is something "unsupported" by LKMM yet?

Regards,
Boqun

> Thoughts?
> 
> 							Thanx, Paul
