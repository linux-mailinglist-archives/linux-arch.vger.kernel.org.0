Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58F991D7EB4
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 18:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgERQhr (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 12:37:47 -0400
Received: from foss.arm.com ([217.140.110.172]:44026 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727006AbgERQhr (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 12:37:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80620106F;
        Mon, 18 May 2020 09:37:46 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 94B893F52E;
        Mon, 18 May 2020 09:37:45 -0700 (PDT)
Date:   Mon, 18 May 2020 17:37:43 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-arch@vger.kernel.org, linux-man@vger.kernel.org,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 13/14] prctl.2: Add SVE prctls (arm64)
Message-ID: <20200518163742.GC21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-14-git-send-email-Dave.Martin@arm.com>
 <20200513084351.GB18196@willie-the-truck>
 <20200513104635.GD21779@arm.com>
 <a01fc572-cac8-1932-c3e5-c70184417ca3@gmail.com>
 <20200513140200.GP21779@arm.com>
 <20200513211153.GB28594@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513211153.GB28594@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 10:11:54PM +0100, Will Deacon wrote:
> On Wed, May 13, 2020 at 03:02:00PM +0100, Dave Martin wrote:
> > On Wed, May 13, 2020 at 01:01:12PM +0200, Michael Kerrisk (man-pages) wrote:
> > > On 5/13/20 12:46 PM, Dave Martin wrote:
> > > > On Wed, May 13, 2020 at 09:43:52AM +0100, Will Deacon wrote:
> > > >> On Tue, May 12, 2020 at 05:36:58PM +0100, Dave Martin wrote:
> > > > glibc explicitly has
> > > > 
> > > > 	extern int prctl (int __option, ...);
> > > > 
> > > > (and nobody has to write _exit(0, 0, 0, 0, 0, 0) after all.)
> > > > 
> > > > Is there some agreed rationale for requiring redundant arguments to be
> > > > supplied explicitly as zero?  For now there are likely to be few users
> > > > of this, so we _might_ get away with changing the behaviour here if it's
> > > > considered important enough.
> > > 
> > > See above.
> > 
> > So there is no bulletproof rationale for either approach, but the main
> > concern is inconsistency?  Have I understood that right?
> 
> I think it's all just an extension of "make sure unused parameters are 0"
> idiom which allows those bits to be safely repurposed for flags and things
> later on without the worry of existing applications getting away with
> passing junk.

I'd say that the explicit zeroing may give a false sense of safety, but
I sympathise with the intent.

At least, I think the explicit zeroing means that any resulting bugs are
more likely to be fixable in userspace.

> > I'll propose to get that written down in the kernel source somewhere
> > if so.
> 
> That would be a really good idea, actually!
> 
> > (From my end, the pros and cons of the two approaches seem superficial
> > but the inconsistency is indeed annoying.  For PR_SVE_SET_VL, I think
> > the first example I looked at didn't zero the trailing arguments, so I
> > didn't either... but it's been upstream for several releases, so most
> > likely we're stuck with it.)
> 
> FWIW, I wasn't blaming you for this. Just that these oversights aren't
> always apparent when reviewing patches, but become more clear when
> reviewing the documentation.

I'll have a think, so long as nobody implies that the SVE prctls are
"wrong" ;)

Adding comments in the code about how the implementation of those prctls
can and can't safely be extended would be sensible though.  I'll try to
address that at some point.

> > > > There is no forwards compatibility problem with this prctl though,
> > > > because there are spare bits in arg2 which can "turn on" additional
> > > > args if needed.
> > > > 
> > > > Also, it's implausible that PR_SVE_GET_VL will ever want an argument.
> > > > 
> > > > There are still 2 billion unallocated prctl numbers, so new prctls can
> > > > always be added if there's ever a need to work around these limitations,
> > > > but it seems extremely unlikely.
> 
> Oh, there are ways out, but had I noticed this during code review it
> would've been very easy just to enforce zero for the other args and be done
> with it.

Ack

> > > >>> +If
> > > >>> +.B PR_SVE_VL_INHERIT
> > > >>> +is also included in
> > > >>> +.IR arg2 ,
> > > >>> +it takes effect
> > > >>> +.I after
> > > >>> +this deferred change.
> > > >>
> > > >> I find this a bit hard to follow, since it's not clear to me whether the
> > > >> INHERIT flag is effectively set before or after the next execve(). In other
> > > >> words, if both PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT are specified,
> > > >> is the vector length preserved or reset on the next execve()?
> > > > 
> > > > It makes no difference, because the ONEXEC handling takes priority over
> > > > the INHERIT handling. But either way INHERIT is never cleared by execve()
> > > > and will apply at subsequent execs().
> > > > 
> > > > Explaining all this properly seems out of scope here.  Maybe this should
> > > > be trimmed down rather than elaborated?  Or perhaps just explain it in
> > > > terms of what the kernel does instead of futile attempts to make it
> > > > intuitive?
> 
> Hmm, if we don't explain it in the man page then we should at least point
> people to somewhere where they can get the gory details, because I think
> they're necessary in order to use the prctl() request correctly. I'm still
> not confident that I understand the semantics of setting both
> PR_SVE_SET_VL_ONEXEC and PR_SVE_VL_INHERIT without reading the code, which
> may change.
> 
> (I concede on all the spelling/grammar discussions ;)

Ultimately I aim to add another page, but for now would it be sufficient
to refer to Documentation/?

Cheers
---Dave
