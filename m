Return-Path: <linux-arch-owner@vger.kernel.org>
X-Original-To: lists+linux-arch@lfdr.de
Delivered-To: lists+linux-arch@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1E851D7DF7
	for <lists+linux-arch@lfdr.de>; Mon, 18 May 2020 18:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgERQLc (ORCPT <rfc822;lists+linux-arch@lfdr.de>);
        Mon, 18 May 2020 12:11:32 -0400
Received: from foss.arm.com ([217.140.110.172]:43622 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727007AbgERQLc (ORCPT <rfc822;linux-arch@vger.kernel.org>);
        Mon, 18 May 2020 12:11:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8E0C7106F;
        Mon, 18 May 2020 09:11:31 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 74E9C3F52E;
        Mon, 18 May 2020 09:11:30 -0700 (PDT)
Date:   Mon, 18 May 2020 17:11:28 +0100
From:   Dave Martin <Dave.Martin@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     mtk.manpages@gmail.com, linux-man@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 14/14] prctl.2: Add PR_PAC_RESET_KEYS (arm64)
Message-ID: <20200518161128.GB21779@arm.com>
References: <1589301419-24459-1-git-send-email-Dave.Martin@arm.com>
 <1589301419-24459-15-git-send-email-Dave.Martin@arm.com>
 <20200513072530.GA18196@willie-the-truck>
 <20200513143653.GQ21779@arm.com>
 <20200513210022.GA28594@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513210022.GA28594@willie-the-truck>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-arch-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-arch.vger.kernel.org>
X-Mailing-List: linux-arch@vger.kernel.org

On Wed, May 13, 2020 at 10:00:22PM +0100, Will Deacon wrote:
> On Wed, May 13, 2020 at 03:36:54PM +0100, Dave Martin wrote:
> > On Wed, May 13, 2020 at 08:25:31AM +0100, Will Deacon wrote:
> > > On Tue, May 12, 2020 at 05:36:59PM +0100, Dave Martin wrote:
> > > > +As a special case, if
> > > > +.I arg2
> > > > +is zero then all the keys are reset.
> > > > +Since new keys could be added in future,
> > > > +this is the recommended way to completely wipe the existing keys
> > > > +when creating a new execution context.
> > > 
> > > I see what you're saying, but the keys are also reset on exec() iirc, so we
> > > don't want to encourage people to issue the prctl() unnecessarily
> > > immediately following an exec().
> > 
> > I thought of saying that, then pulled it out again.
> > 
> > How about:
> > 
> > "[...] a new execution context within an existing process.  Note that
> > execve() always resets all the keys as part of its operation, without
> > the need for this prctl() call.  PR_PAC_RESET_KEYS is intended for
> > custom situations that do not involve execve(), such as creating a new
> > managed run-time sandbox."
> > 
> > I deliberately don't say "thread" because that's probably libc's job.
> > I'll need to check glibc does, though.  There may be issues with
> > pthreads semantics that mean we can't reset the keys there.
> 
> That's better, but you may even be able to drop the "such as..." part, I
> reckon.
> 
> > > > @@ -1920,6 +1960,27 @@ are not 0.
> > > >  .B EINVAL
> > > >  .I option
> > > >  was
> > > > +.B PR_PAC_RESET_KEYS
> > > > +and
> > > > +.I arg2
> > > > +contains non-zero bits other than
> > > > +.BR
> > > > +.BR PR_PAC_APIAKEY ,
> > > > +.BR PR_PAC_APIBKEY ,
> > > > +.BR PR_PAC_APDAKEY ,
> > > > +.B PR_PAC_APDBKEY
> > > > +and
> > > > +.BR PR_PAC_APGAKEY ;
> > > > +or
> > > > +.IR arg3 ,
> > > > +.I arg4
> > > > +and
> > > > +.I arg5
> > > > +were not all zero.
> > > 
> > > Do we care about other reasons for -EINVAL, such as the system not
> > > supporting pointer authentication?
> > 
> > Again, I tried to catch that under the new "not supported by this
> > platform" wording in the earlier patch.  Do you think that's sufficient,
> > or do we need something else here?
> 
> As long as it's clear that the prctl() *can* fail and userspace can't just
> ignore the return value, then I'm happy. If it's not obvious, then spelling
> it out seems harmless to me.

OK, I'll try to figure out a way to capture this.

Since prctl is really the wild west when it comes to error codes I was
presuming that's it's best to say nothing and rely on people's common sense.
But I guess this isn't great either.


How about summarising the key error cases here, and just putting a cross-
reference in the ERRORS section rather than trying to describe them
there?  I really don't want to duplicate this stuff -- that will get
unmaintanable, fast (if it hasn't already).

Cheers
---Dave
