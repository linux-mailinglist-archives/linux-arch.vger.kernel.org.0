Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34D73DBFDD
	for <lists+linux-arch@lfdr.de>; Fri, 30 Jul 2021 22:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbhG3Ufr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Fri, 30 Jul 2021 16:35:47 -0400
Received: from netrider.rowland.org ([192.131.102.5]:46761 "HELO
        netrider.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with SMTP id S230418AbhG3Ufr (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Fri, 30 Jul 2021 16:35:47 -0400
Received: (qmail 265720 invoked by uid 1000); 30 Jul 2021 16:35:41 -0400
Date:   Fri, 30 Jul 2021 16:35:41 -0400
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
Message-ID: <20210730203541.GA262784@rowland.harvard.edu>
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
> Dear all,

> Sincere apologies in taking so long to reply. I attach a technical
> report which describes the status of dependencies in the Arm memory
> model. 
> 
> I have also released the corresponding cat files and a collection of
> interesting litmus tests over here:
> https://github.com/herd/herdtools7/commit/f80bd7c2e49d7d3adad22afc62ff4768d65bf830
> 
> I hope this material can help inform this conversation and I would love
> to hear your thoughts.

Jade:

Here are a few very preliminary reactions (I haven't finished reading the 
entire paper yet).

P.2: Typo: "the register X1 contains the address x" should be "the 
register X1 contains the address of x".

P.4 and later: Several complicated instructions (including CSEL, CAS, and 
SWP) are mentioned but not explained; the text assumes that the reader 
already understands what these instructions do.  A brief description of 
their effects would help readers like me who aren't very familiar with the 
ARM instruction set.

P.4: The text describing Instrinsic dependencies in CSEL instructions says 
that if cond is true then there is an Intrinsic control dependencies from 
the read of PSTATE.NZCV to the read of Xm.  Why is this so?  Can't the CPU 
read Xm unconditionally before it knows whether the value will be used?

P.17: The definition of "Dependency through registers" uses the acronym 
"PE", but the acronym isn't defined anywhere.

P.14: In the description of Figure 18, I wasn't previously aware -- 
although perhaps I should have been -- that ARM could speculatively place 
a Store in a local store buffer, allowing it to be forwarded to a po-later 
Read.  Why doesn't the same mechanism apply to Figure 20, allowing the 
Store in D to be speculatively placed in a local store buffer and 
forwarded to E?  Is this because conditional branches are predicted but 
loads aren't?  If so, that is a significant difference.

More to come...

Alan
