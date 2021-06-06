Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2697339D093
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 21:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229573AbhFFTIx (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 15:08:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:60900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhFFTIx (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 15:08:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F03EE61008;
        Sun,  6 Jun 2021 19:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623006423;
        bh=d2HVLIJRxM3MJUJzNoNPukJKGJ4n+a/NjzxsdmX/Ht4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IFoz5fTDF3rbV7e6pETWK8GY2s/H+L/kS0UI7rnuoNfu9HZxd4zyy0MpexWZs6N3D
         0BpMxhG304kW9LgPnT6+2UvT0VdoBSOL1auWyA9WxCp/YzIVl9sYJWL8LPIRu9VSES
         MdbjpHpWMk9Yo0A9qX1SO7rIHCZS8IBmPqBRHpwBcIAw1ND2I8mwwgnfJ+yxxaB7A9
         uWsBgQq91qun47ev3o3GYyis6LRyTGCD+Qeg2R3ms1VWrvEy6r6mLKgAnBU7yhn/zM
         ZSMRrbCw4DTWio+HsE3p7F2QTrrMtHgV0f/rTa5utI+g9P0J/KV9egbeygelPlWHt6
         vLV8G9aXndgTA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id BCD105C014A; Sun,  6 Jun 2021 12:07:02 -0700 (PDT)
Date:   Sun, 6 Jun 2021 12:07:02 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210606190702.GL4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606044333.GI4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606131740.GU18427@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606131740.GU18427@gate.crashing.org>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 08:17:40AM -0500, Segher Boessenkool wrote:
> On Sat, Jun 05, 2021 at 09:43:33PM -0700, Paul E. McKenney wrote:
> > So gcc might some day note a do-nothing asm and duplicate it for
> > the sole purpose of collapsing the "then" and "else" clauses.  I
> > guess I need to keep my paranoia for the time being, then.  :-/
> 
> Or a "do-something" asm, even.  What it does is make sure it is executed
> on the real machine exactly like on the abstract machine.  That is how C
> is defined, what a compiler *does*.
> 
> The programmer does not have any direct control over the generated code.

I am not looking for direct control, simply sufficient influence.  ;-)

> > Of course, there is no guarantee that gcc won't learn about
> > assembler constants.  :-/
> 
> I am not sure what you call an "assembler constant" here.  But you can
> be sure that GCC will not start doing anything here.  GCC does not try
> to understand what you wrote in an inline asm, it just fills in the
> operands and that is all.  It can do all the same things to it that it
> can do to any other code of course: duplicate it, deduplicate it,
> frobnicate it, etc.

Apologies, that "assembler constants" should have been "assembler
comments".

							Thanx, Paul
