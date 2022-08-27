Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2912A5A38D9
	for <lists+linux-arch@lfdr.de>; Sat, 27 Aug 2022 18:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbiH0QpM (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sat, 27 Aug 2022 12:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbiH0QpL (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Sat, 27 Aug 2022 12:45:11 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 151FA37FAE;
        Sat, 27 Aug 2022 09:45:08 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id s1so3359026qvn.11;
        Sat, 27 Aug 2022 09:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc;
        bh=ZhfbAHlPQFx8IPZok5WapkkflkTEU7J+fDiYrhhmxIA=;
        b=M0b5ENI57ijrrSBOdqsI4nNWdePJhQB34ojLnGx1NLyBtuxthw5HlWP80AiqIjk3lU
         P+4RUXrRoTcBjhATVcFtXruNMuUNuq5BfeWxNcVYkhW7BRJb77nwQFSn/SSa9GWuBftT
         X/XfiA7vA+5aXegoOnnIsISEdiPbJI81WGEtV9CC0VVX3MWrFOhfjuMfH2x99/uOOubr
         aeb78qeaalSJoe7g7YFhlYJlRMff+XiTQRvKZ+Hv07z2YlMmENAYl3wG/9JIT+utk58T
         ti0+hXqvLSktqm0iREGzUKghPcnhEvABZEDtSQc7UuFUhwfAC0O6CQVogaiJZecAMOD4
         03vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc;
        bh=ZhfbAHlPQFx8IPZok5WapkkflkTEU7J+fDiYrhhmxIA=;
        b=zTh8Bi0RRA0wLbb8980hj52yZK5enVQrq9wXmx13yoeYRdQu14J8aS8rhOcoXVVhe7
         jNJIP71/74A7ROQgBLq/M0ceaer/key3URlycg7X5hDd3oV5yKNYajlxQ7PvaROF3HFK
         bRUzp3RJunqBLs9645mnpBinOW2ZzcL4izx3WPZN4nnUaPkUREQer+v5L/ubR3UrT3Gk
         swb6ryRJuYz/J2CNltNCx9yohKas57nqUhKoP4Lzh8jSJ74daMuiAlac7eQWSJt/GRcr
         FFnii6N5er2yccqj5MND6z12qpXIR9KWFyoiy7DfnF7Fh8RwEI8ZVm8ChZcDY6+OkfxC
         Dd4A==
X-Gm-Message-State: ACgBeo0WelIyAKEzUwN0sZWMeVxw6CL9XACqZax+ivmhNmc+NfxUm+KS
        KSMLW2cqqwackZFNWN/whJBF2/rk3QE=
X-Google-Smtp-Source: AA6agR4EA7lK9MqSZtDKKlmHSyAAvzyqsEy9HxXgmoadwDV/yIFxuEYAmu1UBax8Q8IbbfSdHwJjxw==
X-Received: by 2002:a05:6214:5005:b0:472:e6b0:1fb2 with SMTP id jo5-20020a056214500500b00472e6b01fb2mr4073953qvb.124.1661618707237;
        Sat, 27 Aug 2022 09:45:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id j10-20020ac874ca000000b003434e47515csm1886500qtr.7.2022.08.27.09.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 09:45:06 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 0935527C0054;
        Sat, 27 Aug 2022 12:45:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 27 Aug 2022 12:45:06 -0400
X-ME-Sender: <xms:EUoKYyZfV3VCiI4JA7zHq8TLwZJ3TUUZv-qw6fi39l9fitEprqE-9g>
    <xme:EUoKY1bDrWj3bmnYa5T5_GUfTvuL1wt4ukpp9Sw76b4Omr_vdXJEikVdI-QDGfoTD
    fZR3az1CrVzSt4E_w>
X-ME-Received: <xmr:EUoKY8_HI06AHdxs4QrKJxRrbgPcymeufln6GzuyevWnK9kfEAN5RCOHLG0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdejjedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnheptdegffdugfefhfdugfeiheefheekudehfeeiieegleegheejleefieek
    veeuhfdunecuffhomhgrihhnpegvvghlrdhishdpiihulhhiphgthhgrthdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhn
    odhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejje
    ekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhn
    rghmvg
X-ME-Proxy: <xmx:EUoKY0p5d2QWI2Cl3lufmV5wxPM_dJ8N7kfW6wY15UvhYIRBTkqz_Q>
    <xmx:EUoKY9rkUlaGjn0utSIrYVuRTVorsivMl07V0qK5qZqhENuLTPUcqg>
    <xmx:EUoKYyTpxcDwfsyXUE-KJErT1iNoOtgwhNwtw27KQuz62hZ2Lo7ZLQ>
    <xmx:EUoKY-6RAy8gCB6IwjQR6jQMYIjTiwcZOJJ1ka1WXClZPN_g3KTgjQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 27 Aug 2022 12:45:04 -0400 (EDT)
Date:   Sat, 27 Aug 2022 09:44:17 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, parri.andrea@gmail.com,
        will@kernel.org, npiggin@gmail.com, dhowells@redhat.com,
        j.alglave@ucl.ac.uk, luc.maranget@inria.fr, akiyks@gmail.com,
        dlustig@nvidia.com, joel@joelfernandes.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: "Verifying and Optimizing Compact NUMA-Aware Locks on Weak
 Memory Models"
Message-ID: <YwpJ4ZPVbuCnnFKS@boqun-archlinux>
References: <20220826124812.GA3007435@paulmck-ThinkPad-P17-Gen-1>
 <YwjzfASTcODOXP1f@worktop.programming.kicks-ass.net>
 <Ywj+j2kC+5xb6DmO@rowland.harvard.edu>
 <YwlbpPHzp8tj0Gn0@hirez.programming.kicks-ass.net>
 <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YwpAzTwSRCK5kdLN@rowland.harvard.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sat, Aug 27, 2022 at 12:05:33PM -0400, Alan Stern wrote:
> On Sat, Aug 27, 2022 at 01:47:48AM +0200, Peter Zijlstra wrote:
> > On Fri, Aug 26, 2022 at 01:10:39PM -0400, Alan Stern wrote:
> > 
> > > >  - some babbling about a missing propagation -- ISTR Linux if stuffed
> > > >    full of them, specifically we require stores to auto propagate
> > > >    without help from barriers
> > > 
> > > Not a missing propagation; a late one.
> > > 
> > > Don't understand what you mean by "auto propagate without help from 
> > > barriers".
> > 
> > Linux hard relies on:
> > 
> > 	CPU0				CPU1
> > 
> > 	WRITE_ONCE(foo, 1);		while (!READ_ONCE(foo));
> > 
> > making forward progress.
> 
> Indeed yes.  As far as I can tell, this requirement is not explicitly 
> mentioned in the LKMM, although it certainly is implicit.  I can't even 
> think of a way to express it in a form Herd could verify.
> 

FWIW, C++ defines this as (in https://eel.is/c++draft/atomics#order-11):

	Implementations should make atomic stores visible to atomic
	loads within a reasonable amount of time.

in other words:

if one thread does an atomic store, then all other threads must see that
store eventually.

(from: https://rust-lang.zulipchat.com/#narrow/stream/136281-t-lang.2Fwg-unsafe-code-guidelines/topic/Rust.20forward.20progress.20guarantees/near/294702950)

Should we add something somewhere in our model, maybe in the
explanation.txt?

Plus, I think we cannot express this in Herd because Herd uses
graph-based model (axiomatic model) instead of an operational model to
describe the model: axiomatic model cannot describe "something will
eventually happen". There was also some discussion in the zulip steam
of Rust unsafe-code-guidelines.

Regards,
Boqun

> > There were a few 'funny' uarchs that were broken, see for example commit
> > a30718868915f.
> 
> Ha!  That commit should be a lesson in something, although I'm not sure 
> what.  :-)
> 
> Alan
