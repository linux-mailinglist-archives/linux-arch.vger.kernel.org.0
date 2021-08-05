Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E15AA3E1CF7
	for <lists+linux-arch@lfdr.de>; Thu,  5 Aug 2021 21:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238800AbhHETsF (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 5 Aug 2021 15:48:05 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35765 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S237055AbhHETsE (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Thu, 5 Aug 2021 15:48:04 -0400
Received: (qmail 436831 invoked by uid 1000); 5 Aug 2021 15:47:49 -0400
Date:   Thu, 5 Aug 2021 15:47:49 -0400
From:   Alan Stern <stern@rowland.harvard.edu>
To:     Jade Alglave <j.alglave@ucl.ac.uk>
Cc:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
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
Message-ID: <20210805194749.GA436115@rowland.harvard.edu>
References: <20210605145739.GB1712909@rowland.harvard.edu>
 <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu>
 <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606182213.GA1741684@rowland.harvard.edu>
 <CAHk-=whDrTbYT6Y=9+XUuSd5EAHWtB9NBUvQLMFxooHjxtzEGA@mail.gmail.com>
 <YL34NZ12mKoiSLvu@hirez.programming.kicks-ass.net>
 <20210607115234.GA7205@willie-the-truck>
 <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210730172020.GA32396@knuckles.cs.ucl.ac.uk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Fri, Jul 30, 2021 at 06:20:22PM +0100, Jade Alglave wrote:
> I hope this material can help inform this conversation and I would love
> to hear your thoughts.

Thoughts on section 3...

The paragraph on Branching Effect is pretty meager.  Exactly what 
effects does a conditional branch instruction generate?  I imagine 
there's a register read of the flags register, to see whether the branch 
should be taken.  And evidently there's a branch effect, which may take 
the register read as input but doesn't have any obvious outputs.  
Anything else? -- there don't seem to be any register writes.

Why are Store Exclusive instructions explicitly disallowed in the 
definition of dependency through registers?  Is this because ARM CPUs 
don't forward values written by such instructions to po-later reads?  If 
so, why don't they?  (Paul asked a similar question.)

Since the recursive definition of dependency through registers starts 
with either a register write or intrinsic order of events in an 
instruction, it appears that there cannot be any dependency through 
registers starting from a branching effect.  So why does the definition 
of address dependency talk about a dependency through registers from B4 
(a branching effect) to R2?  (Paul also asked about this -- does writing 
to the program counter get treated as a register write?  But almost no 
instructions explicitly read from the program counter.)

What is the whole point of the special handling of branching effects in 
the definition of address dependencies?  It isn't obvious and the text 
doesn't explain it.

Figure 26 includes a lot of terms that seem like herd primitives.  They 
must be relatively new, because they aren't mentioned in the 
documentation that I've got.  (I'm referring to such terms as iico_data, 
iico_ctrl, intrinsic, same-instance, DATA, and NDATA.)  Are they 
explained anywhere?

Way back in Section 1, various Intrinsic dependency relations were 
introduced.  The reason for treating Intrinsic control dependencies 
specially seems to be that the CPU can speculate past such dependencies 
(though it would be nice if the text made this point explicitly).  But 
why do you differentiate between data and order Intrinsic dependencies?  
Is this also related to some specific behavior of ARM CPUs?

Alan
