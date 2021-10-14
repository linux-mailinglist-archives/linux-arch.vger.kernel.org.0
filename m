Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0099142DF10
	for <lists+linux-arch@lfdr.de>; Thu, 14 Oct 2021 18:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbhJNQZV (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Thu, 14 Oct 2021 12:25:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:54750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhJNQZV (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Thu, 14 Oct 2021 12:25:21 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6D9F8610F9;
        Thu, 14 Oct 2021 16:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634228591;
        bh=fCvytSPcAeWo2Vds96eNy2fT0BcSOAO7bX73OXJ3ZDw=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=IFU1s5a3z5Ekj2w0Y2WYmd0mqAHup0noJpoI07M4xq3w2OeC34TFrWMNrY47A0opP
         u5kjSp64z8dUyFT/erKNcZcvGkCGzbQ818e9jW44tzbGv+ZNAHdccv8GTw50ODk6yG
         uwElhmZHFVGJ1jt/ormdO88HltmoRpcv/RDha4gJxN69udTCLmYr7HK5Xsq8mKNKLy
         IMLhgAUql24WpHJxB9S9IbuyyIGFLEIjvjJNM7E7TlcsaxjDwlvmy/vr42ZeolpOK0
         6XuKeF5N32eBlGLDS4fWsuvdhxEqqqth7FACn71BL2PelgoZluE+Vdydxi0VKlNyIa
         pK2QToiAjSoxA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 38B635C0AE9; Thu, 14 Oct 2021 09:23:11 -0700 (PDT)
Date:   Thu, 14 Oct 2021 09:23:11 -0700
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
Message-ID: <20211014162311.GD880162@paulmck-ThinkPad-P17-Gen-1>
Reply-To: paulmck@kernel.org
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
 <87lf3f7eh6.fsf@oldenburg.str.redhat.com>
 <20210929174146.GF22689@gate.crashing.org>
 <2088260319.47978.1633104808220.JavaMail.zimbra@efficios.com>
 <871r54ww2k.fsf@oldenburg.str.redhat.com>
 <CAHk-=wgexLqNnngLPts=wXrRcoP_XHO03iPJbsAg8HYuJbbAvw@mail.gmail.com>
 <87y271yo4l.fsf@mid.deneb.enyo.de>
 <20211014000104.GX880162@paulmck-ThinkPad-P17-Gen-1>
 <87lf2v61k7.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lf2v61k7.fsf@mid.deneb.enyo.de>
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Thu, Oct 14, 2021 at 05:58:16PM +0200, Florian Weimer wrote:
> * Paul E. McKenney:
> 
> > On Sun, Oct 10, 2021 at 04:02:02PM +0200, Florian Weimer wrote:
> >> * Linus Torvalds:
> >> 
> >> > On Fri, Oct 1, 2021 at 9:26 AM Florian Weimer <fweimer@redhat.com> wrote:
> >> >>
> >> >> Will any conditional branch do, or is it necessary that it depends in
> >> >> some way on the data read?
> >> >
> >> > The condition needs to be dependent on the read.
> >> >
> >> > (Easy way to see it: if the read isn't related to the conditional or
> >> > write data/address, the read could just be delayed to after the
> >> > condition and the store had been done).
> >> 
> >> That entirely depends on how the hardware is specified to work.  And
> >> the hardware could recognize certain patterns as always producing the
> >> same condition codes, e.g., AND with zero.  Do such tests still count?
> >> It depends on what the specification says.
> >> 
> >> What I really dislike about this: Operators like & and < now have side
> >> effects, and is no longer possible to reason about arithmetic
> >> expressions in isolation.
> >
> > Is there a reasonable syntax that might help with these issues?
> 
> Is this really a problem of syntax?

No, but we seem to need some way to communicate the control-dependency's
ordering intent to the compiler.  ;-)

> > Yes, I know, we for sure have conflicting constraints on "reasonable"
> > on copy on this email.  What else is new?  ;-)
> >
> > I could imagine a tag of some sort on the load and store, linking the
> > operations that needed to be ordered.  You would also want that same
> > tag on any conditional operators along the way?  Or would the presence
> > of the tags on the load and store suffice?
> 
> If the load is assigned to a local variable whose address is not taken
> and which is only assigned this once, it could be used to label the
> store.  Then the compiler checks if all paths from the load to the
> store feature a condition that depends on the local variable (where
> qualifying conditions probably depend on the architecture).  If it
> can't prove that is the case, it emits a fake no-op condition that
> triggers the hardware barrier.  This formulation has the advantage
> that it does not add side effects to operators like <.  It even
> generalizes to different barrier-implying instructions besides
> conditional branches.

So something like this?

	tagvar = READ_ONCE(a);
	if (tagvar)
		WRITE_ONCE_COND(b, 1, tagvar);

(This seems to me to be an eminently reasonable syntax.)

Or did I miss a turn in there somewhere?

> But I'm not sure if all this complexity will be a tangible improvement
> over just using that no-op condition all the time (whether implied by
> READ_ONCE, or in a separate ctrl_dep macro).

That is an excellent question.  I have no idea what the answer is.  ;-)

						Thanx, Paul
