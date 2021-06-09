Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3093A1E1B
	for <lists+linux-arch@lfdr.de>; Wed,  9 Jun 2021 22:30:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFIUcD (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 9 Jun 2021 16:32:03 -0400
Received: from gate.crashing.org ([63.228.1.57]:51896 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIUcC (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 9 Jun 2021 16:32:02 -0400
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 159KOVoh018172;
        Wed, 9 Jun 2021 15:24:31 -0500
Received: (from segher@localhost)
        by gate.crashing.org (8.14.1/8.14.1/Submit) id 159KOR2Q018166;
        Wed, 9 Jun 2021 15:24:27 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to segher@kernel.crashing.org using -f
Date:   Wed, 9 Jun 2021 15:24:27 -0500
From:   Segher Boessenkool <segher@kernel.crashing.org>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Marco Elver <elver@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
Message-ID: <20210609202427.GK18427@gate.crashing.org>
References: <20210607152806.GS4397@paulmck-ThinkPad-P17-Gen-1> <YL5Risa6sFgnvvnG@elver.google.com> <CANpmjNNtDX+eBEpuP9-NgT6RAwHK5OgbQHT9b+8LZQJtwWpvPg@mail.gmail.com> <YL9TEqealhxBBhoS@hirez.programming.kicks-ass.net> <20210608152851.GX18427@gate.crashing.org> <CANpmjNPJaDT4vBqkTw8XaRfKgDuwh71qmrvNfq-vx-Zyp4ugNg@mail.gmail.com> <20210609153133.GF18427@gate.crashing.org> <CANpmjNPq3NBhi_pFpNd6TwXOVjw0LE2NuQ63dWZrYSfEet3ChQ@mail.gmail.com> <20210609171419.GI18427@gate.crashing.org> <CAKwvOdn0t-z9pa5csvqSEJ1LLnwef8HQwZzfJgdkddN6GVZpXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdn0t-z9pa5csvqSEJ1LLnwef8HQwZzfJgdkddN6GVZpXA@mail.gmail.com>
User-Agent: Mutt/1.4.2.3i
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, Jun 09, 2021 at 10:31:13AM -0700, Nick Desaulniers wrote:
> On Wed, Jun 9, 2021 at 10:20 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Wed, Jun 09, 2021 at 06:13:00PM +0200, Marco Elver wrote:
> > > On Wed, 9 Jun 2021 at 17:33, Segher Boessenkool
> > > <segher@kernel.crashing.org> wrote:
> > > [...]
> > > > > An alternative design would be to use a statement attribute to only
> > > > > enforce (C) ("__attribute__((mustcontrol))" ?).
> > > >
> > > > Statement attributes only exist for empty statements.  It is unclear how
> > > > (and if!) we could support it for general statements.
> > >
> > > Statement attributes can apply to anything -- Clang has had them apply
> > > to non-empty statements for a while.
> >
> > First off, it is not GCC's problem if LLVM decides to use a GCC
> > extension in some non-compatible way.
> 
> Reminds me of
> https://lore.kernel.org/lkml/CAHk-=whu19Du_rZ-zBtGsXAB-Qo7NtoJjQjd-Sa9OB5u1Cq_Zw@mail.gmail.com/

And my reply to that
https://lore.kernel.org/lkml/20200910154423.GK28786@gate.crashing.org/


Segher
