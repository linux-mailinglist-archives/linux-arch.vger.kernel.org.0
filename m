Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6D3E0929
	for <lists+linux-arch@lfdr.de>; Wed,  4 Aug 2021 22:09:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbhHDUKE (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 4 Aug 2021 16:10:04 -0400
Received: from netrider.rowland.org ([192.131.102.5]:43349 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S239660AbhHDUKE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 4 Aug 2021 16:10:04 -0400
Received: (qmail 408211 invoked by uid 1000); 4 Aug 2021 16:09:50 -0400
Date:   Wed, 4 Aug 2021 16:09:50 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Jade Alglave <j.alglave@ucl.ac.uk>, Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC] LKMM: Add volatile_if()
Message-ID: <20210804200950.GA406916@rowland.harvard.edu>
References: <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
 <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
 <20210802233156.GM4397@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210802233156.GM4397@paulmck-ThinkPad-P17-Gen-1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Mon, Aug 02, 2021 at 04:31:56PM -0700, Paul E. McKenney wrote:
> o	Section 2 I leave in Alan's capable hands.

Here goes, although I'm not sure how important this is, given that 
section 2 is presented as merely a "straw man" argument for something 
that ARM decided to abandon.

While reading this section (and the paper in general), it was annoying 
that the terms "down-one-leg" and "down-two-legs" are never explained or 
motivated.  Even after reading section 2, I'm still not sure what they 
are really intended to mean.  My impression is that "down-one-leg" is an 
attempt to express the idea that control dependencies apply to accesses 
occurring along one leg of a conditional but not to accesses occurring 
after the two legs have rejoined.  Is that right?

P.17: "The drawback of this approach is that it would require order for 
the “independent” case" -- this doesn't seem like a drawback to me.  
Particularly since no existing architecture attempts to avoid ordering 
the independent case.

Def. of "points of divergence": This is not very precise.  What exactly 
is a "branching decision"?  Do the two paths of a CAS or CSEL 
instruction count?  What if the decision doesn't involve whether or not 
to take the branch but rather where to branch to (as in a computed 
branch or even just a call through a function pointer)?

Def. of "address dependency": How could there be a Dependency through 
registers from D4 to R2?  It's not at all easy to untangle the 
definitions to see what this might mean.  What would be an example?  At 
any rate, the case where RW2 is a Memory read doesn't seem right.  It 
says that:

	R0 = Load
	R1 = Load([R0])

is an address dependency but

	R0 = Load
	// Branching decision that depends on the value of R0 and
	// carries a Dependency through registers to a new value for
	// R0 (whatever that may mean) which is always equal to the
	// existing value 
	R1 = Load([R0])

isn't.  Is this really what you mean?  If so, what is the motivation for 
this definition?  How does it relate to the discussion earlier in this 
section?

Def. of antecedent: What is a Local read successor or an immediate Local 
write successor?  These terms aren't defined, and without knowing what 
they mean it is impossible to understand what an antecedent is.

Def. of pre-equivalent effects and related terms: I don't understand how 
you can have effects on different branches of a Point of divergence.  By 
definition, only one of the branches is executed -- how can there be any 
effects on the speculated branch?

With all these concepts being so unclear, I was completely unable to 
figure out what the definition of control dependency means.  The text 
doesn't help at all, because it doesn't contain any examples or 
explanations to make these things more comprehensible.

The formalization in cat may have some historical interest, but it 
conveys no information to a reader who isn't prepared to spend hours or 
days trying to decipher it.  Honestly, do you know _anybody_ who could 
tell what Figures 22 - 25 mean and what they do just from reading them?  
You pretty much have to be an expert in cat just to tell what some of 
the recursive functions in Figs. 23 and 24 do.

(As just one very minor example, the "bisimulation" function in the 
fourth-to-last line of Figure 25 isn't mentioned anywhere else.  How are 
people supposed to understand it?)

Alan
