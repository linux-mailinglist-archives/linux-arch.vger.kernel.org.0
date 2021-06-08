Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9A0439FAD1
	for <lists+linux-arch@lfdr.de>; Tue,  8 Jun 2021 17:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhFHPgZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Tue, 8 Jun 2021 11:36:25 -0400
Received: from gate.crashing.org ([63.228.1.57]:34923 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231842AbhFHPgY (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Tue, 8 Jun 2021 11:36:24 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 158FStNV014004;
        Tue, 8 Jun 2021 10:28:55 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 158FSp5w013994;
        Tue, 8 Jun 2021 10:28:51 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Tue, 8 Jun 2021 10:28:51 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Monakov <amonakov@ispras.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jakub Jelinek <jakub@redhat.com>,
        Alan Stern <stern@rowland.harvard.edu>,
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
Message-ID: <20210608152851.GX18427@gate.crashing.org>
References: <20210606185922.GF7746@tucnak> <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com> <alpine.LNX.2.20.13.2106070017070.7184@monopod.intra.ispras.ru> <CAHk-=wjwXs5+SOZGTaZ0bP9nsoA+PymAcGE4CBDVX3edGUcVRg@mail.gmail.com> <alpine.LNX.2.20.13.2106070956310.7184@monopod.intra.ispras.ru> <CANpmjNMwq6ENUtBunP-rw9ZSrJvZnQw18rQ47U3JuqPEQZsaXA@mail.gmail.com> <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com> <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com> <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Tue, Jun 08, 2021 at 01:22:58PM +0200, Peter Zijlstra wrote:
> Works for me; and note how it mirrors how we implemented volatile_if()
> in the first place, by doing an expression wrapper.
> 
> __builtin_ctrl_depends(expr) would have to:
> 
>  - ensure !__builtin_const_p(expr)	(A)

Why would it be an error if __builtin_constant_p(expr)?  In many
programs the compiler can figure out some expression does never change.
Having a control dependency on sometthing like that is not erroneous.

>  - imply an acquire compiler fence	(B)
>  - ensure cond-branch is emitted	(C)

(C) is almost impossible to do.  This should be reformulated to talk
about the effect of the generated code, instead.

> *OR*
> 
>  - ensure !__builtin_const_p(expr);		(A)
>  - upgrade the load in @expr to load-acquire	(D)

So that will only work if there is exactly one read from memory in expr?
That is problematic.

This needs some work.


Segher
