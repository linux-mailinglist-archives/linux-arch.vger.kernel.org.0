Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAADD39E832
	for <lists+linux-arch@lfdr.de>; Mon,  7 Jun 2021 22:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231358AbhFGUSZ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 7 Jun 2021 16:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:42640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231224AbhFGUSZ (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 7 Jun 2021 16:18:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B49FE61073;
        Mon,  7 Jun 2021 20:16:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623096993;
        bh=08gdxzwURDe4wevJoXlpjWkpdnSHetVYI9KdbuJxJIg=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=AtFXfnPS4Szh2Z6ZmNAQ+xxTkQqi7crC5FolBg6VG5tgD33qbnxyTS7ug5ULagq3B
         sg4XgM2U0MRv747LzCkVrJrwH/KGh+SgvcvdoiuerOiIt4sxHMO18T5H6qKh+N3Nqs
         MO/BQDffLnSxYXJGXidEMMq35ueHM+8cTwAvp/duFRgq7VnxdzBifTuLFML/dSMpGa
         iDFsclD7HBmMjXbNMvE9lMGm5Y9BHolcXgJSxBQ5tDEGMltSY0asOsGWfVn9BQS0eG
         U6hG+moKyHgkrCdRYls1gq32AXcWHilz0R38Us2Z+EEMy3RPYblaTUg2veZqnzS/a7
         Qxox7FF0NiMOQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 7FDDF5C0395; Mon,  7 Jun 2021 13:16:33 -0700 (PDT)
Date:   Mon, 7 Jun 2021 13:16:33 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Message-ID: <20210607201633.GW4397@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210606184021.GY18427@gate.crashing.org>
 <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
 <20210606195242.GA18427@gate.crashing.org>
 <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
 <20210606202616.GC18427@gate.crashing.org>
 <20210606233729.GN4397@paulmck-ThinkPad-P17-Gen-1>
 <20210607141242.GD18427@gate.crashing.org>
 <20210607152712.GR4397@paulmck-ThinkPad-P17-Gen-1>
 <20210607182335.GI18427@gate.crashing.org>
 <20210607195144.GC1779688@rowland.harvard.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210607195144.GC1779688@rowland.harvard.edu>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Jun 07, 2021 at 03:51:44PM -0400, Alan Stern wrote:
> On Mon, Jun 07, 2021 at 01:23:35PM -0500, Segher Boessenkool wrote:
> > On Mon, Jun 07, 2021 at 08:27:12AM -0700, Paul E. McKenney wrote:
> > > > > > > The barrier() thing can work - all we need to do is to simply make it
> > > > > > > impossible for gcc to validly create anything but a conditional
> > > > > > > branch.
> > 
> > > > > What would you suggest as a way of instructing the compiler to emit the
> > > > > conditional branch that we are looking for?
> > > > 
> > > > You write it in the assembler code.
> > > > 
> > > > Yes, it sucks.  But it is the only way to get a branch if you really
> > > > want one.  Now, you do not really need one here anyway, so there may be
> > > > some other way to satisfy the actual requirements.
> > > 
> > > Hmmm...  What do you see Peter asking for that is different than what
> > > I am asking for?  ;-)
> > 
> > I don't know what you are referring to, sorry?
> > 
> > I know what you asked for: literally some way to tell the compiler to
> > emit a conditional branch.  If that is what you want, the only way to
> > make sure that is what you get is by writing exactly that in assembler.
> 
> That's not necessarily it.
> 
> People would be happy to have an easy way of telling the compiler that 
> all writes in the "if" branch of an if statement must be ordered after 
> any reads that the condition depends on.  Or maybe all writes in either 
> the "if" branch or the "else" branch.  And maybe not all reads that the 
> condition depends on, but just the reads appearing syntactically in the 
> condition.  Or maybe even just the volatile reads appearing in the 
> condition.  Nobody has said exactly.
> 
> The exact method used for doing this doesn't matter.  It could be 
> accomplished by treating those reads as load-acquires.  Or it could be 
> done by ensuring that the object code contains a dependency (control or 
> data) from the reads to the writes.  Or it could be done by treating 
> the writes as store-releases.  But we do want the execution-time 
> penalty to be small.
> 
> In short, we want to guarantee somehow that the conditional writes are 
> not re-ordered before the reads in the condition.  (But note that 
> "conditional writes" includes identical writes occurring in both 
> branches.)

What Alan said!  ;-)

							Thanx, Paul
