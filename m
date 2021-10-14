Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B134242CF5D
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 02:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbhJNADJ (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Wed, 13 Oct 2021 20:03:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:34200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229677AbhJNADI (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Wed, 13 Oct 2021 20:03:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 102CF61130;
        Thu, 14 Oct 2021 00:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634169665;
        bh=xQ9stP59+c3RrHPEyY/yaAiPg7w9ZkGXGwxSUoF2MVw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=O/DF7k+1QM3CpeeavAORpDv+Hqz1sK1IiUF++fkBYOevSWBTLRxeKpTNlSSbOnFqJ
         v9SxsTLSfRqZqH+UfaZWpupsXZuZozXZwDIu20OOuFy8QG9nTPGNi7aZ2Wb8XNTmPI
         ImiIXG8CajWHoF0hTIsbxa+A2ev1O0b3XvtKatBNQQHgphF7Dkl/dcspIf6apn1s02
         0mjD43ySwEW2SysU+w3U+X602Oj2dCe+nuGJcPI6rTtiHzKaZp83oobOwJIH+Z9eIo
         GujymaYUU3N4qyUXk0hww+iVJZ8tZ5Ah07z5PFCtLRmsC9/7UYsXK76gwG4h8fT6Wo
         W+0mGANd7TRCw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id CAC0C5C14F7; Wed, 13 Oct 2021 17:01:04 -0700 (PDT)
Date:   Wed, 13 Oct 2021 17:01:04 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        j alglave <j.alglave@ucl.ac.uk>,
        luc maranget <luc.maranget@inria.fr>,
        akiyks <akiyks@gmail.com>,
        linux-toolchains <linux-toolchains@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
Message-ID: <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
 <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
 <871r54ww2k.fsf@oldenburg.str.redhat.com>
 <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
 <87y271yo4l.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87y271yo4l.fsf@mid.deneb.enyo.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Sun, Oct 10, 2021 at 04:02:02PM +0200, Florian Weimer wrote:
> * Linus Torvalds:
> 
> > On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> >>
> >> Will any conditional branch do, or is it necessary that it depends in
> >> some way on the data read?
> >
> > The condition needs to be dependent on the read.
> >
> > (Easy way to see it: if the read isn't related to the conditional or
> > write data/address, the read could just be delayed to after the
> > condition and the store had been done).
> 
> That entirely depends on how the hardware is specified to work.  And
> the hardware could recognize certain patterns as always producing the
> same condition codes, e.g., AND with zero.  Do such tests still count?
> It depends on what the specification says.
> 
> What I really dislike about this: Operators like & and < now have side
> effects, and is no longer possible to reason about arithmetic
> expressions in isolation.

Is there a reasonable syntax that might help with these issues?

Yes, I know, we for sure have conflicting constraints on "reasonable"
on copy on this email.  What else is new?  ;-)

I could imagine a tag of some sort on the load and store, linking the
operations that needed to be ordered.  You would also want that same
tag on any conditional operators along the way?  Or would the presence
of the tags on the load and store suffice?

							Thanx, Paul
