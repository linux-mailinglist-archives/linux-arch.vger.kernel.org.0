Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD9139D0E6
	for <lists+linux-arch@lfdr.de>; Sun,  6 Jun 2021 21:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhFFTRa (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Sun, 6 Jun 2021 15:17:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:57352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230340AbhFFTRT (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Sun, 6 Jun 2021 15:17:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 532AB61287;
        Sun,  6 Jun 2021 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623006929;
        bh=wvJiq1aGB+9WeuKZmWAPp0jOhE+zr1mmCVbd1NGNGRA=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=kkj7nPcFYhr1VThzJW/TU+bNYpzdLKj6i9sie9zIil+K0cEyI9g16ci+In9LCUNjZ
         8aVyEiDB6g7mz6Y5Lz86BaXOc95NzCy8Ixq3HLprgtWlG+/OK7/0Y2/j8b2GjSVFOy
         8dRsgrKOGGkZuAJIKp8042ayAXHtW/ins+nCOuzbzsa7O8Sk9UN9ivQ+ywiw7wtT2m
         gq7RekJk7T0gvYWXbiKeMKgcx6spjoGrgK4yy7EdBscPjMs4Z5/UrkZ6hmLmW3cfyO
         B9OkooxTjqUr7VvwF7SV7wGtPiSBzZRPKHNGpa+9fAH5yeRxAnpp5HVU2ev85ZNend
         TZB5vp9SW01KQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 1F6B05C014A; Sun,  6 Jun 2021 12:15:29 -0700 (PDT)
Date:   Sun, 6 Jun 2021 12:15:29 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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
Message-ID: <20210606191529.GM4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1>
 <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210606185922.GF7746@tucnak>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Jun 06, 2021 at 08:59:22PM +0200, Jakub Jelinek wrote:
> On Sat, Jun 05, 2021 at 08:41:00PM -0700, Linus Torvalds wrote:
> > Something like this *does* seem to work:
> > 
> >    #define ____barrier(id) __asm__ __volatile__("#" #id: : :"memory")
> >    #define __barrier(id) ____barrier(id)
> >    #define barrier() __barrier(__COUNTER__)
> > 
> > which is "interesting" or "disgusting" depending on how you happen to feel.
> 
> I think just
> #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> should be enough (or "X" instead of "i" if some arch uses -fpic and will not
> accept small constants in PIC code), for CSE gcc compares that the asm template
> string and all arguments are the same.

This does seem to do the trick: https://godbolt.org/z/K5j3bYqGT

So thank you for that!

							Thanx, Paul

> As for volatile, that is implicit on asm without any output operands and
> it is about whether the inline asm can be DCEd, not whether it can be CSEd.
> 
> 	Jakub
> 
