Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A8C3DE151
	for <lists+linux-arch@lfdr.de>; Mon,  2 Aug 2021 23:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbhHBVSw (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 2 Aug 2021 17:18:52 -0400
Received: from netrider.rowland.org ([192.131.102.5]:35477 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S231397AbhHBVSv (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Mon, 2 Aug 2021 17:18:51 -0400
Received: (qmail 345682 invoked by uid 1000); 2 Aug 2021 17:18:41 -0400
Date:   Mon, 2 Aug 2021 17:18:41 -0400
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
Message-ID: <20210802211841.GB344022@rowland.harvard.edu>
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

More comments...

I find the herd-style diagrams (Figures 2, 3, 5, 7, 9, and so on) almost 
impossible to decipher.  While they might be useful to people running 
herd, they have several drawbacks for readers of this report:

	They include multiple instructions, not just the one for which
	you want to illustrate the internal dependencies.  How about
	getting rid of the extraneous instructions?

	Each box contains three lines of information, of which only the
	first is really significant, and it is hard to figure out.  How 
	about getting rid of the second and third lines, and replacing
	things like "e: R0:X1q=x" in the first line with something more
	along the lines of "RegR X0" or "tmp1 = RegR X0"?

	The "iico" in the dependency arrows doesn't add anything.

Section 1.1 mentions order, data, and control Intrinsic dependencies but 
doesn't give so much as a hint as to what they are.  Instead the reader 
is forced to invent his own generalizations by reading through several 
complex special-case examples.  There should be a short description of 
what each Intrinsic dependency represents.  For instance, the first 
sentence in 1.3 would be a great way to explain data dependencies.  (And 
is it not true that control dependencies are mainly needed for 
situations where an instruction's inputs and outputs may include the 
same register or memory address, when it is necessary to enforce that 
the input value is read before the output value is written?)

Some of the dependencies listed for CAS are surprising, but there is no 
explanation.  Why is C2 a control dependency rather than a data 
dependency?  After all, the value read from [Xn] is stored in Xs in both 
cases.  In fact, Df1 supersedes C2 in the failure case, doesn't it?  And 
why are C1 and Ds1 a control and data dependency respectively rather 
than both order dependencies?

Section 2.1: Although the Store F is independent of the conditional 
branch and so might be made visible to other observers early, isn't it 
true that neither ARMv8 nor any other type of processor will do this?

General question: How does this discussion of conditional branches 
relate overall to the way computed branches are handled?

Alan
